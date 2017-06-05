package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.card.controllers.CardAccessController;
import cn.pacificimmi.card.controllers.CardCustomerController;
import cn.pacificimmi.card.controllers.CardResourceController;
import cn.pacificimmi.custMsg.controller.CustinfoMessageController;


public class CardRoutes extends Routes {

	@Override
	public void config() {
		add("/data/cardcustomer",CardCustomerController.class);
		add("/data/cardresource", CardResourceController.class);
		add("/data/cardaccess", CardAccessController.class);
		add("/data/custMsg", CustinfoMessageController.class);//客户留言板
	}

}
