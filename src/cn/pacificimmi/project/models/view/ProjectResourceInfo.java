package cn.pacificimmi.project.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class ProjectResourceInfo extends ComplexModel<ProjectResourceInfo> {
	
	private Integer project_resource_id;
	
	/**
	 * 媒体类型
	 */
	private String media_type;
	
	/**
	 * 类型名称
	 */
	private String media_name;
	
	/**
	 * 大小 
	 */
	private String size;
	
	/**
	 * 标题
	 */
	private String title;
	
	/**
	 * 上传时间
	 */
	private Date create_time;
	
	/**
	 * url
	 * @return
	 */
	private String url;
	
	/**
	 * 说明
	 */
	private String description;
	
	
	public Integer getProject_resource_id() {
		return project_resource_id;
	}

	public void setProject_resource_id(Integer project_resource_id) {
		this.project_resource_id = project_resource_id;
	}

	public String getMedia_type() {
		return media_type;
	}

	public void setMedia_type(String media_type) {
		this.media_type = media_type;
	}

	public String getMedia_name() {
		return media_name;
	}

	public void setMedia_name(String media_name) {
		this.media_name = media_name;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
