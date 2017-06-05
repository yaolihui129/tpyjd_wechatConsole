package cn.pacificimmi.official.controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.AboutNav;
import cn.pacificimmi.common.models.Configs;
import cn.pacificimmi.common.models.LoginUserInfo;

@Before(LoginInterCeptor.class)
public class AboutController extends Controller {
	private Logger log = LoggerFactory.getLogger(AboutController.class);
	protected Prop dp = PropKit.use("debug_config.txt");
	/**
	 * 列表页
	 */
	public void index() {
		List<AboutNav> list = AboutNav.dao.find("select * from official_about_nav order by sort asc");
		this.setAttr("aboutlist", list);
		this.renderJsp("/views/official/about/about_list.jsp");
	}
	
	
	
	/**
	 * 公司简介
	 */
	public void introduction(){
		aboutMenu("公司简介");
		this.setAttr("PREVIEW_URL", dp.get("OFFICIAL_URL") + "/about-us/profilePreview");
	}
	
	/**
	 * 诚邀合作
	 */
	public void invitation(){
		aboutMenu("诚邀合作");
		this.setAttr("PREVIEW_URL", dp.get("OFFICIAL_URL") + "/about-us/cooperationPreview");
	}
	
	/**
	 * 投诉建议
	 */
	public void suggestions(){
		aboutMenu("投诉建议");
		this.setAttr("PREVIEW_URL", dp.get("OFFICIAL_URL") + "/about-us/suggestionsPreview");
	}	
	
	public void aboutMenu(String code){
		Configs c = Configs.dao.findFirst("select * from official_configs where code = '"+code+"'");
		this.setAttr("config", c);
		this.renderJsp("/views/official/about/common.jsp");
	}
	
	/**
	 * 保存配置
	 */
	@Clear
	public void saveConfig(){
		ParamsParser pp = new ParamsParser(this);
		String v = pp.getAllStr("contents");
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			Configs c = Configs.dao.findById(pp.getId());
			c.setValue(v);
			c.setStatus("未发布");
			c.update();
			
			rst.put("status", 0);
			rst.put("msg", "保存成功");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", "保存失败");
		}
		this.renderJson(rst);
		
	}
	
	/**
	 * 发布配置
	 */
	@Clear
	public void pubConfig(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			Configs c = Configs.dao.findById(pp.getId());
			c.setStatus("已发布");
			c.update();
			
			rst.put("status", 0);
			rst.put("msg", "发布成功");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", "发布失败");
		}
		this.renderJson(rst);
	}
	
	/**
	 * 上移
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void upsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		AboutNav r = AboutNav.dao.findById(id);
		AboutNav r1= findPreOrNextOne(id,true);
		
		if(r!=null && r1!=null){
			//交换排序
			int t1 = r.getSort();
			int t2 = r1.getSort();
			
			r.setSort(t2);
			r.update();
			
			r1.setSort(t1);
			r1.update();

			rst.put("status", 0);
			rst.put("msg", "上移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "上移失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * 下移
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void downsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		AboutNav r = AboutNav.dao.findById(id);
		AboutNav r1= findPreOrNextOne(id,false);
		if(r!=null && r1!=null){
			//交换排序
			int t1 = r.getSort();
			int t2 = r1.getSort();
			
			r.setSort(t2);
			r.update();
			
			r1.setSort(t1);
			r1.update();
			
			rst.put("status", 0);
			rst.put("msg", "下移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "下移失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * @param id 当前id
	 * @param flag true 上一个     false  下一个
	 * @return 
	 */
	private AboutNav findPreOrNextOne(String id,boolean flag){
		AboutNav r = AboutNav.dao.findById(Integer.parseInt(id));
		if(r!=null){
			List<AboutNav> rs = AboutNav.dao.find("select * from official_about_nav  order by sort asc");
			AboutNav pre=null;
			AboutNav next=null;
			for(int i=0;i<rs.size();i++){
				AboutNav rt = rs.get(i);
				if(rt.getOanId() == Integer.valueOf(id)){
					int pidx=i-1;
					int nidx=i+1;
					if(pidx>-1)
						pre=rs.get(pidx);
					if(nidx<rs.size())
						next=rs.get(nidx);
				}
			}
			//上一个
			if(flag){
				return pre;
			}
			else{
				return next;
			}
		}else{
			return null;
		}
		
	}
	
	/**
	 * 保存
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void edit(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		LoginUserInfo u = getSessionAttr("LoginUserInfo");
		try{
			String oanId = pp.getAllStr("oan_id");
			String navName = pp.getAllStr("nav_name");
			String navUrl = pp.getAllStr("nav_url");
			
			AboutNav nav = AboutNav.dao.findById(oanId);
			nav.setNavName(navName);
			nav.setNavUrl(navUrl);
			nav.setEditTime(new Date());
			nav.setEditor(u.getLoginName());
			nav.update();
			
			rst.put("status", 0);
			rst.put("msg", "保存成功");
		}catch(Exception e){
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "保存失败");
		}
		this.renderJson(rst);
	}
}
