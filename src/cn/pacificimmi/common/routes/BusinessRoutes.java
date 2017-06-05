package cn.pacificimmi.common.routes;

import cn.pacificimmi.business.controllers.BusinessController;

import com.jfinal.config.Routes;

public class BusinessRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/cooperation",BusinessController.class);//商务合作
	}

}
