package cn.pacificimmi.proxy.controllers;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.proxy.models.view.ProxyStatusRecordInfo;

@Before(LoginInterCeptor.class)
public class ProxyStatusRecordController extends Controller {

	/**
	 * 代理状态变更记录
	 */
	public void index() {
		ParamsParser pp = new ParamsParser(this);
		String custinfo_id = pp.getId();
		if(StringUtil.notEmpty(custinfo_id)) {
			List<Record> list = Db.find("SELECT "+
					"custinfo_id, reason, status, update_time, "+
					"(select name from console_dictionary where delete_flag=0 and dict_code=status)status_name "+
				"FROM "+
					"crm_proxy_status_record "+
				"WHERE "+
					"custinfo_id = "+custinfo_id+
				" ORDER BY update_time asc");
			List<ProxyStatusRecordInfo> result = new ArrayList<ProxyStatusRecordInfo>();
			for(Record rd:list) {
				ProxyStatusRecordInfo pri = new ProxyStatusRecordInfo();
				pri.bindingData(pri, rd);
				result.add(pri);
			}
			Custinfo custinfo = Custinfo.dao.findById(custinfo_id);
			this.setAttr("custinfo", custinfo);
			this.setAttr("statusRecordList", result);
			this.renderJsp("/views/proxy/record.jsp");
		} else {
			this.redirect("/proxy/proxy");
		}
	}
	
}
