package cn.pacificimmi.project.models.view;

import cn.pacificimmi.common.ComplexModel;

public class ProjectApplyProcessInfo extends ComplexModel<ProjectApplyProcessInfo>{
	
	private Integer project_apply_process_id;
	
	private Integer project_id;
	
	private String name;
	
	private String cycle;
	
	private String content;
	

	public Integer getProject_apply_process_id() {
		return project_apply_process_id;
	}

	public void setProject_apply_process_id(Integer project_apply_process_id) {
		this.project_apply_process_id = project_apply_process_id;
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

	public String getCycle() {
		return cycle;
	}

	public void setCycle(String cycle) {
		this.cycle = cycle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
}
