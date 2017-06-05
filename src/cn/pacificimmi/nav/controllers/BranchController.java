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
 * 分公司
 * @author yang
 * @date 2017年5月12日 上午11:06:25
 */
@Before(LoginInterCeptor.class)
public class BranchController extends Controller {
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
		this.renderJsp("/views/nav/branch/list.jsp");
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
			
			FriendlyLink now = FriendlyLink.dao.findFirst("SELECT friendly_link_id, priority from  official_friendly_link where delete_flag = 0 and link_type="+PropKit.use("constants.txt").get("link_type_branch")
					+" order by priority desc limit 1");
			if(null != now && null != now.getPriority()) {
				fi.set("priority", now.getPriority()+1);
			} else {
				fi.set("priority", 0);
			}
			
			fi.set("delete_flag", 0);
			fi.set("link_type", PropKit.use("constants.txt").get("link_type_branch"));
			fi.set("create_time", new Date());
			fi.save();
			this.redirect("/official/nav/branch");
		} else {
			this.setAttr("operation", "新增");
			this.renderJsp("/views/nav/branch/edit.jsp");
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
				this.redirect("/official/nav/branch");
			} else {
				this.setAttr("branch", fi);
				this.setAttr("operation", "编辑");
				this.renderJsp("/views/nav/branch/edit.jsp");
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
			this.addWhereSegmentByAnd("link_type = "+PropKit.use("constants.txt").get("link_type_branch"));
			this.setDefaultOrderStr("ORDER BY priority DESC");
		}
		
	}
}
