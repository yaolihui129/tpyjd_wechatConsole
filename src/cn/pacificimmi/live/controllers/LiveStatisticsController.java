package cn.pacificimmi.live.controllers;

import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Live;
import cn.pacificimmi.common.models.LiveMessage;
import cn.pacificimmi.common.utils.StringUtil;

@Before(LoginInterCeptor.class)

public class LiveStatisticsController extends Controller {
	public void index(){
		StatisticsParamsParser spp = new StatisticsParamsParser(this);
		/**
		 * 相关统计
		 */
		String id = spp.getId();
		Live live = Live.dao.findById(id);
		setAttr("live",live);
		//主播
		Record user = Db.findFirst("select cu.user_name from console_user as cu,crm_steward_user as csu where cu.user_id=csu.user_id and csu.steward_id="+live.getLiveStewardId());
		if(user!=null){
			String steward = user.getStr("user_name");
			setAttr("steward",steward);
		}
		
		//评论
		List<LiveMessage> lm = LiveMessage.dao.find("select * from portal_live_message where live_id="+id);
		setAttr("mnum",lm.size());
		
		//参与人数
		Record joiner = Db.findFirst("select count(*) as joiner from portal_live_application where live_id="+id);
		setAttr("joiner",joiner.getLong("joiner"));
		
		//点赞
		Record goods = Db.findFirst("select count(*) as goods from portal_live_like where 'like'=0 and live_id="+id);
		setAttr("goods",goods.getLong("goods"));
		
		Record bads = Db.findFirst("select count(*) as bads from portal_live_like where 'like'=1 and live_id="+id);
		setAttr("bads",bads.getLong("bads"));
		
		//临时听课码
		Record temp = Db.findFirst("SELECT count(*) temp FROM kaifa.portal_live_application where live_id="+id+" and invitation_code not in (select code from portal_invitation_code where live_id="+id+")");
		setAttr("temp",temp.getLong("temp"));
		
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(spp.getPageNum(), spp.getPageSize(), spp.getSelectStr(), spp.getFromStr());
		List<Record> list = page.getList();
		setAttr("list",list);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(spp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		this.renderJsp("/views/live/live_room_statistics.jsp");
	}
	
	public void comments(){
		ParamsParser pp = new ParamsParser(this);
		String live_id = this.getPara(0);
		String cust_id = this.getPara(1);
		
		setAttr("live_id",live_id);
		
		pp.setSelectStr("select * ");
		pp.setFromStr("from portal_live_message");
		pp.addWhereSegmentByAnd("live_id="+live_id);
		pp.addWhereSegmentByAnd("custinfo_id="+cust_id);
		pp.setDefaultOrderStr("order by create_time desc");
		
		Page<LiveMessage> page = LiveMessage.dao.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<LiveMessage> list = page.getList();
		setAttr("list",list);
		
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		this.renderJsp("/views/live/live_room_statistics_messages.jsp");
	}
	
	private class StatisticsParamsParser extends ParamsParser{

		public StatisticsParamsParser(Controller ct) {
			super(ct);
			// TODO Auto-generated constructor stub
			this.setSelectStr("SELECT pla.live_id, pla.custinfo_id, cd.name as method, cc.name,cd1.name as city, cc.phone_num, COUNT(plm.message_id) AS mnum, pll.like");
			this.setFromStr("FROM portal_live_application pla "
							+"LEFT JOIN crm_custinfo cc ON pla.custinfo_id = cc.custinfo_id "
							+"LEFT JOIN portal_live_message plm ON pla.live_id = plm.live_id "
							+"	AND pla.custinfo_id = plm.custinfo_id "
							+"LEFT JOIN portal_live_like pll ON pla.live_id = pll.live_id "
							+"	AND pla.custinfo_id = pll.custinfo_id "
							+"LEFT JOIN console_dictionary cd ON pla.application_method = cd.dict_code "
						    +"LEFT JOIN console_dictionary cd1 ON cc.city = cd1.dict_code ");
			this.addWhereSegmentByAnd("pla.live_id="+this.getId());
			this.setDefaultGroupStr("GROUP BY pla.custinfo_id");
		}
		
	}
}
