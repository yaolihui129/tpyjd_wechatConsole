package cn.pacificimmi.project.controllers;

import java.util.Date;
import java.util.List;

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
public class ProjectWebIntroduceController extends Controller {
	
	/**
	 * 项目介绍
	 */
	public void index() {
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(null != id && !id.isEmpty()) {
			String operation = pp.getAllStr("operation");
			if(null != operation) {
				Project project = Project.dao.findById(id);
				
				String web_introduce = pp.getFieldName("web_introduce");
				if(StringUtil.notEmpty(web_introduce)) {
					project.set("web_introduce", web_introduce);
					project.update();
					this.setAttr("status", 1);
				} else {
					if(!project.getProjectStatus().equals(PropKit.use("constants.txt").get("project_status_sx"))) {
						project.set("web_introduce", null);
						project.update();
						this.setAttr("status", 1);
					} else {
						this.setAttr("msg", "当前项目为发布状态，不允许全部删除！");
					}
				}
				Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+project.getProjectId());
				
				this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
				this.setAttr("subProject", subProject);
				this.setAttr("project", project);
				this.setAttr("operation", "编辑");
				this.render("/views/project/project_web_introduce.jsp");
			} else {
				/**
				 * 初始化页面
				 */
				Project project = Project.dao.findById(pp.getId());
				if(project != null) {
					Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+project.getProjectId());
					
					this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
					this.setAttr("subProject", subProject);
					this.setAttr("project", project);
					this.setAttr("operation", "编辑");
					this.render("/views/project/project_web_introduce.jsp");
				} else {
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
}
