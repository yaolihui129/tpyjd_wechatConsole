package cn.pacificimmi.project.models.view;

import java.util.Date;
import java.util.List;

import cn.pacificimmi.common.ComplexModel;
import cn.pacificimmi.common.models.ProjectExpands;

public class ProjectInfo extends ComplexModel<ProjectInfo>{
	
	/**
	 * 项目id
	 */
	private Integer project_id;
	
	/**
	 * 项目编号
	 */
	private String project_code;
	
	/**
	 * 项目名称
	 */
	private String project_name;
	
	/**
	 * 国家地区code
	 */
	private String country;
	
	/**
	 * 国家名称
	 */
	private String country_name;
	
	/**
	 * 城市
	 */
	private String city;
	
	/**
	 * 城市名称
	 */
	private String city_name;
	
	/**
	 * 扩展名称
	 */
	private String project_expands_name;
	
	/**
	 * 项目状态
	 */
	private String project_status;
	
	/**
	 * 项目状态
	 */
	private String project_status_name;
	
	/**
	 * 项目类型
	 */
	private String project_type;
	
	/**
	 * 项目类型名称
	 */
	private String project_type_name;
	
	/**
	 * 项目简介
	 */
	private String introduce;
	
	/**
	 * 总体费用
	 */
	private Integer immigration_budget;
	
	/**
	 * 上线日期
	 */
	private Date online_time;
	
	/**
	 * 创建人
	 */
	private String create_user_name;
	
	/**
	 * 项目等级
	 */
	private String project_level_name;
	

	public Integer getProject_id() {
		return project_id;
	}

	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}

	public String getProject_code() {
		return project_code;
	}

	public void setProject_code(String project_code) {
		this.project_code = project_code;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCountry_name() {
		return country_name;
	}

	public void setCountry_name(String country_name) {
		this.country_name = country_name;
	}

	public String getProject_status() {
		return project_status;
	}

	public void setProject_status(String project_status) {
		this.project_status = project_status;
	}

	public String getProject_status_name() {
		return project_status_name;
	}

	public void setProject_status_name(String project_status_name) {
		this.project_status_name = project_status_name;
	}

	public String getProject_type() {
		return project_type;
	}

	public void setProject_type(String project_type) {
		this.project_type = project_type;
	}

	public String getProject_type_name() {
		return project_type_name;
	}

	public void setProject_type_name(String project_type_name) {
		this.project_type_name = project_type_name;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public Integer getImmigration_budget() {
		return immigration_budget;
	}

	public void setImmigration_budget(Integer immigration_budget) {
		this.immigration_budget = immigration_budget;
	}

	public Date getOnline_time() {
		return online_time;
	}

	public void setOnline_time(Date online_time) {
		this.online_time = online_time;
	}

	public String getCreate_user_name() {
		return create_user_name;
	}

	public void setCreate_user_name(String create_user_name) {
		this.create_user_name = create_user_name;
	}
	
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCity_name() {
		return city_name;
	}

	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}

	public String getProject_expands_name() {
		return project_expands_name;
	}

	public void setProject_expands_name(String project_expands_name) {
		this.project_expands_name = project_expands_name;
	}

	public String getProject_level_name() {
		return project_level_name;
	}

	public void setProject_level_name(String project_level_name) {
		this.project_level_name = project_level_name;
	}


}
