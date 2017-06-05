package cn.pacificimmi.project.controllers;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.utils.StringUtil;

@Before(LoginInterCeptor.class)
public class ProjectDetailsIntroController extends Controller{
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
				this.render("/views/project/details/project_web_introduce.jsp");
			} else {
				this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
}
