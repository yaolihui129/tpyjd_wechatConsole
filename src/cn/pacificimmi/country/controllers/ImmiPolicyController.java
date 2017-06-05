package cn.pacificimmi.country.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Country;
import cn.pacificimmi.common.models.ImmigrationPolicy;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.country.models.view.PolicyInfo;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 移民政策
 * @author xiangbin
 *
 */
@Before(LoginInterCeptor.class)
public class ImmiPolicyController extends Controller{
	
	private static Logger log = LoggerFactory.getLogger(ImmiPolicyController.class);
	
	public void index(){
		
	}
	public void listPolicy(){
		InfotmationParams sp = new InfotmationParams(this);
		sp.setPageSize(15);
		ParamsParser pp = new ParamsParser(this);
		//国家信息
		String coun_id = pp.getNormStr("coun_id" );
		if(coun_id != null && !"".equals(coun_id)){
			Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
			if(null != country){this.setAttr("coun", country);}
			this.setAttr("coun_id", coun_id);
		}
		//this.setAttr("title", (pp.getNormStr("title") == null || pp.getNormStr("title").isEmpty()) ? "" : pp.getNormStr("title"));
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();

		/***
		 * 保存数据列表
		 */
		this.setAttr("list", list);
		
		//资讯状态
		this.setAttr("statusList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("publish_status"), 1).getSubDictionaries());
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);

		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/country/policy_list.jsp");
	}
	/**
	 * 切换为其他的表中保存移民政策listPolicy改为listPolicys
	 */
	public void listPolicys(){
		log.debug("移民政策列表");
		ImmiPolicyParams params = new ImmiPolicyParams(this);
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		//国家信息
		String coun_id = params.getNormStr("coun_id" );
		if(coun_id != null && !"".equals(coun_id)){
			Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
			if(null != country){this.setAttr("coun", country);}
			this.setAttr("coun_id", coun_id);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
//		this.setAttr("list", list); 
		Map<String,List<PolicyInfo>> maps = new LinkedHashMap<String,List<PolicyInfo>>();
		for(Record rd:list){
			PolicyInfo policyInfo = new PolicyInfo();
			policyInfo.bindingData(policyInfo, rd);
			String dateString = "";
			Date create_time = policyInfo.getCreate_time();
			dateString = sdf.format(create_time);
			List<PolicyInfo> policyInfos = maps.get(dateString);
			if(null != policyInfos){
				policyInfos.add(policyInfo);
				maps.put(dateString, policyInfos);
			}else{
				policyInfos = new ArrayList<PolicyInfo>();
				policyInfos.add(policyInfo);
				maps.put(dateString, policyInfos);
			}
		}
		
		this.setAttr("maps", maps);
		
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		//页面
		this.renderJsp("/views/country/policy_list.jsp");
		
	}
	public void addPolicy(){
		log.debug("添加移民政策");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getNormStr("operation");
		String coun_id = pp.getNormStr("coun_id");
		if(StringUtil.isEmpty(operation)){//跳转添加页面
			
			if(StringUtil.notEmpty(coun_id)){
				Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag = 0");
				this.setAttr("coun", country);
				List<Project> projects = Project.dao.find("select project_id,project_name,project_code,project_status,project_type,country from crm_project where country = '"+coun_id+"' and project_status = '"+PropKit.use("constants.txt").get("project_status_sx")+"' and delete_flag = 0");
				this.setAttr("projects", projects);
				this.setAttr("coun_name", country.getCountryName());
				this.setAttr("coun_id", coun_id);
				this.setAttr("operation", "添加");
				this.renderJsp("/views/country/policy_add.jsp");
			}
		}else{//添加移民政策后跳转移民列表页
			ImmigrationPolicy immiPolicy = new ImmigrationPolicy();
			
			if(null != coun_id && !"".equals(coun_id)) {
				Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag = 0");
				this.setAttr("coun", country);
				immiPolicy.set("country_id", coun_id);
			}
			String title = pp.getAllStr("title");
			if(null != title && !"".equals(title)) {
				immiPolicy.set("title", title);
			}
			String country_name = pp.getNormStr("coun_name");
			if(null != country_name && !"".equals(country_name)) {
				immiPolicy.set("country_name", country_name);
			}
			String project_id = pp.getNormStr("project_id");
			if(null != project_id && !"".equals(project_id)) {
				immiPolicy.set("project_id", project_id);
			}
			String project_name = pp.getNormStr("project_name");
			if(null != project_name && !"".equals(project_name)) {
				immiPolicy.set("project_name", project_name);
			}
			
			String content = pp.getAllStr("content");
			if(null != content && !"".equals(content)) {
				immiPolicy.set("content", content);
			}
			immiPolicy.set("create_time", new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			if(null != user){
				immiPolicy.set("create_user", user.getLoginName());
				immiPolicy.set("delete_flag", "0");
			}
			boolean isOk = immiPolicy.save();
			if(isOk){
				this.redirect("/country/immiPolicy/listPolicy?coun_id="+coun_id);
			}
			
		}
		
	}
	
	
	public void editPolicy(){
		log.debug("编辑移民政策");
		ParamsParser pp = new ParamsParser(this);
		String operation = pp.getNormStr("operation");
		String coun_id = pp.getNormStr("coun_id");
		String id = pp.getNormStr("id");
		ImmigrationPolicy immiPolicy = ImmigrationPolicy.dao.findById(id);
		if(StringUtil.isEmpty(operation)){//跳转添加页面
			if(StringUtil.notEmpty(coun_id)){
				this.setAttr("policy", immiPolicy);
				Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag = 0");
				this.setAttr("coun", country);
				List<Project> projects = Project.dao.find("select project_id,project_name,project_code,project_status,project_type,country from crm_project where country = '"+coun_id+"' and project_status = '"+PropKit.use("constants.txt").get("project_status_sx")+"' and delete_flag = 0");
				this.setAttr("projects", projects);
				this.setAttr("coun_name", country.getCountryName());
				this.setAttr("coun_id", coun_id);
				this.setAttr("operation", "编辑");
				this.renderJsp("/views/country/policy_add.jsp");
			}
		}else{//添加移民政策后跳转移民列表页
			
			if(null != coun_id && !"".equals(coun_id)) {
				Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag = 0");
				this.setAttr("coun", country);
				immiPolicy.set("country_id", coun_id);
			}
			String title = pp.getAllStr("title");
			if(null != title && !"".equals(title)) {
				immiPolicy.set("title", title);
			}
			String country_name = pp.getNormStr("coun_name");
			if(null != country_name && !"".equals(country_name)) {
				immiPolicy.set("country_name", country_name);
			}
			String project_id = pp.getNormStr("project_id");
			if(null != project_id && !"".equals(project_id)) {
				immiPolicy.set("project_id", project_id);
			}
			String project_name = pp.getNormStr("project_name");
			if(null != project_name && !"".equals(project_name)) {
				immiPolicy.set("project_name", project_name);
			}
			
			String content = pp.getAllStr("content");
			if(null != content && !"".equals(content)) {
				immiPolicy.set("content", content);
			}
			immiPolicy.set("modify_time", new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			if(null != user){
				immiPolicy.set("modify_user", user.getLoginName());
			}
			boolean isOk = immiPolicy.update();
			if(isOk){
				this.redirect("/country/immiPolicy/listPolicy?coun_id="+coun_id);
			}
			
		}
		
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void deletePolicy(){
		log.debug("删除移民政策");
		ParamsParser pp = new ParamsParser(this);
		String coun_id = pp.getNormStr("coun_id");
		String id = pp.getNormStr("id");
		ImmigrationPolicy immiPolicy = ImmigrationPolicy.dao.findById(id);
		if(null != immiPolicy){
			immiPolicy.set("delete_flag", "1");
			immiPolicy.set("delete_time", new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			if(null != user){
				immiPolicy.set("delete_user", user.getLoginName());
			}
			boolean isOk = immiPolicy.update();
			if(isOk){
				this.setAttr("status", "0");
				this.renderJson();
			}else{
				this.setAttr("status", "1");
				this.setAttr("msg", "数据库异常！");
				this.renderJson();
			}
		}
		
		
	}
	
	private class ImmiPolicyParams extends ParamsParser{

		public ImmiPolicyParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select policy.id,policy.title,policy.country_id,policy.country_name,policy.project_id,policy.project_name,"+
							"policy.content,policy.create_time,policy.create_user,policy.modify_time,policy.modify_user,policy.delete_flag,policy.delete_time,policy.delete_user ");
			this.setFromStr("from crm_immigration_policy policy ");
			
			this.addWhereSegmentByAnd("policy.delete_flag = 0");
			
			//按照国家id查询
			String coun_id = this.getNormStr("coun_id" );
			if(coun_id != null && !"".equals(coun_id)){
				this.addWhereSegmentByAnd(" policy.country_id = '" + coun_id + "'");
				this.ctr.setAttr("coun_id", coun_id);
			}
			
			this.setPageSize(15);		
			this.setDefaultOrderStr("order by policy.create_time desc");
		}
	}
	
	/**
	 * 查询参数解析类(资讯发布)
	 * @author Gorge
	 */
	private class InfotmationParams extends ParamsParser{

		public InfotmationParams(Controller ctr) {
			super(ctr);
			this.setSelectStr("select * ");
			this.setFromStr("from (" +
			"select a.info_id,a.section_id,section_name,a.title,a.country,a.status,d.name statusZN,a.click_count,a.publish_user,a.publish_time,a.create_time,a.sort,\"图片\" section_type" +
			" from crm_information_img a left join console_dictionary d on a.status = d.dict_code and d.delete_flag = 0" +
			" where a.delete_flag = 0 " +

			" union " + 

			" select a.info_id,a.section_id,section_name,a.title,a.country,a.status,d.name statusZN,a.click_count,a.publish_user,a.publish_time,a.create_time,a.sort,\"文章\" section_type" +
			" from crm_information_article a left join console_dictionary d on a.status = d.dict_code and d.delete_flag = 0" + 
			" where a.delete_flag = 0 " +
			") t");
					
			//资讯名称
			String title = this.getAllStr("title");
			if(title !=null && !title.isEmpty()){
				this.addWhereSegmentByAnd("title like '%"+title.trim()+"%'");
				setAttr("title", title.trim());
			}
			
			//发布状态
			String pubStatus = PropKit.use("constants.txt").get("publish_status_yfb");
			if(pubStatus != null){
				this.addWhereSegmentByAnd(" status = '" + pubStatus +"'");
			}
			
			//国家
			String coun_id = this.getNormStr("coun_id" );
			if(coun_id != null && !"".equals(coun_id)){
				this.addWhereSegmentByAnd(" country = '" + coun_id +"'");
			}
			
			//栏目 固定为移民政策
			//String secId = "0003";
			
			
				//if(secId!=null && !secId.isEmpty())
					//this.addWhereSegmentByAnd("section_id in (select section_id from crm_section where code = '"+secId+"')");
			//栏目 固定为移民政策
			this.addWhereSegmentByAnd("find_in_set((select section_id from crm_section where delete_flag = 0 and name = '移民政策'), section_id)");
			
			
			this.setDefaultOrderStr("order by sort desc,publish_time desc");
		}
	}
}
