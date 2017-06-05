package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.live.controllers.LicenseCodeController;
import cn.pacificimmi.live.controllers.LiveListController;
import cn.pacificimmi.live.controllers.LiveRoomController;
import cn.pacificimmi.live.controllers.LiveStatisticsController;


public class LiveRoutes extends Routes {

	@Override
	public void config() {
		add("/live/list/room",LiveRoomController.class);
		add("/live/list",LiveListController.class);
		add("/live/list/statistics",LiveStatisticsController.class);
		add("/live/list/code",LicenseCodeController.class);
	}

}
