package cn.pacificimmi.common.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.Menu;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.models.Websys;
import cn.pacificimmi.common.utils.MD5Util;
import cn.pacificimmi.common.utils.StringUtil;

public class IndexController extends Controller {
	private static Logger log = LoggerFactory.getLogger(IndexController.class);
	/****
	 * 默认初始化页面
	 */
	public void index(){
		LoginUserInfo ui =getSessionAttr("LoginUserInfo");
		if(ui==null){
			String sysname = PropKit.get("sysname", "微站后台管理系统");
			setAttr("sysname",sysname);

			this.renderJsp("/views/login.jsp");
		}else{
			String menus = ui.getMenuListHtml("/");
			setAttr("menus", menus);
			this.renderJsp("/views/indexPage.jsp");
		}
	}
	
	/**
	 * 密码修改
	 */
	public void password(){
		String password = getPara("password");//新密码
		String oldPassword = getPara("oldpass");//原密码
		if(password==null){
			Map<String,Object> result = new HashMap<String,Object>();
			result.put("status", 1);
			result.put("msg", "param error");
			this.renderJson(result);
		}
		else if(this.getSessionAttr("LoginUserInfo")==null){
			Map<String,Object> result = new HashMap<String,Object>();
			result.put("status", 2);
			result.put("msg", "error");
			this.renderJson(result);
		}
		else{
			Map<String,Object> result = new HashMap<String,Object>();
			LoginUserInfo ui =getSessionAttr("LoginUserInfo");
			
			//校验原密码是否正确
			Record r = Db.findFirst("select user_id from console_user where user_id='" + ui.getUid() + "' and password ='" + MD5Util.MD5(oldPassword) + "'");
			if(r == null){
				result.put("status", 400);//制定原密码错误返回400,以区别其他
				result.put("msg", "原密码错误!");
			}else{
				Db.update("update console_user set password='"+MD5Util.MD5(password)+"' where user_id='"+ui.getUid()+"'");
				
				result.put("status", 0);
				result.put("msg", "success");
			}
			this.renderJson(result);
		}
	}
	
	/**
	 * 原密码输入校验
	 */
	@Clear
	public void valiOldPassword(){
		String oldPassword = getPara("oldpass");//原密码
		Map<String,Object> result = new HashMap<String,Object>();
		LoginUserInfo ui =getSessionAttr("LoginUserInfo");
		
		//校验原密码是否正确
		Record r = Db.findFirst("select user_id from console_user where user_id='" + ui.getUid() + "' and password ='" + MD5Util.MD5(oldPassword) + "'");
		if(r == null){
			result.put("status", 400);//制定原密码错误返回400,以区别其他
			result.put("msg", "原密码错误!");
		}else{
			result.put("status", 0);
			result.put("msg", "success");
		}
		this.renderJson(result);
	}
	
	/**
	 * 没有权限
	 */
	public void noPermissions(){
		log.info("无权限,跳转提示页面");
		this.setAttr("errorInfo","对不起!您尚未分配该权限!如有疑问请联系权限管理员.");
		this.renderJsp("common/error.jsp");
	}
	
