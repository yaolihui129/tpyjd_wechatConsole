package cn.pacificimmi.nav.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.FriendlyLink;
import cn.pacificimmi.common.utils.StringUtils;
import cn.pacificimmi.nav.models.view.FriendlyLinkInfo;

/**
 * 友情链接
 * @author yang
 * @date 2017年5月12日 上午10:28:13
 */
@Before(LoginInterCeptor.class)
public class FriendlyLinkController extends Controller {
	
	/**
	 * 友情链接列表
	 */
	public void index() {
		FriendlyLinkParams flp = new FriendlyLinkParams(this); 
		Page<Record> page = Db.paginate(flp.getPageNum(), flp.getPageSize(), flp.getSelectStr(), flp.getFromStr());
		List<Record> list = page.getList();
		List<FriendlyLinkInfo> result = new ArrayList<FriendlyLinkInfo>();
		for(Record rd : list) {
			FriendlyLinkInfo fi = new FriendlyLinkInfo();
			fi.bindingData(fi, rd);
			result.add(fi);
		}
		String pagesView = PagesBar.getShortPageBar(flp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		this.setAttr("list", result);
		this.setAttr("now", flp.getPageNum());
		this.setAttr("page", page.getTotalPage());
		this.renderJsp("/views/nav/link/list.jsp");
	}
	
	
	/**
	 * 新增
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation") != null) {
			FriendlyLink fi = new FriendlyLink();
			
			String title = pp.getAllStr("title");
			if(StringUtils.notEmpty(title)) {
				fi.set("title", title);
			}
			String url = pp.getAllStr("url");
			if(StringUtils.notEmpty(url)) {
				fi.set("url", url);
			}
			
			FriendlyLink now = FriendlyLink.dao.findFirst("SELECT friendly_link_id, priority from  official_friendly_link where delete_flag = 0 and link_type="+PropKit.use("constants.txt").get("link_type_friendly")
								+" order by priority desc limit 1");
			if(null != now && null != now.getPriority()) {
				fi.set("priority", now.getPriority()+1);
			} else {
				fi.set("priority", 0);
			}
			
			fi.set("delete_flag", 0);
			fi.set("link_type", PropKit.use("constants.txt").get("link_type_friendly"));
			fi.set("create_time", new Date());
			fi.save();
			this.redirect("/official/nav/link");
		} else {
			this.setAttr("operation", "新增");
			this.renderJsp("/views/nav/link/edit.jsp");
		}
	}
	
	/**
	 * 更新
	 */
	public void updata() {
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		
		if(StringUtils.notEmpty(id)) {
			FriendlyLink fi = FriendlyLink.dao.findById(id);
			if(pp.getNormStr("operation") != null) {
				String title = pp.getAllStr("title");
				if(StringUtils.notEmpty(title)) {
					fi.set("title", title);
				}
				String url = pp.getAllStr("url");
				if(StringUtils.notEmpty(url)) {
					fi.set("url", url);
				}
				
				fi.update();
				this.redirect("/official/nav/link");
			} else {
				this.setAttr("friendly", fi);
				this.setAttr("operation", "编辑");
				this.renderJsp("/views/nav/link/edit.jsp");
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete() {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = this.getPara(0);
		if(StringUtils.notEmpty(id)) {
			FriendlyLink fi = FriendlyLink.dao.findById(id);
			fi.setDeleteFlag(1);
			fi.update();
			map.put("status", 0);
			map.put("msg", "删除成功");
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
		}
		this.renderJson(map);
	}
	
	/**
	 * 排序
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void order() {
		Map<String, Object> map = new HashMap<String, Object>();
		String id=this.getPara("id");
		String order = this.getPara("order");
		if(StringUtils.notEmpty(id) && StringUtils.notEmpty(order)) {
			int status=0;
			String msg="操作成功";
			FriendlyLink fi = FriendlyLink.dao.findById(id);
			Integer pr =fi.getPriority();
			
			if(order.equals("up")) {
				FriendlyLink now = FriendlyLink.dao.findFirst("SELECT friendly_link_id, priority from official_friendly_link where priority > "+pr+" and delete_flag = 0 and link_type="+PropKit.use("constants.txt").get("link_type_friendly")
								+" order by priority asc limit 1");
				if(null == now || id.equals(now.getFriendlyLinkId().toString())) {
					status=1;
					msg="无法上移，排序已是最上";
				} else {
					fi.setPriority(now.getPriority());
					now.setPriority(pr);
					now.update();
					fi.update();
					status=0;
				}
			} else if(order.equals("down")) {
				FriendlyLink now = FriendlyLink.dao.findFirst("SELECT friendly_link_id, priority from official_friendly_link where priority < "+pr+" and delete_flag = 0 and link_type="+PropKit.use("constants.txt").get("link_type_friendly")
								+" order by priority desc limit 1");
				if(null == now || id.equals(now.getFriendlyLinkId().toString())) {
					status=1;
					msg="无法下移，排序已是最下";
				} else {
					fi.setPriority(now.getPriority());
					now.setPriority(pr);
					now.update();
					fi.update();
					status=0;
				}
			}
			map.put("status", status);
			map.put("msg", msg);
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
		}
		this.renderJson(map);
	}
	
	/**
	 * 查询
	 * @author yang
	 * @date 2017年5月12日 上午10:42:45
	 */
	private class FriendlyLinkParams extends ParamsParser {

		public FriendlyLinkParams(Controller ct) {
			super(ct);
			// TODO Auto-generated constructor stub
			this.setSelectStr("select * ");
			this.setFromStr("from official_friendly_link");
			this.addWhereSegmentByAnd("delete_flag = 0");
			this.addWhereSegmentByAnd("link_type = "+PropKit.use("constants.txt").get("link_type_friendly"));
			this.setDefaultOrderStr("ORDER BY priority DESC");
		}
		
	}
	
}
