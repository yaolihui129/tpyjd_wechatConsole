package cn.pacificimmi.project.models.view;

import java.util.Date;

public class CrmProject {
	
	/**
	 * 标识
	 */
	private String id;
	
	/**
	 * 项目名称
	 */
	private String name;
	
	/**
	 * 项目编号
	 */
	private String projectbh;
	
	/**
	 * 项目级别
	 */
	private String projectjb;
	
	/**
	 * 国家
	 */
	private String projectcountry;
	
	/**
	 * 项目类型
	 */
	private String xmlx;
	
	/**
	 * 项目状态
	 */
	private String projectzt;
	
	/**
	 * 创建时间
	 */
	private String createdate;
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getProjectbh() {
		return projectbh;
	}

	public void setProjectbh(String projectbh) {
		this.projectbh = projectbh;
	}

	public String getProjectjb() {
		return projectjb;
	}

	public void setProjectjb(String projectjb) {
		this.projectjb = projectjb;
	}

	public String getProjectcountry() {
		return projectcountry;
	}

	public void setProjectcountry(String projectcountry) {
		this.projectcountry = projectcountry;
	}

	public String getXmlx() {
		return xmlx;
	}

	public void setXmlx(String xmlx) {
		this.xmlx = xmlx;
	}

	public String getProjectzt() {
		return projectzt;
	}

	public void setProjectzt(String projectzt) {
		this.projectzt = projectzt;
	}

	public String getCreatedate() {
		return createdate;
	}

	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
}
