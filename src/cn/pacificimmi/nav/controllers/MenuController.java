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

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.NavMenu;
import cn.pacificimmi.common.utils.StringUtils;
import cn.pacificimmi.nav.models.view.MenuInfo;

/**
 * 导航菜单
 * @author yang
 * @date 2017年5月12日 下午3:34:13
 */
@Before(LoginInterCeptor.class)
public class MenuController extends Controller {
	
	/**
	 * 一级菜单列表
	 */
	public void index() {
		NavMenuParams mp = new NavMenuParams(this);
		Page<Record> page = Db.paginate(mp.getPageNum(), mp.getPageSize(), mp.getSelectStr(), mp.getFromStr());
		List<Record> list = page.getList();
		List<MenuInfo> result = new ArrayList<MenuInfo>();
		for(Record rd : list) {
			MenuInfo mi = new MenuInfo();
			mi.bindingData(mi, rd);
			result.add(mi);
		}
		
		
		String pagesView = PagesBar.getShortPageBar(mp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		this.setAttr("list", result);
		this.setAttr("now", mp.getPageNum());
		this.setAttr("page", page.getTotalPage());
		
		this.setAttr("menu_status_wfb", PropKit.use("constants.txt").get("menu_status_wfb"));
		this.setAttr("menu_status_yfb", PropKit.use("constants.txt").get("menu_status_yfb"));
		this.renderJsp("/views/nav/menu/list.jsp");
	}
	
	/**
	 * 新增
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation") != null) {
			NavMenu nm = new NavMenu();
			
			String menu_name = pp.getAllStr("menu_name");
			if(StringUtils.notEmpty(menu_name)) {
				nm.set("menu_name", menu_name);
			}
			String menu_url = pp.getAllStr("menu_url");
			if(StringUtils.notEmpty(menu_url)) {
				nm.set("menu_url", menu_url);
			}
			String open_mode = pp.getAllStr("open_mode");
			if(StringUtils.notEmpty(open_mode)) {
				nm.set("open_mode", open_mode);
			}
			String menu_type = pp.getAllStr("menu_type");
			if(StringUtils.notEmpty(menu_type)) {
				nm.set("menu_type", menu_type);
			}
			
			NavMenu now = NavMenu.dao.findFirst("SELECT nav_menu_id, priority from  official_nav_menu where delete_flag = 0 and menu_level=1 order by priority desc limit 1");
			if(null != now && null != now.getPriority()) {
				nm.set("priority", now.getPriority()+1);
			} else {
				nm.set("priority", 0);
			}
			
			nm.set("menu_status", PropKit.use("constants.txt").get("menu_status_wfb"));
			nm.setMenuLevel(1);
			nm.setDeleteFlag(0);
			nm.setCreateTime(new Date());
			nm.save();
			
			this.redirect("/official/nav/menu");
		} else {
			List<Dict> modeList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
			List<Dict> typeList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("menu_type"), 1).getSubDictionaries();
			
			this.setAttr("checked", "checked");
			this.setAttr("modeList", modeList);
			this.setAttr("typeList", typeList);
			this.setAttr("operation", "新增");
			this.renderJsp("/views/nav/menu/edit.jsp");
		}
	}
	
	
	/**
	 * 修改
	 */
	public void updata() {
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		
		if(StringUtils.notEmpty(id)) {
			NavMenu nm = NavMenu.dao.findById(id);
			if(pp.getNormStr("operation") != null) {
				String menu_name = pp.getAllStr("menu_name");
				if(StringUtils.notEmpty(menu_name)) {
					nm.set("menu_name", menu_name);
				}
				String menu_url = pp.getAllStr("menu_url");
				if(StringUtils.notEmpty(menu_url)) {
					nm.set("menu_url", menu_url);
				}
				String open_mode = pp.getAllStr("open_mode");
				if(StringUtils.notEmpty(open_mode)) {
					nm.set("open_mode", open_mode);
				}
				String menu_type = pp.getAllStr("menu_type");
				if(StringUtils.notEmpty(menu_type)) {
					nm.set("menu_type", menu_type);
				}
				
				nm.update();
				this.redirect("/official/nav/menu");
			} else {
				List<Dict> modeList = DictionaryManager.getInstance().
						getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
				List<Dict> typeList = DictionaryManager.getInstance().
						getAllSubDictionaries(PropKit.use("constants.txt").get("menu_type"), 1).getSubDictionaries();
				
				this.setAttr("modeList", modeList);
				this.setAttr("typeList", typeList);
				this.setAttr("menu", nm);
				this.setAttr("operation", "编辑");
				this.renderJsp("/views/nav/menu/edit.jsp");
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
	
	/**
	 * 删除
	 */
	/*@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete() {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = this.getPara(0);
		if(StringUtils.notEmpty(id)) {
			NavMenu nm = NavMenu.dao.findById(id);
			nm.setDeleteFlag(1);
			nm.update();
			map.put("status", 0);
			map.put("msg", "删除成功");
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
		}
		this.renderJson(map);
	}*/
	
	
	/**
	 * 发布
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void release() {
		Map<String, Object> map = new HashMap<String, Object>();
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getAllStr("id");
		String code = pp.getAllStr("code");
		if(StringUtils.notEmpty(id)) {
			NavMenu nm = NavMenu.dao.findById(id);
			nm.setMenuStatus(code);
			nm.update();
			
			map.put("status", 0);
			map.put("msg", "修改成功");
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
		}
		renderJson(map);
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
			NavMenu nm = NavMenu.dao.findById(id);
			Integer pr = nm.getPriority();
			
			if(order.equals("up")) {
				NavMenu now = NavMenu.dao.findFirst("SELECT nav_menu_id, priority from official_nav_menu where priority > "+pr+" and delete_flag = 0 and menu_level=1 order by priority asc limit 1");
				if(null == now || id.equals(now.getNavMenuId().toString())) {
					status=1;
					msg="无法上移，排序已是最上";
				} else {
					nm.setPriority(now.getPriority());
					now.setPriority(pr);
					now.update();
					nm.update();
					status=0;
				}
			} else if(order.equals("down")) {
				NavMenu now = NavMenu.dao.findFirst("SELECT nav_menu_id, priority from official_nav_menu where priority < "+pr+" and delete_flag = 0 and menu_level=1 order by priority desc limit 1");
				if(null == now || id.equals(now.getNavMenuId().toString())) {
					status=1;
					msg="无法下移，排序已是最下";
				} else {
					nm.setPriority(now.getPriority());
					now.setPriority(pr);
					now.update();
					nm.update();
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
	 * @date 2017年5月12日 下午3:48:27
	 */
	private class NavMenuParams extends ParamsParser {

		public NavMenuParams(Controller ct) {
			super(ct);
			this.setSelectStr("SELECT "+
						"nm.nav_menu_id, "+
						"nm.menu_name, "+
						"nm.menu_status, "+
						"nm.menu_url, "+
						"( "+
							"SELECT "+
								"d. NAME "+
							"FROM "+
								"console_dictionary d "+
							"WHERE "+
								"d.delete_flag = 0 "+
							"AND d.dict_code = nm.open_mode "+
						") open_mode_name, "+
						"( "+
							"SELECT "+
								"c. NAME "+
							"FROM "+
								"console_dictionary c "+
							"WHERE "+
								"c.delete_flag = 0 "+
							"AND c.dict_code = nm.menu_status "+
						") menu_status_name");
			
			this.setFromStr("FROM official_nav_menu nm");
			this.addWhereSegmentByAnd("nm.delete_flag = 0");
			this.addWhereSegmentByAnd("nm.menu_level = 1");
			this.setDefaultOrderStr("ORDER BY nm.priority DESC");
		}
		
	}
}
