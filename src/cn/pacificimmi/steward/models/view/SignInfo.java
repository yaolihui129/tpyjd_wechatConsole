package cn.pacificimmi.steward.models.view;

import java.util.Date;

public class SignInfo{
	private String stewardName;
	private String customNickName;
	private String englishName;
	private String customMobile;
	private String signStatus;
	private Date optTime;
	
	private String unsignReason;
	private String unsignReasonTitle;
	
	public String getStewardName() {
		return stewardName;
	}
	public void setStewardName(String stewardName) {
		this.stewardName = stewardName;
	}
	
	public String getEnglishName() {
		return englishName;
	}
	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	public String getCustomNickName() {
		return customNickName;
	}
	public void setCustomNickName(String customNickName) {
		this.customNickName = customNickName;
	}
	public String getCustomMobile() {
		return customMobile;
	}
	public void setCustomMobile(String customMobile) {
		this.customMobile = customMobile;
	}
	public String getSignStatus() {
		return signStatus;
	}
	public void setSignStatus(String signStatus) {
		this.signStatus = signStatus;
	}
	public String getUnsignReason() {
		return unsignReason;
	}
	public void setUnsignReason(String unsignReason) {
		this.unsignReason = unsignReason;
	}
	public Date getOptTime() {
		return optTime;
	}
	public void setOptTime(Date optTime) {
		this.optTime = optTime;
	}
	public String getUnsignReasonTitle() {
		return unsignReasonTitle;
	}
	public void setUnsignReasonTitle(String unsignReasonTitle) {
		this.unsignReasonTitle = unsignReasonTitle;
	}
	
}
