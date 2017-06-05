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
public class ProjectDetailsCostController extends Controller {

	public void index() {
		ProjectCostParams pp = new ProjectCostParams(this);
		String id = pp.getId();
		
		Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<Record> list = page.getList();
		List<ProjectCostInfo> result = new ArrayList<ProjectCostInfo>();
		for(Record rd : list) {
			ProjectCostInfo pci = new ProjectCostInfo();
			pci.bindingData(pci, rd);
			result.add(pci);
		}
		this.setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		setAttr("projectId", id);
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("subProject", subProject);
		this.render("/views/project/details/project_cost.jsp");
	}
	
	
	private class ProjectCostParams extends ParamsParser {
		
		public  ProjectCostParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("select * ");
			this.setFromStr("from crm_project_cost ");
			
			String project_id = this.getId();
			if(null != project_id) {
				this.addWhereSegmentByAnd("project_id = "+project_id);
			} else {
				this.addWhereSegmentByAnd("project_id = -1");
			}
			
			this.addWhereSegmentByAnd("delete_flag = 0");
			this.setDefaultOrderStr("order by priority asc");
		}
		
	}
}
