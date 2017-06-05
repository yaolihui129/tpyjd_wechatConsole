package cn.pacificimmi.proxy.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.ProxyStatusRecord;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.proxy.models.view.ProxyInfo;

@Before(LoginInterCeptor.class)
public class ProxyController extends Controller{
	
	/**
	 *  分销商列表
	 */
	public void index() {
		ProxyParams pp = new ProxyParams(this);
		Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<Record> list = page.getList();
		List<ProxyInfo> result = new ArrayList<ProxyInfo>();
		for(Record rd : list) {
			ProxyInfo pi = new ProxyInfo();
			pi.bindingData(pi, rd);
			pi.setSub_custinfo_count(rd.getLong("sub_custinfo_count"));
			pi.setSub_proxy_count(rd.getLong("sub_proxy_count"));
			result.add(pi);
		}
		
		List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country_china"), 1).getSubDictionaries();
		
		Long one_count = Db.queryLong("select COUNT(custinfo_id) from crm_custinfo where delete_flag=0 and proxy_level="+PropKit.use("constants.txt").get("proxy_level_one"));
		Long two_count = Db.queryLong("select COUNT(custinfo_id) from crm_custinfo where delete_flag=0 and proxy_level="+PropKit.use("constants.txt").get("proxy_level_two"));
		Long all_count = Db.queryLong("select COUNT(custinfo_id) from crm_custinfo where delete_flag=0 and proxy_level LIKE '"+PropKit.use("constants.txt").get("proxy_level")+"%'");
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		
		this.setAttr("list", result);
		this.setAttr("all_count", all_count);
		this.setAttr("one_count", one_count);
		this.setAttr("two_count", two_count);
		this.setAttr("provinceList", provinceList);
		this.setAttr("proxy_status", PropKit.use("constants.txt").get("proxy_status"));
		this.setAttr("proxy_status_disabled", PropKit.use("constants.txt").get("proxy_status_disabled"));
		this.setAttr("proxy_status_enabled", PropKit.use("constants.txt").get("proxy_status_enabled"));
		this.setAttr("audit_status", PropKit.use("constants.txt").get("audit_status"));
		this.setAttr("audit_status_new", PropKit.use("constants.txt").get("audit_status_new"));
		this.setAttr("audit_status_refused", PropKit.use("constants.txt").get("audit_status_refused"));
		this.setAttr("audit_status_passed", PropKit.use("constants.txt").get("audit_status_passed"));
		this.setAttr("proxy_level_one", PropKit.use("constants.txt").get("proxy_level_one"));
		this.setAttr("proxy_level_two", PropKit.use("constants.txt").get("proxy_level_two"));
		this.setAttr("proxy_level_other", PropKit.use("constants.txt").get("proxy_level_other"));
		this.setAttr("proxy_level_", PropKit.use("constants.txt").get("proxy_level"));
		
		//回填查询参数
		String fast_query = this.getPara("fast_query");
		if(StringUtil.notEmpty(fast_query)) {
			this.setAttr("sel_fast_query", fast_query.trim());
		}
		
		String start_online_time = this.getPara("start_online_time");
		String end_online_time = this.getPara("end_online_time");
		if(StringUtil.notEmpty(start_online_time)) {
			this.setAttr("sel_start_online_time", start_online_time.trim());
		}
		if(StringUtil.notEmpty(end_online_time)) {
			this.setAttr("sel_end_online_time", end_online_time.trim());
		}
		String province = this.getPara("province");
		if(StringUtil.notEmpty(province)) {
			List<Dict> cityList = DictionaryManager.getInstance().getAllSubDictionaries(province, 1).getSubDictionaries();
			this.setAttr("cityList", cityList);
			this.setAttr("sel_province", province);
		}
		String city = this.getPara("city");
		if(StringUtil.notEmpty(city)) {
			this.setAttr("sel_city", city);
		}
		String selectTab = this.getPara("selectTab");
		if(StringUtil.notEmpty(selectTab)) {
			this.setAttr("selectTab", selectTab);
		} else {
			this.setAttr("selectTab", "all");
		}
		String proxy_level = this.getPara("proxy_level");
		if(StringUtil.notEmpty(proxy_level)) {
			this.setAttr("proxy_level", proxy_level);
		}
		this.renderJsp("/views/proxy/list.jsp");
	}
	
