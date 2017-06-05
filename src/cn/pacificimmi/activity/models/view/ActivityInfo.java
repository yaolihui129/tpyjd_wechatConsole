package cn.pacificimmi.activity.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class ActivityInfo extends ComplexModel<ActivityInfo> {
	
	private Integer activityId;
	private String activityName;
	private String activityMark;
	private Integer activitySort;
	private String activityThumbImage;
	private String activityImage;
	private Integer indexShow;
	private String activityStatus;
	private Integer joinUsers;
	private Date startTime;
	private String activityType;
	private String activityAddress;
	private Date createTime;
	
	public Integer getActivityId() {
		return activityId;
	}
	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}
	
	public String getActivityType() {
		return activityType;
	}
	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getActivityMark() {
		return activityMark;
	}
	public void setActivityMark(String activityMark) {
		this.activityMark = activityMark;
	}
	public Integer getActivitySort() {
		return activitySort;
	}
	public void setActivitySort(Integer activitySort) {
		this.activitySort = activitySort;
	}
	public String getActivityThumbImage() {
		return activityThumbImage;
	}
	public void setActivityThumbImage(String activityThumbImage) {
		this.activityThumbImage = activityThumbImage;
	}
	public String getActivityImage() {
		return activityImage;
	}
	public void setActivityImage(String activityImage) {
		this.activityImage = activityImage;
	}
	public Integer getIndexShow() {
		return indexShow;
	}
	public void setIndexShow(Integer indexShow) {
		this.indexShow = indexShow;
	}
	public String getActivityStatus() {
		return activityStatus;
	}
	public void setActivityStatus(String activityStatus) {
		this.activityStatus = activityStatus;
	}
	public Integer getJoinUsers() {
		return joinUsers;
	}
	public void setJoinUsers(Integer joinUsers) {
		this.joinUsers = joinUsers;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getActivityAddress() {
		return activityAddress;
	}
	public void setActivityAddress(String activityAddress) {
		this.activityAddress = activityAddress;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
}
