package cn.pacificimmi.proxy.controllers;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.proxy.models.view.ProxyInfo;

@Before(LoginInterCeptor.class)
public class ProxyDetailsController extends Controller{
	
	
	/**
	 * 分销商详情
	 */
	public void index() {
		ProxyDetailsParams pdp = new ProxyDetailsParams(this);
		String custinfo_id = pdp.getId();
		if(StringUtil.notEmpty(custinfo_id)) {
			Record record = Db.findFirst("SELECT "+
					"custinfo_id, name, phone_num, contact, proxy_level, audit_status, proxy_status, province, city, passed_time, proxy_pid,bind_proxy_time, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.proxy_level and delete_flag=0) proxy_level_name, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.audit_status and delete_flag=0)audit_status_name, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.proxy_status and delete_flag=0)proxy_status_name, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.province and delete_flag=0)province_name, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.city and delete_flag=0)city_name, "+
					"(select cui.name from crm_custinfo cui where cui.custinfo_id=crm_custinfo.proxy_pid and delete_flag=0)proxy_pname, "+
					"(select COUNT(custinfo_id) from crm_custinfo ccp where ccp.proxy_pid=crm_custinfo.custinfo_id AND ccp.delete_flag=0 AND ccp.audit_status = "+PropKit.use("constants.txt").get("audit_status_passed")+")sub_proxy_count, "+
					"(select COUNT(custinfo_id) from crm_custinfo ccc where ccc.proxy=crm_custinfo.custinfo_id and ccc.delete_flag=0)sub_custinfo_count, "+
					"(select count(custinfo_id) from crm_custinfo ccu where ccu.proxy in(select custinfo_id from crm_custinfo crc where crc.proxy_pid=crm_custinfo.custinfo_id and crc.delete_flag=0))sub_proxy_custinfo_count "+
				"FROM "+
					"crm_custinfo "+
				"where delete_flag=0 and custinfo_id="+custinfo_id);
			ProxyInfo proxyInfo = new ProxyInfo();
			proxyInfo.bindingData(proxyInfo, record);
			proxyInfo.setSub_proxy_count(record.getLong("sub_proxy_count"));
			proxyInfo.setSub_custinfo_count(record.getLong("sub_custinfo_count"));
			proxyInfo.setSub_proxy_custinfo_count(record.getLong("sub_proxy_custinfo_count"));
			this.setAttr("proxyInfo", proxyInfo);
			
			Page<Record> page = Db.paginate(pdp.getPageNum(), pdp.getPageSize(), pdp.getSelectStr(), pdp.getFromStr());
			List<Record> list = page.getList();
			List<ProxyInfo> result = new ArrayList<ProxyInfo>();
			for(Record rd : list) {
				ProxyInfo pi = new ProxyInfo();
				pi.bindingData(pi, rd);
				pi.setSub_custinfo_count(rd.getLong("sub_custinfo_count"));
				pi.setSub_proxy_count(rd.getLong("sub_proxy_count"));
				result.add(pi);
			}
			String pagesView = PagesBar.getShortPageBar(pdp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			this.setAttr("pageBar",pagesView);
			this.setAttr("list", result);
			
			this.setAttr("custinfo_id", custinfo_id);
			this.setAttr("proxy_status", PropKit.use("constants.txt").get("proxy_status"));
			this.setAttr("proxy_status_disabled", PropKit.use("constants.txt").get("proxy_status_disabled"));
			this.setAttr("proxy_status_enabled", PropKit.use("constants.txt").get("proxy_status_enabled"));
			
			//查询条件回填
			String sel_proxy_pid=this.getPara("sel_proxy_pid");
			String sel_proxy=this.getPara("sel_proxy");
			if(StringUtil.isEmpty(sel_proxy_pid) && StringUtil.isEmpty(sel_proxy)) {
				this.setAttr("sel_proxy", custinfo_id);
			} else if(StringUtil.notEmpty(sel_proxy_pid)) {
				this.setAttr("sel_proxy_pid", sel_proxy_pid);
			} else if(StringUtil.notEmpty(sel_proxy)) {
				this.setAttr("sel_proxy", sel_proxy);
			}
			String start_passed_time = this.getPara("start_passed_time");
			String end_passed_time = this.getPara("end_passed_time");
			if(StringUtil.notEmpty(start_passed_time)) {
				this.setAttr("start_passed_time", start_passed_time.trim());
			}
			if(StringUtil.notEmpty(end_passed_time)) {
				this.setAttr("end_passed_time", end_passed_time.trim());
			}
			String start_bind_proxy_time = this.getPara("start_bind_proxy_time");
			String end_bind_proxy_time = this.getPara("end_bind_proxy_time");
			if(StringUtil.notEmpty(start_bind_proxy_time)) {
				this.setAttr("start_bind_proxy_time", start_bind_proxy_time.trim());
			}
			if(StringUtil.notEmpty(end_bind_proxy_time)) {
				this.setAttr("end_bind_proxy_time", end_bind_proxy_time.trim());
			}
			
			if(null != proxyInfo.getProxy_level() && proxyInfo.getProxy_level().equals(PropKit.use("constants.txt").get("proxy_level_one"))) {
				this.renderJsp("/views/proxy/one.jsp");
			} else if(null != proxyInfo.getProxy_level() && proxyInfo.getProxy_level().equals(PropKit.use("constants.txt").get("proxy_level_two"))) {
				this.renderJsp("/views/proxy/two.jsp");
			}
		} else {
			this.redirect("/proxy/proxy");
		}
	}
	
	
	/*
	 * 查询
	 */
	private class ProxyDetailsParams extends ParamsParser {
		public ProxyDetailsParams(Controller ct) {
			super(ct);
			this.setSelectStr("SELECT custinfo_id, name, head_img, phone_num, contact, bind_proxy_time,passed_time, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.province and delete_flag=0)province_name, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.city and delete_flag=0)city_name, "+
					"(select name from console_dictionary where dict_code=crm_custinfo.cust_source)cust_source_name, "+
					"(select COUNT(custinfo_id) from crm_custinfo ccc where ccc.proxy=crm_custinfo.custinfo_id and ccc.delete_flag=0)sub_custinfo_count");
			this.setFromStr(" FROM crm_custinfo");
			this.addWhereSegmentByAnd("delete_flag=0");
			
			String start_passed_time = this.getFieldName("start_passed_time");
			String end_passed_time = this.getFieldName("end_passed_time");
			if(StringUtil.notEmpty(start_passed_time) && StringUtil.notEmpty(end_passed_time)) {
				this.addWhereSegmentByAnd("passed_time between '"+start_passed_time.trim()+"' and '"+TpyDateUtil.getNextDay(end_passed_time.trim(),"1")+"'");
			} else if(StringUtil.notEmpty(start_passed_time)) {
				this.addWhereSegmentByAnd("passed_time > '"+start_passed_time.trim()+"'");
			} else if(StringUtil.notEmpty(end_passed_time)) {
				this.addWhereSegmentByAnd("passed_time < '"+TpyDateUtil.getNextDay(end_passed_time.trim(),"1")+"'");
			}
			
			String start_bind_proxy_time = this.getFieldName("start_bind_proxy_time");
			String end_bind_proxy_time = this.getFieldName("end_bind_proxy_time");
			if(StringUtil.notEmpty(start_bind_proxy_time) && StringUtil.notEmpty(end_bind_proxy_time)) {
				this.addWhereSegmentByAnd("bind_proxy_time between '"+start_bind_proxy_time.trim()+"' and '"+TpyDateUtil.getNextDay(end_bind_proxy_time.trim(),"1")+"'");
			} else if(StringUtil.notEmpty(start_bind_proxy_time)) {
				this.addWhereSegmentByAnd("bind_proxy_time > '"+start_bind_proxy_time.trim()+"'");
			} else if(StringUtil.notEmpty(end_bind_proxy_time)) {
				this.addWhereSegmentByAnd("bind_proxy_time < '"+TpyDateUtil.getNextDay(end_bind_proxy_time.trim(),"1")+"'");
			}
			
			String custinfo_id = this.getId();
			String proxy_pid=this.getFieldName("sel_proxy_pid");
			String proxy=this.getFieldName("sel_proxy");
			
			if(StringUtil.isEmpty(proxy_pid) && StringUtil.isEmpty(proxy)) {
				this.addWhereSegmentByAnd("proxy="+custinfo_id);
				this.setDefaultOrderStr("order by bind_proxy_time desc");
			} else if(StringUtil.notEmpty(proxy_pid)) {
				this.addWhereSegmentByAnd("proxy_pid="+proxy_pid);
				this.addWhereSegmentByAnd("audit_status="+PropKit.use("constants.txt").get("audit_status_passed"));
				this.setDefaultOrderStr("order by passed_time desc");
			} else if(StringUtil.notEmpty(proxy)) {
				this.addWhereSegmentByAnd("proxy="+proxy);
				this.setDefaultOrderStr("order by bind_proxy_time desc");
			}
			
		}
	}
}
