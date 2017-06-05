package cn.pacificimmi.card.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class CardResourceInfo extends ComplexModel<CardResourceInfo>{
	/**
	 * 微信资源标识
	 */
	private Integer weixin_resource_id;
	/**
	 * 绑定用户标识
	 */
	private Integer user_id;
	/**
	 * 绑定用户姓名
	 */
	private String user_name;
	/**
	 * 用户openid
	 */
	private String openid;
	/**
	 * 微信昵称
	 */
	private String wx_name;
	/**
	 * 微信头像
	 */
	private String head_img;
	/**
	 * 资源绑定状态
	 */
	private Integer status;
	/**
	 * 创建时间
	 */
	private Date create_time;
	/**
	 * 用户绑定状态
	 */
	private String bind_status;
	
	
	public Integer getWeixin_resource_id() {
		return weixin_resource_id;
	}
	public void setWeixin_resource_id(Integer weixin_resource_id) {
		this.weixin_resource_id = weixin_resource_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getWx_name() {
		return wx_name;
	}
	public void setWx_name(String wx_name) {
		this.wx_name = wx_name;
	}
	public String getHead_img() {
		return head_img;
	}
	public void setHead_img(String head_img) {
		this.head_img = head_img;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreate_time() {
		return create_time;
	}
	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public String getBind_status() {
		return bind_status;
	}
	public void setBind_status(String bind_status) {
		this.bind_status = bind_status;
	}
	
}
