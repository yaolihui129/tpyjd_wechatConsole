package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BasePageHeaders<M extends BasePageHeaders<M>> extends Model<M> implements IBean {

	public void setPageHeadersId(java.lang.Integer pageHeadersId) {
		set("page_headers_id", pageHeadersId);
	}

	public java.lang.Integer getPageHeadersId() {
		return get("page_headers_id");
	}

	public void setLogoImg(java.lang.String logoImg) {
		set("logo_img", logoImg);
	}

	public java.lang.String getLogoImg() {
		return get("logo_img");
	}

	public void setPhone(java.lang.String phone) {
		set("phone", phone);
	}

	public java.lang.String getPhone() {
		return get("phone");
	}

	public void setWxImgOneDescription(java.lang.String wxImgOneDescription) {
		set("wx_img_one_description", wxImgOneDescription);
	}

	public java.lang.String getWxImgOneDescription() {
		return get("wx_img_one_description");
	}

	public void setWxImgOne(java.lang.String wxImgOne) {
		set("wx_img_one", wxImgOne);
	}

	public java.lang.String getWxImgOne() {
		return get("wx_img_one");
	}

	public void setWxImgTwoDescription(java.lang.String wxImgTwoDescription) {
		set("wx_img_two_description", wxImgTwoDescription);
	}

	public java.lang.String getWxImgTwoDescription() {
		return get("wx_img_two_description");
	}

	public void setWxImgTwo(java.lang.String wxImgTwo) {
		set("wx_img_two", wxImgTwo);
	}

	public java.lang.String getWxImgTwo() {
		return get("wx_img_two");
	}

	public void setContactImg(java.lang.String contactImg) {
		set("contact_img", contactImg);
	}

	public java.lang.String getContactImg() {
		return get("contact_img");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

}
