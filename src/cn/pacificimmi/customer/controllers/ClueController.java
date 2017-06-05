package cn.pacificimmi.customer.controllers;

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

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.CustEditLog;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.CustinfoIntention;
import cn.pacificimmi.common.models.CustinfoSteward;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.ConstantUtil;

/**
 * 线索控制器
 * @author Gorge
 * 
 */
@Before(LoginInterCeptor.class)
public class ClueController extends Controller {
	private static Logger log = LoggerFactory.getLogger(ClueController.class);
	private String qryFlag = "";
	/****
	 * 默认初始化页面
	 */
	public void index(){
		log.debug("查询线索列表");
		int noAssigned = 0;
		int assigned = 0;
		int invalid = 0;
		int changed = 0;
		
		this.qryFlag = "clue";//线索
		
		ClueParams params = new ClueParams(this);
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		
		//处理相同手机号颜色显示
		
		String samePhoneSql = "select phone_num ,count(1) from crm_custinfo where phone_num != '' and delete_flag = 0 GROUP BY phone_num having count(1) > 1";
		List<Record> sameRecord = Db.find(samePhoneSql);
		
		HashMap<String,String> colorMp = new HashMap<String,String>();
		for(Record s : sameRecord){
			colorMp.put((String) s.get("phone_num"), ConstantUtil.color());
		}
		
		//遍历结果,为重复手机号的数据着色
		for(Record r : list){
			if(r.get("phone_num") != null && !r.get("phone_num").toString().isEmpty()){
				if(colorMp.containsKey(r.get("phone_num"))){
					r.set("color", colorMp.get(r.get("phone_num")));
				}
			}
			
		}
		
		this.setAttr("list", list); 
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		//查询客户来源
		List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
		setAttr("csourceList", csourceList);
		
		//查询客户状态
		List<Dict> cstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
		setAttr("cstatusList", cstatusList);
		
		//按分配、未分配、无效统计
		ClueFastParams paramsFast = new ClueFastParams(this);
		Page<Record> page1 = Db.paginate(1, 1000000, paramsFast.getSelectStr(), paramsFast.getFromStr());
		List<Record> list1 = page1.getList();
		for(Record r : list1){
			if(r.get("cust_statusZN") != null && r.get("cust_statusZN").toString().contains("无效")){
				invalid ++;
			}
			if(r.get("user_name") == null || "".equals(r.get("user_name"))){
				noAssigned ++;
			}else{
				assigned ++;
			}
			if(r.get("is_changed") == "1"){
				changed ++;
			}
		}
		this.setAttr("all", list1.size());
		this.setAttr("noAssigned", noAssigned);
		this.setAttr("assigned", assigned);
		this.setAttr("invalid", invalid);
		this.setAttr("changed", changed);
		
		//页面
		this.renderJsp("/views/cust/cust_clue.jsp");
	}

	
	
	/**
	 * 新增
	 */
	public void add(){
		log.debug("page forward to cust_clue_edit.jsp");
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("name") == null || "".equals(pp.getNormStr("name"))){//跳转新增页面
			//查询客户来源
			//查询客户来源
			List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
			setAttr("csourceList", csourceList);
			
			//查询客户状态
			List<Dict> cstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
			setAttr("cstatusList", cstatusList);
			
			//所在地区(省份)
			List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("province"), 1).getSubDictionaries();
			setAttr("provinceList", provinceList);
			
