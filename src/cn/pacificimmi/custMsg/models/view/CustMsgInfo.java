package cn.pacificimmi.custMsg.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class CustMsgInfo extends ComplexModel<CustMsgInfo> {
	
	/**
	 * 客户留言板标识
	 */
	private Integer custinfo_message_id;
	
	/**
	 * 姓名
	 */
	private String name;
	
	/**
	 * 手机
	 */
	private String phone;
	
	/**
	 * 留言内容
	 */
	private String content;
	
	/**
	 * 来源
	 */
	private String source;
	
	/**
	 * 备注
	 */
	private String remark;
	
	/**
	 * 链接
	 */
	private String url;
	
	/**
	 * 提交时间
	 */
	private Date create_time;


	public Integer getCustinfo_message_id() {
		return custinfo_message_id;
	}


	public void setCustinfo_message_id(Integer custinfo_message_id) {
		this.custinfo_message_id = custinfo_message_id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getSource() {
		return source;
	}


	public void setSource(String source) {
		this.source = source;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	public Date getCreate_time() {
		return create_time;
	}


	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}
}
