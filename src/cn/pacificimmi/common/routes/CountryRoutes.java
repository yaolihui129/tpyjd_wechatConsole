package cn.pacificimmi.common.routes;

import cn.pacificimmi.common.controllers.CityController;
import cn.pacificimmi.common.models.ImmigrationPolicy;
import cn.pacificimmi.country.controllers.CountryController;
import cn.pacificimmi.country.controllers.ImmiPolicyController;

import com.jfinal.config.Routes;

public class CountryRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/country",CountryController.class);//国家管理
		add("/country/city/hot",CityController.class);//热门城市
		add("/country/immiPolicy",ImmiPolicyController.class);//移民政策
	}

}
