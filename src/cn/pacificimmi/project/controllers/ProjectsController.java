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
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.models.ProjectExpands;
import cn.pacificimmi.common.utils.Client;
import cn.pacificimmi.common.utils.CrmUtils;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.StringUtils;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.project.models.view.CrmProject;
import cn.pacificimmi.project.models.view.ProjectInfo;

@Before(LoginInterCeptor.class)
public class ProjectsController extends Controller {
	
	private Logger log = LoggerFactory.getLogger(ProjectsController.class);
	
	/**
	 * 列表页
	 */
	public void index() {
		ProjectParams pp = new ProjectParams(this);
		
		/**
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<Record> list = page.getList();
		List<ProjectInfo> result = new ArrayList<ProjectInfo>();
		for(Record rd : list) {
			ProjectInfo pi = new ProjectInfo();
			pi.bindingData(pi, rd);
			
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
												"cp.project_id = "+pi.getProject_id());
			
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
					pi.setProject_expands_name(str);
				}
			}
			result.add(pi);
		}
		
		List<Dict> expandsList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("project_expands"), 1).getSubDictionaries();
		this.setAttr("expandsList", expandsList);
		this.setAttr("list", result);
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		this.setAttr("page", page.getTotalPage());
		this.setAttr("now", pp.getPageNum());
		
		List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
		List<Dict> projectTypeList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("project_type"), 2).getSubDictionaries();
		List<Dict> projectStatusList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("project_status"), 1).getSubDictionaries();
		
		this.setAttr("countryList", countryList);
		this.setAttr("projectTypeList", projectTypeList);
		this.setAttr("projectStatusList", projectStatusList);
		
		String project_name = this.getPara("project_name");
		if(StringUtil.notEmpty(project_name)) {
			this.setAttr("project_name", project_name);
		}
		String country = this.getPara("country");
		if(StringUtil.notEmpty(country)) {
			List<Dict> cityList = DictionaryManager.getInstance().getAllSubDictionaries(country, 1).getSubDictionaries();
			this.setAttr("cityList", cityList);
			this.setAttr("country", country);
		}
		String city = this.getPara("city");
		if(StringUtil.notEmpty(city)) {
			this.setAttr("city", city);
		}
		String project_type = this.getPara("project_type");
		if(StringUtil.notEmpty(project_type)) {
			this.setAttr("project_type", project_type);
		}
		String project_status = this.getPara("project_status");
		if(StringUtil.notEmpty(project_status)) {
			this.setAttr("project_status", project_status);
		}
		
		String start_online_time = this.getPara("start_online_time");
		String end_online_time = this.getPara("end_online_time");
		
		if(StringUtil.notEmpty(start_online_time)) {
			this.setAttr("start_online_time", start_online_time.trim());
			this.setAttr("end_online_time", end_online_time.trim());
		}
		if(StringUtil.notEmpty(end_online_time)) {
			this.setAttr("end_online_time", end_online_time.trim());
		}
		
		String fast_query = this.getPara("fast_query");
		if(StringUtil.notEmpty(fast_query)) {
			this.setAttr("fast_query", fast_query.trim());
		}
		
		String selectTab = this.getPara("selectTab");
		if(StringUtil.notEmpty(selectTab)) {
			this.setAttr("selectTab", selectTab);
		} else {
			this.setAttr("selectTab", "all");
		}
		
		String project_level = this.getPara("project_level");
		if(StringUtil.notEmpty(project_level)) {
			this.setAttr("project_level", project_level);
		}
		
		this.setAttr("project_level_one", PropKit.use("constants.txt").get("project_level_one"));
		this.setAttr("project_level_two", PropKit.use("constants.txt").get("project_level_two"));
		this.renderJsp("/views/project/projects.jsp");
	}
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove() {
		Map<String, Object> map = new HashMap<String, Object>();
		ProjectParams pp = new ProjectParams(this);
		String ids = pp.getIds();
		if(ids != null) {
			String sql = "update crm_project set delete_flag = 1 where project_id in("+ids+")";
			Db.update(sql);
			map.put("status", 0);
			map.put("msg", "删除成功");
			this.renderJson(map);
		} else {
			map.put("status", 100);
			map.put("msg", "删除失败");
			this.renderJson(map);
		}
	}
	
	/**
	 * 项目暂停
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void stop() {
		Map<String, Object> map = new HashMap<String, Object>();
		ProjectParams pp = new ProjectParams(this);
		String id = pp.getId();
		String status = pp.getAllStr("status");
		if(StringUtil.notEmpty(id) && StringUtil.notEmpty(status)) {
			Project project = Project.dao.findById(id);
			
			if(null != project.getPreferred() && project.getPreferred()==1) {
				map.put("status", 1);
				map.put("msg", "该项目不允许暂停/售罄，请在移民官网-首页设置-热门项目进行编辑后下线");
			} else {
				project.setProjectStatus(status);
				project.update();
				
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
				
				map.put("status", 0);
				map.put("msg", "项目状态成功修改");
			}
		} else {
			map.put("status", 1);
			map.put("msg", "修改参数不正确");
		}
		this.renderJson(map);
	}
	
	
	private class ProjectParams extends ParamsParser {

		public ProjectParams(Controller ct) {
			super(ct);
			
			/**
			 * 处理传入参数
			 */
			this.setSelectStr("select * ");
			
			String fast_query = this.getFieldName("fast_query");
			if(StringUtil.notEmpty(fast_query)) {
				this.setFromStr("FROM "+
						"( "+
							"SELECT "+
								"*, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=country)country_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=project_status)project_status_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=project_type)project_type_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=city)city_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=project_level)project_level_name "+
							"FROM "+
								"crm_project "+
							"LEFT JOIN ( "+
								"SELECT "+
									"c.user_id, "+
									"c.login_name AS create_user_name "+
								"FROM "+
									"console_user c "+
							") cu ON crm_project.create_user = cu.user_id "+
							"WHERE "+
								"project_code LIKE '%"+fast_query.trim()+"%' "+
							"OR project_name LIKE '%"+fast_query.trim()+"%' "+
						") proj");
			} else {
				this.setFromStr("FROM "+
						"( "+
							"SELECT "+
								"*, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=country)country_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=project_status)project_status_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=project_type)project_type_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=city)city_name, "+
								"(select name from console_dictionary where delete_flag=0 and dict_code=project_level)project_level_name "+
							"FROM "+
								"crm_project "+
							"LEFT JOIN ( "+
								"SELECT "+
									"c.user_id, "+
									"c.login_name AS create_user_name "+
								"FROM "+
									"console_user c "+
							") cu ON crm_project.create_user = cu.user_id "+
						") proj");
			}
			
			//过滤条件
			String country = this.getAllStr("country");
			if(StringUtil.notEmpty(country)) {
				this.addWhereSegmentByAnd("proj.country = "+country);
			}
			String city=this.getAllStr("city");
			if(StringUtil.notEmpty(city)) {
				this.addWhereSegmentByAnd("proj.city = "+city);
			}
			String project_type = this.getAllStr("project_type");
			if(StringUtil.notEmpty(project_type)) {
				this.addWhereSegmentByAnd("proj.project_type like '"+project_type+"%'");
			}
			String project_status = this.getAllStr("project_status");
			if(StringUtil.notEmpty(project_status)) {
				this.addWhereSegmentByAnd("proj.project_status = "+ project_status);
			}
			
			String start_online_time = this.getFieldName("start_online_time");
			String end_online_time = this.getFieldName("end_online_time");
				
			if(StringUtil.notEmpty(start_online_time) && StringUtil.notEmpty(end_online_time)) {
				this.addWhereSegmentByAnd("proj.online_time between '"+start_online_time.trim()+"' and '"+TpyDateUtil.getNextDay(end_online_time.trim(),"1")+"'");
			} else if(StringUtil.notEmpty(start_online_time)) {
				this.addWhereSegmentByAnd("proj.online_time > '"+start_online_time.trim()+"'");
			} else if(StringUtil.notEmpty(end_online_time)) {
				this.addWhereSegmentByAnd("proj.online_time < '"+TpyDateUtil.getNextDay(end_online_time.trim(),"1")+"'");
			}
			
			String project_level = this.getFieldName("project_level");
			if(StringUtil.notEmpty(project_level)) {
				this.addWhereSegmentByAnd("proj.project_level = "+project_level);
				this.setDefaultOrderStr("order by proj.priority desc");
			} else {
				this.setDefaultOrderStr("order by proj.create_time desc");
			}
			
			this.addWhereSegmentByAnd("proj.delete_flag = 0");
		}
	}
	
	/**
	 * 存储扩展推荐
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void expands() {
		
		String[] projectIds = getParaValues("projectIds");
		String[] expandsIds = getParaValues("expandsIds");
		
		Map<String, Object> map = new HashMap<String, Object>();
		int i, j, k;
		if(null != projectIds && null !=expandsIds && projectIds.length>0 && expandsIds.length>0) {
			for(k=0; k<projectIds.length; k++) {
				List<ProjectExpands> pelist = ProjectExpands.dao.find("select * from crm_project_expands where project_id="+projectIds[k]);
				if(null != pelist && pelist.size()>0) {
					for(ProjectExpands p:pelist) {
						ProjectExpands.dao.deleteById(p.getProjectExpandsId());
					}
				}
			}
			
			for(i=0; i<projectIds.length; i++) {
				for(j=0; j<expandsIds.length; j++) {
					ProjectExpands pes = new ProjectExpands();
					pes.setProjectId(new Integer(projectIds[i]));
					pes.setDictCode(expandsIds[j]);
					pes.save();
				}
			}
			
			map.put("status", 0);
			map.put("msg", "提交成功！");
		} else {
			map.put("status", 1);
			map.put("msg", "提交失败！");
		}
		this.renderJson(map);
	}
	
	/**
	 * 获取扩展项目
	 */
	@Clear
	public void getProjectExpands() {
		String projectId = getPara("projectId");
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(StringUtil.notEmpty(projectId)) {
			List<ProjectExpands> peList = ProjectExpands.dao.find("select * from crm_project_expands where project_id="+projectId);
			map.put("status", 0);
			map.put("list", peList);
			map.put("msg", "获取成功！");
		} else {
			map.put("status", 1);
			map.put("msg", "获取失败！");
		}
		this.renderJson(map);
	}
	
	/**
	 * 排序
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void priority() {
		ParamsParser pp = new ParamsParser(this);
		String order = pp.getAllStr("order");
		String id = pp.getId();
		int status=0;
		String msg="操作成功";
		Project project = Project.dao.findById(id);
		Integer pr = project.getPriority();
		if(StringUtil.notEmpty(order)) {
			if(order.equals("up")) {
				Project nowP = Project.dao.findFirst("SELECT project_id, priority from crm_project where project_level="+project.getProjectLevel()+
						" AND priority > "+pr+" and delete_flag = 0 order by priority asc limit 1");
				if(null == nowP || id.equals(nowP.getProjectId().toString())) {
					status=1;
					msg="无法上移，排序已是最上";
				} else {
					project.setPriority(nowP.getPriority());
					nowP.setPriority(pr);
					
					nowP.update();
					project.update();
					status=0;
				}
			} else if(order.equals("down")) {
				Project nowP = Project.dao.findFirst("SELECT project_id, priority from crm_project where project_level="+project.getProjectLevel()+
						" AND priority < "+pr+" and delete_flag = 0 order by priority desc limit 1");
				if(null == nowP || id.equals(nowP.getProjectId().toString())) {
					status=1;
					msg="无法下移，排序已是最下";
				} else {
					project.setPriority(nowP.getPriority());
					nowP.setPriority(pr);
					
					nowP.update();
					project.update();
					status=0;
				}
			} else if(order.equals("top")) {
				Project nowP = Project.dao.findFirst("SELECT project_id, priority from crm_project where project_level="+project.getProjectLevel()+
						" AND delete_flag = 0 order by priority desc limit 1");
				if(null == nowP || id.equals(nowP.getProjectId().toString())) {
					status=1;
					msg="无法置顶，排序已是最上";
				} else {
					project.setPriority(nowP.getPriority()+1);
					project.update();
					status=0;
				}
			}
		} else {
			status=1;
			msg="参数不正确";
		}
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order", order);
		map.put("status", status);
		map.put("msg", msg);
		this.renderJson(map);
	}
	
	
}