	/**
	 * 修改审核代理状态
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void status() {
		String custinfoId = this.getPara("custinfo_id");
		String statusCode = this.getPara("status_code");
		String column = this.getPara("column");
		String reason = this.getPara("reason");
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtil.notEmpty(column) && StringUtil.notEmpty(custinfoId) && StringUtil.notEmpty(statusCode)) {
			Custinfo ci = Custinfo.dao.findById(custinfoId);
			if(column.equals(PropKit.use("constants.txt").get("proxy_status"))) {   //代理状态
				ci.setProxyStatus(statusCode);
				ci.update();
				
				//状态变更记录
				ProxyStatusRecord psr = new ProxyStatusRecord();
				psr.setCustinfoId(new Integer(custinfoId));
				psr.setStatus(statusCode);
				if(StringUtil.notEmpty(reason)) {
					psr.setReason(reason);
				}
				psr.setUpdateTime(new Date());
				psr.save();
				
				map.put("status", 0);
				map.put("msg", "修改成功");
			} else if(column.equals(PropKit.use("constants.txt").get("audit_status"))) {  //审核状态 
				ci.setAuditStatus(statusCode);
				if(statusCode.equals(PropKit.use("constants.txt").get("audit_status_passed"))) {
					ci.setPassedTime(new Date());
				}
				ci.update();
				
				//状态变更记录
				ProxyStatusRecord psr = new ProxyStatusRecord();
				psr.setCustinfoId(new Integer(custinfoId));
				psr.setStatus(statusCode);
				if(StringUtil.notEmpty(reason)) {
					psr.setReason(reason);
				}
				psr.setUpdateTime(new Date());
				psr.save();
				
				map.put("status", 0);
				map.put("msg", "修改成功");
			} else if(column.equals(PropKit.use("constants.txt").get("proxy_level"))){  //合作方式
				ci.setAuditStatus(PropKit.use("constants.txt").get("audit_status_passed"));
				ci.setPassedTime(new Date());
				ci.setProxyLevel(statusCode);
				ci.update();
				
				//状态变更记录
				ProxyStatusRecord psr = new ProxyStatusRecord();
				psr.setCustinfoId(new Integer(custinfoId));
				psr.setStatus(statusCode);
				if(StringUtil.notEmpty(reason)) {
					psr.setReason(reason);
				}
				psr.setUpdateTime(new Date());
				psr.save();
				
				map.put("status", 0);
				map.put("msg", "修改成功");
			} else {
				map.put("status", 1);
				map.put("msg", "参数错误");
			}
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
		}
		this.renderJson(map);
	}
	
	/**
	 * 查询
	 * @author yang
	 *
	 */
	private class ProxyParams extends ParamsParser {
		public ProxyParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("select * ");
			String fast_query = this.getFieldName("fast_query");
			if(StringUtil.notEmpty(fast_query)) {
				this.setFromStr("FROM "+
						"( "+
							"SELECT "+
								"* "+
							"FROM "+
								"( "+
									"SELECT "+
										"custinfo_id, name, phone_num, contact, proxy_level, audit_status, proxy_status, province, city, passed_time, proxy_pid, create_time,"+
										"(select name from console_dictionary where dict_code=crm_custinfo.proxy_level and delete_flag=0) proxy_level_name, "+
										"(select name from console_dictionary where dict_code=crm_custinfo.audit_status and delete_flag=0)audit_status_name, "+
										"(select name from console_dictionary where dict_code=crm_custinfo.proxy_status and delete_flag=0)proxy_status_name, "+
										"(select name from console_dictionary where dict_code=crm_custinfo.province and delete_flag=0)province_name, "+
										"(select name from console_dictionary where dict_code=crm_custinfo.city and delete_flag=0)city_name, "+
										"(select cui.name from crm_custinfo cui where cui.custinfo_id=crm_custinfo.proxy_pid and delete_flag=0)proxy_pname, "+
										"(select COUNT(custinfo_id) from crm_custinfo ccp where ccp.proxy_pid=crm_custinfo.custinfo_id and ccp.delete_flag=0 and ccp.audit_status = "+PropKit.use("constants.txt").get("audit_status_passed")+")sub_proxy_count, "+
										"(select COUNT(custinfo_id) from crm_custinfo ccc where ccc.proxy=crm_custinfo.custinfo_id and ccc.delete_flag=0)sub_custinfo_count "+
									"FROM "+
										"crm_custinfo "+
									"WHERE "+
										"delete_flag = 0	AND proxy_level LIKE '"+PropKit.use("constants.txt").get("proxy_level")+"%' "+
								") cp "+
							"WHERE "+
								"name LIKE '%"+fast_query.trim()+"%' "+
							"OR phone_num LIKE '%"+fast_query.trim()+"%' "+
							"OR contact LIKE '%"+fast_query.trim()+"%' "+
						") proxy");
			} else {
				this.setFromStr("FROM "+
						"( "+
							"SELECT "+
								"custinfo_id, name, phone_num, contact, proxy_level, audit_status, proxy_status, province, city, passed_time, proxy_pid, create_time,"+
								"(select name from console_dictionary where dict_code=crm_custinfo.proxy_level and delete_flag=0) proxy_level_name, "+
								"(select name from console_dictionary where dict_code=crm_custinfo.audit_status and delete_flag=0)audit_status_name, "+
								"(select name from console_dictionary where dict_code=crm_custinfo.proxy_status and delete_flag=0)proxy_status_name, "+
								"(select name from console_dictionary where dict_code=crm_custinfo.province and delete_flag=0)province_name, "+
								"(select name from console_dictionary where dict_code=crm_custinfo.city and delete_flag=0)city_name, "+
								"(select cui.name from crm_custinfo cui where cui.custinfo_id=crm_custinfo.proxy_pid and delete_flag=0)proxy_pname, "+
								"(select COUNT(custinfo_id) from crm_custinfo ccp where ccp.proxy_pid=crm_custinfo.custinfo_id and ccp.delete_flag=0 and ccp.audit_status = "+PropKit.use("constants.txt").get("audit_status_passed")+")sub_proxy_count, "+
								"(select COUNT(custinfo_id) from crm_custinfo ccc where ccc.proxy=crm_custinfo.custinfo_id and ccc.delete_flag=0)sub_custinfo_count "+
							"FROM "+
								"crm_custinfo "+
							"WHERE "+
								"delete_flag = 0 "+
							"AND proxy_level LIKE '"+PropKit.use("constants.txt").get("proxy_level")+"%' "+
						") proxy");
			}
			
