package cn.pacificimmi.topic.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class TopicInfo extends ComplexModel<TopicInfo> {
	private Integer topicId=0;
	private String topicName="";
	private String topicMark="";
	private Integer topicSort=0;
	private String topicUrl="";
	private String topicImage="";
	private String editUser="";
	private Date updateTime;
	private String topicStatus="";
	private String edit_user="";
	private String send_position="";
	private Integer hits=0;
	private String createUser="";
	private String deleteUser="";
	private String releaseUser="";
	private Date releaseTime;
	
	
	public String getTopicName() {
		return topicName;
	}
	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}
	public String getTopicMark() {
		return topicMark;
	}
	public void setTopicMark(String topicMark) {
		this.topicMark = topicMark;
	}
	
	public String getTopicUrl() {
		return topicUrl;
	}
	public void setTopicUrl(String topicUrl) {
		this.topicUrl = topicUrl;
	}
	public String getTopicImage() {
		return topicImage;
	}
	public void setTopicImage(String topicImage) {
		this.topicImage = topicImage;
	}
	public String getEditUser() {
		return editUser;
	}
	public void setEditUser(String editUser) {
		this.editUser = editUser;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getTopicStatus() {
		return topicStatus;
	}
	public void setTopicStatus(String topicStatus) {
		this.topicStatus = topicStatus;
	}
	public Integer getTopicId() {
		return topicId;
	}
	public void setTopicId(Integer topicId) {
		this.topicId = topicId;
	}
	public Integer getTopicSort() {
		return topicSort;
	}
	public void setTopicSort(Integer topicSort) {
		this.topicSort = topicSort;
	}
	public String getEdit_user() {
		return edit_user;
	}
	public void setEdit_user(String edit_user) {
		this.edit_user = edit_user;
	}
	public String getSend_position() {
		return send_position;
	}
	public void setSend_position(String send_position) {
		this.send_position = send_position;
	}
	public Integer getHits() {
		return hits;
	}
	public void setHits(Integer hits) {
		this.hits = hits;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public String getDeleteUser() {
		return deleteUser;
	}
	public void setDeleteUser(String deleteUser) {
		this.deleteUser = deleteUser;
	}
	public String getReleaseUser() {
		return releaseUser;
	}
	public void setReleaseUser(String releaseUser) {
		this.releaseUser = releaseUser;
	}
	public Date getReleaseTime() {
		return releaseTime;
	}
	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}
	
	
}
