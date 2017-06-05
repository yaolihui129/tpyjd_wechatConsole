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
import cn.pacificimmi.common.models.ProjectMaterial;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.project.models.view.ProjectMaterialInfo;

@Before(LoginInterCeptor.class)
public class ProjectMaterialController extends Controller {
	
	/**
	 * 材料清单列表
	 */
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
		
		setAttr("papList", papList);
		setAttr("pageBar",pagesView);
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("subProject", subProject);
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("projectId", id);
		this.renderJsp("/views/project/project_material.jsp");
	}
	
	
	/**
	 * 新增
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		ProjectMaterial pm = new ProjectMaterial();
		
		String project_material_id = pp.getAllStr("project_material_id");
		if(StringUtil.notEmpty(project_material_id)) {
			pm = ProjectMaterial.dao.findById(project_material_id);
		}
		
		String project_id = pp.getAllStr("project_id");
		if(StringUtil.notEmpty(project_id)) {
			pm.set("project_id", project_id);
		} else {
			pm.set("project_id", null);
		}
		String name = pp.getAllStr("name");
		if(StringUtil.notEmpty(name)) {
			pm.set("name", name);
		} else {
			pm.set("name", null);
		}
		String description = pp.getAllStr("description");
		if(StringUtil.notEmpty(description)) {
			pm.set("description", description);
		} else {
			pm.set("description", null);
		}
		String swatch_url = this.getPara("swatch_url");
		if(StringUtil.notEmpty(swatch_url)) {
			pm.set("swatch_url", swatch_url);
		} else {
			pm.set("swatch_url", null);
		}
		String swatch_name = this.getPara("swatch_name");
		if(StringUtil.notEmpty(swatch_name)) {
			pm.set("swatch_name", swatch_name);
		} else {
			pm.set("swatch_name", null);
		}
		String material_type = this.getPara("material_type");
		if(StringUtil.notEmpty(material_type)) {
			pm.set("material_type", material_type);
		} else {
			pm.set("material_type", null);
		}
		
		
		if(StringUtil.notEmpty(project_material_id)) {
			String project_apply_process_id = pp.getAllStr("project_apply_process_id");
			if(StringUtil.notEmpty(project_apply_process_id) &&
					!project_apply_process_id.equals(pm.getProjectApplyProcessId()+"")) {
				pm.set("project_apply_process_id", project_apply_process_id);
				
				ProjectMaterial pml = ProjectMaterial.dao.findFirst("select * from crm_project_material where project_id = "+
						project_id+" and project_apply_process_id = "+project_apply_process_id+" and delete_flag = 0 order by priority desc limit 1");
				Integer priority = (pml == null)?0:pml.getPriority()+1;
				pm.setPriority(priority);
			}
			pm.update();
		} else {
			String project_apply_process_id = pp.getAllStr("project_apply_process_id");
			if(StringUtil.notEmpty(project_apply_process_id)) {
				pm.set("project_apply_process_id", project_apply_process_id);
			}
			ProjectMaterial pml = ProjectMaterial.dao.findFirst("select * from crm_project_material where project_id = "+
					project_id+" and project_apply_process_id = "+project_apply_process_id+" and delete_flag = 0 order by priority desc limit 1");
			Integer priority = (pml == null)?0:pml.getPriority()+1;
			pm.setPriority(priority);
			pm.set("delete_flag", 0);
			pm.save();
		}
		this.redirect("/project/material/"+project_id);
	}
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove() {
		Map<String, Object> map = new HashMap<String, Object>();
		ProjectMaterialParams pm = new ProjectMaterialParams(this);
		String ids = pm.getIds();
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
							"crm_project_material "+
						"WHERE "+
							"project_material_id = "+ay[0]+")");
			
			if(StringUtil.notEmpty(project.getProjectStatus()) && 
					project.getProjectStatus().equals(PropKit.use("constants.txt").get("project_status_sx"))) {
				List<ProjectMaterial> pmList = 
						ProjectMaterial.dao.find("select * from crm_project_material where delete_flag=0 and project_id="+project.getProjectId());
				int len = ay.length+1;
				if(len>pmList.size()) {
					map.put("status", 1);
					map.put("msg", "当前项目为发布状态，不允许全部删除！");
					this.renderJson(map);
				} else {
					String sql = "update crm_project_material set delete_flag = 1 where project_material_id in("+ids+")";
					Db.update(sql);
					map.put("status", 0);
					map.put("msg", "删除成功");
					this.renderJson(map);
				}
			} else {
				String sql = "update crm_project_material set delete_flag = 1 where project_material_id in("+ids+")";
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
	
	/**
	 * 更新优先级
	 * @author yang
	 *
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void priority() {
		ParamsParser pp = new ParamsParser(this);
		String order = pp.getAllStr("order");
		String id = pp.getId();
		int status=0;
		String msg="操作成功";
		ProjectMaterial pm = ProjectMaterial.dao.findById(id);
		Integer pr = pm.getPriority();
		
		if(null != order && !"".equals(order)) {
			if(order.equals("up")) {
				ProjectMaterial nowPC = ProjectMaterial.dao.findFirst("SELECT * from crm_project_material where project_id = "+
						pm.getProjectId()+" and priority < "+pm.getPriority()+" and project_apply_process_id = "+pm.getProjectApplyProcessId()+
						" and delete_flag = 0 order by priority desc limit 1");
				
				if(null != nowPC) {
					pm.setPriority(nowPC.getPriority());
					nowPC.setPriority(pr);
					
					nowPC.update();
					pm.update();
					status=0;
				} else {
					status=1;
					msg="无法上移，排序已是最上";
				}
			} else if(order.equals("down")) {
				ProjectMaterial nowPC = ProjectMaterial.dao.findFirst("SELECT * from crm_project_material where project_id = "+
						pm.getProjectId()+" and priority > "+pm.getPriority()+" and project_apply_process_id = "+pm.getProjectApplyProcessId()+
						" and delete_flag = 0 order by priority asc limit 1");
				if(null != nowPC) {
					pm.setPriority(nowPC.getPriority());
					nowPC.setPriority(pr);
					
					nowPC.update();
					pm.update();
					status=0;
				} else {
					status=1;
					msg="无法下移，排序已是最下";
				}
			} else if(order.equals("top")) {
				List<ProjectMaterial> list = ProjectMaterial.dao.find("SELECT * from crm_project_material where project_id = "+
						pm.getProjectId()+" and priority < "+pm.getPriority()+" and project_apply_process_id = "+pm.getProjectApplyProcessId()+
						" and delete_flag = 0 order by priority asc");
				if(null != list && list.size()>0) {
					for(ProjectMaterial pc : list) {
						pc.setPriority(pc.getPriority()+1);
						pc.update();
					}
					pm.setPriority(0);
					pm.update();
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
