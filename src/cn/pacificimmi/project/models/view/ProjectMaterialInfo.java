package cn.pacificimmi.project.models.view;

import cn.pacificimmi.common.ComplexModel;

public class ProjectMaterialInfo extends ComplexModel<ProjectMaterialInfo>{
	
	/**
	 * 项目材料id
	 */
	private Integer project_material_id;
	
	/**
	 * 项目id
	 */
	private Integer project_id;
	
	/**
	 * 材料名称
	 */
	private String name;
	
	/**
	 * 说明
	 */
	private String description;
	
	/**
	 * 项目流程
	 */
	private Integer project_apply_process_id;
	
	/**
	 * 项目流程名称
	 */
	private String apply_process_name;
	
	/**
	 * 样例图片
	 */
	private String swatch_url;
	
	private String swatch_name;
	
	private String material_type;


	public Integer getProject_material_id() {
		return project_material_id;
	}


	public void setProject_material_id(Integer project_material_id) {
		this.project_material_id = project_material_id;
	}


	public Integer getProject_id() {
		return project_id;
	}


	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Integer getProject_apply_process_id() {
		return project_apply_process_id;
	}


	public void setProject_apply_process_id(Integer project_apply_process_id) {
		this.project_apply_process_id = project_apply_process_id;
	}


	public String getApply_process_name() {
		return apply_process_name;
	}


	public void setApply_process_name(String apply_process_name) {
		this.apply_process_name = apply_process_name;
	}


	public String getSwatch_url() {
		return swatch_url;
	}


	public void setSwatch_url(String swatch_url) {
		this.swatch_url = swatch_url;
	}


	public String getSwatch_name() {
		return swatch_name;
	}


	public void setSwatch_name(String swatch_name) {
		this.swatch_name = swatch_name;
	}


	public String getMaterial_type() {
		return material_type;
	}


	public void setMaterial_type(String material_type) {
		this.material_type = material_type;
	}
	
}
