package cn.pacificimmi.customer.controllers;
import java.util.ArrayList;
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
import cn.pacificimmi.common.models.CustinfoSteward;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.customer.CustFollowRecordParams;

/**
 * 客户控制器
 * @author Gorge
 * 
 */
@Before(LoginInterCeptor.class)
public class CustController extends Controller {
	private static Logger log = LoggerFactory.getLogger(CustController.class);
	private String qryFlag = "";
	/****
	 * 默认初始化页面
	 */
	public void index(){

	}
	
	/**
	 * 客户查询-潜在
	 */
	public void potential(){
		log.debug("查询潜在客户");
		CustParams params = new CustParams(this);
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		
		
		//处理相同手机号颜色显示
		
		String samePhoneSql = "select phone_num ,count(1) from crm_custinfo where phone_num != '' and delete_flag = 0 GROUP BY phone_num having count(1) > 1";
		List<Record> sameRecord = Db.find(samePhoneSql);
		
		HashMap<String,String> colorMp = new HashMap<String,String>();
		for(Record s : sameRecord){
			colorMp.put(s.get("phone_num"), ConstantUtil.color());
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
		
		//List<Dictionary> csourceList = Dictionary.dao.
		//		find("select dict_code, name from console_dictionary where dict_code like '"+PropKit.use("constants.txt").get("cust_source")+
		//				"%' and length(dict_code)=12 and delete_flag = " + ConstantUtil.DATA_STATUS_NORMAL + " order by sort desc");
		setAttr("csourceList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries());
		
		//查询客户状态
		//List<Dictionary> cstatusList = Dictionary.dao.
		//		find("select dict_code, name from console_dictionary where dict_code like '"+PropKit.use("constants.txt").get("cust_status")+
		//				"%' and length(dict_code)=12 and delete_flag = " + ConstantUtil.DATA_STATUS_NORMAL + " order by sort desc");
		setAttr("cstatusList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries());
		
		
		//按分配、未分配、无效统计
		int assigned = 0,noAssigned=0,signed=0,invalid =0;
		CustFastParams paramsFast = new CustFastParams(this);
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
			if(r.get("cust_statusZN") != null && r.get("cust_statusZN").toString().contains("签约")){
				signed ++;
			}
		}
		this.setAttr("all", list1.size());
		this.setAttr("noAssigned", noAssigned);
		this.setAttr("assigned", assigned);
		this.setAttr("invalid", invalid);
		this.setAttr("signed", signed);
		
		
		//页面
		this.renderJsp("/views/cust/cust_potential.jsp");
	}
	
	
	/**
	 * 查询无效客户
	 */
	public void invalid(){
		log.debug("查询无效客户");
		qryFlag="invalid";
		CustParams params = new CustParams(this);
		
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
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
		
		
		//页面
		this.renderJsp("/views/cust/cust_invalid.jsp");
	}
	
	/**
	 * 新增客户
	 */
	public void add(){
		log.debug("page forward to cust_edit.jsp");
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("name") == null || "".equals(pp.getNormStr("name"))){//跳转新增页面
			//查询客户来源
			List<Dict> csourceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_source"), 1).getSubDictionaries();
			setAttr("csourceList", csourceList);
			
			//查询客户状态
			List<Dict> cstatusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
			setAttr("cstatusList", cstatusList);
			
			
			//所属机构-组织机构树
			ArrayList<String> checked = new ArrayList<String>();
			String org_id = pp.getNormStr("org_id");
			if(org_id == null || "".equals(org_id)){
				org_id = "20";//默认选中北京太平洋加达
			}
			checked.add(org_id);	
			this.setAttr("org_id", org_id);
			
			String org_name = pp.getNormStr("org_name");
			if(org_name==null || "".equals(org_name))
				org_name="北京太平洋加达";
			this.setAttr("org_name", org_name);
			
			String tree = loadTree(checked);
			this.setAttr("tree", tree);
			
			
			this.renderJsp("/views/cust/cust_edit.jsp");
		}else{//保存新增
			try {
				
				String name = pp.getNormStr("name");//客户姓名
				String sex = pp.getNormStr("gender");//性别
				String phoneNum = pp.getNormStr("phone_num");//手机号
				String custSource = pp.getNormStr("cust_source");//客户来源
				String remark = pp.getNormStr("remark");//备注
				String custStatus = "";//pp.getNormStr("cust_status");//客户状态
				String orgId = pp.getNormStr("org_id");//所属部门
				String derection = pp.getNormStr("direction");//流向 0-线索池  1-客户池
				if("0".equals(derection)){
					custStatus = "";
				}else if("1".equals(derection)){
					custStatus = "";
				}
				
				
				Custinfo cust = new Custinfo();
				cust.setName(name);
				cust.setGender(sex);
				cust.setPhoneNum(phoneNum);
				cust.setRemark(remark);
				cust.setCustSource(custSource);
				cust.setCreateTime(new Date());
				cust.setCustStatus(custStatus);
				//cust.set
				cust.save();
				
				if("0".equals(derection)){
					this.redirect("/cust/clue");
				}else if("1".equals(derection)){
					this.redirect("/cust/potential");
				}
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
		log.debug("page forward to cust_edit.jsp");
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
						
						CustFollowRecordParams params = new CustFollowRecordParams(this);
						
						//列表数据
						Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
						List<Record> list = page.getList();
						this.setAttr("list", list); 
						
						//翻页
						String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
						setAttr("pageBar",pagesView);
						
						
						//查看客户签约信息
						String sql = "select s.*,d1.name countryZN,p.project_name,d2.name paycodeZN" +
									" from crm_cust_signinfo s" +
									" LEFT JOIN console_dictionary d1 on s.country = d1.dict_code" +
									" LEFT JOIN crm_project p on s.project_id = p.project_id" +
									" LEFT JOIN console_dictionary d2 on s.paycode = d2.dict_code" +
									" where s.custinfo_id = " + cust.getCustinfoId();	
						List<Record> signedList = Db.find(sql);
						this.setAttr("signedList", signedList);
						
						
						this.renderJsp("/views/cust/cust_detail_edit.jsp");
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
					this.redirect("/cust/potential");
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
	@Clear
	public void detail(){
		log.debug("page forward to cust_detail.jsp");
		ParamsParser pp = new ParamsParser(this);
		
		try {
			if(pp.getId() != null && !"".equals(pp.getId())){
				
				if(pp.getNormStr("custinfo_id") == null || "".equals(pp.getNormStr("custinfo_id"))){
					log.info(pp.getId());
					Record r = Db.findFirst("select * from crm_custinfo where custinfo_id="+pp.getId());
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
						for(Dict d : intentionList){
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
						
						CustFollowRecordParams params = new CustFollowRecordParams(this);
						
						//列表数据
						Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
						List<Record> list = page.getList();
						this.setAttr("list", list); 
						
						//翻页
						String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
						setAttr("pageBar",pagesView);
						
						
						//查看客户签约信息
						String sql = "select s.*,d1.name countryZN,p.project_name,d2.name paycodeZN" +
									" from crm_cust_signinfo s" +
									" LEFT JOIN console_dictionary d1 on s.country = d1.dict_code" +
									" LEFT JOIN crm_project p on s.project_id = p.project_id" +
									" LEFT JOIN console_dictionary d2 on s.paycode = d2.dict_code" +
									" where s.custinfo_id = " + cust.getCustinfoId();	
						List<Record> signedList = Db.find(sql);
						this.setAttr("signedList", signedList);
						
						
						
						this.renderJsp("/views/cust/cust_detail.jsp");
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
	 * 删除客户
	 */
	@Clear
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
						//记录操作日志
						saveCustEditLog(Integer.parseInt(id),Integer.parseInt(u.getUid()),"删除客户");
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
				log.error("删除客户出错：参数客户ID缺失");
				this.setAttr("errorInfo", "删除客户时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除客户时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 置为无效客户
	 */
	@Clear
	public void setInvalid(){
		try{
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getIds().isEmpty()){
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				for(String id : ids){
					int rlt = Db.update("update crm_custinfo set cust_status = '" + PropKit.use("constants.txt").get("cust_status_invalid")
							+ "' where custinfo_id = " + id);
					if(rlt > 0){
						success++;
						//记录操作日志
						saveCustEditLog(Integer.parseInt(id),Integer.parseInt(u.getUid()),"设置为无效客户");
					}else{
						fail++;
					}
				}
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "设置成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "操作结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("设置为无效客户出错：参数客户ID缺失");
				this.setAttr("errorInfo", "设置为无效客户时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "设置为无效客户时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
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
		LoginUserInfo u = getSessionAttr("LoginUserInfo");
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			CustinfoSteward  cs = new CustinfoSteward();
			if(pp.getAllStr("id") != null && !"".equals(pp.getAllStr("id")) 
					&& pp.getNormStr("custId") != null && !"".equals(pp.getNormStr("custId"))){
				//保存前更新已有的顾问状态
				String[] stewardInfo = pp.getAllStr("id").split("-");
				int stewardId = 0;
				String stewardName = "";
				if(stewardInfo.length < 2){
					stewardId = Integer.parseInt(stewardInfo[0]);
				}else{
					stewardId = Integer.parseInt(stewardInfo[0]);
					stewardName = stewardInfo[1];
				}
				
				String[] custIds = pp.getNormStr("custId").split(",");
				for(String custId : custIds){
					Db.update("update crm_custinfo_steward set is_hire = 0 where custinfo_id = " + Integer.parseInt(custId));
					
					//保存新的分配关系
					cs.setCustinfoId(Integer.parseInt(custId));//客户ID
					cs.setStewardId(stewardId);//管家ID
					cs.setIsHire(1);
					cs.setHireDate(new Date());//雇佣日期
					
					cs.save();
					
					
					//分配后修改状态为客户状态为待跟进
					Custinfo cust = Custinfo.dao.findById(Integer.parseInt(custId));
					if(cust != null){
						cust.setCustStatus(PropKit.use("constants.txt").get("cust_status_tofollow"));
						cust.update();
					}
					
					//记录客户编辑日志
					saveCustEditLog(Integer.parseInt(custId),Integer.parseInt(u.getUid()),"分配管家"+stewardName);
				}
				
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
	private class CustParams extends ParamsParser{

		public CustParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select DISTINCT cust.custinfo_id,cust.name,cust.gender,cust.phone_num ," +
					"cd1.name cust_sourceZN,cd2.name cust_statusZN,csu.user_name,cust.create_time");
			this.setFromStr("from crm_custinfo cust " +
					" LEFT JOIN console_dictionary cd1 on cust.cust_source = cd1.dict_code " +
					" LEFT JOIN console_dictionary cd2 on cust.cust_status = cd2.dict_code " +
					" LEFT JOIN crm_custinfo_steward ccs on cust.custinfo_id = ccs.custinfo_id and ccs.is_hire = 1" +
					" LEFT JOIN crm_steward_user csu on ccs.steward_id = csu.steward_id and csu.delete_flag = 0 ");
			
			
			if("invalid".equals(qryFlag)){//查询无效客户
				String invalid = PropKit.use("constants.txt").get("cust_status_invalid");
				this.addWhereSegmentByAnd("cust.delete_flag = 0 and cust.cust_status = '" + invalid + "'");
				this.ctr.setAttr("custStatus", invalid);
			}else if("clue".equals(qryFlag)){ // 查询线索列表
				
			}else{
				//查找有效数据
				this.addWhereSegmentByAnd("cust.delete_flag = 0");
			}
			
			
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
				}else if("signed".equals(fast)){
					String signed = PropKit.use("constants.txt").get("cust_type_signed");//签约客户
					this.addWhereSegmentByAnd(" cust.cust_status = '" + signed +"'");
				}
				this.ctr.setAttr("fast", fast);
			}
				
			
			this.setDefaultOrderStr("order by cust.create_time desc");
		}
	}
	
	
	/**
	 * 客户快捷统计参数
	 * @author Gorge
	 *
	 */
	private class CustFastParams extends ParamsParser{

		public CustFastParams(Controller ctr) {
			super(ctr);
			
			/*String sql = "";
			
			sql += "select DISTINCT cust.custinfo_id,cust.name,cust.gender,cust.phone_num ," +
					"cd1.name cust_sourceZN,cd2.name cust_statusZN,csu.user_name,cust.create_time,count(sign.signed_id) as signCount";
			sql += " from crm_custinfo cust " +
					" LEFT JOIN console_dictionary cd1 on cust.cust_source = cd1.dict_code " +
					" LEFT JOIN console_dictionary cd2 on cust.cust_status = cd2.dict_code " +
					" LEFT JOIN crm_custinfo_steward ccs on cust.custinfo_id = ccs.custinfo_id and ccs.is_hire = 1" +
					" LEFT JOIN crm_steward_user csu on ccs.steward_id = csu.steward_id and csu.delete_flag = 0 " +
					" LEFT JOIN crm_cust_signinfo sign on cust.custinfo_id = sign.custinfo_id and sign.delete_flag = 0";
			
			sql += " where 1=1";
			
			if("invalid".equals(qryFlag)){//查询无效客户
				String invalid = PropKit.use("constants.txt").get("cust_status_invalid");
				sql += " and cust.delete_flag = 0 and cust.cust_status = '" + invalid + "'";
				
			}else if("clue".equals(qryFlag)){ // 查询线索列表
				
			}else{
				//查找有效数据
				sql += " and cust.delete_flag = 0";
			}
			
			
			//查询客户姓名/手机号
			String paras = this.getNormStr("paras");
			if(paras!=null && !"".equals(paras.trim())){
				sql += " and (cust.name like '%"+paras+"%'";
				sql += " or cust.phone_num like '%" + paras + "%' )";
			}
			
			//姓名
			String name = this.getNormStr("name");
			if(name!=null && !"".equals(name.trim())){
				sql += " and cust.name like '%"+name+"%'";
			}
			
			//手机号
			String phoneNum = this.getNormStr("phoneNum");
			if(phoneNum!=null && !"".equals(phoneNum.trim())){
				sql += " and cust.phone_num like '%"+phoneNum+"%'";
			}
			
			//推荐人姓名
			String recommender = this.getNormStr("recommender");
			if(recommender != null && !"".equals(recommender.trim())){
				sql += " and cust.recommender = '" + recommender + "'";
			}
			
			//客户状态
			String custStatus = this.getNormStr("status");
			if(custStatus != null && !"".equals(custStatus)){
				sql += " and cust.cust_status = '" + custStatus + "'";
			}
			
			//客户来源
			String custSource = this.getNormStr("source");
			if(custSource != null && !"".equals(custSource)){
				sql += " and cust.cust_source = '" + custSource + "'";
			}
			
			
			sql += " group by cust.custinfo_id";
			this.setSelectStr(sql);*/
			this.setSelectStr("select DISTINCT cust.custinfo_id,cust.name,cust.gender,cust.phone_num ," +
					"cd1.name cust_sourceZN,cd2.name cust_statusZN,csu.user_name,cust.create_time");
			this.setFromStr("from crm_custinfo cust " +
					" LEFT JOIN console_dictionary cd1 on cust.cust_source = cd1.dict_code " +
					" LEFT JOIN console_dictionary cd2 on cust.cust_status = cd2.dict_code " +
					" LEFT JOIN crm_custinfo_steward ccs on cust.custinfo_id = ccs.custinfo_id and ccs.is_hire = 1" +
					" LEFT JOIN crm_steward_user csu on ccs.steward_id = csu.steward_id and csu.delete_flag = 0 ");
			
			
			if("invalid".equals(qryFlag)){//查询无效客户
				String invalid = PropKit.use("constants.txt").get("cust_status_invalid");
				this.addWhereSegmentByAnd("cust.delete_flag = 0 and cust.cust_status = '" + invalid + "'");
			}else if("clue".equals(qryFlag)){ // 查询线索列表
				
			}else{
				//查找有效数据
				this.addWhereSegmentByAnd("cust.delete_flag = 0");
			}
			
			
			//查询客户姓名/手机号
			String paras = this.getNormStr("paras");
			if(paras!=null && !"".equals(paras.trim())){
				this.addWhereSegmentByAnd("(cust.name like '%"+paras+"%'");
				this.addWhereSegmentByOr(" cust.phone_num like '%" + paras + "%' )");
			}
			
			//姓名
			String name = this.getNormStr("name");
			if(name!=null && !"".equals(name.trim())){
				this.addWhereSegmentByAnd("cust.name like '%"+name+"%'");
			}
			
			//手机号
			String phoneNum = this.getNormStr("phoneNum");
			if(phoneNum!=null && !"".equals(phoneNum.trim())){
				this.addWhereSegmentByAnd("cust.phone_num like '%"+phoneNum+"%'");
			}
			
			//推荐人姓名
			String recommender = this.getNormStr("recommender");
			if(recommender != null && !"".equals(recommender.trim())){
				this.addWhereSegmentByAnd(" cust.recommender = '" + recommender + "'");
			}
			
			//客户状态
			String custStatus = this.getNormStr("status");
			if(custStatus != null && !"".equals(custStatus)){
				this.addWhereSegmentByAnd(" cust.cust_status = '" + custStatus + "'");
			}
			
			//客户来源
			String custSource = this.getNormStr("source");
			if(custSource != null && !"".equals(custSource)){
				this.addWhereSegmentByAnd(" cust.cust_source = '" + custSource + "'");
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
			this.setFromStr("from crm_steward_user cu left join console_orgnization co1 on cu.com_id = co1.org_id " +
							" left join console_orgnization co2 on cu.dep_id = co2.org_id ");
			
			//查找有效数据
			this.addWhereSegmentByAnd(" cu.delete_flag = 'VALID'");
			
			
			//查询客户姓名/手机号
			String uname = this.getNormStr("uname");
			if(uname!=null && !"".equals(uname.trim())){
				this.addWhereSegmentByAnd(" cu.user_name like '%"+uname+"%'");
				this.ctr.setAttr("uname", uname);
			}
			
			this.setDefaultOrderStr("order by cu.user_name ");
		}
	}
	
	
	/**加载组织机构树
	 * @param codes
	 * @return
	 */
	public String loadTree(List<String> codes){
		List<Record> records = Db.find("select * from console_orgnization where delete_flag='0' order by org_code asc");
		NodeTree ct = new NodeTree("orgTree","组织机构",10);
		
		/***
		* 初始化时将选中的节点，描红显示
		*/
		if(codes.size()>0){
			ct.setSelectedCodes(codes);
		}
		
		/**
		* 显示选择框
		*/
		ct.setSelectMode(false);
		
		/**
		* 不显示编辑按钮
		*/
		ct.setAllownEdit(false);
		
		for(Record r:records){
			Node node = new Node();
			node.setName(r.getStr("name"));
			node.setCode(r.getStr("org_code"));
			node.setId(String.valueOf(r.getInt("org_id")));
			
			node.setExtInfo(String.valueOf(r.getInt("org_id")));
			ct.addNode(node);
		}
		
		return ct.buildTree();
	}
}
