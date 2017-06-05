package cn.pacificimmi.customer.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.CustEditLog;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.CustinfoSteward;
import cn.pacificimmi.common.models.EstimateQuestion;
import cn.pacificimmi.common.models.EstimateRecord;
import cn.pacificimmi.common.models.EstimateSelectAdditional;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.estimate.controllers.EstimateResultController;
import cn.pacificimmi.estimate.models.view.EstimateResultInfo;
import cn.pacificimmi.estimate.models.view.EstimatetDetailRecordInfo;

/**
 * 会员管理控制器
 * @author Gorge
 * 
 */
@Before(LoginInterCeptor.class)
public class MembersController extends Controller {
	private static Logger log = LoggerFactory.getLogger(MembersController.class);
	private String qryFlag = "";
	/****
	 * 默认初始化页面-会员查询
	 */
	
	public void index(){
		log.debug("查询会员信息");
		MemberParams params = new MemberParams(this);
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		for(Record r : list){
			r.set("phone_num", StringUtil.getMaskMobile(r.getStr("phone_num")));
		}
		this.setAttr("list", list); 
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		//查询会员/客户来源
		List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
		setAttr("csourceList", csourceList);
		
		//查询会员/客户状态
		List<Dict> cstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
		setAttr("cstatusList", cstatusList);
		
		//会员状态
		List<Dict> mstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("member_status"), 1).getSubDictionaries();
		setAttr("mstatusList", mstatusList);
		setAttr("mstatus_enabled", PropKit.use("constants.txt").get("member_status_enabled"));
		setAttr("mstatus_disabled", PropKit.use("constants.txt").get("member_status_disabled"));
		
