package cn.pacificimmi.live.controllers.models.view;

import cn.pacificimmi.common.AbsComplexModel;
import java.lang.Integer;
import java.lang.String;
import java.util.Date;

public class LiveInfo extends AbsComplexModel<LiveInfo> {
	
	private Integer liveId;
	private String liveTitle;//
	private String stewardName;//
	private Integer liveLimit;//
	private String liveIntroduce;//
	private String livePoster;
	private String liveStatus;
	private Date createTime;
	private Date signupStartTime;//
	private Date signupEndTime;//
	private Date liveStartTime;//
	private Integer signupNum;//
	private Integer tempSignupNum;//
	private Integer channelId;//
	private String liveType;//
	
	public void setLiveId(Integer liveId) {
		this.liveId=liveId;
	}

	public java.lang.Integer getLiveId() {
		return this.liveId;
	}


	public void setLiveTitle(String liveTitle) {
		this.liveTitle = liveTitle;
	}

	public String getLiveTitle() {
		return this.liveTitle;
	}

	public String getStewardName() {
		return stewardName;
	}

	public void setStewardName(String stewardName) {
		this.stewardName = stewardName;
	}

	public void setLiveLimit(Integer liveLimit) {
		this.liveLimit = liveLimit;
	}

	public Integer getLiveLimit() {
		return this.liveLimit;
	}

	public void setLiveIntroduce(String liveIntroduce) {
		this.liveIntroduce = liveIntroduce;
	}

	public String getLiveIntroduce() {
		return this.liveIntroduce;
	}

	public void setLivePoster(String livePoster) {
		this.livePoster = livePoster;
	}

	public String getLivePoster() {
		return this.livePoster;
	}

	public void setLiveStatus(String liveStatus) {
		this.liveStatus=liveStatus;
	}

	public String getLiveStatus() {
		return this.liveStatus;
	}

	public void setCreateTime(Date createTime) {
		this.createTime= createTime;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setSignupStartTime(Date signupStartTime) {
		this.signupStartTime=signupStartTime;
	}

	public Date getSignupStartTime() {
		return this.signupStartTime;
	}

	public void setSignupEndTime(Date signupEndTime) {
		this.signupEndTime=signupEndTime;
	}

	public Date getSignupEndTime() {
		return this.signupEndTime;
	}

	public void setSignupNum(Integer signupNum) {
		this.signupNum = signupNum;
	}

	public Integer getSignupNum() {
		return this.signupNum;
	}

	public void setTempSignupNum(Integer tempSignupNum) {
		this.tempSignupNum = tempSignupNum;
	}

	public Integer getTempSignupNum() {
		return this.tempSignupNum;
	}

	public void setChannelId(Integer channelId) {
		this.channelId=channelId;
	}

	public Integer getChannelId() {
		return channelId;
	}

	public void setLiveType(String liveType) {
		this.liveType = liveType;
	}

	public String getLiveType() {
		return this.liveType;
	}

	public Date getLiveStartTime() {
		return liveStartTime;
	}

	public void setLiveStartTime(Date liveStartTime) {
		this.liveStartTime = liveStartTime;
	}
	
}
