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
import cn.pacificimmi.common.models.ProjectApplyProcess;
import cn.pacificimmi.common.models.ProjectCost;
import cn.pacificimmi.project.models.view.ProjectCostInfo;
import cn.pacificimmi.project.models.view.ProjectMaterialInfo;

@Before(LoginInterCeptor.class)
public class ProjectDetailsMaterialController extends Controller {

	public void index() {
		ProjectMaterialParams pm = new ProjectMaterialParams(this);
		String id = pm.getId();
		
		Page<Record> page = Db.paginate(pm.getPageNum(), pm.getPageSize(), pm.getSelectStr(), pm.getFromStr());
		List<Record> list = page.getList();
		List<ProjectMaterialInfo> result = new ArrayList<ProjectMaterialInfo>();
		for(Record rd : list) {
			ProjectMaterialInfo pmi = new ProjectMaterialInfo();
			pmi.bindingData(pmi, rd);
			result.add(pmi);
		}
		this.setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(
				pm.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		
		List<ProjectApplyProcess> papList = ProjectApplyProcess.dao.find(
				"select * from crm_project_apply_process where delete_flag = 0 and project_id = "+id);
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("subProject", subProject);
		this.setAttr("papList", papList);
		this.setAttr("pageBar",pagesView);
		this.setAttr("projectId", id);
		this.render("/views/project/details/project_material.jsp");
	}
	
	
	private class ProjectMaterialParams extends ParamsParser {

		public ProjectMaterialParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("select * ");
			this.setFromStr("from crm_project_material left join "+
					"(select p.project_apply_process_id as projectApplyProcessId, p.name as apply_process_name from crm_project_apply_process p) cpap "+
					"on crm_project_material.project_apply_process_id = cpap.projectApplyProcessId");
			
			String project_id = this.getId();
			if(null != project_id) {
				this.addWhereSegmentByAnd(" project_id = "+project_id);
			}
			
			this.addWhereSegmentByAnd("delete_flag = 0");
			this.setDefaultOrderStr("order by project_apply_process_id asc, priority asc");
		}
	}
}