		//所在省
		List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country_china"), 1).getSubDictionaries();
		this.setAttr("provinceList", provinceList);
		//页面
		this.renderJsp("/views/members/member_main.jsp");
	}
	
	
	/**
	 * 新增会员
	 */
	public void add(){
		log.debug("page forward to member_edit.jsp");
		ParamsParser pp = new ParamsParser(this);
		this.setAttr("operation", "新增");
		
		if(pp.getNormStr("name") == null || "".equals(pp.getNormStr("name"))){//跳转新增页面
			//查询客户来源
			List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
			setAttr("csourceList", csourceList);
			
			//查询学历
			List<Dict> eduList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("qualifications"), 1).getSubDictionaries();
			setAttr("eduList", eduList);
			
			this.renderJsp("/views/members/member_edit.jsp");
		}else{//保存新增
			try {
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				
				String name = pp.getNormStr("name");//客户姓名
				String sex = pp.getNormStr("gender");//性别
				String phoneNum = pp.getNormStr("phone_num");//手机号
				String custSource = pp.getNormStr("cust_source");//客户来源
				String qq = pp.getNormStr("qq");//QQ
				String wx = pp.getNormStr("wx");//微信
				String email = pp.getNormStr("email");//邮箱
				String edu = pp.getNormStr("education");//学历
				//String birthday = pp.getNormStr("birthday1");
				String loginName = pp.getNormStr("login_name");//登录名
				String nickName = pp.getNormStr("nick_name");//昵称
				String namePinyin = pp.getNormStr("name_pinyin");//姓名拼音
				
				Custinfo cust = new Custinfo();
				cust.setName(name);
				cust.setGender(sex);
				cust.setPhoneNum(phoneNum);
				cust.setCustSource(custSource);
				cust.setCreateTime(new Date());
				//cust.setBirthday(TpyDateUtil.strToDateLong(birthday));
				cust.setEducation(edu);
				cust.setLoginName(loginName);
				cust.setNickName(nickName);
				cust.setNamePinyin(namePinyin);
				cust.setEmail(email);
				cust.setQq(qq);
				cust.setWx(wx);
				cust.setCreateUser(u.getUid());
				
				cust.save();
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			this.redirect("/members");
		}
	}
	
	/**
	 * 编辑会员
	 */
	public void edit(){
		log.debug("page forward to member_edit.jsp");
		ParamsParser pp = new ParamsParser(this);
		this.setAttr("operation", "编辑");
		try {
			if(pp.getId() != null && !"".equals(pp.getId())){
				if(pp.getNormStr("custinfo_id") == null || "".equals(pp.getNormStr("custinfo_id"))){
					Record cust = Db.findFirst("select * from crm_custinfo where custinfo_id = " + pp.getId());
					if(cust != null){
						this.setAttr("cust", cust);
						
						//查询客户来源
						List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
						setAttr("csourceList", csourceList);						
						
						//查询会员发票信息
						String invoiceSql = "select custinfo_invoice_id,invoice_title,is_use from crm_custinfo_invoice where custinfo_id = "+ pp.getId();
						List<Record> invoiceList = Db.find(invoiceSql);
						this.setAttr("invoiceList", invoiceList);
						
						//查询会员地址信息
						String receiveSql = "select * from crm_custinfo_receive where custinfo_id = "+ pp.getId();
						List<Record> receiveList = Db.find(receiveSql);
						this.setAttr("receiveList", receiveList);
						
						this.renderJsp("/views/members/member_detail.jsp");
					}else{
						this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
						this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
					}
				}else{
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					Custinfo cust = Custinfo.dao.findById(pp.getNormStr("custinfo_id"));
					String name = pp.getNormStr("name");//客户姓名
					String sex = pp.getNormStr("gender");//性别
					String phoneNum = pp.getNormStr("phone_num");//手机号
					String custSource = pp.getNormStr("cust_source");//客户来源
					String qq = pp.getNormStr("qq");//QQ
					String wx = pp.getNormStr("wx");//微信
					String email = pp.getNormStr("email");//邮箱
					String edu = pp.getNormStr("education");//学历
					//String birthday = pp.getNormStr("birthday1");
					String loginName = pp.getNormStr("login_name");//登录名
					String nickName = pp.getNormStr("nick_name");//昵称
					String namePinyin = pp.getNormStr("name_pinyin");//姓名拼音
					
					cust.setName(name);
					cust.setGender(sex);
					cust.setPhoneNum(phoneNum);
					cust.setCustSource(custSource);
					cust.setCreateTime(new Date());
					//cust.setBirthday(TpyDateUtil.strToDateLong(birthday));
					cust.setEducation(edu);
					cust.setLoginName(loginName);
					cust.setNickName(nickName);
					cust.setNamePinyin(namePinyin);
					cust.setEmail(email);
					cust.setQq(qq);
					cust.setWx(wx);
					cust.setCreateUser(u.getUid());
					cust.update();
					this.redirect("/members");
				}
			}else{
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}

	
	/**
	 * 客户详情
	 */
	
	public void detail(){
		log.debug("page forward to cust_detail.jsp");
		try {
			ParamsParser pp = new ParamsParser(this);
			if(pp.getId() == null || "".equals(pp.getId())){
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}else{
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				this.setAttr("userId", u.getUid());
				Custinfo cust = Custinfo.dao.findById(pp.getId());
				if(cust != null){
					cust.setPhoneNum(StringUtil.getMaskMobile(cust.getPhoneNum()));
					this.setAttr("cust", cust);
					//代理人
					String dlr = "无";
					if(cust.getProxy() != null){
						Custinfo proxy = Custinfo.dao.findById(cust.getProxy());
						if(proxy != null){
							dlr = proxy.getName();
						}
					}
					this.setAttr("dlr", dlr);
					
					//查询客户来源
					Record s = Db.findFirst("select name from console_dictionary where delete_flag = 0 and dict_code='" + cust.getCustSource() + "'");
					this.setAttr("memberSource", s != null ? s.get("name"):"");
					
					//会员状态
					Record r = Db.findFirst("select name from console_dictionary where delete_flag = 0 and dict_code='" + cust.getMemberStatus() + "'");
					this.setAttr("memberStatus", r != null ? r.get("name"):"");
					
					//所在省市
					String ss = "";
					if( cust.getProvince() != null && !cust.getProvince().isEmpty()){
						Record p = Db.findFirst("select name from console_dictionary where delete_flag = 0 and dict_code='" + cust.getProvince() + "'");
						ss += (p != null ? p.get("name"):"");
						
						if( cust.getCity() != null && !cust.getCity().isEmpty()){
							Record c = Db.findFirst("select name from console_dictionary where delete_flag = 0 and dict_code='" + cust.getCity() + "'");
							ss += (c != null ? c.get("name"):"");
						}
					}
					this.setAttr("ss", ss);
					
					//查询评估记录
					String estimateSql = "select r.create_time estTime,qu.title,se.content,r.custinfo_id,dr.int_value "+
										 "from wx_estimate_record r "+
										 "left join wx_estimatet_detail_record dr on r.estimate_record_id = dr.estimate_record_id " +
										 "left join wx_estimate_question qu on dr.estimate_question_id = qu.estimate_question_id " +
										 "left join wx_estimate_select se on dr.estimate_select_id = se.estimate_select_id " +
										 "where r.custinfo_id=" + cust.getCustinfoId() +
										 " order by qu.priority asc";
					List<Record> estimateRecord = Db.find(estimateSql);
					this.setAttr("estimateRecord", estimateRecord);
					this.setAttr("notEmpty", (null != estimateRecord && estimateRecord.size() > 0) ? 1:0);
					this.setAttr("ifEstimate", (null != estimateRecord && estimateRecord.size() > 0) ? "已评估":"未评估");
					this.setAttr("estimateTime", (null != estimateRecord && estimateRecord.size() > 0) ? estimateRecord.get(0).get("estTime"):"");
					
					//评估结果
					List<Project> projectList = null;
					List<Project> plist = Project.dao.find("select * from crm_project where project_status = "+
							PropKit.use("constants.txt").get("project_status_sx")+
							" AND project_level = "+PropKit.use("constants.txt").get("project_level_one")+"  and delete_flag=0");
					projectList = plist;
					
					EstimateRecord er = EstimateRecord.dao.findFirst("select * from wx_estimate_record where custinfo_id="+cust.getCustinfoId());
					if(null != projectList && projectList.size()>0 && null != er) {
						List<Record> result = Db.find("select * from wx_estimatet_detail_record WHERE estimate_record_id="+er.getEstimateRecordId());
						List<EstimatetDetailRecordInfo> edrList = new ArrayList<EstimatetDetailRecordInfo>();
						if(null != result && result.size()>0) {
							for(Record re:result) {
								EstimatetDetailRecordInfo edr = new EstimatetDetailRecordInfo();
								edr.bindingData(edr, re);
								EstimateQuestion eq = EstimateQuestion.dao.findById(edr.getEstimate_question_id());
								edr.setEstimateQuestion(eq);
								if(null != edr.getEstimate_select_id() && !"".equals(edr.getEstimate_select_id())) {
									List<EstimateSelectAdditional> esaList = EstimateSelectAdditional.dao.find("select * from wx_estimate_select_additional where estimate_select_id ="+edr.getEstimate_select_id());
									edr.setEsaList(esaList);
								}
								edrList.add(edr);
							}
							
							List<EstimateResultInfo> eriList = new ArrayList<EstimateResultInfo>();
							for(Project pj:projectList) {
								EstimateResultInfo eri = (new EstimateResultController()).EstimateResultByProjectId(edrList, pj);
								if(null != eri) {
									eriList.add(eri);
								}
							}
							
							if(eriList.size()>0) {
								Collections.sort(eriList,new Comparator<EstimateResultInfo>(){
								      public int compare(EstimateResultInfo arg0, EstimateResultInfo arg1) {
								          int i = arg1.getMatching().compareTo(arg0.getMatching());
								          if(i==0) {
								               int j = arg1.getRecommended().compareTo(arg0.getRecommended());
								               if(j==0) {
								            	   int k = arg0.getOnline_time().compareTo(arg1.getOnline_time());
								            	   return k;
								               }
								               return j;
								          }
								          return i;
								    }
								});
								this.setAttr("resultList", eriList);
							} 
							
						}
					
				}else{
					this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
				}
				this.renderJsp("/views/members/member_detail.jsp");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 删除客户
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete(){
		try{
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getIds().isEmpty()){
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				for(String id : ids){
					int rlt = Db.update("update crm_custinfo set delete_flag = 1 where custinfo_id = " + id);
					if(rlt > 0){
						success++;
					}else{
						fail++;
					}
				}
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "删除成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("删除会员出错：参数ID缺失");
				this.setAttr("errorInfo", "删除会员时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除会员时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 禁用
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void disabled(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getId().isEmpty()){
				int rlt = Db.update("update crm_custinfo set member_status = '"+
						PropKit.use("constants.txt").get("member_status_disabled")
						+"' where custinfo_id = " + pp.getId());
				if(rlt > 0){
					rst.put("status", 0);
					rst.put("msg", "禁用成功");
				}else{
					rst.put("status", 100);
					rst.put("msg", "禁用失败");
				}
				this.renderJson(rst);
			}else{
				log.error("禁用会员出错：参数ID缺失");
				this.setAttr("errorInfo", "禁用会员时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "禁用会员时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 启用
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void enabled(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getId().isEmpty()){
				int rlt = Db.update("update crm_custinfo set member_status = '"+
						PropKit.use("constants.txt").get("member_status_enabled")
						+"' where custinfo_id = " + pp.getId());
				if(rlt > 0){
					rst.put("status", 0);
					rst.put("msg", "启用成功");
				}else{
					rst.put("status", 100);
					rst.put("msg", "启用失败");
				}
				this.renderJson(rst);
			}else{
				log.error("启用会员出错：参数ID缺失");
				this.setAttr("errorInfo", "启用会员时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "启用会员时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 分配顾问(移民管家)
	 */
	public void assign(){
		log.debug("page forward to assign.jsp");
		AdviserParams params = new AdviserParams(this);
		String custId = params.getId();
		this.setAttr("custId", custId);
		//查询客户信息
		
		//查询客户其他信息 
		
		//查询移民管家列表
		/*String sql = "select cu.user_id,cu.user_name,co1.name as comName,co2.name as depName "+
					" from console_user cu,console_user_station cus ,console_station cs,console_orgnization co1,console_orgnization co2 " +
					" where cu.user_id = cus.user_id and cus.station_id = cs.station_id " +
					" and cs.name = '移民管家' and cu.delete_flag = 'VALID' and cs.delete_flag = 'STATE_VALID'";*/
		
		
		//列表数据
		//db.p
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("list", list); 
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);

		//构造移民管家树		
		this.renderJsp("/views/cust/assign.jsp");
	}
	
	
	/**
	 * 保存客户和分配顾问(管家)关系
	 */
	@Clear
	public void saveCustAdviser(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			CustinfoSteward  cs = new CustinfoSteward();
			if(pp.getNormStr("id") != null && !"".equals(pp.getNormStr("id")) 
					&& pp.getNormStr("custId") != null && !"".equals(pp.getNormStr("custId"))){
				//保存前更新已有的顾问状态
				Db.update("update crm_custinfo_steward set is_hire = 0 where custinfo_id = " + Integer.parseInt(pp.getNormStr("custId")));
				
				//保存新的分配关系
				cs.setCustinfoId(Integer.parseInt(pp.getNormStr("custId")));//客户ID
				cs.setStewardId(Integer.parseInt(pp.getNormStr("id")));//管家ID
				cs.setIsHire(1);
				cs.setHireDate(new Date());//雇佣日期
				
				cs.save();
				
				rst.put("status", 0);
				rst.put("msg", "分配顾问成功.");
				this.renderJson(rst);
			}else{
				log.error("保存客户和顾问关系出错：参数缺失");
				rst.put("status", 1);
				rst.put("msg", "参数错误，请刷新重试.");
				this.renderJson(rst);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "保存客户和顾问关系时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	/**
	 * 客户管理查询参数解析类
	 * @author Gorge
	 *
	 */
	private class MemberParams extends ParamsParser{

		public MemberParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select DISTINCT cust.custinfo_id,cust.name,cust.gender,cust.phone_num ," +
							" cust.login_name,cust.nick_name,cust.email,cust.last_time,cust.last_ip, " +
							"cd1.name cust_source,cust.create_time,cd2.name member_statusZN,cust.member_status,proxy.name dlr");
			this.setFromStr("from crm_custinfo cust " +
							" LEFT JOIN console_dictionary cd1 on cust.cust_source = cd1.dict_code and cd1.delete_flag = 0 " +
							" LEFT JOIN console_dictionary cd2 on cust.member_status = cd2.dict_code and cd2.delete_flag = 0  " +
							" LEFT JOIN crm_custinfo proxy on cust.proxy = proxy.custinfo_id and proxy.delete_flag = 0 ");
			
			//查询无效客户
			if("invalid".equals(qryFlag)){
				String invalid = PropKit.use("constants.txt").get("cust_status_invalid");
				this.addWhereSegmentByAnd("cust.delete_flag = 0 and cust.cust_status = '" + invalid + "'");
				this.ctr.setAttr("custStatus", invalid);
			}else{
				//查找有效数据
				this.addWhereSegmentByAnd("cust.delete_flag = 0");
			}
			
			//查询客户姓名
			String name = this.getAllStr("name");
			if(name != null && !name.trim().isEmpty()){
				this.addWhereSegmentByAnd(" cust.name like '%" + name.trim() + "%'");
				this.ctr.setAttr("name", name.trim());
			}
			//手机号
			String paras = this.getAllStr("paras");
			if(paras!=null && !"".equals(paras.trim())){
				this.addWhereSegmentByAnd(" cust.phone_num like '%" + paras.trim() + "%'");
				this.ctr.setAttr("paras", paras.trim());
			}
			
			//客户来源
			String custSource = this.getNormStr("source");
			if(custSource != null && !"".equals(custSource)){
				this.addWhereSegmentByAnd(" cust.cust_source = '" + custSource + "'");
				this.ctr.setAttr("custSource", custSource);
			}
			
			//会员状态
			String mstatus = this.getNormStr("mstatus");
			if(mstatus != null && !mstatus.isEmpty()){
				this.addWhereSegmentByAnd(" cust.member_status = '" + mstatus + "'");
				this.ctr.setAttr("memberStatus", mstatus);
			}
			
			//所在城市
			String province = this.getNormStr("province");
			if(province != null && !province.isEmpty()){
				this.addWhereSegmentByAnd(" cust.province = '" + province + "'");
				this.ctr.setAttr("sheng", province);
				this.ctr.setAttr("cityList", DictionaryManager.getInstance().getSubDictionariesByDegree(province, 1).getSubDictionaries());
			}
			
			String city = this.getNormStr("city");
			if(city != null && !city.isEmpty()){
				this.addWhereSegmentByAnd(" cust.city = '" + city + "'");
				this.ctr.setAttr("shi", city);
				
			}
			
			this.setDefaultOrderStr("order by cust.create_time desc");
		}
	}
	
	
	/**
	 * 修改客户（线索）状态
	 */
	
	public void update(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getId().isEmpty()){
				String operType = pp.getNormStr("operType");
				String custStatus = "";
				if(ConstantUtil.OPERATE_INVALID.equals(operType)){//无效客户
					custStatus = PropKit.use("constants.txt").get("cust_source_invalid");
				}else if(ConstantUtil.OPERATE_INTENTION.equals(operType)){//意向客户
					custStatus = PropKit.use("constants.txt").get("cust_source_intention");
				}
				
				int rlt = Db.update("update crm_custinfo set cust_status = " + custStatus + " where custinfo_id = " + pp.getId());
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
				log.error("更新客户状态出错：参数客户ID缺失");
				this.setAttr("errorInfo", "更新客户状态时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "更新客户状态时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	} 
	
	/**
	 * @param custId 客户ID
	 * @param operator 操作人ID
	 * @param operDesc 操作描述
	 */
	public void saveCustEditLog(int custId,int operator,String operDesc){
		try {
			CustEditLog cel = new CustEditLog();
			cel.setCustinfoId(custId);
			cel.setDeleteFlag(0);
			cel.setOperator(operator);
			cel.setRemark(operDesc);
			cel.setCreateTime(new Date());
			cel.save();
		} catch (Exception e) {
			log.error("记录客户信息修改日志" + e.getMessage(), e);
		}
	}
	
	
	/**
	 * 顾问查询参数解析类
	 * @author Gorge
	 *
	 */
	private class AdviserParams extends ParamsParser{

		public AdviserParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select cu.steward_id,cu.user_id,cu.user_name,co1.name as comName,co2.name as depName");
			this.setFromStr("from crm_steward_user cu,console_orgnization co1,console_orgnization co2 ");
			
			//查找有效数据
			this.addWhereSegmentByAnd(" cu.delete_flag = 'VALID' and cu.com_id = co1.org_id and cu.dep_id = co2.org_id");
			
			
			//查询客户姓名/手机号
			String uname = this.getNormStr("uname");
			if(uname!=null && !"".equals(uname.trim())){
				this.addWhereSegmentByAnd(" cu.user_name like '%"+uname+"%'");
				this.ctr.setAttr("uname", uname);
			}
			
			this.setDefaultOrderStr("order by cu.user_name ");
		}
	}
	
	/**
	 * 校验会员/客户 用户名、手机号、邮箱是否唯一
	 */
	@Clear
	public void invalidation(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		try {
			String typeName = "";
			String paraValue = pp.getNormStr("para_value");
			String type = pp.getNormStr("type");
			String keyId = pp.getAllStr("key_id");
			String sql = "select custinfo_id from crm_custinfo where delete_flag = 0";
			if(ConstantUtil.VALID_LOGINNAME.equals(type)){//用户名
				sql += " and login_name = '" + paraValue + "'";
				typeName = ConstantUtil.VALID_LOGINNAME_NAME;
			}else if(ConstantUtil.VALID_MOBILE.equals(type)){//手机号
				sql += " and phone_num = '" + paraValue + "'";
				typeName = ConstantUtil.VALID_MOBILE_NAME;
			}else if(ConstantUtil.VALID_EMAIL.equals(type)){//邮箱
				sql += " and email = '" + paraValue + "'";
				typeName = ConstantUtil.VALID_EMAIL_NAME;
			}
			
			if(keyId != null && !keyId.isEmpty()){
				sql += " and custinfo_id != " + keyId;
			}
			List<Record> list = Db.find(sql);
			if(list != null && list.size() > 0){
				rst.put("status", 100);
				rst.put("msg", "该"+typeName+"已存在");
			}else{
				rst.put("status", 0);
				rst.put("msg", "成功");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "请求服务器出错");
		}
		this.renderJson(rst);
		
	}
	
	/**
	 * 根据省份查询城市
	 */
	@Clear
	public void city(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		try {
			String province = pp.getNormStr("province");
			
			List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(province, 1).getSubDictionaries();
			
			rst.put("status", 0);
			rst.put("lists", provinceList);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "请求服务器出错");
		}
		this.renderJson(rst);
	}
}
