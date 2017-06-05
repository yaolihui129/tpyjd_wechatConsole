package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.feedback.controllers.FeedbackController;

public class FeedbackRoutes extends Routes {

	@Override
	public void config() {
		add("/data/feedback", FeedbackController.class);
	}

}