			String province = this.getAllStr("province");
			if(StringUtil.notEmpty(province)) {
				this.addWhereSegmentByAnd("proxy.province="+province);
			}
			
			String city = this.getAllStr("city");
			if(StringUtil.notEmpty(city)) {
				this.addWhereSegmentByAnd("proxy.city="+city);
			}
			
			String start_online_time = this.getFieldName("start_online_time");
			String end_online_time = this.getFieldName("end_online_time");
			
			if(StringUtil.notEmpty(start_online_time) && StringUtil.notEmpty(end_online_time)) {
				this.addWhereSegmentByAnd("proxy.passed_time between '"+start_online_time.trim()+"' and '"+TpyDateUtil.getNextDay(end_online_time.trim(),"1")+"'");
			} else if(StringUtil.notEmpty(start_online_time)) {
				this.addWhereSegmentByAnd("proxy.passed_time > '"+start_online_time.trim()+"'");
			} else if(StringUtil.notEmpty(end_online_time)) {
				this.addWhereSegmentByAnd("proxy.passed_time < '"+TpyDateUtil.getNextDay(end_online_time.trim(),"1")+"'");
			}
			
			String proxy_level = this.getAllStr("proxy_level");
			if(StringUtil.notEmpty(proxy_level)) {
				this.addWhereSegmentByAnd("proxy.proxy_level="+proxy_level);
			}
			
			this.setDefaultOrderStr("order by proxy.create_time desc , proxy.passed_time desc");
		}
	}
	
}
