package cn.pacificimmi.project.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.models.ProjectApplyProcess;
import cn.pacificimmi.common.models.ProjectCost;
import cn.pacificimmi.common.models.ProjectMaterial;
import cn.pacificimmi.common.utils.Client;
import cn.pacificimmi.common.utils.CrmUtils;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.StringUtils;
import cn.pacificimmi.project.models.view.CrmProject;

@Before(LoginInterCeptor.class)
public class ProjectDetailsController extends Controller {
	
	private Logger log = LoggerFactory.getLogger(ProjectDetailsController.class);
	
	/**
	 * 项目详情
	 */
	public void index() {
		ParamsParser pp = new ParamsParser(this);
		String project_id = pp.getId();
		
		Project project = Project.dao.findById(project_id);
		
		
		Dictionary country = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getCountry()+" and delete_flag=0");
		Dictionary city = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getCity()+" and delete_flag=0");
		Dictionary projectType = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getProjectType()+" and delete_flag=0");
		Dictionary visaType = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getVisaType()+" and delete_flag=0");
		Dictionary liveRequirement = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getLiveRequirement()+" and delete_flag=0");
		Dictionary asset = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getAsset()+" and delete_flag=0");
		Dictionary manage = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getManage()+" and delete_flag=0");
		Dictionary  qualifications = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getQualifications()+" and delete_flag=0");
		Dictionary language = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getLanguage()+" and delete_flag=0");
		Dictionary age = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getAge()+" and delete_flag=0");
		Dictionary projectStatus = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getProjectStatus()+" and delete_flag=0");
		Dictionary projectLevelName = Dictionary.dao.findFirst("select name from console_dictionary where dict_code ="+project.getProjectLevel()+" and delete_flag=0");
		
		this.setAttr("projectLevelName", projectLevelName.get("name"));
		
		if(StringUtil.notEmpty(project.getProjectPid())) {
			Project projectPip = Project.dao.findById(project.getProjectPid());
			if(projectPip != null) {
				this.setAttr("projectPName", projectPip.getProjectName());
			}
		}
		
		if(null != country) {
			this.setAttr("country", country.get("name"));
		}
		if(null != city) {
			this.setAttr("city", city.get("name"));
		}
		if(null != projectType) {
			this.setAttr("projectType", projectType.get("name"));
		}
		if(null != visaType) {
			this.setAttr("visaType", visaType.get("name"));
		}
		if(null != liveRequirement) {
			this.setAttr("liveRequirement", liveRequirement.get("name"));
		}
		if(null != asset) {
			this.setAttr("asset", asset.get("name"));
		}
		if(null != manage) {
			this.setAttr("manage", manage.get("name"));
		}
		if(null != qualifications) {
			this.setAttr("qualifications", qualifications.get("name"));
		}
		if(null != language) {
			this.setAttr("language", language.get("name"));
		}
		if(null != age) {
			this.setAttr("age", age.get("name"));
		}
		if(null != age) {
			this.setAttr("projectStatus", projectStatus.get("name"));
		}
		
		List<Record> exList = Db.find("SELECT "+
				"* "+
			"FROM "+
				"crm_project_expands cp "+
			"LEFT JOIN ( "+
				"SELECT "+
					"cd.dict_code, "+
					"cd. NAME "+
				"FROM "+
					"console_dictionary cd "+
				"where cd.delete_flag=0"+
			") cdy ON cp.dict_code = cdy.dict_code "+
			"WHERE "+
				"cp.project_id = "+project_id);
		
		if(exList.size()>0) {
			String str = "";
			for(int i=0; i<exList.size(); i++) {
				if(i==0) {
					str=exList.get(0).getStr("NAME");
				} else {
					str+=", "+exList.get(i).getStr("NAME");
				}
			}
			if(!"".equals(str)) {
				this.setAttr("project_expands_name", str);
			}
		}
		
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+project_id);
		
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("subProject", subProject);
		this.setAttr("project", project);
		this.render("/views/project/details/project_details.jsp");
	}
	
	/**
	 * 发布功能
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void release() {
		Map<String, Object> map = new HashMap<String, Object>();
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Project project = Project.dao.findById(id);
		
		if(StringUtils.isEmpty(project.getWebIntroduce())) {
			map.put("status", 1);
			map.put("msg", "请补充项目介绍");
		} else {
			if(StringUtil.isEmpty(project.getApplyCondition())) {
				map.put("status", 1);
				map.put("msg", "请补充项目申请条件");
			} else {
				List<ProjectApplyProcess> papList = ProjectApplyProcess.dao.find("select * from crm_project_apply_process where project_id="+id+" and delete_flag=0");
				if(null == papList || papList.size()==0) {
					map.put("status", 1);
					map.put("msg", "请补充项目办理流程");
				} else {
//					List<ProjectCost> pcList = ProjectCost.dao.find("select * from crm_project_cost where project_id="+id+" and delete_flag=0");
//					if(null == pcList || pcList.size()==0) {
//						map.put("status", 1);
//						map.put("msg", "请补充项目费用详情");
//					} else {
//						List<ProjectMaterial> pmList = ProjectMaterial.dao.find("select * from crm_project_material where project_id="+id+" and delete_flag=0");
//						if(null == pmList || pmList.size()==0) {
//							map.put("status", 1);
//							map.put("msg", "请补充材料清单");
//						} else {
							String sql = "update crm_project set project_status = '"+PropKit.use("constants.txt").get("project_status_sx")+
									"', online_time=NOW() where project_id = "+id;
							Db.update(sql);
							map.put("status", 0);
							map.put("msg", "发布成功");
							
							/*//同步crm start
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
								String upJson = null;
								try {
									upJson = Client.doPost(PropKit.use("debug_config.txt").get("CRM_API_URL"), par);
								} catch (IOException e) {
									log.error("crm接口执行返回结果异常["+upJson+"]");
									log.error(e.getMessage());
								}
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
								String json = null;
								try {
									json = Client.doPost(PropKit.use("debug_config.txt").get("CRM_API_URL"), par);
								} catch (IOException e) {
									log.error("crm接口执行返回结果异常["+json+"]");
									log.error(e.getMessage());
								}
								
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
							//同步crm end
			*/				
//						}
//					}
				}
			}
		}
		this.renderJson(map);
	}
	
	
}
