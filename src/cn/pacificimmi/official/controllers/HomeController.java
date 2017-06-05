package cn.pacificimmi.official.controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Configs;
import cn.pacificimmi.common.models.Country;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Memorabilia;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.utils.CommonHelper;
import cn.pacificimmi.common.utils.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

@Before(LoginInterCeptor.class)
public class HomeController extends Controller {
	private Logger log = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * 首页设置
	 */
	public void index() {
		log.info("跳转到首页");
		this.redirect("/");
	}
	/**
	 * 跳转基本设置页 显示成功案例设置页
	 * 包括 -成功案例
	 * 	  -移民评估
	 *    -政策动态的设置
	 *    成功案例保存在official_configs表中
	 */
	public void successfulCase(){
		log.info("首页设置-基本设置-成功案例");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getAllStr("operation");
		String sql = "select * from official_configs where code = '成功案例设置' and type='首页设置'";
		Configs configs = Configs.dao.findFirst(sql);
		if(StringUtils.notEmpty(operation)){
			log.info("保存成功案例信息");
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			String successful_case_num = pp.getAllStr("successful_case_num");
			String successful_case_rate = pp.getAllStr("successful_case_rate");
			Map<String,Object> maps = new HashMap<String, Object>();
			maps.put("successful_case_num", successful_case_num);
			maps.put("successful_case_rate", successful_case_rate);
			JSONObject obj = new JSONObject(maps);
			if(CommonHelper.isNullOrEmpty(configs)){
				configs = new Configs();
				configs.setCode("成功案例首页设置");
				configs.setValue(obj.toString());
				configs.setEditor(user.getLoginName());
				configs.setEditTime(new Date());
				configs.setType("首页设置");
				configs.save();
			}else{
				configs.setValue(obj.toString());
				configs.setEditor(user.getLoginName());
				configs.setEditTime(new Date());
				configs.update();
			}
			this.setAttr("successful_case_num", successful_case_num);//成功案例首页推荐的篇数 
			this.setAttr("successful_case_rate", successful_case_rate);//成功案例轮播频率
			this.setAttr("operation", "编辑");
			this.setAttr("saveSuccess", 1);
			this.renderJsp("/views/official/home/successful_case.jsp");
			
		}else{
			log.info("跳转首页设置，基本信息--成功案例编辑页面！");
			if(!CommonHelper.isNullOrEmpty(configs)){
				String value = configs.get("value");
				JSONObject obj = JSON.parseObject(value);
				this.setAttr("successful_case_num", obj.get("successful_case_num"));//成功案例首页推荐的篇数 
				this.setAttr("successful_case_rate", obj.get("successful_case_rate"));//成功案例轮播频率
			}
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/official/home/successful_case.jsp");
		}
	}
	
	public void estimateNumber(){
		log.info("首页设置-基本设置-移民评估");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getAllStr("operation");
		String sql = "select * from official_configs where code = '移民评估人数基数' and type='首页设置'";
		Configs configs = Configs.dao.findFirst(sql);
		LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
		if(StringUtils.notEmpty(operation)){
			log.info("保存移民评估人数基数");
			if(CommonHelper.isNullOrEmpty(configs)){
				configs = new Configs();
				configs.setCode("移民评估人数基数");
				configs.setValue(pp.getAllStr("estimate_num"));
				configs.setEditor(user.getLoginName());
				configs.setEditTime(new Date());
				configs.setType("首页设置");
				configs.save();
			}else{
				configs.setValue(pp.getAllStr("estimate_num"));
				configs.setEditor(user.getLoginName());
				configs.setEditTime(new Date());
				configs.update();
			}
			this.setAttr("estimate_num", pp.getAllStr("estimate_num"));
			this.setAttr("operation", "编辑");
			this.setAttr("saveSuccess", 1);
			this.renderJsp("/views/official/home/estimate_num.jsp");
		}else{
			log.info("跳转首页设置，基本信息-移民评估！");
			if(!CommonHelper.isNullOrEmpty(configs)){
				String value = configs.get("value");
				//JSONObject obj = JSON.parseObject(value);
				this.setAttr("estimate_num", value);//成功案例首页推荐的篇数 
			}
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/official/home/estimate_num.jsp");	
		}
	}
	
