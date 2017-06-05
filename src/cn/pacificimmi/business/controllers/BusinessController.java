package cn.pacificimmi.business.controllers;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.BusinessCooperation;
import cn.pacificimmi.common.models.BusinessNegotiation;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.LoginUserInfo;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * 商务合作管理
 * @author xiangbin
 *
 */

@Before(LoginInterCeptor.class)
public class BusinessController extends Controller{
	private static Logger log = LoggerFactory.getLogger(BusinessController.class);
	
	/****
	 * 默认初始化页面
	 */
	public void index(){
		log.debug("商务合作");
		BusinessParams params = new BusinessParams(this);
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("list", list); 
		//国家
		String country_china = PropKit.use("constants.txt").get("country_china");
		List<Dictionary> provinces = Dictionary.dao.find(
				"select * from console_dictionary where delete_flag=0 and dict_pcode='"+country_china+"'");
		this.setAttr("provinces", provinces);
			
		//按照省份查询城市（当选中省份的时候城市列表显示的数据）
		String applicant_province = this.getAttrForStr("applicant_province");
		List<Dictionary> listProvince = Dictionary.dao.find("SELECT  * FROM console_dictionary WHERE name = '"+applicant_province+"' and delete_flag = 0 order by dict_code asc");
		if(listProvince.size()>0){
			//中国的CountryId
			String provinceId = listProvince.get(0).getDictCode();
		
		if(provinceId != null && !"".equals(provinceId)){
			String sql="SELECT  * FROM console_dictionary WHERE dict_pcode = "+"'"+provinceId+"' and delete_flag = 0";
			List<Dictionary> citys = Dictionary.dao.find(sql); 
				this.setAttr("citys", citys);
			}
		}
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		//页面
		this.renderJsp("/views/cooperation/cooperation_list.jsp");
	}
	
//	public void cooperation(){
//		
//		
//	}
	
	
	public void progress(){
		BusinessParams params = new BusinessParams(this);
		ProgressParams progress = new ProgressParams(this);
		
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("cooperation", list.get(0)); 
		
		Page<Record> pagepro = Db.paginate(progress.getPageNum(), progress.getPageSize(), progress.getSelectStr(), progress.getFromStr());
		List<Record> listpro = pagepro.getList();
		this.setAttr("listpro", listpro);
		
		//页面
		this.renderJsp("/views/cooperation/cooperation_progress.jsp");
		
		
	}
	/**
	 * 添加洽谈进度
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void addProgress(){
		String negotiation_status = this.getPara("negotiation_status");
		String negotiation_explain = this.getPara("negotiation_explain");
		String cooperation_id = this.getPara("cooperation_id");
		BusinessCooperation cooperation = BusinessCooperation.dao.findById(cooperation_id);
		String oldNegotiationStatus = cooperation.getNegotiationStatus();
		if(Integer.valueOf(negotiation_status) < Integer.valueOf(oldNegotiationStatus) ){
			this.setAttr("status", 1);
			this.setAttr("msg", "添加失败，请确认洽谈进度!");
			this.renderJson();
		}else{
			cooperation.set("negotiation_status", negotiation_status);
			cooperation.set("treatment_status", "1");
			cooperation.update();
			BusinessNegotiation negotiation = new BusinessNegotiation();
			negotiation.set("cooperation_id", cooperation_id);
			negotiation.set("negotiation_status", negotiation_status);
			negotiation.set("negotiation_explain", negotiation_explain);
			negotiation.set("negotiation_time", new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			negotiation.set("negotiation_user", user.getLoginName());
			negotiation.save();
//			Map<String,String> data = new HashMap<String,String>();
//			data.put("code", "0");
//			data.put("value", "保存成功！");
			this.setAttr("status", 0);
			this.renderJson();
		}
		
		
	}
	
	//添加处理结果
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void addTreatment(){
		String treatment_status = this.getPara("treatment_status");
		String treatment_explain = this.getPara("treatment_explain");
		String cooperation_id = this.getPara("cooperation_id");
		BusinessCooperation cooperation = BusinessCooperation.dao.findById(cooperation_id);
		cooperation.set("negotiation_status","3");
		cooperation.set("treatment_status", treatment_status);
		cooperation.set("treatment_explain", treatment_explain);
		cooperation.set("treatment_time", new Date());
		LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
		cooperation.set("treatment_operator", user.getLoginName());
		cooperation.update();
		this.setAttr("status", 0);
		this.renderJson();
	}
	
	/**
	 * 商务合作查询
	 * @author xiangbin
	 *
	 */
	private class BusinessParams extends ParamsParser{

