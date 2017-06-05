package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseLetters<M extends BaseLetters<M>> extends Model<M> implements IBean {

	public void setLetterId(java.lang.Integer letterId) {
		set("letter_id", letterId);
	}

	public java.lang.Integer getLetterId() {
		return get("letter_id");
	}

	public void setTitle(java.lang.String title) {
		set("title", title);
	}

	public java.lang.String getTitle() {
		return get("title");
	}

	public void setContents(java.lang.String contents) {
		set("contents", contents);
	}

	public java.lang.String getContents() {
		return get("contents");
	}

	public void setSender(java.lang.Integer sender) {
		set("sender", sender);
	}

	public java.lang.Integer getSender() {
		return get("sender");
	}

	public void setReceiver(java.lang.Integer receiver) {
		set("receiver", receiver);
	}

	public java.lang.Integer getReceiver() {
		return get("receiver");
	}

	public void setSendTime(java.util.Date sendTime) {
		set("send_time", sendTime);
	}

	public java.util.Date getSendTime() {
		return get("send_time");
	}

	public void setStatus(java.lang.Integer status) {
		set("status", status);
	}

	public java.lang.Integer getStatus() {
		return get("status");
	}

	public void setDeleteFlag(java.lang.Integer deleteFlag) {
		set("delete_flag", deleteFlag);
	}

	public java.lang.Integer getDeleteFlag() {
		return get("delete_flag");
	}

}