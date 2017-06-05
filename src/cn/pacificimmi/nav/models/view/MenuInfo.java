package cn.pacificimmi.nav.models.view;

import cn.pacificimmi.common.ComplexModel;

public class MenuInfo extends ComplexModel<MenuInfo> {
	
	/**
	 * 导航菜单标识
	 */
	private Integer nav_menu_id;
	
	/**
	 * 导航菜单名称
	 */
	private String menu_name;
	
	/**
	 * 菜单链接地址
	 */
	private String menu_url;
	
	/**
	 * 打开方式
	 */
	private String open_mode_name;
	
	/**
	 * 菜单状态name
	 */
	private String menu_status_name;

	/**
	 * 导航类型
	 */
	private String menu_type;
	
	/**
	 * 上一级标识
	 */
	private Integer menu_pid;
	
	/**
	 * 绑定选择
	 */
	private String dict_code;
	
	/**
	 * 菜单状态
	 */
	private String menu_status;
	
	public Integer getNav_menu_id() {
		return nav_menu_id;
	}

	public void setNav_menu_id(Integer nav_menu_id) {
		this.nav_menu_id = nav_menu_id;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getMenu_url() {
		return menu_url;
	}

	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}

	public String getOpen_mode_name() {
		return open_mode_name;
	}

	public void setOpen_mode_name(String open_mode_name) {
		this.open_mode_name = open_mode_name;
	}

	public String getMenu_status_name() {
		return menu_status_name;
	}

	public void setMenu_status_name(String menu_status_name) {
		this.menu_status_name = menu_status_name;
	}

	public String getMenu_type() {
		return menu_type;
	}

	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}

	public Integer getMenu_pid() {
		return menu_pid;
	}

	public void setMenu_pid(Integer menu_pid) {
		this.menu_pid = menu_pid;
	}

	public String getDict_code() {
		return dict_code;
	}

	public void setDict_code(String dict_code) {
		this.dict_code = dict_code;
	}

	public String getMenu_status() {
		return menu_status;
	}

	public void setMenu_status(String menu_status) {
		this.menu_status = menu_status;
	}

}
