package cn.pacificimmi.project.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.models.ProjectCost;
import cn.pacificimmi.project.models.view.ProjectCostInfo;

@Before(LoginInterCeptor.class)
public class ProjectDetailsApplycController extends Controller {

	public void index() {
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(null != id && !id.isEmpty()) {
			/**
			 * 初始化页面
			 */
			Project project = Project.dao.findById(pp.getId());
			if(project != null) {
				
				Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+project.getProjectId());
				
				this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
				this.setAttr("subProject", subProject);
				this.setAttr("project", project);
				this.render("/views/project/details/project_apply_condition.jsp");
			} else {
				this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
}
