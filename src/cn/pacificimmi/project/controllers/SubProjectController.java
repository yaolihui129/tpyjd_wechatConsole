package cn.pacificimmi.project.controllers;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.project.models.view.ProjectInfo;

@Before(LoginInterCeptor.class)
public class SubProjectController  extends Controller {
	/**
	 * 二级项目
	 */
	public void index() {
		ProjectParams pp = new ProjectParams(this);
		/**
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
		List<Record> list = page.getList();
		List<ProjectInfo> result = new ArrayList<ProjectInfo>();
		for(Record rd : list) {
			ProjectInfo pi = new ProjectInfo();
			pi.bindingData(pi, rd);
			
			List<Record> exList = Db.find("SELECT "+
												"* "+
											"FROM "+
												"crm_project_expands cp "+
											"LEFT JOIN ( "+
												"SELECT "+
													"cd.dict_code, "+
													"cd. NAME "+
												"FROM "+
													"console_dictionary cd "+
											") cdy ON cp.dict_code = cdy.dict_code "+
											"WHERE "+
												"cp.project_id = "+pi.getProject_id());
			
			if(exList.size()>0) {
				String str = "";
				for(int i=0; i<exList.size(); i++) {
					if(i==0) {
						str=exList.get(0).getStr("NAME");
					} else {
						str+=", "+exList.get(i).getStr("NAME");
					}
				}
				if(!"".equals(str)) {
					pi.setProject_expands_name(str);
				}
			}
			result.add(pi);
		}
		
		List<Dict> expandsList = DictionaryManager.getInstance().
				getAllSubDictionaries(PropKit.use("constants.txt").get("project_expands"), 1).getSubDictionaries();
		this.setAttr("expandsList", expandsList);
		this.setAttr("list", result);
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		this.setAttr("page", page.getTotalPage());
		this.setAttr("now", pp.getPageNum());
		this.setAttr("projectId", pp.getId());
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.renderJsp("/views/project/sub_projects.jsp");
	}
	
	private class ProjectParams extends ParamsParser {

		public ProjectParams(Controller ct) {
			super(ct);
			
			/**
			 * 处理传入参数
			 */
			this.setSelectStr("select * ");
			
			this.setFromStr("FROM "+
					"( "+
						"SELECT "+
							"*, "+
							"(select name from console_dictionary where delete_flag=0 and dict_code=country)country_name, "+
							"(select name from console_dictionary where delete_flag=0 and dict_code=project_status)project_status_name, "+
							"(select name from console_dictionary where delete_flag=0 and dict_code=project_type)project_type_name, "+
							"(select name from console_dictionary where delete_flag=0 and dict_code=city)city_name, "+
							"(select name from console_dictionary where delete_flag=0 and dict_code=project_level)project_level_name "+
						"FROM "+
							"crm_project "+
						"LEFT JOIN ( "+
							"SELECT "+
								"c.user_id, "+
								"c.login_name AS create_user_name "+
							"FROM "+
								"console_user c "+
						") cu ON crm_project.create_user = cu.user_id "+
					") proj");
			
			//过滤条件
			
			String projectId = this.getId();
			if(StringUtil.notEmpty(projectId)) {
				this.addWhereSegmentByAnd("proj.project_pid="+projectId);
			}
			
			this.addWhereSegmentByAnd("proj.delete_flag = 0");
			this.setDefaultOrderStr("order by proj.priority desc");
		}
	}
}
