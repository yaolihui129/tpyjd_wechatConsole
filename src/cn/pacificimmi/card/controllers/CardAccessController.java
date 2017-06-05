package cn.pacificimmi.card.controllers;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.card.models.view.CardAccessInfo;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;

@Before(LoginInterCeptor.class)
public class CardAccessController extends Controller{
	
	private static Logger log = LoggerFactory.getLogger(CardAccessController.class);
			
	public void index() {
		CardAccessParams pp = new CardAccessParams(this);
		Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<Record> list = page.getList();
		List<CardAccessInfo> result = new ArrayList<CardAccessInfo>();
		for(Record rd : list) {
			CardAccessInfo cai = new CardAccessInfo();
			cai.bindingData(cai, rd);
			cai.setBrowse_num(rd.getLong("browse_num"));
			if(null != cai.getUser_id()) {
				Long enrol_num = Db.queryLong("select count(user_id) from wx_card_customer where user_id = "+cai.getUser_id());
				if(null != enrol_num) {
					cai.setEnrol_num(enrol_num);
					//转换率
					Long bn = cai.getBrowse_num();
					if(null != bn) {
						Double db = new Double(enrol_num)/new Double(bn)*1000;
						BigDecimal bg = new BigDecimal(db);
						Double d = bg.setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
						if(d>0.0) {
							cai.setPercent(d);
						}
					}
				}
			}
			result.add(cai);
		}
		
		this.setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		this.renderJsp("/views/card/card_access.jsp");
	}
	
	
	private class CardAccessParams extends ParamsParser {

		public CardAccessParams(Controller ct) {
			super(ct);
			this.setSelectStr("SELECT acc.card_access_id as card_access_id, "+
											"acc.user_id as user_id, "+
											"acc.url as url, "+
											"acc.create_time as create_time, "+
											"acc.browse_num as browse_num, "+
											"cus.user_name as user_name, "+
											"wwr.send_user_name as send_user_name, "+
											"wwr.send_wx_name as send_wx_name  ");
			
			this.setFromStr("FROM "+
					"( "+
						"SELECT "+
							"wc.card_access_id, "+
							"wc.user_id, "+
							"wc.url, "+
							"wc.create_time, "+
							"wc.weixin_resource_id as wc_weixin_resource_id, "+
							"COUNT(wc.user_id) AS browse_num "+
						"FROM "+
							"wx_card_access wc "+
						"GROUP BY "+
							"wc.user_id "+
					") acc "+
				"LEFT JOIN ( "+
					"SELECT "+
						"cu.user_id AS c_user_id, "+
						"cu.user_name AS user_name "+
					"FROM "+
						"console_user cu "+
				") cus ON acc.user_id = cus.c_user_id "+
				"LEFT JOIN ( "+
					"SELECT "+
						"w.weixin_resource_id as w_weixin_resource_id, "+
						"w.user_id AS w_user_id, "+
						"w.wx_name AS send_wx_name, "+
						"c.user_name AS send_user_name "+
					"FROM "+
						"wx_weixin_resource w "+
					"LEFT JOIN console_user c ON w.user_id = c.user_id "+
				") wwr ON wwr.w_weixin_resource_id = acc.wc_weixin_resource_id");
			this.setDefaultOrderStr("ORDER BY acc.create_time DESC");
		}
	}
}
