package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.nav.controllers.BranchController;
import cn.pacificimmi.nav.controllers.FriendlyLinkController;
import cn.pacificimmi.nav.controllers.MenuController;
import cn.pacificimmi.nav.controllers.MenuThreeController;
import cn.pacificimmi.nav.controllers.MenuTwoController;
import cn.pacificimmi.nav.controllers.NavConfigController;

public class NavRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/official/nav/config", NavConfigController.class);
		add("/official/nav/link", FriendlyLinkController.class);
		add("/official/nav/branch", BranchController.class);
		add("/official/nav/menu", MenuController.class);
		add("/official/nav/menu/two", MenuTwoController.class);
		add("/official/nav/menu/three", MenuThreeController.class);
	}

}
