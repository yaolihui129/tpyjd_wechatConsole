package cn.pacificimmi.card.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class CardAccessInfo extends ComplexModel<CardAccessInfo> {
	
	/**
	 * 记录id
	 */
	 private Integer card_access_id;
	 
	 /**
	  * 名片所属人id
	  */
	 private Integer user_id;
	 
	 /**
	  * 名片所属人
	  */
	 private String user_name;
	 
	 /**
	  * 浏览量
	  */
	 private Long browse_num;
	 
	 /**
	  * 已报名人数
	  */
	 private Long enrol_num;
	 
	 /**
	  * 转化率
	  */
	 private Double  percent;
	 
	/**
	  * 名片url
	  */
	 private String url;
	 	 
	 /**
	  * 浏览时间
	  */
	 private Date create_time;
	 
	 /**
	  * user转发人
	  */
	 private String send_user_name;
	 
	 /**
	  * wx转发人
	  */
	 private String send_wx_name;
	 
	 

	public Integer getCard_access_id() {
		return card_access_id;
	}

	public void setCard_access_id(Integer card_access_id) {
		this.card_access_id = card_access_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public Long getBrowse_num() {
		return browse_num;
	}

	public void setBrowse_num(Long browse_num) {
		this.browse_num = browse_num;
	}

	public Long getEnrol_num() {
		return enrol_num;
	}

	public void setEnrol_num(Long enrol_num) {
		this.enrol_num = enrol_num;
	}

	public Double getPercent() {
		return percent;
	}

	public void setPercent(Double percent) {
		this.percent = percent;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getSend_user_name() {
		return send_user_name;
	}

	public void setSend_user_name(String send_user_name) {
		this.send_user_name = send_user_name;
	}

	public String getSend_wx_name() {
		return send_wx_name;
	}

	public void setSend_wx_name(String send_wx_name) {
		this.send_wx_name = send_wx_name;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	 
}