	/**
	 * 登录请求处理
	 */
//	public void login(){
//		String username = getPara("username");
//		String password = getPara("password");
//		//系统id
//		String systemid="2";
//
//		/**
//		 * 加载用户信息
//		 */
//		LoginUserInfo ui = new LoginUserInfo();
//		//超级用户特殊处理,不允许admin登录业务系统
//		if(username!=null && !username.isEmpty() && !username.equals("admin") && StringUtil.validateFieldName(username)
//			&& password!=null && !password.isEmpty()){
//			User user = User.dao.findFirst("select * from console_user where login_name='"+username+"'");
//			if(user!=null && user.getPassword().equals(MD5Util.MD5(password))){
//				ui.setUid(String.valueOf(user.getInt("user_id")));
//				ui.setUserName(user.getStr("user_name"));
//				ui.setHeadImg(user.getStr("head_img"));
//				ui.setLoginName(user.getStr("login_name"));
//				
//				ArrayList<Menu> menus ;
//				
////				if(username.equals("admin"))
////					menus = loadMainMenuBySupper(systemid);
////				else
//				menus= loadMainMenu(systemid,String.valueOf(user.getUserId()));
//				ui.setMenus(menus);
//				
//				//加载当前用户的权限列表
//				ui.setPathCode(getResources(systemid,String.valueOf(user.getUserId())));
//				
//				//保存到session中，分布式情况可考虑memcache的session共享
//				this.setSessionAttr("LoginUserInfo", ui);
//				this.redirect("/");
//			}
//			else{
//				this.redirect("/");
//			}
//		}
//		else{
//			this.redirect("/");
//		}
//	}
	/**
	 * 登录请求处理
	 */
	public void login(){
		String username = getPara("username");
		String password = getPara("password");
		//系统id
		String systemid=PropKit.get("sysid");
		String rolesystem = PropKit.get("rolesystem");
		if(!rolesystem.endsWith("/"))
			rolesystem+="/";
		StringBuffer bf = new StringBuffer();
		bf.append(rolesystem);
		bf.append("APILogin?");
		bf.append("username=").append(username).append("&");
		bf.append("password=").append(password).append("&");
		bf.append("sysid=").append(systemid);
		try{
			String jsonStr = StringUtil.doGet(bf.toString());
			JSONObject rst = new JSONObject(jsonStr);
			if(rst.getInt("status")==0){
				LoginUserInfo lui = new LoginUserInfo();
				String luiStr = rst.getJSONObject("userinfo").toString();
				lui.loadFromJson(luiStr);
				this.setSessionAttr("LoginUserInfo", lui);
				
				ArrayList<Websys> wss = new ArrayList<Websys>();
				JSONArray platforms = rst.getJSONArray("platforms");
				for(int i=0;i<platforms.length();i++){
					JSONObject jo =  platforms.getJSONObject(i);
					Websys ws = new Websys();
					ws.setName(jo.getString("name"));
					ws.setDomain(jo.getString("url"));
					ws.setOathurl(jo.getString("tokenLoginUrl"));
					wss.add(ws);
				}
				this.setSessionAttr("platforms", wss);
				this.redirect("/");
			}
			else
			{
				this.redirect("/");
			}
		}
		catch(Exception e){
			this.redirect("/");
		}
	}
	
	/**
	 * 登录请求处理
	 */
	public void tokenLogin(){
		String token = getPara("token");
		//系统id
		String systemid=PropKit.get("sysid");
		String rolesystem = PropKit.get("rolesystem");
		if(!rolesystem.endsWith("/"))
			rolesystem+="/";
		StringBuffer bf = new StringBuffer();
		bf.append(rolesystem);
		bf.append("APITokenLogin?");
		bf.append("token=").append(token).append("&");
		bf.append("sysid=").append(systemid);
		try{
			String jsonStr = StringUtil.doGet(bf.toString());
			JSONObject rst = new JSONObject(jsonStr);
			if(rst.getInt("status")==0){
				LoginUserInfo lui = new LoginUserInfo();
				String luiStr = rst.getJSONObject("userinfo").toString();
				lui.loadFromJson(luiStr);
				this.setSessionAttr("LoginUserInfo", lui);
				
				ArrayList<Websys> wss = new ArrayList<Websys>();
				JSONArray platforms = rst.getJSONArray("platforms");
				for(int i=0;i<platforms.length();i++){
					JSONObject jo =  platforms.getJSONObject(i);
					Websys ws = new Websys();
					ws.setName(jo.getString("name"));
					ws.setDomain(jo.getString("url"));
					ws.setOathurl(jo.getString("tokenLoginUrl"));
					wss.add(ws);
				}
				this.setSessionAttr("platforms", wss);
				
				this.redirect("/");
			}
			else
			{
				this.redirect("/");
			}
		}
		catch(Exception e){
			this.redirect("/");
		}
	}
	
