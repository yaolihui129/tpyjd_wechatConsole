package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.team.controller.EmploiesController;
import cn.pacificimmi.team.controller.TeamController;

public class TeamRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/official/about/team/list",TeamController.class);
		add("/official/about/team/list/add",EmploiesController.class);
	}

}
