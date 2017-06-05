package cn.pacificimmi.nav.controllers;

import java.util.Date;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Copyright;
import cn.pacificimmi.common.models.PageFooters;
import cn.pacificimmi.common.models.PageHeaders;
import cn.pacificimmi.common.utils.StringUtils;

/**
 * 导航菜单－通用设置
 * @author yang
 * @date 2017年5月11日 上午11:39:12
 */
@Before(LoginInterCeptor.class)
public class NavConfigController extends Controller {
	
	public void index() {
		this.redirect("/official/nav/config/headers");
	}
	
	
	/**
	 * 顶部管理
	 */
	public void headers() {
		ParamsParser pp = new ParamsParser(this);
		PageHeaders headers = PageHeaders.dao.findFirst("select * from official_page_headers");
		if(pp.getAllStr("operation") != null) {
			if(null == headers) {
				headers = new PageHeaders();
			}
			
			String logo_img = pp.getAllStr("logo_img");
			if(StringUtils.notEmpty(logo_img)) {
				headers.set("logo_img", logo_img);
			}
			String phone = pp.getAllStr("phone");
			if(StringUtils.notEmpty(phone)) {
				headers.set("phone", phone);
			}
			String wx_img_one_description = pp.getAllStr("wx_img_one_description");
			if(StringUtils.notEmpty(wx_img_one_description)) {
				headers.set("wx_img_one_description", wx_img_one_description);
			}
			String wx_img_one = pp.getAllStr("wx_img_one");
			if(StringUtils.notEmpty(wx_img_one)) {
				headers.set("wx_img_one", wx_img_one);
			}
			String wx_img_two_description = pp.getAllStr("wx_img_two_description");
			if(StringUtils.notEmpty(wx_img_two_description)) {
				headers.set("wx_img_two_description", wx_img_two_description);
			}
			String wx_img_two = pp.getAllStr("wx_img_two");
			if(StringUtils.notEmpty(wx_img_two)) {
				headers.set("wx_img_two", wx_img_two);
			}
			String contact_img = pp.getAllStr("contact_img");
			if(StringUtils.notEmpty(contact_img)) {
				headers.set("contact_img", contact_img);
			}
			
			if(null != headers.getPageHeadersId()) {
				headers.update();
			} else {
				headers.setCreateTime(new Date());
				headers.save();
			}
			
			this.setAttr("status", 1);
			this.setAttr("headers", headers);
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/nav/config/headers.jsp");
		} else {
			this.setAttr("headers", headers);
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/nav/config/headers.jsp");
		}
	}
	
	/**
	 * 底部管理
	 */
	public void footers() {
		ParamsParser pp = new ParamsParser(this);
		PageFooters footers = PageFooters.dao.findFirst("select * from official_page_footers");
		if(pp.getAllStr("operation") != null) {
			if(null == footers) {
				footers = new PageFooters();
			}
			String logo_img = pp.getAllStr("logo_img");
			if(StringUtils.notEmpty(logo_img)) {
				footers.set("logo_img", logo_img);
			}
			String company_name = pp.getAllStr("company_name");
			if(StringUtils.notEmpty(company_name)) {
				footers.set("company_name", company_name);
			}
			String company_add = pp.getAllStr("company_add");
			if(StringUtils.notEmpty(company_add)) {
				footers.set("company_add", company_add);
			}
			String email = pp.getAllStr("email");
			if(StringUtils.notEmpty(email)) {
				footers.set("email", email);
			}
			String service_hotline = pp.getAllStr("service_hotline");
			if(StringUtils.notEmpty(service_hotline)) {
				footers.set("service_hotline", service_hotline);
			}
			String customer_hotline = pp.getAllStr("customer_hotline");
			if(StringUtils.notEmpty(customer_hotline)) {
				footers.set("customer_hotline", customer_hotline);
			}
			String wx_img_one = pp.getAllStr("wx_img_one");
			if(StringUtils.notEmpty(wx_img_one)) {
				footers.set("wx_img_one", wx_img_one);
			}
			String wx_img_two = pp.getAllStr("wx_img_two");
			if(StringUtils.notEmpty(wx_img_two)) {
				footers.set("wx_img_two", wx_img_two);
			}

			if(null != footers.getPageFootersId()) {
				footers.update();
			} else {
				footers.setCreateTime(new Date());
				footers.save();
			}
			
			this.setAttr("status", 1);
			this.setAttr("footers", footers);
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/nav/config/footers.jsp");
		} else {
			this.setAttr("footers", footers);
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/nav/config/footers.jsp");
		}
	}
	
	
	public void copyright() {
		ParamsParser pp = new ParamsParser(this);
		Copyright cop = Copyright.dao.findFirst("select * from official_copyright");
		if(pp.getAllStr("operation") != null) {
			if(null == cop) {
				cop = new Copyright();
			}
			String company_name = pp.getAllStr("company_name");
			if(StringUtils.notEmpty(company_name)) {
				cop.set("company_name", company_name);
			}
			String copyright = pp.getAllStr("copyright");
			if(StringUtils.notEmpty(copyright)) {
				cop.set("copyright", copyright);
			}
			String recordation = pp.getAllStr("recordation");
			if(StringUtils.notEmpty(recordation)) {
				cop.set("recordation", recordation);
			}
			
			if(null != cop.getCopyrightId()) {
				cop.update();
			} else {
				cop.setCreateTime(new Date());
				cop.save();
			}
			
			this.setAttr("status", 1);
			this.setAttr("copyright", cop);
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/nav/config/copyright.jsp");
		} else {
			this.setAttr("copyright", cop);
			this.setAttr("operation", "编辑");
			this.renderJsp("/views/nav/config/copyright.jsp");
		}
	}
}
