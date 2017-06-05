package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseMessage<M extends BaseMessage<M>> extends Model<M> implements IBean {

	public void setMsgId(java.lang.Integer msgId) {
		set("msg_id", msgId);
	}

	public java.lang.Integer getMsgId() {
		return get("msg_id");
	}

	public void setMsgTitle(java.lang.String msgTitle) {
		set("msg_title", msgTitle);
	}

	public java.lang.String getMsgTitle() {
		return get("msg_title");
	}

	public void setMsgContent(java.lang.String msgContent) {
		set("msg_content", msgContent);
	}

	public java.lang.String getMsgContent() {
		return get("msg_content");
	}

	public void setMsgTarget(java.lang.Integer msgTarget) {
		set("msg_target", msgTarget);
	}

	public java.lang.Integer getMsgTarget() {
		return get("msg_target");
	}

	public void setTargetId(java.lang.Integer targetId) {
		set("target_id", targetId);
	}

	public java.lang.Integer getTargetId() {
		return get("target_id");
	}

	public void setReaded(java.lang.Integer readed) {
		set("readed", readed);
	}

	public java.lang.Integer getReaded() {
		return get("readed");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

}