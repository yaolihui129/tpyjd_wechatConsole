package cn.pacificimmi.customer;

import com.jfinal.core.Controller;

import cn.pacificimmi.common.ParamsParser;

public class CustFollowRecordParams  extends ParamsParser {
	public CustFollowRecordParams(Controller ctr) {
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
