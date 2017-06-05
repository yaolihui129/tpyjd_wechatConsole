package cn.pacificimmi.card.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class CarCustomerInfo extends ComplexModel<CarCustomerInfo> {
	
	private Integer card_customer_id;
	
	private String name;
	
	private String mobile;
	
	private String ip;
	
	private String url;
	
	private String userName;
	
	private Date create_time;

	public Integer getCard_customer_id() {
		return card_customer_id;
	}

	public void setCard_customer_id(Integer card_customer_id) {
		this.card_customer_id = card_customer_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	
	
}
