package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.common.models.ProjectResource;
import cn.pacificimmi.project.controllers.ProjectApplyConditionController;
import cn.pacificimmi.project.controllers.ProjectApplyProcessController;
import cn.pacificimmi.project.controllers.ProjectBaseController;
import cn.pacificimmi.project.controllers.ProjectCostController;
import cn.pacificimmi.project.controllers.ProjectDetailsApplycController;
import cn.pacificimmi.project.controllers.ProjectDetailsApplypController;
import cn.pacificimmi.project.controllers.ProjectDetailsController;
import cn.pacificimmi.project.controllers.ProjectDetailsCostController;
import cn.pacificimmi.project.controllers.ProjectDetailsIntroController;
import cn.pacificimmi.project.controllers.ProjectDetailsMaterialController;
import cn.pacificimmi.project.controllers.ProjectDetailsResourceController;
import cn.pacificimmi.project.controllers.ProjectDetailsSubProjectController;
import cn.pacificimmi.project.controllers.ProjectMaterialController;
import cn.pacificimmi.project.controllers.ProjectResourceController;
import cn.pacificimmi.project.controllers.ProjectWebIntroduceController;
import cn.pacificimmi.project.controllers.ProjectsController;
import cn.pacificimmi.project.controllers.SubProjectController;


public class ProjectRoutes extends Routes {

	@Override
	public void config() {
		add("/project", ProjectsController.class);
		add("/project/base", ProjectBaseController.class);
		add("/project/intro", ProjectWebIntroduceController.class);
		add("/project/applyc", ProjectApplyConditionController.class);
		add("/project/applyp", ProjectApplyProcessController.class);
		add("/project/cost", ProjectCostController.class);
		add("/project/material", ProjectMaterialController.class);
		add("/project/resource", ProjectResourceController.class);
		add("/project/subProject", SubProjectController.class);
		
		add("/project/details", ProjectDetailsController.class);
		add("/project/details/intro", ProjectDetailsIntroController.class);
		add("/project/details/applyc", ProjectDetailsApplycController.class);
		add("/project/details/applyp", ProjectDetailsApplypController.class);
		add("/project/details/cost", ProjectDetailsCostController.class);
		add("/project/details/material", ProjectDetailsMaterialController.class);
		add("/project/details/resource", ProjectDetailsResourceController.class);
		add("/project/details/subProject", ProjectDetailsSubProjectController.class);
	}

}
