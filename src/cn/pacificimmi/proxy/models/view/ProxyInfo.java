package cn.pacificimmi.proxy.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class ProxyInfo extends ComplexModel<ProxyInfo>{
	/**
	 * 客户标识
	 */
	private Integer custinfo_id;
	/**
	 * 客户姓名
	 */
	private String name;
	/**
	 * 联系电话
	 */
	private String phone_num;
	/**
	 * 备用电话
	 */
	private String contact;
	/**
	 * 分销等级code
	 */
	private String proxy_level;
	/**
	 * 审核状态code
	 */
	private String audit_status;
	/**
	 * 代理状态code
	 */
	private String proxy_status;
	/**
	 * 省份code
	 */
	private String province;
	/**
	 * 城市code
	 */
	private String city;
	/**
	 * 审核通过时间
	 */
	private Date passed_time;
	/**
	 * 所属上级
	 */
	private Integer proxy_pid;
	/**
	 * 分销等级name
	 */
	private String proxy_level_name;
	/**
	 * 审核状态name
	 */
	private String audit_status_name;
	/**
	 * 代理状态name
	 */
	private String proxy_status_name;
	/**
	 * 省份name
	 */
	private String province_name;
	/**
	 * 城市name
	 */
	private String city_name;
	/**
	 * 上级代理name
	 */
	private String proxy_pname;
	/**
	 * 下级代理人数
	 */
	private Long sub_proxy_count;
	/**
	 * 直属客户人数
	 */
	private Long sub_custinfo_count;
	/**
	 * 归属代理时间
	 */
	private Date bind_proxy_time;
	/**
	 * 下级代理获客
	 */
	private Long sub_proxy_custinfo_count;
	/**
	 * 客户来源
	 */
	private String cust_source_name;
	/**
	 * 头像
	 */
	private String head_img;
	
	public Integer getCustinfo_id() {
		return custinfo_id;
	}
	public void setCustinfo_id(Integer custinfo_id) {
		this.custinfo_id = custinfo_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getProxy_level() {
		return proxy_level;
	}
	public void setProxy_level(String proxy_level) {
		this.proxy_level = proxy_level;
	}
	public String getAudit_status() {
		return audit_status;
	}
	public void setAudit_status(String audit_status) {
		this.audit_status = audit_status;
	}
	public String getProxy_status() {
		return proxy_status;
	}
	public void setProxy_status(String proxy_status) {
		this.proxy_status = proxy_status;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public Date getPassed_time() {
		return passed_time;
	}
	public void setPassed_time(Date passed_time) {
		this.passed_time = passed_time;
	}
	public Integer getProxy_pid() {
		return proxy_pid;
	}
	public void setProxy_pid(Integer proxy_pid) {
		this.proxy_pid = proxy_pid;
	}
	public String getProxy_level_name() {
		return proxy_level_name;
	}
	public void setProxy_level_name(String proxy_level_name) {
		this.proxy_level_name = proxy_level_name;
	}
	public String getAudit_status_name() {
		return audit_status_name;
	}
	public void setAudit_status_name(String audit_status_name) {
		this.audit_status_name = audit_status_name;
	}
	public String getProxy_status_name() {
		return proxy_status_name;
	}
	public void setProxy_status_name(String proxy_status_name) {
		this.proxy_status_name = proxy_status_name;
	}
	public String getProvince_name() {
		return province_name;
	}
	public void setProvince_name(String province_name) {
		this.province_name = province_name;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public String getProxy_pname() {
		return proxy_pname;
	}
	public void setProxy_pname(String proxy_pname) {
		this.proxy_pname = proxy_pname;
	}
	public Long getSub_proxy_count() {
		return sub_proxy_count;
	}
	public void setSub_proxy_count(Long sub_proxy_count) {
		this.sub_proxy_count = sub_proxy_count;
	}
	public Long getSub_custinfo_count() {
		return sub_custinfo_count;
	}
	public void setSub_custinfo_count(Long sub_custinfo_count) {
		this.sub_custinfo_count = sub_custinfo_count;
	}
	public Date getBind_proxy_time() {
		return bind_proxy_time;
	}
	public void setBind_proxy_time(Date bind_proxy_time) {
		this.bind_proxy_time = bind_proxy_time;
	}
	public Long getSub_proxy_custinfo_count() {
		return sub_proxy_custinfo_count;
	}
	public void setSub_proxy_custinfo_count(Long sub_proxy_custinfo_count) {
		this.sub_proxy_custinfo_count = sub_proxy_custinfo_count;
	}
	public String getHead_img() {
		return head_img;
	}
	public void setHead_img(String head_img) {
		this.head_img = head_img;
	}
	public String getCust_source_name() {
		return cust_source_name;
	}
	public void setCust_source_name(String cust_source_name) {
		this.cust_source_name = cust_source_name;
	}
}
