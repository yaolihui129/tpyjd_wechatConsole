package cn.pacificimmi.common.routes;
import cn.pacificimmi.official.controllers.AboutController;
import cn.pacificimmi.official.controllers.ContactUsController;
import cn.pacificimmi.official.controllers.HomeController;
import cn.pacificimmi.official.controllers.HonorController;
import cn.pacificimmi.official.controllers.HonorImgController;
import cn.pacificimmi.official.controllers.RecruitmentController;

import com.jfinal.config.Routes;

public class OfficialRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/official/home",HomeController.class);//首页设置
		add("/official/about",AboutController.class);//关于我们
		add("/official/about/zp",RecruitmentController.class);//招聘
		add("official/about/honor",HonorController.class);//荣誉
		add("official/about/honorimg",HonorImgController.class);//荣誉图片
		add("/official/about/contactus",ContactUsController.class);//荣誉图片
	}

}
