package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.proxy.controllers.ProxyController;
import cn.pacificimmi.proxy.controllers.ProxyDetailsController;
import cn.pacificimmi.proxy.controllers.ProxyStatusRecordController;

public class ProxyRoutes extends Routes {

	@Override
	public void config() {
		add("/proxy/proxy", ProxyController.class);
		add("/proxy/proxy/details", ProxyDetailsController.class);
		add("/proxy/proxy/statusRecord", ProxyStatusRecordController.class);
	}

}
