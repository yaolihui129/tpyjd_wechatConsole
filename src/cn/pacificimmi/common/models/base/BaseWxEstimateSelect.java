package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseWxEstimateSelect<M extends BaseWxEstimateSelect<M>> extends Model<M> implements IBean {

	public void setEstimateSelectId(java.lang.Integer estimateSelectId) {
		set("estimate_select_id", estimateSelectId);
	}

	public java.lang.Integer getEstimateSelectId() {
		return get("estimate_select_id");
	}

	public void setEstimateQuestionId(java.lang.Integer estimateQuestionId) {
		set("estimate_question_id", estimateQuestionId);
	}

	public java.lang.Integer getEstimateQuestionId() {
		return get("estimate_question_id");
	}

	public void setContent(java.lang.String content) {
		set("content", content);
	}

	public java.lang.String getContent() {
		return get("content");
	}

	public void setPriority(java.lang.Integer priority) {
		set("priority", priority);
	}

	public java.lang.Integer getPriority() {
		return get("priority");
	}

}
