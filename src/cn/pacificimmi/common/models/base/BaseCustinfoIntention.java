package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseCustinfoIntention<M extends BaseCustinfoIntention<M>> extends Model<M> implements IBean {

	public void setIntentionId(java.lang.Integer intentionId) {
		set("intention_id", intentionId);
	}

	public java.lang.Integer getIntentionId() {
		return get("intention_id");
	}

	public void setCustinfoId(java.lang.Integer custinfoId) {
		set("custinfo_id", custinfoId);
	}

	public java.lang.Integer getCustinfoId() {
		return get("custinfo_id");
	}

	public void setIntention(java.lang.String intention) {
		set("intention", intention);
	}

	public java.lang.String getIntention() {
		return get("intention");
	}

	public void setCountry(java.lang.String country) {
		set("country", country);
	}

	public java.lang.String getCountry() {
		return get("country");
	}

	public void setProjectId(java.lang.String projectId) {
		set("project_id", projectId);
	}

	public java.lang.String getProjectId() {
		return get("project_id");
	}

	public void setEducation(java.lang.String education) {
		set("education", education);
	}

	public java.lang.String getEducation() {
		return get("education");
	}

	public void setLanguage(java.lang.String language) {
		set("language", language);
	}

	public java.lang.String getLanguage() {
		return get("language");
	}

	public void setCalculationMin(java.math.BigDecimal calculationMin) {
		set("calculation_min", calculationMin);
	}

	public java.math.BigDecimal getCalculationMin() {
		return get("calculation_min");
	}

	public void setCalculationMax(java.math.BigDecimal calculationMax) {
		set("calculation_max", calculationMax);
	}

	public java.math.BigDecimal getCalculationMax() {
		return get("calculation_max");
	}

	public void setFamilyAssets(java.lang.String familyAssets) {
		set("family_assets", familyAssets);
	}

	public java.lang.String getFamilyAssets() {
		return get("family_assets");
	}

	public void setIdentityType(java.lang.String identityType) {
		set("identity_type", identityType);
	}

	public java.lang.String getIdentityType() {
		return get("identity_type");
	}

	public void setLiveRequire(java.lang.String liveRequire) {
		set("live_require", liveRequire);
	}

	public java.lang.String getLiveRequire() {
		return get("live_require");
	}

	public void setStatus(java.lang.String status) {
		set("status", status);
	}

	public java.lang.String getStatus() {
		return get("status");
	}

	public void setCurrentAssign(java.lang.Integer currentAssign) {
		set("current_assign", currentAssign);
	}

	public java.lang.Integer getCurrentAssign() {
		return get("current_assign");
	}

	public void setDeleteFlag(java.lang.Integer deleteFlag) {
		set("delete_flag", deleteFlag);
	}

	public java.lang.Integer getDeleteFlag() {
		return get("delete_flag");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

	public void setCreator(java.lang.Integer creator) {
		set("creator", creator);
	}

	public java.lang.Integer getCreator() {
		return get("creator");
	}

	public void setModifyTime(java.util.Date modifyTime) {
		set("modify_time", modifyTime);
	}

	public java.util.Date getModifyTime() {
		return get("modify_time");
	}

	public void setModifier(java.lang.Integer modifier) {
		set("modifier", modifier);
	}

	public java.lang.Integer getModifier() {
		return get("modifier");
	}

	public void setAge(java.lang.String age) {
		set("age", age);
	}

	public java.lang.String getAge() {
		return get("age");
	}

	public void setManageExp(java.lang.String manageExp) {
		set("manage_exp", manageExp);
	}

	public java.lang.String getManageExp() {
		return get("manage_exp");
	}

}