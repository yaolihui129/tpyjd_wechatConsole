package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.estimate.controllers.EstimateController;

public class EstimateRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/estimates",EstimateController.class);
	}

}