			this.renderJsp("/views/cust/cust_clue_edit.jsp");
		}else{//保存新增
			try {
				
				String name = pp.getNormStr("name");//客户姓名
				String sex = pp.getNormStr("gender");//性别
				String phoneNum = pp.getNormStr("phone_num");//手机号
				String custSource = pp.getNormStr("cust_source");//客户来源
				String remark = pp.getNormStr("remark");//备注
				String custStatus = pp.getNormStr("cust_status");//客户状态
				
				Custinfo cust = new Custinfo();
				cust.setName(name);
				cust.setGender(sex);
				cust.setPhoneNum(phoneNum);
				cust.setRemark(remark);
				cust.setCustSource(custSource);
				cust.setCreateTime(new Date());
				cust.setCustStatus(custStatus);
				cust.save();
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			this.redirect("/cust/potential");
		}
	}
	
	/**
	 * 编辑客户
	 */
	public void edit(){
		log.debug("page forward to cust_clue_edit.jsp");
		ParamsParser pp = new ParamsParser(this);
		
		try {
			if(pp.getId() != null && !"".equals(pp.getId())){
				
				if(pp.getNormStr("custinfo_id") == null || "".equals(pp.getNormStr("custinfo_id"))){
					Custinfo cust = Custinfo.dao.findById(pp.getId());
					if(cust != null){
						this.setAttr("cust", cust);
						
						//查询客户来源
						List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
						setAttr("csourceList", csourceList);
						
						//查询客户状态
						List<Dict> cstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
						setAttr("cstatusList", cstatusList);
						
						//所在地区(省份)
						List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("province"), 1).getSubDictionaries();
						setAttr("provinceList", provinceList);
						
						//客户意向信息
						Record intention = Db.findFirst("select * from crm_custinfo_intention where custinfo_id =" + pp.getId());
						this.setAttr("intention", intention);
						
						//移民目的
						List<Dict> intentionList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("immigrate_intention"), 1).getSubDictionaries();
						for(Dict d : intentionList){
							if(intention != null && intention.get("intention") != null && !"".equals(intention.get("intention"))
									&& intention.get("intention").toString().contains(d.getDictCode())){
								d.setDeleteFlag(9);//选中状态
							}
							
						}
						setAttr("intentionList", intentionList);
						
						//国家
						List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 1).getSubDictionaries();
						for(Dict d : countryList){
							if(intention != null && intention.get("country") != null && !"".equals(intention.get("country"))
									&& intention.get("country").toString().contains(d.getDictCode())){
								d.setDeleteFlag(9);//选中状态
							}
							
						}
						setAttr("countryList", countryList);
						
						//学历
						List<Dict> eduList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("qualifications"), 1).getSubDictionaries();
						setAttr("eduList", eduList);
						
						//外语能力
						List<Dict> languageList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("language"), 1).getSubDictionaries();
						setAttr("languageList", languageList);
						
						//签证类型
						List<Dict> visaTypeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("visa_type"), 1).getSubDictionaries();
						setAttr("visaTypeList", visaTypeList);
						
						//居住要求
						List<Dict> liveList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("live_requirement"), 1).getSubDictionaries();
						setAttr("liveList", liveList);
						
						//年龄要求
						List<Dict> ageList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("age"), 1).getSubDictionaries();
						setAttr("ageList", ageList);
						
						//管理经验
						List<Dict> manageList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("manage"), 1).getSubDictionaries();
						setAttr("manageList", manageList);
						
						//查看跟进记录
						
						CustFollowParams params = new CustFollowParams(this);
						
						//列表数据
						Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
						List<Record> list = page.getList();
						this.setAttr("list", list); 
						
						//翻页
						String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
						setAttr("pageBar",pagesView);
						
						
						
						this.renderJsp("/views/cust/cust_clue_edit.jsp");
					}else{
						this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
						this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
					}
				}else{
					Custinfo cust = Custinfo.dao.findById(pp.getNormStr("custinfo_id"));
					String name = pp.getNormStr("name");//客户姓名
					String sex = pp.getNormStr("gender");//性别
					String phoneNum = pp.getNormStr("phone_num");//手机号
					String custSource = pp.getNormStr("cust_source");//客户来源
					String remark = pp.getNormStr("remark");//备注
					String custStatus = pp.getNormStr("cust_status");//客户状态
					
					cust.setName(name);
					cust.setGender(sex);
					cust.setPhoneNum(phoneNum);
					cust.setRemark(remark);
					cust.setCustSource(custSource);
					cust.setCreateTime(new Date());
					cust.setCustStatus(custStatus);
					cust.update();
					this.redirect("/cust/clue");
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
	 * 转换线索
	 */
	public void changeClue(){
		try{
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(pp.getIds() != null && !"".equals(pp.getIds())){
				int success = 0;
				int fail = 0;
			
				String[] ids = pp.getIds().split(",");
				for(String id : ids){
					//修改状态
					int rlt = Db.update("update crm_custinfo set cust_status = '"+PropKit.use("constants.txt").get("cust_status_invalid")
					 +"',is_changed = 1 where custinfo_id = " + Integer.parseInt(id));
					if(rlt > 0){
						success ++;
						CustController c = new CustController();
						c.saveCustEditLog(Integer.parseInt(id), Integer.parseInt(u.getUid()), "转换线索");
						
					}else{
						fail ++;
					}
				}
				if(fail > 0){
					rst.put("status", 0);
					rst.put("msg", "转换线索成功["+ success +"],失败["+ fail +"].");
					this.renderJson(rst);
				}
				rst.put("status", 0);
				rst.put("msg", "转换线索成功.");
				this.renderJson(rst);
				
			}else{
				log.error("转换线索出错：参数缺失");
				this.setAttr("errorInfo", "转换线索时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "转换线索时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 保存线索意向信息
	 */
	@Clear
	public void saveCustIntention(){
		ParamsParser params = new ParamsParser(this);
		try{
			if(params.getNormStr("custinfo_id") == null || params.getNormStr("custinfo_id").isEmpty()){
				log.error("保存意向信息出错：客户ID缺失");
				this.setAttr("errorInfo", "保存意向信息时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			if(params.getNormStr("intention_id") == null || params.getNormStr("intention_id").isEmpty()){
				//新增
				CustinfoIntention ci = new CustinfoIntention();
				ci.setCreateTime(new Date());
				ci.setCreator(Integer.parseInt(u.getUid()));
				ci.setCalculationMax(
						new BigDecimal(
								((
										params.getNormStr("calculation_max") == null || params.getNormStr("calculation_max").isEmpty()
										))?"0":params.getNormStr("calculation_max")));//最高预算
				
				ci.setCalculationMin(
						new BigDecimal(
								((
										params.getNormStr("calculation_min") == null || params.getNormStr("calculation_min").isEmpty()
										))?"0":params.getNormStr("calculation_min")));//最低预算
				ci.setCountry(params.getNormStr("country"));//国家
				ci.setCurrentAssign(0);//当前跟进人
				ci.setCustinfoId(Integer.parseInt(params.getNormStr("custinfo_id")));//客户ID
				ci.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				ci.setEducation(params.getNormStr("education"));//学历
				ci.setFamilyAssets(params.getAllStr("family_assets"));//家庭净资产
				ci.setIdentityType(params.getNormStr("identity_type"));//获得身份
				ci.setIntention(params.getAllStr("intention"));//
				ci.setLanguage(params.getAllStr("language"));//语言
				ci.setLiveRequire(params.getAllStr("live_require"));//居住要求
				ci.setProjectId(params.getAllStr("project_id"));
				ci.setStatus("");
				ci.setManageExp(params.getAllStr("manage_exp"));//管理经验
				ci.setAge(params.getAllStr("age"));
				
				//保存前判断是否存在该客户的意向信息
				Record rl = Db.findFirst("select intention_id from crm_custinfo_intention where delete_flag = 0 and custinfo_id =" + params.getNormStr("custinfo_id") );
				if(rl != null ){ 
					ci.setIntentionId((Integer)rl.get("intention_id"));
					ci.update();
				}else{
					ci.save();
				}
				
				this.setAttr("active", "1");
				//this.redirect("/cust/clue/edit/" + params.getNormStr("custinfo_id"));
				this.redirect(params.getAllStr("fromurl"));
			}else{
				CustinfoIntention ci = CustinfoIntention.dao.findById(Integer.parseInt(params.getNormStr("intention_id")));
				ci.setModifier(Integer.parseInt(u.getUid()));
				ci.setModifyTime(new Date());

				ci.setCalculationMax(
						new BigDecimal(
								((
										params.getNormStr("calculation_max") == null || params.getNormStr("calculation_max").isEmpty()
										))?"0":params.getNormStr("calculation_max")));//最高预算
				
				ci.setCalculationMin(
						new BigDecimal(
								((
										params.getNormStr("calculation_min") == null || params.getNormStr("calculation_min").isEmpty()
										))?"0":params.getNormStr("calculation_min")));//最低预算
				ci.setCountry(params.getNormStr("country"));//国家
				ci.setCurrentAssign(0);//当前跟进人
				ci.setCustinfoId(Integer.parseInt(params.getNormStr("custinfo_id")));//客户ID
				ci.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				ci.setEducation(params.getNormStr("education"));//学历
				ci.setFamilyAssets(params.getAllStr("family_assets"));//家庭净资产
				ci.setIdentityType(params.getNormStr("identity_type"));//获得身份
				ci.setIntention(params.getAllStr("intention"));//
				ci.setLanguage(params.getAllStr("language"));//语言
				ci.setLiveRequire(params.getAllStr("live_require"));//居住要求
				ci.setProjectId(params.getAllStr("project_id"));
				ci.setStatus("");
				ci.setManageExp(params.getAllStr("manage_exp"));//管理经验
				ci.setAge(params.getAllStr("age"));
				
				ci.update();
				
				this.setAttr("active", "1");
				//this.redirect("/cust/clue/edit/" + params.getNormStr("custinfo_id"));
				this.redirect(params.getAllStr("fromurl"));
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "保存意向信息时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	
	
	/**
	 * 查看编辑记录
	 */
	@Clear
	public void editHis(){
		log.debug("page forward to cust_edit_log.jsp");
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				List<Record> editList = Db.find("select log.*,u.user_name from crm_cust_edit_log log "+
						"left join console_user u on log.operator = u.user_id where log.delete_flag = 0 and log.custinfo_id = " + pp.getId()+
						" order by log.create_time desc"
						);
				this.setAttr("editList", editList);
				this.renderJsp("/views/cust/cust_edit_log.jsp");
			}else{
				this.setAttr("errorInfo", "查看编辑记录时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "查看"+pp.getId()+"编辑记录时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	public CustinfoIntention handleCiParams(ParamsParser params){
		LoginUserInfo u = getSessionAttr("LoginUserInfo");
		
		CustinfoIntention ci = new CustinfoIntention();
		if(params.getNormStr("intention_id") != null && !params.getNormStr("intention_id").isEmpty()){
			//修改
			ci = CustinfoIntention.dao.findById(Integer.parseInt(params.getNormStr("intention_id")));
			ci.setModifier(Integer.parseInt(u.getUid()));
			ci.setModifyTime(new Date());
		}else{
			//新增
			ci.setCreateTime(new Date());
			ci.setCreator(Integer.parseInt(u.getUid()));
		}
		ci.setCalculationMax(
				new BigDecimal(
						((
								params.getNormStr("calculationMax") == null || params.getNormStr("calculationMax").isEmpty()
								))?"0":params.getNormStr("calculationMax")));//最高预算
		
		ci.setCalculationMin(
				new BigDecimal(
						((
								params.getNormStr("calculationMin") == null || params.getNormStr("calculationMin").isEmpty()
								))?"0":params.getNormStr("calculationMin")));//最低预算
		ci.setCountry(params.getNormStr("country"));//国家
		ci.setCurrentAssign(0);//当前跟进人
		ci.setCustinfoId(Integer.parseInt(params.getNormStr("custId")));//客户ID
		ci.setDeleteFlag(ConstantUtil.DATA_STATUS_DELETE);
		ci.setEducation(params.getNormStr("education"));//学历
		ci.setFamilyAssets(params.getNormStr("familyAssets"));//家庭净资产
		ci.setIdentityType(params.getNormStr("identityType"));
		ci.setIntention(params.getNormStr("intention"));//
		ci.setLanguage(params.getNormStr("language"));//语言
		ci.setLiveRequire(params.getAllStr("liveRequire"));//居住要求
		ci.setProjectId(params.getNormStr("projectId"));
		ci.setStatus("");
		
		return ci;
	}
	
	
	/**
	 * 客户跟进记录查询参数解析类
	 * @author Gorge
	 *
	 */
	public class CustFollowParams extends ParamsParser{

		public CustFollowParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select cfr.*,cd.name as cust_status");
			this.setFromStr("from crm_cust_follow_records cfr" +
							" INNER JOIN crm_custinfo cc on cfr.custinfo_id = cc.custinfo_id" +
							" LEFT JOIN console_dictionary cd on cc.cust_status = cd.dict_code");
			
			//查找有效数据
			this.addWhereSegmentByAnd("cfr.delete_flag != 1");
			
			
			//查询客户ID
			String custId = this.getId();
			if(custId!=null && !"".equals(custId.trim())){
				this.addWhereSegmentByAnd(" cfr.custinfo_id = " + custId + "");
				this.ctr.setAttr("custId", custId);
			}
			
			this.setDefaultOrderStr("ORDER BY cfr.create_time desc");
		}
	}

	
	/**
	 * 详情
	 */
	@Clear
	public void detail(){
		log.debug("page forward to cust_clue_detail.jsp");
		ParamsParser pp = new ParamsParser(this);
		
		try {
			if(pp.getId() != null && !"".equals(pp.getId())){
				
				if(pp.getNormStr("custinfo_id") == null || "".equals(pp.getNormStr("custinfo_id"))){
					Custinfo cust = Custinfo.dao.findById(pp.getId());
					if(cust != null){
						this.setAttr("cust", cust);
						
						//查询客户来源
						List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
						setAttr("csourceList", csourceList);
						
						//查询客户状态
						List<Dict> cstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
						setAttr("cstatusList", cstatusList);
						
						//所在地区(省份)
						List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("province"), 1).getSubDictionaries();
						setAttr("provinceList", provinceList);
						
						//客户意向信息
						Record intention = Db.findFirst("select * from crm_custinfo_intention where custinfo_id =" + pp.getId());
						this.setAttr("intention", intention);
						
						//移民目的
						List<Dict> intentionList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("immigrate_intention"), 1).getSubDictionaries();
						for(Dict d : intentionList){
							if(intention != null && intention.get("intention") != null && !"".equals(intention.get("intention"))
									&& intention.get("intention").toString().contains(d.getDictCode())){
								d.setDeleteFlag(9);//选中状态
							}
							
						}
						setAttr("intentionList", intentionList);
						
						//国家
						List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 1).getSubDictionaries();
						for(Dict d : countryList){
							if(intention != null && intention.get("country") != null && !"".equals(intention.get("country"))
									&& intention.get("country").toString().contains(d.getDictCode())){
								d.setDeleteFlag(9);//选中状态
							}
							
						}
						setAttr("countryList", countryList);
						
						//学历
						List<Dict> eduList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("qualifications"), 1).getSubDictionaries();
						setAttr("eduList", eduList);
						
						//外语能力
						List<Dict> languageList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("language"), 1).getSubDictionaries();
						setAttr("languageList", languageList);
						
						//签证类型
						List<Dict> visaTypeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("visa_type"), 1).getSubDictionaries();
						setAttr("visaTypeList", visaTypeList);
						
						//居住要求
						List<Dict> liveList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("live_requirement"), 1).getSubDictionaries();
						setAttr("liveList", liveList);
						
						//年龄要求
						List<Dict> ageList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("age"), 1).getSubDictionaries();
						setAttr("ageList", ageList);
						
						//管理经验
						List<Dict> manageList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("manage"), 1).getSubDictionaries();
						setAttr("manageList", manageList);
						
						//查看跟进记录
						
						CustFollowParams params = new CustFollowParams(this);
						
						//列表数据
						Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
						List<Record> list = page.getList();
						this.setAttr("list", list); 
						
						//翻页
						String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
						setAttr("pageBar",pagesView);
						
						
						
						this.renderJsp("/views/cust/cust_clue_detail.jsp");
					}else{
						this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
						this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
					}
				}else{
					this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
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
				this.setAttr("errorInfo", "保存客户和顾问关系时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
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
	private class ClueParams extends ParamsParser{

		public ClueParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select DISTINCT cust.custinfo_id,cust.name,cust.gender,cust.phone_num ," +
					"cd1.name cust_sourceZN,cd2.name cust_statusZN,csu.user_name,cust.create_time");
			this.setFromStr("from crm_custinfo cust " +
					" LEFT JOIN console_dictionary cd1 on cust.cust_source = cd1.dict_code " +
					" LEFT JOIN console_dictionary cd2 on cust.cust_status = cd2.dict_code " +
					" LEFT JOIN crm_custinfo_steward ccs on cust.custinfo_id = ccs.custinfo_id and ccs.is_hire = 1" +
					" LEFT JOIN crm_steward_user csu on ccs.steward_id = csu.steward_id and csu.delete_flag = 0 ");
			
			
			this.addWhereSegmentByAnd("cust.delete_flag = 0 and cust.direction = 0");
			
			
			//查询客户姓名/手机号
			String paras = this.getNormStr("paras");
			if(paras!=null && !"".equals(paras.trim())){
				this.addWhereSegmentByAnd("(cust.name like '%"+paras+"%'");
				this.addWhereSegmentByOr(" cust.phone_num like '%" + paras + "%' )");
				this.ctr.setAttr("paras", paras);
			}
			
			//姓名
			String name = this.getNormStr("name");
			if(name!=null && !"".equals(name.trim())){
				this.addWhereSegmentByAnd("cust.name like '%"+name+"%'");
				this.ctr.setAttr("name", name);
			}
			
			//手机号
			String phoneNum = this.getNormStr("phoneNum");
			if(phoneNum!=null && !"".equals(phoneNum.trim())){
				this.addWhereSegmentByAnd("cust.phone_num like '%"+phoneNum+"%'");
				this.ctr.setAttr("phoneNum", phoneNum);
			}
			
			//推荐人姓名
			String recommender = this.getNormStr("recommender");
			if(recommender != null && !"".equals(recommender.trim())){
				this.addWhereSegmentByAnd(" cust.recommender = '" + recommender + "'");
				this.ctr.setAttr("recommender", recommender);
			}
			
			//客户状态
			String custStatus = this.getNormStr("status");
			if(custStatus != null && !"".equals(custStatus)){
				this.addWhereSegmentByAnd(" cust.cust_status = '" + custStatus + "'");
				this.ctr.setAttr("custStatus", custStatus);
			}
			
			//客户来源
			String custSource = this.getNormStr("source");
			if(custSource != null && !"".equals(custSource)){
				this.addWhereSegmentByAnd(" cust.cust_source = '" + custSource + "'");
				this.ctr.setAttr("custSource", custSource);
			}
			
			//快捷操作
			String fast = this.getNormStr("fast");
			if(fast != null && !"".equals(fast)){
				if("noAssigned".equals(fast)){//未分配
					this.addWhereSegmentByAnd(" (csu.user_name is null || csu.user_name = '') ");
				}else if("assigned".equals(fast)){
					this.addWhereSegmentByAnd(" (csu.user_name is not null and csu.user_name != '')");
				}else if("invalid".equals(fast)){
					String invalid = PropKit.use("constants.txt").get("cust_status_invalid");
					this.addWhereSegmentByAnd("cust.delete_flag = 0 and cust.cust_status = '" + invalid + "'");
				}else if("changed".equals(fast)){
					this.addWhereSegmentByAnd(" cust.is_changed = 1");
				}
				this.ctr.setAttr("fast", fast);
			}
				
			
			//this.setDefaultOrderStr("order by cust.create_time desc");
		}
	}
	
	
	/**快捷统计参数
	 * @author Gorge
	 * 2016年11月21日
	 */
	private class ClueFastParams extends ParamsParser{

		public ClueFastParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select DISTINCT cust.custinfo_id,cust.name,cust.gender,cust.phone_num ," +
					"cd1.name cust_sourceZN,cd2.name cust_statusZN,csu.user_name,cust.create_time");
			this.setFromStr("from crm_custinfo cust " +
					" LEFT JOIN console_dictionary cd1 on cust.cust_source = cd1.dict_code " +
					" LEFT JOIN console_dictionary cd2 on cust.cust_status = cd2.dict_code " +
					" LEFT JOIN crm_custinfo_steward ccs on cust.custinfo_id = ccs.custinfo_id and ccs.is_hire = 1" +
					" LEFT JOIN crm_steward_user csu on ccs.steward_id = csu.steward_id and csu.delete_flag = 0 ");
			this.addWhereSegmentByAnd("cust.delete_flag = 0 and cust.direction = 0");
			//查询客户姓名/手机号
			String paras = this.getNormStr("paras");
			if(paras!=null && !"".equals(paras.trim())){
				this.addWhereSegmentByAnd("(cust.name like '%"+paras+"%'");
				this.addWhereSegmentByOr(" cust.phone_num like '%" + paras + "%' )");
				this.ctr.setAttr("paras", paras);
			}
			
			//姓名
			String name = this.getNormStr("name");
			if(name!=null && !"".equals(name.trim())){
				this.addWhereSegmentByAnd("cust.name like '%"+name+"%'");
				this.ctr.setAttr("name", name);
			}
			
			//手机号
			String phoneNum = this.getNormStr("phoneNum");
			if(phoneNum!=null && !"".equals(phoneNum.trim())){
				this.addWhereSegmentByAnd("cust.phone_num like '%"+phoneNum+"%'");
				this.ctr.setAttr("phoneNum", phoneNum);
			}
			
			//推荐人姓名
			String recommender = this.getNormStr("recommender");
			if(recommender != null && !"".equals(recommender.trim())){
				this.addWhereSegmentByAnd(" cust.recommender = '" + recommender + "'");
				this.ctr.setAttr("recommender", recommender);
			}
			
			//客户状态
			String custStatus = this.getNormStr("status");
			if(custStatus != null && !"".equals(custStatus)){
				this.addWhereSegmentByAnd(" cust.cust_status = '" + custStatus + "'");
				this.ctr.setAttr("custStatus", custStatus);
			}
			
			//客户来源
			String custSource = this.getNormStr("source");
			if(custSource != null && !"".equals(custSource)){
				this.addWhereSegmentByAnd(" cust.cust_source = '" + custSource + "'");
				this.ctr.setAttr("custSource", custSource);
			}
				
			
			//this.setDefaultOrderStr("order by cust.create_time desc");
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
}
