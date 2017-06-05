package cn.pacificimmi.common.routes;

import cn.pacificimmi.common.controllers.CityController;

import com.jfinal.config.Routes;

public class CityRoute extends Routes{

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/city",CityController.class);
	}

}
