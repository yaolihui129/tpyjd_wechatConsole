package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseCustinfoFeedback<M extends BaseCustinfoFeedback<M>> extends Model<M> implements IBean {

	public void setCustinfoFeedbackId(java.lang.Integer custinfoFeedbackId) {
		set("custinfo_feedback_id", custinfoFeedbackId);
	}

	public java.lang.Integer getCustinfoFeedbackId() {
		return get("custinfo_feedback_id");
	}

	public void setCustinfoId(java.lang.Integer custinfoId) {
		set("custinfo_id", custinfoId);
	}

	public java.lang.Integer getCustinfoId() {
		return get("custinfo_id");
	}

	public void setContactWay(java.lang.String contactWay) {
		set("contact_way", contactWay);
	}

	public java.lang.String getContactWay() {
		return get("contact_way");
	}

	public void setVersion(java.lang.String version) {
		set("version", version);
	}

	public java.lang.String getVersion() {
		return get("version");
	}

	public void setFeedback(java.lang.String feedback) {
		set("feedback", feedback);
	}

	public java.lang.String getFeedback() {
		return get("feedback");
	}

	public void setProfessionDegree(java.lang.String professionDegree) {
		set("profession_degree", professionDegree);
	}

	public java.lang.String getProfessionDegree() {
		return get("profession_degree");
	}

	public void setCallBack(java.lang.String callBack) {
		set("call_back", callBack);
	}

	public java.lang.String getCallBack() {
		return get("call_back");
	}

	public void setMessage(java.lang.String message) {
		set("message", message);
	}

	public java.lang.String getMessage() {
		return get("message");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

}
