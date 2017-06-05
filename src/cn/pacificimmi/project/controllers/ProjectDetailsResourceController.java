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
import cn.pacificimmi.project.controllers.ProjectResourceController.ProjectResourceParams;
import cn.pacificimmi.project.models.view.ProjectCostInfo;
import cn.pacificimmi.project.models.view.ProjectResourceInfo;

@Before(LoginInterCeptor.class)
public class ProjectDetailsResourceController extends Controller {

	public void index() {
		ProjectResourceParams prp = new ProjectResourceParams(this);
		String id = prp.getId();
		
		Page<Record> page = Db.paginate(prp.getPageNum(), prp.getPageSize(), prp.getSelectStr(), prp.getFromStr());
		List<Record> list = page.getList();
		List<ProjectResourceInfo> result = new ArrayList<ProjectResourceInfo>();
		for(Record rd : list) {
			ProjectResourceInfo pri = new ProjectResourceInfo();
			pri.bindingData(pri, rd);
			result.add(pri);
		}
		setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(prp.getPageNum(), 
				page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		setAttr("projectId", id);
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("subProject", subProject);
		this.renderJsp("/views/project/details/project_resource.jsp");
	}
	
	
	public class ProjectResourceParams extends ParamsParser {

		public ProjectResourceParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("select cpr.*, cd.name as media_name ");
			this.setFromStr(" FROM crm_project_resource cpr LEFT JOIN console_dictionary cd ON cpr.media_type = cd.dict_code ");
			String project_id = this.getId();
			if(null != project_id) {
				this.addWhereSegmentByAnd("cpr.project_id = "+project_id);
			} else {
				this.addWhereSegmentByAnd("cpr.project_id = -1");
			}
			this.addWhereSegmentByAnd("cpr.delete_flag = 0");
			this.setDefaultOrderStr("order by cpr.priority asc");
		}
	}
}
