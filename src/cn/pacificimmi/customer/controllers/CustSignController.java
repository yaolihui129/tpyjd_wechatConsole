package cn.pacificimmi.customer.controllers;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.FileService;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.CustFollowRecords;
import cn.pacificimmi.common.models.CustSigninfo;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.SigninfoAnnex;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;

/**
 * 客户签约控制器
 * @author Gorge
 * 
 */
@Before(LoginInterCeptor.class)
public class CustSignController extends Controller {
	private static Logger log = LoggerFactory.getLogger(CustSignController.class);
	
	/****
	 * 默认初始化页面
	 */

	@Clear
	public void index(){
		log.debug("查询客户签约记录");
		CustSginParams params = new CustSginParams(this);
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("list", list); 
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		this.setAttr("custId", params.getId());//查询的客户ID
		
		//页面
		this.renderJsp("/views/cust/cust_sign_record.jsp");
	}
	
	
	/**
	 * 签约信息新增保存
	 */
	public void add(){
		log.debug("新增客户签约信息");
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				Custinfo c = Custinfo.dao.findById(pp.getId());
				if(c == null){
					this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
				this.setAttr("cust", c);
			}
			
			//国家
			List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
			setAttr("countryList", countryList);
			
			//支付方式
			List<Dict> paycodeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("paycode"), 1).getSubDictionaries();
			setAttr("paycodeList", paycodeList);
			
			
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		this.renderJsp("/views/cust/cust_signinfo_edit.jsp");
	}
	
	
	/**
	 * 签约信息保存
	 */
	@Clear
	public void save(){
		log.debug("保存客户签约信息");
		try {
			LoginUserInfo loginUser = getSessionAttr("LoginUserInfo");
			CustSigninfo cs = new CustSigninfo();
			
			List<UploadFile> upFiles = this.getFiles();
			
			ParamsParser p = new ParamsParser(this);
			log.info("custId:" + this.getPara("custinfo_id"));
			if(Integer.parseInt(p.getNormStr("custinfo_id")) == 0){
				log.error("参数缺失:客户ID为空");
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			if(p.getNormStr("signed_id") != null && !p.getNormStr("signed_id").isEmpty()){
				cs = CustSigninfo.dao.findById(Integer.parseInt(p.getNormStr("signed_id")));
			}
			
			
			Map<String,Object> rst = new HashMap<String,Object>();
			
			cs.setCountry(p.getNormStr("country"));//国家
			cs.setCustinfoId(Integer.parseInt(p.getNormStr("custinfo_id")));//客户ID
			cs.setDealNo(p.getNormStr("dealNo"));//合同编号
			cs.setDeleteFlag(0);
			
			cs.setFee(new BigDecimal(p.getAllStr("fee")));//签约费用
			cs.setOperatorId(Integer.parseInt(loginUser.getUid()));//操作员-签约顾问
			cs.setPartner(p.getNormStr("partner"));//合作伙伴
			cs.setPaycode(p.getNormStr("paycode"));//支付方式
			cs.setProjectId(Integer.parseInt(p.getNormStr("project_id")));//签约项目
			cs.setRemark(p.getAllStr("remark"));
			
			cs.setServiceFee(new BigDecimal(p.getAllStr("service_fee")));//签约服务费
			cs.setServiceLawyer(p.getNormStr("service_lawyer"));//签约律师
			cs.setSignDate(TpyDateUtil.strToDate(p.getAllStr("sign_date")));
			cs.setCreateTime(new Date());
			cs.setAdviser(loginUser.getLoginName());
			cs.setDealNo("aaaaa");//合同编号
			
			Boolean rslt = false;
			if(p.getNormStr("signed_id") != null && !p.getNormStr("signed_id").isEmpty()){
				rslt = cs.update();
			}else{
				rslt = cs.save();
			}
			if(rslt){
				//保存附件信息
				for(UploadFile uf : upFiles){
					String dealName=uf.getOriginalFileName();
			        File file=uf.getFile();    
			        FileService fs=new FileService();    
			        File t=new File(TpyDateUtil.getDateString() + dealName);
			        try {
			            t.createNewFile();
			        } catch (IOException e) {
			            // TODO Auto-generated catch block
			            e.printStackTrace();
			        }
			        fs.fileChannelCopy(file, t);
			        file.delete();
			        
			        SigninfoAnnex sa = new SigninfoAnnex();
			        sa.setCustinfoId(Integer.parseInt(p.getNormStr("custinfo_id")));
			        sa.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
			        sa.setSignedId(cs.getSignedId());
			        sa.setFilepath(t.getName());
			        if("deal".equalsIgnoreCase(uf.getParameterName())){//合同
			        	sa.setType("deal");
			        }else if("resume".equalsIgnoreCase(uf.getParameterName())){//简历
			        	sa.setType("resume");
			        }
			        sa.save();
				}
				
				rst.put("status", ConstantUtil.STATUS_SUCCESS);
				rst.put("msg", "成功");
				this.renderJson(rst);	
			}else{
				rst.put("status", ConstantUtil.STATUS_FAILTURE);
				rst.put("msg", "失败");
				this.renderJson(rst);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	
	/**
	 * 编辑(新增)签约信息
	 */
	@Clear
	public void edit(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				CustSigninfo cs = CustSigninfo.dao.findById(pp.getId());
				if(cs == null){
					this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
				this.setAttr("signinfo", cs);
				
				Custinfo c = Custinfo.dao.findById(cs.getCustinfoId());
				this.setAttr("cust", c);
				
				//查询附件信息
				List<SigninfoAnnex> deals = SigninfoAnnex.dao.find("select * from crm_signinfo_annex where delete_flag = 0 and type='deal' and signed_id =" + cs.getSignedId());
				this.setAttr("deals", deals);
				
				List<SigninfoAnnex> resumes = SigninfoAnnex.dao.find("select * from crm_signinfo_annex where delete_flag = 0 and type='resume' and signed_id =" + cs.getSignedId());
				this.setAttr("resumes", resumes);
			}
			
			//国家
			List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
			setAttr("countryList", countryList);
			
			//支付方式
			List<Dict> paycodeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("paycode"), 1).getSubDictionaries();
			setAttr("paycodeList", paycodeList);
			
			
			
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		this.renderJsp("/views/cust/cust_signinfo_edit.jsp");
	}
	
	
	/**
	 * 根据国家获取国家的项目信息
	 */
	@Clear
	public void getProjectsByCountry(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		List<Record> list = Db.find("select project_id,project_name,project_code from crm_project where delete_flag = 0 and country ='" + pp.getNormStr("country")+"'");
		StringBuffer sb = new StringBuffer();
		sb.append("<label class=\"control-label\">项目：</label>")
		.append("<select id=\"project_id\" name=\"project_id\" >")
		.append("<option value=\"\">全部</option>");
		for(Record r : list){
			sb.append("<option value='").append(r.get("project_id").toString()).append("' ")
			.append((r.get("project_id").toString().equals(pp.getNormStr("pid")) ? "selected" : ""))
			.append(">").append(r.getStr("project_name")).append("</option>");
		}
		sb.append("</select>");
		rst.put("result", sb.toString());
		this.renderJson(rst);
	}
	
	
	
	
	/**
	 * 删除客户签约信息
	 */
	@Clear
	public void delete(){
		log.debug("删除客户签约信息");
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getId().isEmpty()){
				CustFollowRecords cfr = new CustFollowRecords();
				cfr.setFollowRecordId(Integer.parseInt(pp.getId()));
				int rlt = Db.update("update crm_cust_signinfo set delete_flag = 1 where signed_id = " + pp.getId());
				if(rlt > 0){
					rst.put("status", 0);
					rst.put("msg", "删除成功");
					this.renderJson(rst);	
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除失败");
					this.renderJson(rst);
				}
			}else{
				log.error("删除客户签约信息出错：参数客户ID缺失");
				this.setAttr("errorInfo", "删除客户签约信息时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	
	/**
	 * 客户签约信息查询参数解析类
	 * @author Gorge
	 *
	 */
	private class CustSginParams extends ParamsParser{

		public CustSginParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select cc.name,ccs.signed_id,ccs.deal_no,cd1.name as country,cp.project_name,ccs.fee,cd2.name as paycode,cc.custinfo_id");
			this.setFromStr(
					"from crm_custinfo cc INNER JOIN crm_cust_signinfo ccs on cc.custinfo_id = ccs.custinfo_id and ccs.delete_flag = 0 and cc.delete_flag = 0" +
					" LEFT JOIN console_user cu on ccs.operator_id = cu.user_id" + 
					" LEFT JOIN console_dictionary cd1 on ccs.country = cd1.dict_code" +
					" LEFT JOIN console_dictionary cd2 on ccs.paycode = cd2.dict_code" +
					" LEFT JOIN crm_project cp on ccs.project_id = cp.project_id ");
			
			//查找有效数据
			LoginUserInfo uinfo = getSessionAttr("LoginUserInfo");
			this.addWhereSegmentByAnd("ccs.operator_id = '" + uinfo.getUid() +"'");
			
			
			//查询客户ID
			String custName = this.getNormStr("custName");
			if(custName!=null && !"".equals(custName.trim())){
				this.addWhereSegmentByAnd(" ccs.name like '%" + custName + "%'");
				this.ctr.setAttr("custName", custName);
			}
			
			this.setDefaultOrderStr("ORDER BY ccs.create_time desc");
		}
	}
	
	
	/**
	 * 删除客户签约附件信息
	 */

	public void deleteAnnex(){
		log.debug("删除客户签约附件信息");
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getId().isEmpty()){
				int rlt = Db.update("update crm_signinfo_annex set delete_flag = 1 where id = " + pp.getId());
				if(rlt > 0){
					rst.put("status", 0);
					rst.put("msg", "删除成功");
					this.renderJson(rst);	
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除失败");
					this.renderJson(rst);
				}
			}else{
				log.error("删除客户签约附件信息出错：参数ID缺失");
				this.setAttr("errorInfo", "删除客户签约附件信息时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	
	/**
	 * 签约附件下载
	 */
	public void download(){
		log.debug("签约附件下载");
		try{
			ParamsParser pp = new ParamsParser(this);
			if(!pp.getId().isEmpty()){
				SigninfoAnnex sa = SigninfoAnnex.dao.findById(Integer.parseInt(pp.getId()));
				if(sa == null){
					log.error("签约附件下载出错：附件信息不存在");
					this.setAttr("errorInfo", "签约附件下载时" + ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
				File f = new File(sa.getFilepath());
				if(f.isFile()){
					renderFile(f);
				}
				renderNull();
			}else{
				log.error("签约附件下载出错：参数ID缺失");
				this.setAttr("errorInfo", "签约附件下载时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
}
