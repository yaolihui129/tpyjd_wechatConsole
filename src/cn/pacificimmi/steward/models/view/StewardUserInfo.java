
package cn.pacificimmi.steward.models.view;

import java.io.Serializable;

import cn.pacificimmi.common.ComplexModel;

import com.jfinal.plugin.activerecord.Record;

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月27日 下午3:10:31
 **/

public class StewardUserInfo   extends ComplexModel<StewardUserInfo>    implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer steward_id;
	private int user_id=0;
	private String user_name="";
	private String english_name="";
	private String gender="";
	private String phone="";
	private String job_title="";
	private String release_mark="";
	private String province_id="";
	private String province_name="";
	private String like_count="";
	//部门id
	private String dep_id;
	//部门名称
	private String dep_name;
	private int dynamicScore=0;
	private int sign_count=0;
	
	public int getSign_count() {
		return sign_count;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public void setSign_count(int sign_count) {
		this.sign_count = sign_count;
	}

	public int getDynamicScore() {
		return dynamicScore;
	}

	public void setDynamicScore(int dynamicScore) {
		this.dynamicScore = dynamicScore;
	}

	public String getDep_id() {
		return dep_id;
	}

	public void setDep_id(String dep_id) {
		this.dep_id = dep_id;
	}

	public String getDep_name() {
		return dep_name;
	}

	public void setDep_name(String dep_name) {
		this.dep_name = dep_name;
	}

	public String getProvince_name() {
		return province_name;
	}

	public void setProvince_name(String province_name) {
		this.province_name = province_name;
	}

	private String email;

	public Integer getSteward_id() {
		return steward_id;
	}

	public String getLike_count() {
		return like_count;
	}

	public void setLike_count(String like_count) {
		this.like_count = like_count;
	}

	public void setSteward_id(Integer steward_id) {
		this.steward_id = steward_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getEnglish_name() {
		return english_name;
	}

	public void setEnglish_name(String english_name) {
		this.english_name = english_name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getJob_title() {
		return job_title;
	}

	public void setJob_title(String job_title) {
		this.job_title = job_title;
	}

	public String getRelease_mark() {
		return release_mark;
	}

	public void setRelease_mark(String release_mark) {
		this.release_mark = release_mark;
	}

	public String getProvince_id() {
		return province_id;
	}

	public void setProvince_id(String province_id) {
		this.province_id = province_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void bindingData(StewardUserInfo dt, Record rd) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String toString() {
		return "StewardUserInfo [steward_id=" + steward_id + ", user_id="
				+ user_id + ", user_name=" + user_name + ", english_name="
				+ english_name + ", gender=" + gender + ", phone=" + phone
				+ ", job_title=" + job_title + ", release_mark=" + release_mark
				+ ", province_id=" + province_id + ", province_name="
				+ province_name + ", dep_id=" + dep_id + ", dep_name="
				+ dep_name + ", dynamicScore=" + dynamicScore + ", email="
				+ email + "]";
	}
	
	
	
	
	
}
