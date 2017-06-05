/**
 * Copyright (c) 2011-2014, James Zhan 詹波 (jfinal@126.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

package cn.pacificimmi.common.config;

import cn.pacificimmi.common.controllers.FileUploadController;
import cn.pacificimmi.common.controllers.ImageUpload;
import cn.pacificimmi.common.controllers.UtilsController;
import cn.pacificimmi.common.models._MappingKit;
import cn.pacificimmi.common.routes.BusinessRoutes;
import cn.pacificimmi.common.routes.CardRoutes;
import cn.pacificimmi.common.routes.CityRoute;
import cn.pacificimmi.common.routes.CmsRoutes;
import cn.pacificimmi.common.routes.CountryRoutes;
import cn.pacificimmi.common.routes.CustRoutes;
import cn.pacificimmi.common.routes.DistributionRotes;
import cn.pacificimmi.common.routes.EstimateRoutes;
import cn.pacificimmi.common.routes.FeedbackRoutes;
import cn.pacificimmi.common.routes.IndexRoute;
import cn.pacificimmi.common.routes.LiveRoutes;
import cn.pacificimmi.common.routes.NavRoutes;
import cn.pacificimmi.common.routes.OfficialRoutes;
import cn.pacificimmi.common.routes.ProjectRoutes;
import cn.pacificimmi.common.routes.ProxyRoutes;
import cn.pacificimmi.common.routes.StewardRotes;
import cn.pacificimmi.common.routes.TeamRoutes;

import java.awt.Image;

import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.wall.WallFilter;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.render.ViewType;

public class TpyjdConfig extends JFinalConfig {

	/**
	 * 如果生产环境配置文件存在，则优先加载该配置，否则加载开发环境配置文件
	 * @param pro 生产环境配置文件
	 * @param dev 开发环境配置文件
	 */
	public void loadProp(String pro, String dev) {
		try {
			PropKit.use(pro);
			loadPropertyFile(pro);
		}
		catch (Exception e) {
			PropKit.use(dev);
			loadPropertyFile(dev);
		}
	}
	
	/**
	 * 如果生产环境配置文件存在，则优先加载该配置，否则加载开发环境配置文件
	 * @param pro 生产环境配置文件
	 * @param dev 开发环境配置文件
	 */
	public void loadDictionaryProp(String pro, String dev) {
		try {
			PropKit.use(pro);
			loadPropertyFile(pro);
		}
		catch (Exception e) {
			PropKit.use(dev);
			loadPropertyFile(dev);
		}
	}

	public void configConstant(Constants me) {
		loadProp("product_config.txt", "debug_config.txt");
		
		// 加载少量必要配置，随后可用getProperty(...)获取值
		me.setViewType(ViewType.JSP);
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setError404View("/sorry.html");
		me.setError500View("/sorry.html");
	}

	public void configRoute(Routes me) {
		me.add(new IndexRoute());
		me.add(new EstimateRoutes());
		me.add(new ProjectRoutes());
		me.add(new CountryRoutes());
		me.add(new BusinessRoutes());
		me.add(new DistributionRotes());
		me.add(new CustRoutes());
		me.add(new StewardRotes());
		me.add(new CmsRoutes()); 
		me.add(new CardRoutes());
		me.add(new CityRoute());
		me.add(new ProxyRoutes());
		me.add(new FeedbackRoutes());
		me.add(new TeamRoutes());
		me.add("/fileupload", FileUploadController.class);
		me.add("/utils", UtilsController.class);
		me.add("/imageupload",ImageUpload.class);
		me.add(new LiveRoutes());
		
		me.add(new OfficialRoutes());
		me.add(new NavRoutes());
	}

	public void configPlugin(Plugins me) {
		DruidPlugin dp = new DruidPlugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password"));
		dp.addFilter(new StatFilter());
		WallFilter wall = new WallFilter();
		wall.setDbType("mysql");
		dp.addFilter(wall);
		me.add(dp);
		
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
		arp.setShowSql(true);
		_MappingKit.mapping(arp);
		me.add(arp);
	}

	public void configInterceptor(Interceptors me) {
		// ApiInterceptor.setAppIdParser(new AppIdParser.DefaultParameterAppIdParser("appId")); 默认无需设置
		// MsgInterceptor.setAppIdParser(new AppIdParser.DefaultParameterAppIdParser("appId")); 默认无需设置
	}

	public void configHandler(Handlers me) {

	}

	public void afterJFinalStart() {
		
	}

	public static void main(String[] args) {
		JFinal.start("src/main/webapp", 80, "/", 5);
	}
}