	public void syslist(){
		String rolesystem = PropKit.get("rolesystem");
		if(!rolesystem.endsWith("/"))
			rolesystem+="/";
		rolesystem += "syslist";
		try {
			String json = StringUtil.doGet(rolesystem);
			this.renderJson(json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			this.renderJson("{status:500,msg:'visit api failure'}");
		}
	}
//	/**
//	 * 返回用户在当前系统中的所有权限路径
//	 * @param sysid
//	 * @param userid
//	 * @return
//	 */
//	private Hashtable<String,String> getResources(String sysid,String userid){
//		Hashtable<String,String> resources = new Hashtable<String,String>();
//		List<Record> futures = Db.find("SELECT * FROM console_resource where delete_flag='0' and sys_id='"+sysid+"' and res_id in (SELECT distinct(res_id) FROM console_user_station as mus,console_role_station as mrs,console_role_resource as mrr where mus.station_id=mrs.station_id and mrs.role_id=mrr.role_id and mus.user_id='"+userid+"') order by res_code asc;");
//		for(Record rd:futures){
//			String path = rd.getStr("url");
//			if(path!=null && !path.isEmpty()){
//				String code = rd.getStr("res_code");
//				resources.put(path, code);
//			}
//		}
//		return resources;
//	}
//	
//	/**
//	 * 增加一级菜单
//	 * @return
//	 */
//	private ArrayList<Menu> loadMainMenu(String sysid,String userid){
//		//加载层级菜单
//		ArrayList<Menu> menus = new ArrayList<Menu>();
//		Menu index = new Menu();
//		index.setId("0000");
//		index.setTitle("主页");
//		index.setIcon("icon-home");
//		index.setHref("/");
//		index.setResType("SYS_MENU");
//		menus.add(index);
//		
//		List<Record> futures = Db.find("SELECT * FROM console_resource where  delete_flag='0' and length(res_code)=8 and delete_flag=0 and res_type='SYS_MENU' and sys_id='"+sysid+"' and res_id in (SELECT distinct(res_id) FROM console_user_station as mus,console_role_station as mrs,console_role_resource as mrr where mus.station_id=mrs.station_id and mrs.role_id=mrr.role_id and mus.user_id='"+userid+"') order by sort desc;");
//
//		for(Record rd:futures){
//			Menu menu = new Menu();
//			menu.setId(rd.getStr("res_code"));
//			menu.setTitle(rd.getStr("name"));
//			menu.setIcon(rd.getStr("icon"));
//			menu.setHref(rd.getStr("url"));
//			menu.setResType(rd.getStr("res_type"));
//			
//			ArrayList<Menu> submenus =loadSubMenu(rd.getStr("res_code"));
//			if(submenus.size()>0)
//				menu.setSubMenu(submenus);
//				menus.add(menu);
//			}
//		return menus;
//	}
//	
//	/**
//	 * 增加一级菜单
//	 * @return
//	 */
//	private ArrayList<Menu> loadMainMenuBySupper(String sysid){
//		//加载层级菜单
//				ArrayList<Menu> menus = new ArrayList<Menu>();
//				Menu index = new Menu();
//				index.setId("0000");
//				index.setTitle("主页");
//				index.setIcon("icon-home");
//				index.setHref("/");
//				index.setResType("SYS_MENU");
//				menus.add(index);
//				
//				List<Record> futures = Db.find("SELECT * FROM console_resource where delete_flag='0' and length(res_code)=8 and res_type='SYS_MENU' and sys_id='"+sysid+"' order by sort desc;");
//				
//				for(Record rd:futures){
//					Menu menu = new Menu();
//					menu.setId(rd.getStr("res_code"));
//					menu.setTitle(rd.getStr("name"));
//					menu.setIcon(rd.getStr("icon"));
//					menu.setHref(rd.getStr("url"));
//					menu.setResType(rd.getStr("res_type"));
//					ArrayList<Menu> submenus =loadSubMenu(rd.getStr("res_code"));
//					if(submenus.size()>0)
//						menu.setSubMenu(submenus);
//					menus.add(menu);
//				}
//		return menus;
//	}
//	
//	/***
//	 * 递归加载子菜单
//	 * @param code
//	 * @return
//	 */
//	private ArrayList<Menu> loadSubMenu(String code){
//		ArrayList<Menu> menus = new ArrayList<Menu>();
//		List<Record> futures = Db.find("SELECT * FROM console_resource where res_code like '"+code+"%' and res_type='SYS_MENU' and delete_flag=0 and length(res_code)="+(code.length()+4)+" order by sort desc;");
//		for(Record rd:futures){
//			Menu menu = new Menu();
//			menu.setId(rd.getStr("res_code"));
//			menu.setIcon(rd.getStr("icon"));
//			menu.setTitle(rd.getStr("name"));
//			menu.setHref(rd.getStr("url"));
//			menu.setResType(rd.getStr("res_type"));
//			ArrayList<Menu> submenus =loadSubMenu(rd.getStr("res_code"));
//			if(submenus.size()>0)
//				menu.setSubMenu(submenus);
//			menus.add(menu);
//		}
//		return menus;
//	}

	/****
	 * 登出请求处理
	 */
	public void loginOut(){
		this.removeSessionAttr("LoginUserInfo");
		this.redirect("/");
	}
}
