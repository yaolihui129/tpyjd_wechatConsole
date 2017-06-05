package cn.pacificimmi.project.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.models.ProjectApplyProcess;
import cn.pacificimmi.common.models.ProjectCost;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.project.models.view.ProjectCostInfo;

@Before(LoginInterCeptor.class)
public class ProjectCostController extends Controller {

	/**
	 * 项目费用
	 */
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
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("subProject", subProject);
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));		
		this.setAttr("projectId", id);
		this.renderJsp("/views/project/project_cost.jsp");
	}
	
	
	/**
	 * 新增
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		ProjectCost pc = new ProjectCost();
		
		String project_cost_id = pp.getAllStr("project_cost_id");
		if(StringUtil.notEmpty(project_cost_id)) {
			pc = ProjectCost.dao.findById(project_cost_id);
		} 
		String project_id = pp.getAllStr("project_id");
		if(StringUtil.notEmpty(project_id)) {
			pc.set("project_id", project_id);
		} else {
			pc.set("project_id", null);
		}
		
		String name = pp.getAllStr("name");
		if(StringUtil.notEmpty(name)) {
			pc.set("name", name);
		} else {
			pc.set("name", null);
		}
		
		String institution = pp.getAllStr("institution");
		if(StringUtil.notEmpty(institution)) {
			pc.set("institution", institution);
		} else {
			pc.set("institution", null);
		}
		
		String cost = pp.getAllStr("cost");
		if(StringUtil.notEmpty(cost)) {
			pc.set("cost", cost);
		} else {
			pc.set("cost", null);
		}
		
		String charge_stage = pp.getAllStr("charge_stage");
		if(StringUtil.notEmpty(charge_stage)) {
			pc.set("charge_stage", charge_stage);
		} else {
			pc.set("charge_stage", null);
		}
		
		String refund_standard = pp.getAllStr("refund_standard");
		if(StringUtil.notEmpty(refund_standard)) {
			pc.set("refund_standard", refund_standard);
		} else {
			pc.set("refund_standard", null);
		}
		
		if(StringUtil.notEmpty(project_cost_id)) {
			pc.update();
		} else {
			pc.set("delete_flag", 0);
			ProjectCost pct = ProjectCost.dao.findFirst("select * from crm_project_cost where project_id = "+
					project_id+" and delete_flag = 0 order by priority desc limit 1");
			Integer priority = (pct == null)?0:pct.getPriority()+1;
			pc.setPriority(priority);
			pc.save();
		}
		this.redirect("/project/cost/"+project_id);
	}
	

	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove() {
		Map<String, Object> map = new HashMap<String, Object>();
		ProjectCostParams pc = new ProjectCostParams(this);
		String ids = pc.getIds();
		
		if(ids != null) {
			String[] ay = ids.split(",");
			Project project = Project.dao.findFirst("SELECT "+
						"project_id, "+
						"project_status "+
					"FROM "+
						"crm_project "+
					"WHERE "+
						"delete_flag = 0 "+
					"AND project_id = ( "+
						"SELECT "+
							"project_id "+
						"FROM "+
							"crm_project_cost "+
						"WHERE "+
							"project_cost_id = "+ay[0]+")");
			
			if(StringUtil.notEmpty(project.getProjectStatus()) && 
					project.getProjectStatus().equals(PropKit.use("constants.txt").get("project_status_sx"))) {
				List<ProjectCost> pcList = 
						ProjectCost.dao.find("select * from crm_project_cost where delete_flag=0 and project_id="+project.getProjectId());
				int len = ay.length+1;
				if(len>pcList.size()) {
					map.put("status", 1);
					map.put("msg", "当前项目为发布状态，不允许全部删除！");
					this.renderJson(map);
				} else {
					String sql = "update crm_project_cost set delete_flag = 1 where project_cost_id in("+ids+")";
					Db.update(sql);
					map.put("status", 0);
					map.put("msg", "删除成功");
					this.renderJson(map);
				}
			} else {
				String sql = "update crm_project_cost set delete_flag = 1 where project_cost_id in("+ids+")";
				Db.update(sql);
				map.put("status", 0);
				map.put("msg", "删除成功");
				this.renderJson(map);
			}
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
			this.renderJson(map);
		}
	}
	
	//更新优先级
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void priority() {
		ParamsParser pp = new ParamsParser(this);
		String order = pp.getAllStr("order");
		String id = pp.getId();
		int status=0;
		String msg="操作成功";
		ProjectCost pci = ProjectCost.dao.findById(id);
		Integer pr = pci.getPriority();
		
		if(null != order && !"".equals(order)) {
			if(order.equals("up")) {
				ProjectCost nowPC = ProjectCost.dao.findFirst("SELECT * from crm_project_cost where project_id = "+
						pci.getProjectId()+" and priority < "+pci.getPriority()+" and delete_flag = 0 order by priority desc limit 1");
				
				if(null != nowPC) {
					pci.setPriority(nowPC.getPriority());
					nowPC.setPriority(pr);
					
					nowPC.update();
					pci.update();
					status=0;
				} else {
					status=1;
					msg="无法上移，排序已是最上";
				}
			} else if(order.equals("down")) {
				ProjectCost nowPC = ProjectCost.dao.findFirst("SELECT * from crm_project_cost where project_id = "+
						pci.getProjectId()+" and priority > "+pci.getPriority()+" and delete_flag = 0 order by priority asc limit 1");
				if(null != nowPC) {
					pci.setPriority(nowPC.getPriority());
					nowPC.setPriority(pr);
					
					nowPC.update();
					pci.update();
					status=0;
				} else {
					status=1;
					msg="无法下移，排序已是最下";
				}
			} else if(order.equals("top")) {
				List<ProjectCost> list = ProjectCost.dao.find("SELECT * from crm_project_cost where project_id = "+
						pci.getProjectId()+" and priority < "+pci.getPriority()+" and delete_flag = 0 order by priority asc");
				if(null != list && list.size()>0) {
					for(ProjectCost pc : list) {
						pc.setPriority(pc.getPriority()+1);
						pc.update();
					}
					pci.setPriority(0);
					pci.update();
					status=0;
				} else {
					status=1;
					msg="无法置顶，排序已是最上";
				}
			}
		} 
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("order", order);
		map.put("status", status);
		map.put("msg", msg);
		this.renderJson(map);
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
