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
import cn.pacificimmi.common.models.ProjectResource;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.project.models.view.ProjectResourceInfo;

@Before(LoginInterCeptor.class)
public class ProjectResourceController extends Controller {
	
	/**
	 * 资源列表
	 */
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
		
		Long subProject = Db.queryLong("select count(cp.project_id) from crm_project cp where cp.delete_flag=0 and cp.project_pid ="+id);
		
		this.setAttr("subProject", subProject);
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.setAttr("projectId", id);
		this.renderJsp("/views/project/project_resource.jsp");
	}
	
	/**
	 * 保存
	 */
	public void add() {
		ParamsParser pp = new ParamsParser(this);
		ProjectResource pr = new ProjectResource();
		String project_resource_id = pp.getAllStr("project_resource_id");
		if(StringUtil.notEmpty(project_resource_id)) {
			pr = ProjectResource.dao.findById(project_resource_id);
		}
		String project_id = pp.getAllStr("project_id");
		if(StringUtil.notEmpty(project_id)) {
			pr.set("project_id", project_id);
		} else {
			pr.set("project_id", null);
		}
		String title = pp.getAllStr("title");
		if(StringUtil.notEmpty(title)) {
			pr.set("title", title);
		} else {
			pr.set("title", null);
		}
		String media_type = pp.getAllStr("media_type");
		if(StringUtil.notEmpty(media_type)){
			pr.set("media_type", media_type);
		} else {
			pr.set("media_type", null);
		}
		String url = this.getPara("url");
		if(StringUtil.notEmpty(url)) {
			pr.set("url", url);
		} else {
			pr.set("url", null);
		}
		String description = pp.getAllStr("description");
		if(StringUtil.notEmpty(description)) {
			pr.set("description", description);
		} else {
			pr.set("description", null);
		}
		String size = pp.getAllStr("size");
		if(StringUtil.notEmpty(size)) {
			pr.set("size", size);
		} else {
			pr.set("size", null);
		}
		
		if(StringUtil.notEmpty(project_resource_id)) {
			pr.update();
		} else {
			pr.setDeleteFlag(0);
			ProjectResource pre = ProjectResource.dao.findFirst("select * from crm_project_resource where project_id = "+
					project_id+" and delete_flag = 0 order by priority desc limit 1");
			Integer priority = (pre==null)?0:pre.getPriority()+1;
			pr.setPriority(priority);
			pr.save();
		}
		this.redirect("/project/resource/"+project_id);
	}
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove() {
		Map<String, Object> map = new HashMap<String, Object>();
		ProjectResourceParams prp = new ProjectResourceParams(this);
		String ids = prp.getIds();
		if(ids != null) {
			String sql = "update crm_project_resource set delete_flag = 1 where project_resource_id in("+ids+")";
			Db.update(sql);
			map.put("status", 0);
			map.put("msg", "删除成功");
			this.renderJson(map);
		} else {
			map.put("status", 1);
			map.put("msg", "参数错误");
			this.renderJson(map);
		}
	}
	
	/**
	 * 更新优先级
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void priority() {
		ParamsParser pp = new ParamsParser(this);
		String order = pp.getAllStr("order");
		String id = pp.getId();
		int status=0;
		String msg="操作成功";
		ProjectResource pr = ProjectResource.dao.findById(id);
		Integer pry = pr.getPriority();
		if(null != order && !"".equals(order)) {
			if(order.equals("up")) {
				ProjectResource nowPr = ProjectResource.dao.findFirst("SELECT * from crm_project_resource where project_id = "+
						pr.getProjectId()+" and priority < "+pr.getPriority()+" and delete_flag = 0 order by priority desc limit 1");
				if(null != nowPr) {
					pr.setPriority(nowPr.getPriority());
					nowPr.setPriority(pry);
					
					nowPr.update();
					pr.update();
					status=0;
				} else {
					status=1;
					msg="无法上移，排序已是最上";
				}
			} else if(order.equals("down")) {
				ProjectResource nowPr = ProjectResource.dao.findFirst("SELECT * from crm_project_resource where project_id = "+
						pr.getProjectId()+" and priority > "+pr.getPriority()+" and delete_flag = 0 order by priority asc limit 1");
				if(null != nowPr) {
					pr.setPriority(nowPr.getPriority());
					nowPr.setPriority(pry);
					
					nowPr.update();
					pr.update();
					status=0;
				} else {
					status=1;
					msg="无法下移，排序已是最下";
				}
			} else if(order.equals("top")) {
				List<ProjectResource> list = ProjectResource.dao.find("SELECT * from crm_project_resource where project_id = "+
						pr.getProjectId()+" and priority < "+pr.getPriority()+" and delete_flag = 0 order by priority asc");
				if(null != list && list.size()>0) {
					for(ProjectResource pre : list) {
						pre.setPriority(pre.getPriority()+1);
						pre.update();
					}
					pr.setPriority(0);
					pr.update();
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
