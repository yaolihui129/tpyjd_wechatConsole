package cn.pacificimmi.card.controllers;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.card.models.view.CarCustomerInfo;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.utils.StringUtil;

/**
 * 获客列表
 * @author yang
 *
 */
@Before(LoginInterCeptor.class)
public class CardCustomerController extends Controller{
	
	private static Logger log = LoggerFactory.getLogger(CardCustomerController.class);

	public void index() {
		CardCustomerParams pp = new CardCustomerParams(this);
		Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<Record> list = page.getList();
		List<CarCustomerInfo> result = new ArrayList<CarCustomerInfo>();
		for(Record rd : list ) {
			CarCustomerInfo cci = new CarCustomerInfo();
			cci.bindingData(cci, rd);
			if(StringUtil.notEmpty(cci.getMobile())) {
				cci.setMobile(StringUtil.getMaskMobile(cci.getMobile()));
			}
			result.add(cci);
		}
		
		this.setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		this.renderJsp("/views/card/card_customer.jsp");
	}
	
	
	private class CardCustomerParams extends ParamsParser {

		public CardCustomerParams(Controller ct) {
			super(ct);
			this.setSelectStr("select * ");
			
			this.setFromStr("FROM "+
					"wx_card_customer "+
				"LEFT JOIN ( "+
					"SELECT "+
						"cu.user_id AS userId, "+
						"cu.user_name AS userName "+
					"FROM "+
						"console_user cu "+
				") cur ON wx_card_customer.user_id = cur.userId ");
			
			this.setDefaultOrderStr("order by create_time desc");
					
		}
		
	}
	
}
