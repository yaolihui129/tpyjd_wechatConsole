package cn.pacificimmi.card.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.ContentType;

import cn.pacificimmi.card.models.view.CardResourceInfo;
import cn.pacificimmi.card.models.view.OrgUserInfo;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.models.WeixinResource;
import cn.pacificimmi.common.utils.StringUtil;

@Before(LoginInterCeptor.class)
public class CardResourceController extends Controller{
	
	private static Logger log = LoggerFactory.getLogger(CardResourceController.class);
			
	public void index() {
		CardResourceParams crp = new CardResourceParams(this);
		Page<Record> page = Db.paginate(crp.getPageNum(), crp.getPageSize(), crp.getSelectStr(), crp.getFromStr());
		List<Record> list = page.getList();
		List<CardResourceInfo> result = new ArrayList<CardResourceInfo>();
		for(Record rd : list) {
			CardResourceInfo cri = new CardResourceInfo();
			cri.bindingData(cri, rd);
			result.add(cri);
		}
		String pagesView = PagesBar.getShortPageBar(crp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		this.setAttr("list", result);
		
		//回填参数
		String bind_status = this.getPara("bind_status");
		if(StringUtil.notEmpty(bind_status)) {
			this.setAttr("bind_status", bind_status.trim());
		}
		String user_name = this.getPara("user_name");
		if(StringUtil.notEmpty(user_name)) {
			this.setAttr("user_name", user_name.trim());
		}
		
		this.renderJsp("/views/card/card_resource.jsp");
	}
	
	/**
	 * 微信号绑定
	 */
	public void bind() {
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		String operation = pp.getNormStr("operation");
		if(null != id && !"".equals(id)) {
			WeixinResource wxr = WeixinResource.dao.findById(id);
			if(null != operation) {
				 String user_id = pp.getNormStr("user_id");
				 if(null != user_id && !"".equals(user_id)) {
					 WeixinResource wr = WeixinResource.dao.findFirst("select weixin_resource_id, user_id from wx_weixin_resource where user_id="+user_id);
					 if(null == wr || (null != wr && id.equals(wr.getWeixinResourceId().toString()))) {
						 //修改以前绑定用户
						 if(null != wxr.getUserId() && !"".equals(wxr.getUserId())) {
							 User oldUser = User.dao.findById(wxr.getUserId());
							 oldUser.set("bind_status", PropKit.use("constants.txt").get("bind_status_j"));
							 oldUser.update();
						 }
						 //保存绑定新用户
						 User user = User.dao.findById(user_id);
						 user.set("bind_status", PropKit.use("constants.txt").get("bind_status_y"));
						 user.update();
						 
						 LoginUserInfo ui = this.getSessionAttr("LoginUserInfo");
						 wxr.set("create_user", ui.getUid());
						 wxr.set("user_id", user_id);
						 wxr.set("status",PropKit.use("constants.txt").get("bind_status_y"));
						 wxr.update();
						 this.redirect("/data/cardresource");
					 } else {
						 edit(wxr, "1");
					 }
				 } else {
					 this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				 }
			} else {
				edit(wxr, null);
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
	
	//返回编辑页
	private void edit(WeixinResource wxr, String status) {
		List<OrgUserInfo> userList = getUsers();
		Integer userId = wxr.getUserId();
		if(null != userId && !"".equals(userId)) {
			User user = User.dao.findById(userId);
			this.setAttr("user", user);
		}
		if(StringUtil.notEmpty(status)) {
			this.setAttr("status", status);
		}
		this.setAttr("userList", userList);
		this.setAttr("weixin", wxr);
		this.setAttr("operation", "编辑");
		this.renderJsp("/views/card/wx_user.jsp");
	}
	
	/**
	 * 获取组织架构人员(除user_id=1的超级管理员外的人员)
	 * @return
	 */
	private List<OrgUserInfo> getUsers() {
		List<OrgUserInfo> result = new ArrayList<OrgUserInfo>();
		List<Record> list = Db.find("SELECT "+
					"cus.user_id, "+
					"cus.user_name, "+
					"cus.com_id, "+
					"cus.dep_id, "+
					"cus.phone, "+
					"com.com_name, "+
					"dep.dep_name "+
				"FROM "+
					"console_user cus "+
				"LEFT JOIN ( "+
					"SELECT "+
						"cor.org_id, "+
						"cor.short_name AS com_name "+
					"FROM "+
						"console_orgnization cor "+
				") com ON com.org_id = cus.com_id "+
				"LEFT JOIN ( "+
					"SELECT "+
						"cor_.org_id, "+
						"cor_.short_name AS dep_name "+
					"FROM "+
						"console_orgnization cor_ "+
				") dep ON dep.org_id = cus.dep_id "+
				"WHERE "+
					"delete_flag = 0 and user_id != 1 "+
				"ORDER BY "+
					"cus.com_id, "+
					"cus.dep_id ASC");
		
		for(Record rd : list) {
			OrgUserInfo ori = new OrgUserInfo();
			ori.bindingData(ori, rd);
			result.add(ori);
		}
		return result;
	}
	
	/**
	 * 查询
	 * @author yang
	 */
	private class CardResourceParams extends ParamsParser {

		public CardResourceParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("SELECT * ");
			this.setFromStr("FROM "+
					"( "+
						"SELECT "+
							"*, ifnull(cus.c_bind_status, 0) bind_status "+
						"FROM "+
							"wx_weixin_resource wwr "+
						"LEFT JOIN ( "+
							"SELECT "+
								"c.user_id AS c_user_id, "+
								"c.user_name AS user_name, "+
								"c.bind_status AS c_bind_status "+
							"FROM "+
								"console_user c "+
						") cus ON cus.c_user_id = wwr.user_id "+
					") w");
			
			String user_name = this.getFieldName("user_name");
			if(StringUtil.notEmpty(user_name)) {
				this.addWhereSegmentByAnd("w.user_name like '%"+user_name.trim()+"%'");
			}
			String bind_status = this.getFieldName("bind_status");
			if(StringUtil.notEmpty(bind_status)) {
				this.addWhereSegmentByAnd("w.bind_status="+bind_status);
			}
			
			this.setDefaultOrderStr("ORDER BY w.create_time desc");
		}
	}
}
