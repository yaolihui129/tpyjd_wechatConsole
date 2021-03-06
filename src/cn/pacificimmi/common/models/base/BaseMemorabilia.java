package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseMemorabilia<M extends BaseMemorabilia<M>> extends Model<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public void setScreen(java.lang.Integer screen) {
		set("screen", screen);
	}

	public java.lang.Integer getScreen() {
		return get("screen");
	}

	public void setPosition(java.lang.Integer position) {
		set("position", position);
	}

	public java.lang.Integer getPosition() {
		return get("position");
	}

	public void setPictureUrl(java.lang.String pictureUrl) {
		set("picture_url", pictureUrl);
	}

	public java.lang.String getPictureUrl() {
		return get("picture_url");
	}

	public void setDescribe(java.lang.String describe) {
		set("describe", describe);
	}

	public java.lang.String getDescribe() {
		return get("describe");
	}

	public void setEditor(java.lang.String editor) {
		set("editor", editor);
	}

	public java.lang.String getEditor() {
		return get("editor");
	}

	public void setEditorTime(java.util.Date editorTime) {
		set("editor_time", editorTime);
	}

	public java.util.Date getEditorTime() {
		return get("editor_time");
	}

	public void setPublisher(java.lang.String publisher) {
		set("publisher", publisher);
	}

	public java.lang.String getPublisher() {
		return get("publisher");
	}

	public void setPublishTime(java.util.Date publishTime) {
		set("publish_time", publishTime);
	}

	public java.util.Date getPublishTime() {
		return get("publish_time");
	}

	public void setPublishStatus(java.lang.String publishStatus) {
		set("publish_status", publishStatus);
	}

	public java.lang.String getPublishStatus() {
		return get("publish_status");
	}

}
