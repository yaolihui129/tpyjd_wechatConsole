package cn.pacificimmi.proxy.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class ProxyStatusRecordInfo extends ComplexModel<ProxyStatusRecordInfo>{
	
	/**
	 * 客户标识
	 */
	private Integer custinfo_id;
	/**
	 * 变更原由
	 */
	private String reason;
	/**
	 * 变更状态
	 */
	private String status;
	/**
	 * 变更状态name
	 */
	private String status_name;
	/**
	 * 修改时间
	 */
	private Date update_time;
	
	public Integer getCustinfo_id() {
		return custinfo_id;
	}
	public void setCustinfo_id(Integer custinfo_id) {
		this.custinfo_id = custinfo_id;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus_name() {
		return status_name;
	}
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	public Date getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}
	
}
