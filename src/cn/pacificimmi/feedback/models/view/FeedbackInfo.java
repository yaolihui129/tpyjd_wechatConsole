package cn.pacificimmi.feedback.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class FeedbackInfo extends ComplexModel<FeedbackInfo>{
	
	/**
	 * 客户反馈
	 */
	private Integer custinfo_feedback_id;
	
	/**
	 * 客户姓名
	 */
	private String custinfo_name;
	
	/**
	 * 客户手机
	 */
	private String phone_num;
	
	/**
	 * 联系方式
	 */
	private String contact_way;
	
	/**
	 * 版本
	 */
	private String version;
	
	/**
	 * 反馈效率
	 */
	private String feedback_name;
	
	/**
	 * 问答专业度
	 */
	private String profession_degree_name;
	
	/**
	 * 及时回访
	 */
	private String call_back_name;
	
	/**
	 * 留言
	 */
	private String message;
	
	/**
	 * 提交时间
	 */
	private Date create_time;

	public Integer getCustinfo_feedback_id() {
		return custinfo_feedback_id;
	}

	public void setCustinfo_feedback_id(Integer custinfo_feedback_id) {
		this.custinfo_feedback_id = custinfo_feedback_id;
	}

	public String getCustinfo_name() {
		return custinfo_name;
	}

	public void setCustinfo_name(String custinfo_name) {
		this.custinfo_name = custinfo_name;
	}

	public String getPhone_num() {
		return phone_num;
	}

	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}

	public String getContact_way() {
		return contact_way;
	}

	public void setContact_way(String contact_way) {
		this.contact_way = contact_way;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public String getFeedback_name() {
		return feedback_name;
	}

	public void setFeedback_name(String feedback_name) {
		this.feedback_name = feedback_name;
	}

	public String getProfession_degree_name() {
		return profession_degree_name;
	}

	public void setProfession_degree_name(String profession_degree_name) {
		this.profession_degree_name = profession_degree_name;
	}

	public String getCall_back_name() {
		return call_back_name;
	}

	public void setCall_back_name(String call_back_name) {
		this.call_back_name = call_back_name;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
}
