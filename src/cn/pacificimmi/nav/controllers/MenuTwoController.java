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
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.NavMenu;
import cn.pacificimmi.common.utils.StringUtils;
import cn.pacificimmi.nav.models.view.MenuInfo;



/**
 * 导航菜单
 * @author yang
 * @date 2017年5月12日 下午3:34:13
 */
@Before(LoginInterCeptor.class)
public class MenuTwoController extends Controller {
	
	/**
	 * 二级菜单列表
	 */
	public void index() {
		NavMenuTwoParams mt = new NavMenuTwoParams(this);
		Page<Record> page = Db.paginate(mt.getPageNum(), mt.getPageSize(), mt.getSelectStr(), mt.getFromStr());
		List<Record> list = page.getList();
		List<MenuInfo> result = new ArrayList<MenuInfo>();
		for(Record rd : list) {
			MenuInfo mi = new MenuInfo();
			mi.bindingData(mi, rd);
			result.add(mi);
		}
		
		String pagesView = PagesBar.getShortPageBar(mt.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		
		this.setAttr("one", NavMenu.dao.findById(mt.getId()));
		this.setAttr("pageBar",pagesView);
		this.setAttr("list", result);
		this.setAttr("now", mt.getPageNum());
		this.setAttr("page", page.getTotalPage());
		this.setAttr("menu_type_cdl", PropKit.use("constants.txt").get("menu_type_cdl"));
		this.renderJsp("/views/nav/menu/two/list.jsp");
	}
	
	/**
	 * 新增
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		String menu_pid = pp.getId();
		if(StringUtils.notEmpty(menu_pid)) {
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
				
				String dict_code = pp.getAllStr("dict_code");
				if(StringUtils.notEmpty(dict_code)) {
					nm.set("dict_code", dict_code);
				}
				
				NavMenu now = NavMenu.dao.findFirst("SELECT nav_menu_id, priority from  official_nav_menu where delete_flag = 0 and menu_level=2 and menu_pid="+menu_pid+" order by priority desc limit 1");
				if(null != now && null != now.getPriority()) {
					nm.set("priority", now.getPriority()+1);
				} else {
					nm.set("priority", 0);
				}
				
				nm.set("menu_pid", menu_pid);
				
				nm.setMenuLevel(2);
				nm.setDeleteFlag(0);
				nm.setCreateTime(new Date());
				nm.save();
				
				this.redirect("/official/nav/menu/two/"+menu_pid);
			} else {
				NavMenu pm = NavMenu.dao.findById(menu_pid);
				
				if(pm.getMenuType().equals(PropKit.use("constants.txt").get("menu_type_cdl"))) {
					List<Dict> modeList = DictionaryManager.getInstance().
							getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
					
					this.setAttr("pm", pm);
					this.setAttr("modeList", modeList);
					this.setAttr("menu_pid", menu_pid);
					this.setAttr("operation", "新增");
					this.renderJsp("/views/nav/menu/two/menu.jsp");
				} else if(pm.getMenuType().equals(PropKit.use("constants.txt").get("menu_type_gj"))) {
					List<Dict> modeList = DictionaryManager.getInstance().
							getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
					
					this.setAttr("pm", pm);
					this.setAttr("modeList", modeList);
					this.setAttr("menu_pid", menu_pid);
					this.setAttr("operation", "新增");
					this.renderJsp("/views/nav/menu/two/country.jsp");
				} else if(pm.getMenuType().equals(PropKit.use("constants.txt").get("menu_type_xm"))) {
					List<Dict> modeList = DictionaryManager.getInstance().
							getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
					
					List<Dictionary> projectTypeList = Dictionary.dao.find("SELECT "+
												"d.dict_code, "+
												"d.`name` "+
											"FROM "+
												"console_dictionary d "+
											"WHERE "+
												"d.delete_flag = '0' "+
											"AND d.dict_code LIKE '"+PropKit.use("constants.txt").get("project_type")+"0%' "+
											"ORDER BY "+
												"d.sort ASC");
					
					this.setAttr("pm", pm);
					this.setAttr("checked", "checked");
					this.setAttr("projectTypeList", projectTypeList);
					this.setAttr("modeList", modeList);
					this.setAttr("menu_pid", menu_pid);
					this.setAttr("operation", "新增");
					this.renderJsp("/views/nav/menu/two/project.jsp");
				}
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
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
				
				String dict_code = pp.getAllStr("dict_code");
				if(StringUtils.notEmpty(dict_code)) {
					nm.set("dict_code", dict_code);
				}
				
				nm.update();
				this.redirect("/official/nav/menu/two/"+nm.getMenuPid());
			} else {
				NavMenu pm = NavMenu.dao.findById(nm.getMenuPid());
				
				if(pm.getMenuType().equals(PropKit.use("constants.txt").get("menu_type_cdl"))) {
					List<Dict> modeList = DictionaryManager.getInstance().
							getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
					
					this.setAttr("pm", pm);
					this.setAttr("modeList", modeList);
					this.setAttr("menu_pid", nm.getMenuPid());
					this.setAttr("operation", "编辑");
					this.setAttr("menu", nm);
					this.renderJsp("/views/nav/menu/two/menu.jsp");
				} else if(pm.getMenuType().equals(PropKit.use("constants.txt").get("menu_type_gj"))) {
					List<Dict> modeList = DictionaryManager.getInstance().
							getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
					
					this.setAttr("pm", pm);
					this.setAttr("modeList", modeList);
					this.setAttr("menu_pid", nm.getMenuPid());
					this.setAttr("operation", "编辑");
					this.setAttr("menu", nm);
					this.renderJsp("/views/nav/menu/two/country.jsp");
				} else if(pm.getMenuType().equals(PropKit.use("constants.txt").get("menu_type_xm"))) {
					List<Dict> modeList = DictionaryManager.getInstance().
							getAllSubDictionaries(PropKit.use("constants.txt").get("open_mode"), 1).getSubDictionaries();
					
					List<Dict> projectTypeList = Dict.dao.find("SELECT "+
							"d.dict_code, "+
							"d.`name` "+
						"FROM "+
							"console_dictionary d "+
						"WHERE "+
							"d.delete_flag = '0' "+
						"AND d.dict_code LIKE '"+PropKit.use("constants.txt").get("project_type")+"0%' "+
						"ORDER BY "+
							"d.sort ASC");
					
					this.setAttr("pm", pm);
					this.setAttr("projectTypeList", projectTypeList);
					this.setAttr("modeList", modeList);
					this.setAttr("menu_pid", nm.getMenuPid());
					this.setAttr("operation", "编辑");
					this.setAttr("menu", nm);
					this.renderJsp("/views/nav/menu/two/project.jsp");
				}
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
	}
	
	
	/**
	 * 发布
	 */
	/*@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void release() {
		Map<String, Object> map = new HashMap<String, Object>();
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(StringUtils.notEmpty(id)) {
			NavMenu nm = NavMenu.dao.findById(id);
			nm.setMenuStatus(PropKit.use("constants.txt").get("menu_status_yfb"));
			nm.update();
			
			map.put("status", 0);
			map.put("msg", "修改成功");
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
		}
		renderJson(map);
	}*/
	
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
				NavMenu now = NavMenu.dao.findFirst("SELECT nav_menu_id, priority from official_nav_menu where priority > "+pr+
						" and delete_flag = 0 and menu_pid="+nm.getMenuPid()+" and menu_level=2 order by priority asc limit 1");
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
				NavMenu now = NavMenu.dao.findFirst("SELECT nav_menu_id, priority from official_nav_menu where priority < "+pr+
						" and delete_flag = 0 and menu_pid="+nm.getMenuPid()+" and menu_level=2 order by priority desc limit 1");
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
	private class NavMenuTwoParams extends ParamsParser {

		public NavMenuTwoParams(Controller ct) {
			super(ct);
			this.setSelectStr("SELECT "+
						"nm.nav_menu_id, "+
						"nm.menu_name, "+
						"nm.menu_url, "+
						"( "+
							"SELECT "+
								"d. NAME "+
							"FROM "+
								"console_dictionary d "+
							"WHERE "+
								"d.delete_flag = 0 "+
							"AND d.dict_code = nm.open_mode "+
						") open_mode_name");
			
			this.setFromStr("FROM official_nav_menu nm");
			this.addWhereSegmentByAnd("nm.delete_flag = 0");
			this.addWhereSegmentByAnd("nm.menu_level = 2");
			this.addWhereSegmentByAnd("nm.menu_pid = "+this.getId());
			this.setDefaultOrderStr("ORDER BY nm.priority DESC");
		}
		
	}
}
