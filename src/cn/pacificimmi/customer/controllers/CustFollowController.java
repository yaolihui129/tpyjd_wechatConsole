package cn.pacificimmi.customer.controllers;

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
import cn.pacificimmi.common.models.CustFollowRecords;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;

/**
 * 客户跟踪控制器
 * @author Gorge
 * 
 */
@Before(LoginInterCeptor.class)
public class CustFollowController extends Controller {
	private static Logger log = LoggerFactory.getLogger(CustFollowController.class);
	/****
	 * 默认初始化页面
	 */

	public void index(){
		log.debug("查询客户跟进记录");
		CustFollowParams params = new CustFollowParams(this);
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("list", list); 
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		this.setAttr("custId", params.getId());//查询的客户ID
		
		this.setAttr("curTime", new Date());
		
		//沟通方式
		List<Dict> followType = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("follow_mode"), 1).getSubDictionaries();
		setAttr("followType", followType);
		
		//客户状态
		List<Dict> statusList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_status"), 1).getSubDictionaries();
		setAttr("statusList", statusList);
		
		//客户类型
		List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("cust_type"), 1).getSubDictionaries();
		setAttr("typeList", typeList);
		
		
		//页面
		this.renderJsp("/views/cust/cust_follow_record.jsp");
	}
	
	
	/**
	 * 跟进记录新增保存
	 */
	@Clear
	public void add(){
		log.debug("保存客户跟进记录");
		try {
			LoginUserInfo loginUser = getSessionAttr("LoginUserInfo");
			CustFollowRecords cfr = new CustFollowRecords();
			ParamsParser p = new ParamsParser(this);
			if(Integer.parseInt(p.getNormStr("custId")) == 0){
				log.error("参数缺失:客户ID为空");
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			Map<String,Object> rst = new HashMap<String,Object>();
			
			cfr.setTitle(p.getNormStr("title"));
			cfr.setRemark(p.getNormStr("remark"));
			cfr.setStartTime(TpyDateUtil.strToDateLong(p.getAllStr("start_time")));
			cfr.setEndTime(TpyDateUtil.strToDateLong(p.getAllStr("end_time")));
			cfr.setCustinfoId(Integer.parseInt(p.getNormStr("custId")));
			cfr.setFollowId(Integer.parseInt(loginUser.getUid()));//
			cfr.setCreateTime(new Date());
			cfr.setCreateUser(Integer.parseInt(loginUser.getUid()));//loginUser.getUid()
			cfr.setFollowType(p.getNormStr("follow_type"));//沟通方式
			
			
			Custinfo c = Custinfo.dao.findById(Integer.parseInt(p.getNormStr("custId")));
			
			if(c != null){
				if(p.getNormStr("cust_status") != null  && !p.getNormStr("cust_status").isEmpty()
						&& p.getNormStr("cust_type") != null && !p.getNormStr("cust_type").isEmpty()){
					//修改客户类型和客户状态
					c.setCustStatus(p.getNormStr("cust_status"));
					c.setCustType(p.getNormStr("cust_type"));
				}
			}else{
				this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			
			if(cfr.save()){
				rst.put("status", ConstantUtil.STATUS_SUCCESS);
				rst.put("msg", "保存成功");
				
				//修改客户状态为已跟进,客户管理新增时以所选状态为准
				if(p.getNormStr("cust_status") == null  || p.getNormStr("cust_status").isEmpty()){
					c.setCustStatus(PropKit.use("constants.txt").get("cust_status_followed"));
				}
				c.update();
				
				this.renderJson(rst);	
			}else{
				rst.put("status", ConstantUtil.STATUS_FAILTURE);
				rst.put("msg", "保存失败");
				this.renderJson(rst);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 删除跟踪记录
	 */
	@Clear
	public void delete(){
		log.debug("删除客户跟进记录");
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getId().isEmpty()){
				CustFollowRecords cfr = new CustFollowRecords();
				cfr.setFollowRecordId(Integer.parseInt(pp.getId()));
				int rlt = Db.update("update crm_cust_follow_records set delete_flag = 1 where follow_record_id = " + pp.getId());
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
				log.error("删除客户出错：参数客户ID缺失");
				this.setAttr("errorInfo", "删除客户时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	
	/**
	 * 客户跟进记录查询参数解析类
	 * @author Gorge
	 *
	 */
	private class CustFollowParams extends ParamsParser{

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
	
}
