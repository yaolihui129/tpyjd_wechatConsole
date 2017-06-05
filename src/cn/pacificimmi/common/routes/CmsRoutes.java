package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.activity.controlers.ActivityController;
import cn.pacificimmi.activity.controlers.ActivitysController;
import cn.pacificimmi.activity.controlers.SignsController;
import cn.pacificimmi.section.controllers.ArticleInfoController;
import cn.pacificimmi.section.controllers.ImageInfoController;
import cn.pacificimmi.section.controllers.InformationController;
import cn.pacificimmi.section.controllers.SectionController;
import cn.pacificimmi.topic.controllers.TopicController;
import cn.pacificimmi.topic.controllers.TopicsController;

public class CmsRoutes extends Routes {

	@Override
	public void config() {
		add("/cms/topics",TopicsController.class);
		add("/cms/topics/topic",TopicController.class);
		add("/cms/section",SectionController.class);//栏目管理
		add("/cms/imageinfo",ImageInfoController.class);//图片资讯
		add("/cms/articleinfo",ArticleInfoController.class);//文章资讯
		add("/cms/information",InformationController.class);//资讯发布,合并图片资讯和文章资讯
		add("/cms/activitys",ActivitysController.class); //专享活动列表
		add("/cms/activitys/activity",ActivityController.class);//专享活动修改
		add("/cms/activitys/signs",SignsController.class);//专享活动报名
	}

}
