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
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.project.models.view.ProjectApplyProcessInfo;

@Before(LoginInterCeptor.class)
public class ProjectApplyProcessController extends Controller {
	/**
	 * 办理流程列表
	 */
	public void index() {
		ProjectApplyProcessParams pa = new ProjectApplyProcessParams(this);
		String id = pa.getId();
		
		Page<Record> page = Db.paginate(pa.getPageNum(), pa.getPageSize(), pa.getSelectStr(), pa.getFromStr());
		List<Record> list = page.getList();
		List<ProjectApplyProcessInfo> result = new ArrayList<ProjectApplyProcessInfo>();
		for(Record rd : list) {
			ProjectApplyProcessInfo ppi = new ProjectApplyProcessInfo();
			ppi.bindingData(ppi, rd);
			result.add(ppi);
		}
		this.setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(pa.getPageNum(), 
				page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("subProject", subProject);
		this.setAttr("projectId", id);
		this.renderJsp("/views/project/project_apply_process.jsp");
	}
	
	/**
	 * 保存
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		ProjectApplyProcess pap = new ProjectApplyProcess();
		
		String project_apply_process_id = pp.getAllStr("project_apply_process_id");
		if(StringUtil.notEmpty(project_apply_process_id)) {
			pap = ProjectApplyProcess.dao.findById(project_apply_process_id);
		}
		
		String project_id = pp.getAllStr("project_id");
		if(StringUtil.notEmpty(project_id)) {
			pap.set("project_id", project_id);
		} else {
			pap.set("project_id", null);
		}
		
		String name = pp.getAllStr("name");
		if(StringUtil.notEmpty(name)) {
			pap.set("name", name);
		} else {
			pap.set("name", null);
		}
		String cycle = pp.getAllStr("cycle");
		if(StringUtil.notEmpty(cycle)) {
			pap.set("cycle", cycle);
		} else {
			pap.set("cycle", null);
		}
		String content = pp.getAllStr("content");
		if(StringUtil.notEmpty(content)) {
			pap.set("content", content);
		} else {
			pap.set("content", null);
		}
		if(StringUtil.notEmpty(project_apply_process_id)) {
			pap.update();
		} else {
			pap.set("delete_flag", 0);
			ProjectApplyProcess nowPap = ProjectApplyProcess.dao.findFirst("select * from crm_project_apply_process where project_id = "+
					project_id+" and delete_flag = 0 order by priority desc limit 1");
			Integer priority = (nowPap == null)?0:nowPap.getPriority()+1;
			pap.setPriority(priority);
			pap.save();
		}
		this.redirect("/project/applyp/"+project_id);
	}
	
	/**
	 * 删除
	 * @author yang
	 *
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove() {
		Map<String, Object> map = new HashMap<String, Object>();
		ProjectApplyProcessParams pap = new ProjectApplyProcessParams(this);
		String ids = pap.getIds();
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
							"crm_project_apply_process "+
						"WHERE "+
							"project_apply_process_id = "+ay[0]+")");
			
			if(StringUtil.notEmpty(project.getProjectStatus()) && 
					project.getProjectStatus().equals(PropKit.use("constants.txt").get("project_status_sx"))) {
				List<ProjectApplyProcess> papList = 
						ProjectApplyProcess.dao.find("select * from crm_project_apply_process where delete_flag=0 and project_id="+project.getProjectId());
				int len = ay.length+1;
				if(len>papList.size()) {
					map.put("status", 1);
					map.put("msg", "当前项目为发布状态，不允许全部删除！");
					this.renderJson(map);
				} else {
					String sql = "update crm_project_apply_process set delete_flag = 1 where project_apply_process_id in("+ids+")";
					Db.update(sql);
					map.put("status", 0);
					map.put("msg", "删除成功");
					this.renderJson(map);
				}
			} else {
				String sql = "update crm_project_apply_process set delete_flag = 1 where project_apply_process_id in("+ids+")";
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
		ProjectApplyProcess pci = ProjectApplyProcess.dao.findById(id);
		Integer pr = pci.getPriority();
		
		if(StringUtil.notEmpty(order)) {
			if(order.equals("up")) {
				ProjectApplyProcess nowPC = ProjectApplyProcess.dao.findFirst("SELECT * from crm_project_apply_process where project_id = "+
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
				ProjectApplyProcess nowPC = ProjectApplyProcess.dao.findFirst("SELECT * from crm_project_apply_process where project_id = "+
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
				List<ProjectApplyProcess> list = ProjectApplyProcess.dao.find("SELECT * from crm_project_apply_process where project_id = "+
						pci.getProjectId()+" and priority < "+pci.getPriority()+" and delete_flag = 0 order by priority asc");
				if(null != list && list.size()>0) {
					for(ProjectApplyProcess pc : list) {
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
	
	private class ProjectApplyProcessParams extends ParamsParser {

		public ProjectApplyProcessParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("select * ");
			this.setFromStr(" from crm_project_apply_process");
			
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