	public void policyDynamic(){
		log.info("首页设置-基本设置-政策动态");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getAllStr("operation");
		String sql = "select * from official_configs where code = '政策动态' and type='首页设置'";
		Configs configs = Configs.dao.findFirst(sql);
		LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
		if(StringUtils.notEmpty(operation)){
			log.info("保存政策动态");
			if(CommonHelper.isNullOrEmpty(configs)){
				configs = new Configs();
				configs.setCode("政策动态");
				configs.setValue(pp.getAllStr("policy_dynamic"));
				configs.setEditor(user.getLoginName());
				configs.setEditTime(new Date());
				configs.setType("首页设置");
				configs.save();
			}else{
				configs.setValue(pp.getAllStr("policy_dynamic"));
				configs.setEditor(user.getLoginName());
				configs.setEditTime(new Date());
				configs.update();
			}
			this.setAttr("policy_dynamic", pp.getAllStr("policy_dynamic"));
			this.setAttr("operation", "编辑");
			this.setAttr("code", 0);
			this.renderJson();
		}else{
			log.info("跳转首页设置，基本信息-政策动态！");
			if(!CommonHelper.isNullOrEmpty(configs)){
				String value = configs.get("value");
				//JSONObject obj = JSON.parseObject(value);
				this.setAttr("policy_dynamic", value);//成功案例首页推荐的篇数 
			}
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/official/home/policy_dynamic.jsp");
		}
	}
	/**
	 * 优选国家列表
	 */
	public void preferenceCountryList(){
		log.info("进入优选国家列表页");
		String sql = "select * from crm_country where preferred = '1' and release_status = '1' and delete_flag = '0' order by sort desc";
		List<Country> countryList = Country.dao.find(sql);
		this.setAttr("countryList", countryList);
		this.renderJsp("/views/official/home/preference_country_list.jsp");
		
	}
	/**
	 * 添加优选国家
	 */
	public void addPreferenceCountry(){
		log.info("添加优选国家");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getAllStr("operation");
			
		if(StringUtils.notEmpty(operation)){
			log.info("保存优选国家");
			String country_id = pp.getAllStr("country_id");
			String preferred_pic = pp.getAllStr("preferred_pic");
			String old_country_id = pp.getAllStr("old_country_id");
			Country country = Country.dao.findById(country_id);
			Country oldcountry = Country.dao.findById(old_country_id);
			if(CommonHelper.isNullOrEmpty(country)){
				log.info("未找到国家信息，跳转到优选国家列表页");
				this.setAttr("code", 1);
				this.renderJson();
			}else{
				if(!CommonHelper.isNullOrEmpty(oldcountry)){
					oldcountry.setPreferred(0);
					oldcountry.setPreferredPic(null);
					oldcountry.setSort(null);
					oldcountry.update();
				}
				country.setPreferred(1);
				country.setPreferredPic(preferred_pic);
				String firstCountrySql = "select * from crm_country where release_status = '1' and delete_flag = '0' and preferred = '1'  order by sort desc";
				Country firstCountrySort = Country.dao.findFirst(firstCountrySql);
				if(!CommonHelper.isNullOrEmpty(firstCountrySort)){
					int sort = firstCountrySort.getSort();
					if(sort > 0){
						country.setSort(sort+1);
					}else{
						country.setSort(1);
					}
				}else{
					country.setSort(1);
				}
				country.update();
				this.setAttr("code", 0);
				this.renderJson();
				
			}
		}else{
			String country_id = pp.getAllStr("country_id");
			Country country = Country.dao.findById(country_id);
			if(CommonHelper.isNullOrEmpty(country)){
				log.info("跳转到添加优选国家页面--添加");
				this.setAttr("operation", "编辑");
				String sql = "select * from crm_country where release_status = '1' and delete_flag = '0' and preferred = '0'";
				List<Country> countryList = Country.dao.find(sql);
				this.setAttr("countryList", countryList);
				this.renderJsp("/views/official/home/preference_country_add.jsp");
			}else{
				log.info("跳转到添加优选国家页面--编辑");
				this.setAttr("country", country);
				this.setAttr("operation", "编辑");
				String sql = "select * from crm_country where release_status = '1' and delete_flag = '0' and preferred = '0'";
				List<Country> countryList = Country.dao.find(sql);
				this.setAttr("countryList", countryList);
				this.renderJsp("/views/official/home/preference_country_add.jsp");
			}
		}
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void countryupsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		Country t = Country.dao.findById(id);
		Country t1 = findPreOrNextOneCountry(id,true);
		
		if(t!=null && t1!=null){
			if(t.getSort()==t1.getSort()){
				t.setSort(t.getSort()+1);
				t.update();
			}
			else{
				int sort = t1.getSort();
				t1.setSort(t.getSort());
				t1.update();
				t.setSort(sort);
				t.update();
			}

			rst.put("status", 0);
			rst.put("msg", "上移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "已经置顶");
			this.renderJson(rst);
		}
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void countrydownsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		Country t = Country.dao.findById(id);
		Country t1= findPreOrNextOneCountry(id,false);
		if(t!=null && t1!=null){
			if(t.getSort()==t1.getSort()){
				t1.setSort(t1.getSort()+1);
				t1.update();
			}
			else{
				int sort = t1.getSort();
				t1.setSort(t.getSort());
				t1.update();
				t.setSort(sort);
				t.update();
			}
			
			rst.put("status", 0);
			rst.put("msg", "下移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "已经置底");
			this.renderJson(rst);
		}
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void countrytopsort(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Country c = Country.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(c!=null){
			int sort=10000;
			Record rd = Db.findFirst("select * from crm_country where delete_flag='0' order by sort desc");
			if(rd!=null && rd.getInt("sort")!=null){
				sort = rd.getInt("sort");
			}
			sort++;
			c.setSort(sort);
			c.update();
			rst.put("status", 0);
			rst.put("msg", "置顶成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "置顶失败");
			this.renderJson(rst);
		}
	}
	
	private Country findPreOrNextOneCountry(String id,boolean flag){
		List<Country> countrys = Country.dao.find("select * from crm_country where release_status = '1' and delete_flag='0' and preferred = '1' order by sort desc");
		Country pre=null;
		Country next=null;
		for(int i=0;i<countrys.size();i++){
			Country c = countrys.get(i);
			if(c.getId()==Integer.valueOf(id)){
				int pidx=i-1;
				int nidx=i+1;
				if(pidx>-1)
					pre=countrys.get(pidx);
				if(nidx<countrys.size())
					next=countrys.get(nidx);
			}
		}
		//上一个
		if(flag){
			return pre;
		}
		else{
			return next;
		}
	}
	///热门项目
	/**
	 * 添加热门项目
	 */
	public void addHotProject(){
		log.info("添加热门项目");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getAllStr("operation");
			
		if(StringUtils.notEmpty(operation)){
			log.info("保存热门项目");
			String project_id = pp.getAllStr("project_id");
			String preferred_pic = pp.getAllStr("preferred_pic");
			String old_project_id = pp.getAllStr("old_project_id");
			Project project = Project.dao.findById(project_id);
			Project oldproject = Project.dao.findById(old_project_id);
			if(CommonHelper.isNullOrEmpty(project)){
				log.info("未找到热门项目信息，跳转到热门项目列表页");
				this.setAttr("code", 1);
				this.renderJson();
			}else{
				if(!CommonHelper.isNullOrEmpty(oldproject)){
					oldproject.setPreferred(0);
					oldproject.setPreferredPic(null);
					oldproject.setHotSort(null);
					oldproject.update();
				}
				project.setPreferred(1);
				project.setPreferredPic(preferred_pic);
				String firstProSql = "select * from crm_project where delete_flag = '0' and preferred = '1' and project_status = "+PropKit.use("constants.txt").get("project_status_sx")+" order by hot_sort desc";
				Project firstPro = Project.dao.findFirst(firstProSql);
				if(!CommonHelper.isNullOrEmpty(firstPro)){
					int sort = firstPro.getHotSort();
					if(sort > 0){
						project.setHotSort(sort+1);
					}else{
						project.setHotSort(1);
					}
				}else{
					project.setHotSort(1);
				}
				project.update();
				this.setAttr("code", 0);
				this.renderJson();
				
			}
		}else{
			String project_id = pp.getAllStr("project_id");
			Project project = Project.dao.findById(project_id);
			if(CommonHelper.isNullOrEmpty(project)){
				log.info("跳转到添加热门项目页面--添加");
				this.setAttr("operation", "编辑");
				String sql = "select * from crm_project where preferred = '0' and project_status = "+PropKit.use("constants.txt").get("project_status_sx")+" and delete_flag = '0'";
				List<Project> projectList = Project.dao.find(sql);
				this.setAttr("projectList", projectList);
				this.renderJsp("/views/official/home/hot_project_add.jsp");
			}else{
				log.info("跳转到添加热门项目页面--编辑");
				this.setAttr("project", project);
				this.setAttr("operation", "编辑");
				String sql = "select * from crm_project where preferred = '0' and project_status = "+PropKit.use("constants.txt").get("project_status_sx")+" and delete_flag = '0'";
				List<Project> projectList = Project.dao.find(sql);
				this.setAttr("projectList", projectList);
				this.renderJsp("/views/official/home/hot_project_add.jsp");
			}
		}
	}
	
	/**
	 * 热门项目列表
	 */
	public void hotProjectList(){
		log.info("进入热门项目列表页");
		String sql = "select * from crm_project where preferred = '1' and project_status = "+PropKit.use("constants.txt").get("project_status_sx")+" and delete_flag = '0' order by hot_sort desc";
		List<Project> projectList = Project.dao.find(sql);
		this.setAttr("projectList", projectList);
		this.renderJsp("/views/official/home/hot_project_list.jsp");
		
	}
	

	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void projectupsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		Project t = Project.dao.findById(id);
		Project t1 = findPreOrNextOneProject(id,true);
		
		if(t!=null && t1!=null){
			if(t.getHotSort()==t1.getHotSort()){
				t.setHotSort(t.getHotSort()+1);
				t.update();
			}
			else{
				int sort = t1.getHotSort();
				t1.setHotSort(t.getHotSort());
				t1.update();
				t.setHotSort(sort);
				t.update();
			}

			rst.put("status", 0);
			rst.put("msg", "上移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "已经置顶");
			this.renderJson(rst);
		}
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void projectdownsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		Project t = Project.dao.findById(id);
		Project t1= findPreOrNextOneProject(id,false);
		if(t!=null && t1!=null){
			if(t.getHotSort()==t1.getHotSort()){
				t1.setHotSort(t1.getHotSort()+1);
				t1.update();
			}
			else{
				int sort = t1.getHotSort();
				t1.setHotSort(t.getHotSort());
				t1.update();
				t.setHotSort(sort);
				t.update();
			}
			
			rst.put("status", 0);
			rst.put("msg", "下移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "已经置底");
			this.renderJson(rst);
		}
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void projecttopsort(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Project c = Project.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(c!=null){
			int sort=10000;
			Record rd = Db.findFirst("select * from crm_project where delete_flag='0' order by hot_sort desc");
			if(rd!=null && rd.getInt("hot_sort")!=null){
				sort = rd.getInt("hot_sort");
			}
			sort++;
			c.setHotSort(sort);
			c.update();
			rst.put("status", 0);
			rst.put("msg", "置顶成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "置顶失败");
			this.renderJson(rst);
		}
	}
	
	private Project findPreOrNextOneProject(String id,boolean flag){
		List<Project> projects = Project.dao.find("select * from crm_project where delete_flag='0' and preferred = '1' order by hot_sort desc");
		Project pre=null;
		Project next=null;
		for(int i=0;i<projects.size();i++){
			Project c = projects.get(i);
			if(c.getProjectId()==Integer.valueOf(id)){
				int pidx=i-1;
				int nidx=i+1;
				if(pidx>-1)
					pre=projects.get(pidx);
				if(nidx<projects.size())
					next=projects.get(nidx);
			}
		}
		//上一个
		if(flag){
			return pre;
		}
		else{
			return next;
		}
	}
	/**
	 * 公司大事记
	 */
	public void companyMemorabilia(){
		
		this.renderJsp("/views/official/home/memorabilia.jsp");
	}
	
	/**
	 * 保存公司大事记
	 */
	@Clear
	public void saveMemorabilia(){
		ParamsParser pp = new ParamsParser(this);
		LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
		String position = pp.getAllStr("position");
		String screen = pp.getAllStr("screen");
		String pic_url = pp.getAllStr("pic_url");
		String describe = pp.getAllStr("describe");
		String sql = "select * from official_memorabilia where screen = "+screen+" and position = " + position;
		Memorabilia memorabilia = Memorabilia.dao.findFirst(sql);
		if(CommonHelper.isNullOrEmpty(memorabilia)){
			memorabilia = new Memorabilia();
			memorabilia.setScreen(Integer.valueOf(screen));
			memorabilia.setPosition(Integer.valueOf(position));
			memorabilia.setPictureUrl(pic_url);
			memorabilia.setDescribe(describe);
			if(!CommonHelper.isNullOrEmpty(user)){
				memorabilia.setEditor(user.getLoginName());
				memorabilia.setEditorTime(new Date());
			}
			memorabilia.save();
		}else{
			memorabilia.setScreen(Integer.valueOf(screen));
			memorabilia.setPosition(Integer.valueOf(position));
			if(StringUtils.notEmpty(pic_url)){
				memorabilia.setPictureUrl(pic_url);
			}
			if(StringUtils.notEmpty(describe)){
				memorabilia.setDescribe(describe);
			}
			if(!CommonHelper.isNullOrEmpty(user)){
				memorabilia.setEditor(user.getLoginName());
			}
			memorabilia.setEditorTime(new Date());
			memorabilia.update();
		}
//		this.setAttr("saveSuccess", 1);
//		this.setAttr("code", 1);
		this.renderJson();
	}
	/**
	 * 查询公司大事记
	 */
	@Clear
	public void selectMemorabilia(){
		ParamsParser pp = new ParamsParser(this);
		LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
		String position = pp.getAllStr("position");
		String screen = pp.getAllStr("screen");
		if(StringUtils.notEmpty(screen)&&StringUtils.notEmpty(position)){
			String sql = "select * from official_memorabilia where screen = "+screen+" and position = " + position;
			Memorabilia memorabilia = Memorabilia.dao.findFirst(sql);
			if(CommonHelper.isNullOrEmpty(memorabilia)){
				this.setAttr("code", 1);
				this.renderJson();
			}else{
				this.setAttr("pic_url", memorabilia.getPictureUrl());
				this.setAttr("describe", memorabilia.getDescribe());
				this.setAttr("code", 0);
				this.renderJson();
			}
		}else{
			this.setAttr("code", 1);
			this.renderJson();
		}
	}
	/**
	 * 根据获取的第几屏幕发布公司大事记
	 */
	@Clear
	public void releaseMemorabilia(){
		ParamsParser pp = new ParamsParser(this);
		LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
		String screen = pp.getAllStr("screen");
		if(StringUtils.notEmpty(screen)){
			String sqlScreen = "select * from official_memorabilia where screen = "+screen;
			List<Memorabilia> memorabilias = Memorabilia.dao.find(sqlScreen);
			for(Memorabilia memorabilia:memorabilias){
				//遍历每个大事记对象，判断如果图片地址或者描述为空则返回提示信息
				if(!isPreRelease(memorabilia)){
					this.setAttr("code", 1);
					this.setAttr("msg", "第"+memorabilia.getScreen()+"屏的第"+memorabilia.getPosition()+"个位置的图片地址或描述为空，还不能发布...");
					this.renderJson();
					return;
				}
			}
			//再次遍历都改为发布状态
			for(Memorabilia memorabilia:memorabilias){
				//前面已经判断过，到这里时已经都具备发布状态，可以发布
				if(CommonHelper.isNullOrEmpty(user)){
					memorabilia.setPublisher(user.getLoginName());
				}
				memorabilia.setPublishTime(new Date());
				memorabilia.setPublishStatus("已发布");
				memorabilia.update();
			}
			this.setAttr("code", 0);
			this.renderJson();
		}else{
			this.setAttr("code", 1);
			this.setAttr("msg", "未选择第几屏幕进行发布");
			this.renderJson();
		}
	}
	
	@Clear
	public boolean isPreRelease(Memorabilia memorabilia){
		boolean isPre = true;
		if(StringUtils.isEmpty(memorabilia.getPictureUrl())){ isPre = false;}
		if(StringUtils.isEmpty(memorabilia.getPictureUrl())){ isPre = false;}
		return isPre;
	}
}
