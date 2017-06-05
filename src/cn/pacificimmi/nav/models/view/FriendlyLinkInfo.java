package cn.pacificimmi.nav.models.view;

import cn.pacificimmi.common.ComplexModel;

public class FriendlyLinkInfo extends ComplexModel<FriendlyLinkInfo> {
	
	/**
	 * 链接标识
	 */
	private Integer friendly_link_id;
	
	/**
	 * 标题
	 */
	private String title;
	
	/**
	 * 链接地址
	 */
	private String url;

	public Integer getFriendly_link_id() {
		return friendly_link_id;
	}

	public void setFriendly_link_id(Integer friendly_link_id) {
		this.friendly_link_id = friendly_link_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