	public BusinessParams(Controller ctr) {
		super(ctr);
		
		this.setSelectStr("select @rownum:=@rownum+1 AS rownum,custinfo.wx_name,business_cooperation.id,business_cooperation.applicant_name,business_cooperation.applicant_phone ," +
						"business_cooperation.applicant_province,business_cooperation.applicant_city,business_cooperation.cooperation_mode,business_cooperation.submit_time,"+
						"business_cooperation.submit_user,business_cooperation.negotiation_status,business_cooperation.treatment_status,business_cooperation.treatment_result,business_cooperation.treatment_explain,business_cooperation.treatment_time,business_cooperation.treatment_operator");
//						"business_negotiation.negotiation_explain,business_negotiation.negotiation_time,business_negotiation.negotiation_user");
		this.setFromStr("from (SELECT @rownum:=0) r,crm_business_cooperation business_cooperation "+
				" LEFT JOIN crm_custinfo custinfo on business_cooperation.submit_user = custinfo.phone_num ");
		
//		this.addWhereSegmentByAnd("coun.delete_flag = 0");
		
		
		//按照国家名称查询
		String id = ctr.getPara();
		if(id != null && !"".equals(id)){
			this.addWhereSegmentByAnd(" id = '" + id + "'");
			this.ctr.setAttr("id", id);
		}
		
		//按照合作方式查询
		String cooperation_mode = this.getNormStr("cooperation_mode");
		if(cooperation_mode != null && !"".equals(cooperation_mode)){
			this.addWhereSegmentByAnd(" business_cooperation.cooperation_mode = '" + cooperation_mode + "'");
			this.ctr.setAttr("cooperation_mode", cooperation_mode);
		}
		
		//按照处理状态查询
		String treatment_status = this.getNormStr("treatment_status");
		if(treatment_status != null && !"".equals(treatment_status)){
			this.addWhereSegmentByAnd(" business_cooperation.treatment_status = '" + treatment_status + "'");
			this.ctr.setAttr("treatment_status", treatment_status);
		}
			
		//按照发布状态查询
		String applicant_phone = this.getNormStr("applicant_phone");
		if(applicant_phone != null && !"".equals(applicant_phone)){
			this.addWhereSegmentByAnd(" business_cooperation.applicant_phone like '%" + applicant_phone + "%'");
			this.ctr.setAttr("applicant_phone", applicant_phone);
		}
		//按照省份查询
		String applicant_province = this.getNormStr("applicant_province");
		if(applicant_province != null && !"".equals(applicant_province)){
			this.addWhereSegmentByAnd(" business_cooperation.applicant_province = '" + applicant_province + "'");
			this.ctr.setAttr("applicant_province", applicant_province);
		}
		//按照城市查询
		String applicant_city = this.getNormStr("applicant_city");
		if(applicant_city != null && !"".equals(applicant_city)){
			this.addWhereSegmentByAnd(" business_cooperation.applicant_city = '" + applicant_city + "'");
			this.ctr.setAttr("applicant_city", applicant_city);
		}
				
		this.setDefaultOrderStr("order by submit_time desc");
	}
}
	/**
	 * 洽谈进度查询
	 * @author xiangbin
	 *
	 */
	private class ProgressParams extends ParamsParser{

	public ProgressParams(Controller ctr) {
		super(ctr);
		
		this.setSelectStr("select @rownum:=@rownum+1 AS rownum,business_negotiation.id,business_negotiation.cooperation_id,business_negotiation.negotiation_status ," +
						"business_negotiation.negotiation_explain,business_negotiation.negotiation_time,business_negotiation.negotiation_user");
		this.setFromStr("from (SELECT @rownum:=0) r,crm_business_negotiation business_negotiation ");
		
//		this.addWhereSegmentByAnd("coun.delete_flag = 0");
		
		
		//按照合作方Id查询
		String cooperation_id = ctr.getPara();
		if(cooperation_id != null && !"".equals(cooperation_id)){
			this.addWhereSegmentByAnd(" cooperation_id = '" + cooperation_id + "'");
			ctr.setAttr("cooperation_id", cooperation_id);
		}
		
				
		this.setDefaultOrderStr("order by business_negotiation.negotiation_time asc");
	}
}
	
}
