package cn.pacificimmi.official.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.AboutNav;
import cn.pacificimmi.common.models.Configs;

@Before(LoginInterCeptor.class)
public class ContactUsController extends AboutController {
	private Logger log = LoggerFactory.getLogger(ContactUsController.class);
	

	/**
	 * 北京分公司
	 */
	public void beijing(){
		aboutMenu("北京");
		this.setAttr("PREVIEW_URL", dp.get("OFFICIAL_URL") + "/about-us/contact-us/preview");
	}
	
	/**
	 * 国内分公司
	 */
	public void domestic(){
		aboutMenu("国内分公司");
		this.setAttr("PREVIEW_URL", dp.get("OFFICIAL_URL") + "/about-us/contact-us/preview");
	}
	
	/**
	 * 国外分公司
	 */
	public void foreign(){
		aboutMenu("国外分公司");
		this.setAttr("PREVIEW_URL", dp.get("OFFICIAL_URL") + "/about-us/contact-us/preview");
	}
}
