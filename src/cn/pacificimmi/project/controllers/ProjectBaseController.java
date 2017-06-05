package cn.pacificimmi.project.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.models.ProjectExpands;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.utils.Client;
import cn.pacificimmi.common.utils.CrmUtils;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.project.models.view.CrmProject;

@Before(LoginInterCeptor.class)
public class ProjectBaseController extends Controller {
	
	private Logger log = LoggerFactory.getLogger(ProjectBaseController.class);
	
	public void index() {
		this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
	/**
	 * 新增
	 */
	public void add() {
		/**
		 * 添加
		 */
		LoginUserInfo ui = this.getSessionAttr("LoginUserInfo");
		User user = User.dao.findById(ui.getUid());
		
		ParamsParser pp = new ParamsParser(this);
		if(pp.getAllStr("operation") != null) {
			Project project = new Project();
			
			String project_name = this.getPara("project_name");
			if(StringUtil.notEmpty(project_name)) {
				project.set("project_name", project_name);
			}
			String project_type = pp.getAllStr("project_type");
			if(StringUtil.notEmpty(project_type)) {
				project.set("project_type", project_type);
			}
			String country = pp.getAllStr("country");
			if(StringUtil.notEmpty(country)) {
				project.set("country", country);
			}
			String city = pp.getAllStr("city");
			if(StringUtil.notEmpty(city)) {
				project.set("city", city);
			}
			String visa_type = pp.getAllStr("visa_type");
			if(StringUtil.notEmpty(visa_type)) {
				project.set("visa_type", visa_type);
			}
			String visa_type_description = pp.getAllStr("visa_type_description");
			if(StringUtil.notEmpty(visa_type_description)) {
				project.set("visa_type_description", visa_type_description);
			}
			String live_requirement = pp.getAllStr("live_requirement");
			if(StringUtil.notEmpty(live_requirement)) {
				project.set("live_requirement", live_requirement);
			}
			String live_requirement_description = pp.getAllStr("live_requirement_description");
			if(StringUtil.notEmpty(live_requirement_description)) {
				project.set("live_requirement_description", live_requirement_description);
			}
			String investments = pp.getAllStr("investments");
			if(StringUtil.notEmpty(investments)) {
				project.set("investments", investments);
			}
			String asset = pp.getAllStr("asset");
			if(StringUtil.notEmpty(asset)) {
				project.set("asset", asset);
			}
			String asset_description = pp.getAllStr("asset_description");
			if(StringUtil.notEmpty(asset_description)) {
				project.set("asset_description", asset_description);
			}
			String qualifications = pp.getAllStr("qualifications");
			if(StringUtil.notEmpty(qualifications)) {
				project.set("qualifications", qualifications);
			}
			String qualifications_description = pp.getAllStr("qualifications_description");
			if(StringUtil.notEmpty(qualifications_description)) {
				project.set("qualifications_description", qualifications_description);
			}
			String immigration_budget = pp.getAllStr("immigration_budget");
			if(StringUtil.notEmpty(immigration_budget)) {
				project.set("immigration_budget", immigration_budget);
			}
			String language = pp.getAllStr("language");
			if(StringUtil.notEmpty(language)) {
				project.set("language", language);
			}
			String language_description = pp.getAllStr("language_description");
			if(StringUtil.notEmpty(language_description)) {
				project.set("language_description", language_description);
			}
			String age = pp.getAllStr("age");
			if(StringUtil.notEmpty(age)) {
				project.set("age", age);
			}
			String age_description = pp.getAllStr("age_description");
			if(StringUtil.notEmpty(age_description)) {
				project.set("age_description", age_description);
			}
			String manage = pp.getAllStr("manage");
			if(StringUtil.notEmpty(manage)) {
				project.set("manage", manage);
			}
			String manage_description = pp.getAllStr("manage_description");
			if(StringUtil.notEmpty(manage_description)) {
				project.set("manage_description", manage_description);
			}
			String introduce = pp.getAllStr("introduce");
			if(StringUtil.notEmpty(introduce)) {
				project.set("introduce", introduce);
			}
			String advantage = this.getPara("advantage");
			if(StringUtil.notEmpty(advantage)) {
				project.set("advantage", advantage);
			}
			String recommended = pp.getAllStr("recommended");
			if(StringUtil.notEmpty(recommended)) {
				project.set("recommended", recommended);
			}
			String project_img = this.getPara("project_img");
			if(StringUtil.notEmpty(project_img)) {
				project.set("project_img", project_img);
			}
			String web_project_img = this.getPara("web_project_img");
			if(StringUtil.notEmpty(web_project_img)) {
				project.set("web_project_img", web_project_img);
			}
			
			project.set("project_status", PropKit.use("constants.txt").get("project_status_wkf"));
			project.set("create_time", new Date());
			project.set("delete_flag", 0);
			String code = getProjectCode(country, project_type);
			if(null != code) {
				project.setProjectCode(code);
			}
			String other_description = pp.getAllStr("other_description");
			if(null != other_description) {
				project.set("other_description", other_description);
			}
			project.set("create_user", ui.getUid());
			
			String project_level = this.getPara("project_level");
			if(StringUtil.notEmpty(project_level)) {
				project.set("project_level", project_level);
				
				String project_pid = this.getPara("project_pid");
				if(StringUtil.notEmpty(project_pid) && project_level.equals(PropKit.use("constants.txt").get("project_level_two"))) {
					project.set("project_pid", project_pid);
				}
			}
			
			Project nowP = Project.dao.findFirst("SELECT project_id, priority from crm_project where project_level="+project.getProjectLevel()+
					" AND delete_flag = 0 order by priority desc limit 1");
			if(null == nowP) {
				project.setPriority(1);
			} else {
				project.setPriority(nowP.getPriority()+1);
			}
			
			project.save();
			
			String[] pes = this.getParaValues("project_expands");
			if(null != pes && pes.length>0) {
				for(int i=0; i<pes.length; i++) {
					ProjectExpands pe = new ProjectExpands();
					pe.setDictCode(pes[i]);
					pe.setProjectId(project.getProjectId());
					pe.save();
				}
			}
			
			/*//同步crm start
			try {
				List<CrmProject> list = new ArrayList<CrmProject>();
				CrmProject cp = new CrmProject();
				cp.setProjectbh(project.getProjectCode());
				cp.setName(project.getProjectName());
				if(null != project.getProjectLevel()) {
					Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectLevel()+" and delete_flag=0");
					if(null != le && null != le.getName()) {
						cp.setProjectjb(le.getName());
					}
				}
				if(null != project.getCountry()) {
					Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getCountry()+" and delete_flag=0");
					if(null != le && null != le.getName()) {
						cp.setProjectcountry(le.getName());
					}
				}
				if(null != project.getProjectType()) {
					Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectType()+" and delete_flag=0");
					if(null != le && null != le.getName()) {
						cp.setXmlx(le.getName());
					}
				}
				if(null != project.getProjectStatus()) {
					Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectStatus()+" and delete_flag=0");
					if(null != le && null != le.getName()) {
						cp.setProjectzt(le.getName());
					}
				}
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String dateString = formatter.format(project.getCreateTime());
				cp.setCreatedate(dateString);
				list.add(cp);
				
				//存储到crm
				Map<String, String> par = new HashMap<String, String>();
				par.put("serviceName", "insert");
				par.put("objectApiName", "project");
				par.put("data", JSON.toJSONString(list));
				par.put("binding", CrmUtils.getBinding());
				String json = Client.doPost(PropKit.use("debug_config.txt").get("CRM_API_URL"), par);
				JSONObject crm = new JSONObject(json);
				
				//保存crm_id
				if(null != crm && crm.getBoolean("result") && "1".equals(crm.getString("returnCode"))) {
					JSONObject ids = (JSONObject) crm.getJSONObject("data").getJSONArray("ids").get(0);
					project.set("crm_id", ids.get("id"));
					project.update();
				} 
			} catch (IOException e) {
				e.printStackTrace();
				log.error("crm接口执行返回结果异常["+e.getMessage()+"]");
			}
			//同步crm end
*/			
			this.redirect("/project/base/update/"+project.getProjectId()+"?status=1");
		} else {
			/**
			 * 初始化新增页面
			 */
			List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
			List<Dict> projectTypeList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("project_type"), 2).getSubDictionaries();
			List<Dict> visaTypeList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("visa_type"), 1).getSubDictionaries();
			List<Dict> liveRequirementList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("live_requirement"), 1).getSubDictionaries();
			List<Dict> assetList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("asset"), 1).getSubDictionaries();
			List<Dict> manageList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("manage"), 1).getSubDictionaries();
			List<Dict> qualificationsList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("qualifications"), 1).getSubDictionaries();
			List<Dict> languageList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("language"), 1).getSubDictionaries();
			List<Dict> ageList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("age"), 1).getSubDictionaries();
			List<Dict> projectStatusList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("project_status"), 1).getSubDictionaries();
			List<Dict> expandsList = DictionaryManager.getInstance().
					getAllSubDictionaries(PropKit.use("constants.txt").get("project_expands"), 1).getSubDictionaries();
			List<Project> levelProjectList = Project.dao.find("select cp.project_id, cp.project_name from crm_project cp where cp.delete_flag=0 and cp.project_level="+
					PropKit.use("constants.txt").get("project_level_one")+" ORDER BY cp.priority");
			
			this.setAttr("countryList", countryList);
			this.setAttr("visaTypeList", visaTypeList);
			this.setAttr("liveRequirementList", liveRequirementList);
			this.setAttr("assetList", assetList);
			this.setAttr("manageList", manageList);
			this.setAttr("qualificationsList", qualificationsList);
			this.setAttr("languageList", languageList);
			this.setAttr("ageList", ageList);
			this.setAttr("projectTypeList", projectTypeList);
			this.setAttr("projectStatusList", projectStatusList);
			this.setAttr("expandsList", expandsList);
			this.setAttr("levelProjectList", levelProjectList);
			this.setAttr("project_level_one", PropKit.use("constants.txt").get("project_level_one"));
			this.setAttr("project_level_two", PropKit.use("constants.txt").get("project_level_two"));
			
			this.setAttr("operation", "新增");
			this.renderJsp("/views/project/project.jsp");
		}
	}
	
	/**
	 * 获取项目编号
	 * @param country_code
	 * @param project_type_code
	 * @return
	 */
	private String getProjectCode(String country_code, String project_type_code) {
		if(country_code == null || project_type_code == null) {
			return null;
		} else {
			Dictionary country = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+country_code+" and delete_flag=0");
			Dictionary project_type = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project_type_code+" and delete_flag=0");
			if(null == country || null == project_type || null == country.getValue() || null == project_type.getValue()) {
				return null;
			} else {
				List<Project> list = Project.dao.find("select project_code from crm_project where country="+country_code+" and delete_flag=0");
				String str ="001";
				if(list.size()>0) {
					List<Integer> nums = new ArrayList<Integer>();
					for(Project p : list) {
						if(null != p.getProjectCode() && !"".equals(p.getProjectCode())) {
							String code = p.getProjectCode();
							String c = code.substring(code.length()-3, code.length());
							nums.add(new Integer(c));
						}
					}
					if(nums.size()>0) {
						Collections.sort(nums);
						int n = nums.get(nums.size()-1)+1;
						if(n<999) {
							str = n+"";
							int len = str.length();
							
							switch (len) {
							case 1:
								str="00"+str;
								break;
							case 2:
								str="0"+str;
								break;
							}
						} else {
							return null;
						}
					} 
				}
				return country.getValue()+project_type.getValue()+str;
			}
		}
	}

	/**
	 * 更新
	 */
	public void update() {
		/**
		 * 更新数据
		 */
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		String status = pp.getAllStr("status");
		
		if(null != id && !id.isEmpty()) {
			String operation = pp.getAllStr("operation");
			if(null != operation) {
				Project project = Project.dao.findById(id);
				String project_name = this.getPara("project_name");
				if(StringUtil.notEmpty(project_name)) {
					project.set("project_name", project_name);
				} else {
					project.set("project_name", null);
				}
				String visa_type = pp.getAllStr("visa_type");
				if(StringUtil.notEmpty(visa_type)) {
					project.set("visa_type", visa_type);
				} else {
					project.set("visa_type", null);
				}
				String visa_type_description = pp.getAllStr("visa_type_description");
				if(StringUtil.notEmpty(visa_type_description)) {
					project.set("visa_type_description", visa_type_description);
				} else {
					project.set("visa_type_description", null);
				}
				String live_requirement = pp.getAllStr("live_requirement");
				if(StringUtil.notEmpty(live_requirement)) {
					project.set("live_requirement", live_requirement);
				} else {
					project.set("live_requirement", null);
				}
				String live_requirement_description = pp.getAllStr("live_requirement_description");
				if(StringUtil.notEmpty(live_requirement_description)) {
					project.set("live_requirement_description", live_requirement_description);
				} else {
					project.set("live_requirement_description", null);
				}
				String investments = pp.getAllStr("investments");
				if(StringUtil.notEmpty(investments)) {
					project.set("investments", investments);
				} else {
					project.set("investments", null);
				}
				String asset = pp.getAllStr("asset");
				if(StringUtil.notEmpty(asset)) {
					project.set("asset", asset);
				} else {
					project.set("asset", null);
				}
				String asset_description = pp.getAllStr("asset_description");
				if(StringUtil.notEmpty(asset_description)) {
					project.set("asset_description", asset_description);
				} else {
					project.set("asset_description", null);
				}
				String manage = pp.getAllStr("manage");
				if(StringUtil.notEmpty(manage)) {
					project.set("manage", manage);
				} else {
					project.set("manage", null);
				}
				String manage_description = pp.getAllStr("manage_description");
				if(StringUtil.notEmpty(manage_description)) {
					project.set("manage_description", manage_description);
				} else {
					project.set("manage_description", null);
				}
				String qualifications = pp.getAllStr("qualifications");
				if(StringUtil.notEmpty(qualifications)) {
					project.set("qualifications", qualifications);
				} else {
					project.set("qualifications", null);
				}
				String qualifications_description = pp.getAllStr("qualifications_description");
				if(StringUtil.notEmpty(qualifications_description)) {
					project.set("qualifications_description", qualifications_description);
				} else {
					project.set("qualifications_description", null);
				}
				String immigration_budget = pp.getAllStr("immigration_budget");
				if(StringUtil.notEmpty(immigration_budget)) {
					project.set("immigration_budget", immigration_budget);
				} else {
					project.set("immigration_budget", null);
				}
				String language = pp.getAllStr("language");
				if(StringUtil.notEmpty(language)) {
					project.set("language", language);
				} else {
					project.set("language", null);
				}
				String language_description = pp.getAllStr("language_description");
				if(StringUtil.notEmpty(language_description)) {
					project.set("language_description", language_description);
				} else {
					project.set("language_description", null);
				}
				String age = pp.getAllStr("age");
				if(StringUtil.notEmpty(age)) {
					project.set("age", age);
				} else {
					project.set("age", null);
				}
				String age_description = pp.getAllStr("age_description");
				if(StringUtil.notEmpty(age_description)) {
					project.set("age_description", age_description);
				} else {
					project.set("age_description", null);
				}
				String introduce = pp.getAllStr("introduce");
				if(StringUtil.notEmpty(introduce)) {
					project.set("introduce", introduce);
				} else {
					project.set("introduce", null);
				}
				String advantage = this.getPara("advantage");
				if(StringUtil.notEmpty(advantage)) {
					project.set("advantage", advantage);
				} else {
					project.set("advantage", null);
				}
				String project_img = this.getPara("project_img");
				if(StringUtil.notEmpty(project_img)) {
					project.set("project_img", project_img);
				} else {
					project.set("project_img", null);
				}
				String web_project_img = this.getPara("web_project_img");
				if(StringUtil.notEmpty(web_project_img)) {
					project.set("web_project_img", web_project_img);
				} else {
					project.set("web_project_img", null);
				}				
				String other_description = pp.getAllStr("other_description");
				if(null != other_description) {
					project.set("other_description", other_description);
				} else {
					project.set("other_description", null);
				}
				String city = pp.getAllStr("city");
				if(StringUtil.notEmpty(city)) {
					project.set("city", city);
				} else {
					project.set("city", null);
				}
				String project_level = this.getPara("project_level");
				if(StringUtil.notEmpty(project_level)) {
					project.set("project_level", project_level);
					
					String project_pid = this.getPara("project_pid");
					if(StringUtil.notEmpty(project_pid) && project_level.equals(PropKit.use("constants.txt").get("project_level_two"))) {
						project.set("project_pid", project_pid);
					} else {
						project.set("project_pid", null);
					}
				}
				
				project.update();
				
				List<ProjectExpands> pelist = ProjectExpands.dao.find("select * from crm_project_expands where project_id="+project.getProjectId());
				if(null != pelist && pelist.size()>0) {
					for(ProjectExpands p:pelist) {
						ProjectExpands.dao.deleteById(p.getProjectExpandsId());
					}
				}
				
				String[] pes = this.getParaValues("project_expands");
				if(null != pes && pes.length>0) {
					for(int i=0; i<pes.length; i++) {
						ProjectExpands pe = new ProjectExpands();
						pe.setDictCode(pes[i]);
						pe.setProjectId(project.getProjectId());
						pe.save();
					}
				}
				
				/*//同步crm start
				try {
					
					CrmProject cp = new CrmProject();
					cp.setProjectbh(project.getProjectCode());
					cp.setName(project.getProjectName());
					if(null != project.getProjectLevel()) {
						Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectLevel()+" and delete_flag=0");
						if(null != le && null != le.getName()) {
							cp.setProjectjb(le.getName());
						}
					}
					if(null != project.getCountry()) {
						Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getCountry()+" and delete_flag=0");
						if(null != le && null != le.getName()) {
							cp.setProjectcountry(le.getName());
						}
					}
					if(null != project.getProjectType()) {
						Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectType()+" and delete_flag=0");
						if(null != le && null != le.getName()) {
							cp.setXmlx(le.getName());
						}
					}
					if(null != project.getProjectStatus()) {
						Dictionary le = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectStatus()+" and delete_flag=0");
						if(null != le && null != le.getName()) {
							cp.setProjectzt(le.getName());
						}
					}
					
					//更新crm
					if(null != project.getCrmId()) {
						List<CrmProject> list = new ArrayList<CrmProject>();
						cp.setId(project.getCrmId());
						list.add(cp);
						
						//存储到crm
						Map<String, String> par = new HashMap<String, String>();
						par.put("serviceName", "update");
						par.put("objectApiName", "project");
						par.put("data", JSON.toJSONString(list)); 
						par.put("binding", CrmUtils.getBinding());
						Client.doPost(PropKit.use("debug_config.txt").get("CRM_API_URL"), par);
						
					} else { //新增crm
						List<CrmProject> list = new ArrayList<CrmProject>();
						
						SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						String dateString = formatter.format(project.getCreateTime());
						cp.setCreatedate(dateString);
						
						list.add(cp);
						
						//存储到crm
						Map<String, String> par = new HashMap<String, String>();
						par.put("serviceName", "insert");
						par.put("objectApiName", "project");
						par.put("data", JSON.toJSONString(list));
						par.put("binding", CrmUtils.getBinding());
						String json = Client.doPost(PropKit.use("debug_config.txt").get("CRM_API_URL"), par);
						
						JSONObject crm = new JSONObject(json);
						
						//保存crm_id
						if(null != crm && crm.getBoolean("result")==true) {
							JSONObject ids = (JSONObject) crm.getJSONObject("data").getJSONArray("ids").get(0);
							project.set("crm_id", ids.get("id"));
							project.update();
						} else {
							log.error("crm接口执行返回结果异常["+crm+"]");
						}
					}
				} catch (IOException e) {
					e.printStackTrace();
					log.error("crm接口执行返回结果异常["+e.getMessage()+"]");
				}
				//同步crm end
*/				
				
				status = "1";
				updataPage(Project.dao.findById(id), status);
			} else {
				/**
				 * 初始化页面
				 */
				Project project = Project.dao.findById(pp.getId());
				updataPage(project, status);
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
	
	/**
	 * 初始化更新页
	 * @param id
	 */
	private void updataPage(Project project, String status) {
		List<Dict> visaTypeList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("visa_type"), 1).getSubDictionaries();
		List<Dict> liveRequirementList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("live_requirement"), 1).getSubDictionaries();
		List<Dict> assetList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("asset"), 1).getSubDictionaries();
		List<Dict> manageList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("manage"), 1).getSubDictionaries();
		List<Dict> qualificationsList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("qualifications"), 1).getSubDictionaries();
		List<Dict> languageList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("language"), 1).getSubDictionaries();
		List<Dict> ageList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("age"), 1).getSubDictionaries();
		List<Dict> projectStatusList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("project_status"), 1).getSubDictionaries();
		List<Dict> expandsList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("project_expands"), 1).getSubDictionaries();
		List<Dict> cityList = DictionaryManager.getInstance().
				getAllSubDictionaries(project.getCountry(), 1).getSubDictionaries();
		
		List<ProjectExpands> peList = ProjectExpands.dao.find("select * from crm_project_expands where project_id="+project.getProjectId());
		this.setAttr("peList", peList);
		
		Dictionary country = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getCountry()+" and delete_flag=0");
		Dictionary city = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getCity()+" and delete_flag=0");
		Dictionary projectType = Dictionary.dao.findFirst("select * from console_dictionary where dict_code ="+project.getProjectType()+" and delete_flag=0");
		
		if(null != country) {
			this.setAttr("country", country.get("name"));
		}
		if(null != city) {
			this.setAttr("city", city.get("name"));
		}
		if(null != projectType) {
			this.setAttr("projectType", projectType.get("name"));
		}
		
		List<Project> levelProjectList = Project.dao.find("select cp.project_id, cp.project_name from crm_project cp where cp.delete_flag=0 and cp.project_id != ("+project.getProjectId()
				+") and cp.project_level="+PropKit.use("constants.txt").get("project_level_one")+" ORDER BY cp.priority");
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+project.getProjectId());
		
		this.setAttr("cityList", cityList);
		this.setAttr("visaTypeList", visaTypeList);
		this.setAttr("liveRequirementList", liveRequirementList);
		this.setAttr("assetList", assetList);
		this.setAttr("manageList", manageList);
		this.setAttr("qualificationsList", qualificationsList);
		this.setAttr("languageList", languageList);
		this.setAttr("ageList", ageList);
		this.setAttr("projectStatusList", projectStatusList);
		this.setAttr("expandsList", expandsList);
		
		this.setAttr("levelProjectList", levelProjectList);
		this.setAttr("project_level_one", PropKit.use("constants.txt").get("project_level_one"));
		this.setAttr("project_level_two", PropKit.use("constants.txt").get("project_level_two"));
		this.setAttr("subProject", subProject);
		
		this.setAttr("project", project);
		this.setAttr("operation", "编辑");
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("status", status);
		this.render("/views/project/project_base.jsp");
	}
	
}
