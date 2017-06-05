package cn.pacificimmi.team.controller;

import java.util.ArrayList;
import java.util.Date;
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
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Orgnization;
import cn.pacificimmi.common.models.ProfessionalTeam;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.StringUtil;
/**
 * @version pacific 1.0.0
 * @author jeff
 * @date : 2016年10月27日 上午11:38:49
 * @category 专业团队
 **/
@Before(LoginInterCeptor.class)
public class TeamController extends Controller {

	public void index() {
			TeamParams sp = new TeamParams(this);
			sp.setPageSize(20);
			/***
			 * 获取数据列表
			 */
			Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
			List<Record> users = page.getList();
			
			this.setAttr("statusList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("publish_status"), 1).getSubDictionaries());
			this.setAttr("teamTypeList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("team_type"), 1).getSubDictionaries());
			/***
			 * 保存数据列表
			 */
			this.setAttr("list", users); 
			
			/***
			 * 保存翻页
			 */
			String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			/**
			 * 渲染视图
			 */
			this.renderJsp("/views/team/team_users.jsp");
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void pub(){
		TeamParams sp = new TeamParams(this);
		Map<String,Object> rst = new HashMap<String,Object>(); 
		if(!sp.getIds().isEmpty()){
			String id = sp.getIds();
			Record r = Db.findFirst("select * from crm_professional_team where team_id="+id);
			if(r!=null){
				String release_mark = r.getStr("release_mark");
				if(release_mark.equals("未发布")){
					Db.update("update crm_professional_team set release_mark='已发布' where team_id="+id);
					rst.put("status", 0);
					rst.put("msg", "发布成功！");
					this.renderJson(rst);
				}
				else if(release_mark.equals("已发布")){
					Db.update("update crm_professional_team set release_mark='已下线' where team_id="+id);
					rst.put("status", 0);
					rst.put("msg", "下线成功！");
					this.renderJson(rst);
				}
			}
			else{
				rst.put("status", 100);
				rst.put("msg", "操作失败");
				this.renderJson(rst);
			}
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "操作失败");
			this.renderJson(rst);
		}
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove(){
		TeamParams sp = new TeamParams(this);
		Map<String,Object> rst = new HashMap<String,Object>(); 
		if(!sp.getIds().isEmpty()){
			String ids = sp.getIds();
//			ProfessionalTeam pt = ProfessionalTeam.dao.findById(ids);
//			if(pt.getIndexShow()==0){
		 		Db.update("delete from crm_professional_team where team_id in ("+ids+")");
		 		
		 		rst.put("status", 0);
				rst.put("msg", "删除成功！");
				this.renderJson(rst);
//			}
//			else{
//				rst.put("status", 100);
//				rst.put("msg", "首页推荐的人员不允许删除！");
//				this.renderJson(rst);
//			}
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "删除失败");
			this.renderJson(rst);
		}
	}

	
	/**
	 * 获取当前管家 的部门结构列 例如:北京>顾问中心>顾问一部
	 * @param code
	 * @param table
	 * @param code_field
	 * @return
	 */
	private String getOrgnizationLineName(String dep_id){
		String orgnizName="";
		String sqlOne="SELECT * FROM  console_orgnization WHERE org_id='"+dep_id+"'";
		Orgnization orgnization = Orgnization.dao.findFirst(sqlOne);
		if(null!=orgnization)
		if(null!=orgnization.getOrgPcode()){
			String parentOrgnizationCode = getParentOrgnizationCode(orgnization);
			orgnizName=parentOrgnizationCode;
		}
		return orgnizName;
	}
	
	/**
	 * 已经父code查出orgName
	 * @param orgnization
	 * @return
	 */
	private String getParentOrgnizationCode(Orgnization orgnization){
		String parentName="";
		if(null!=orgnization){
			if((null!=orgnization.getOrgPcode())&&(!orgnization.getOrgPcode().equals("PARENT"))){
				String orgPcode = orgnization.getOrgPcode();
				if(null!=orgPcode){
					String sqlParent="SELECT * FROM  console_orgnization WHERE org_code='"+orgPcode+"'";
					Orgnization findFirst = Orgnization.dao.findFirst(sqlParent);
					//parentName=findFirst.getName();
					parentName=	orgnization.getName();
					String parentOrgnizationCode = getParentOrgnizationCode(findFirst);
					return	parentName=parentOrgnizationCode+">"+parentName;
				}
			}else{
				return parentName=parentName+orgnization.getName();
			}
		}
		return "";
	}
	
	/**
	 * 查询参数解析类
	 * @author jeff
	 *
	 */
	private class TeamParams extends ParamsParser{

		public TeamParams(Controller ctr) {
			super(ctr);
			/***
			 * 处理传入参数
			 */
			this.setSelectStr("select * ");
			this.setFromStr("from crm_professional_team as cpt,console_user as cu ");
			this.addWhereSegmentByAnd("cpt.user_id=cu.user_id and cpt.delete_flag='0'");
			
			String name = this.getNormStr("name"); 
			if(name!=null){
				this.addWhereSegmentByAnd(" (cu.user_name like '%"+name+"%' or cu.english_name  like '%"+name+"%'  or cu.phone  like '%"+name+"%') ");
				ctr.setAttr("name", name);
			}
			
			String pub_status = this.getNormStr("pub_status");
			if(pub_status!=null){
				this.addWhereSegmentByAnd(" cpt.release_mark='"+pub_status+"'");
				ctr.setAttr("publish_status", pub_status);
			}
			
			String team_type = this.getNormStr("team_type");
			if(team_type!=null){
				this.addWhereSegmentByAnd(" cpt.team_type='"+team_type+"'");
				ctr.setAttr("team_type", team_type);
			}
			
			//默认排序
			this.setDefaultOrderStr("order by cpt.sort desc");
		}
	}
	
	
	public void update(){
		
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation")!=null){
			if(pp.getId()!=null){
				
				ProfessionalTeam su = ProfessionalTeam.dao.findById(pp.getId());
				User user = User.dao.findById(su.getUserId());
		
				String head_img = pp.getAllStr("head_img");
				if(head_img!=null){
					user.setHeadImg(head_img);
				}
				
				String job_title = pp.getAllStr("job_title");
				if(job_title!=null){
					user.setJobTitle(job_title);
				}
				
				//团队类型
				String team_type = pp.getNormStr("team_type");
				if(team_type!=null){
					su.setTeamType(team_type);
				}
				
				//视频地址
				String video = this.getPara("video");
				if(video!=null)
					su.setVideo(video);
				
				//个人简介
				String introduce = this.getPara("introduce");
				if(introduce!=null)
					user.set("introduce", introduce);
				
				/////////////////////////////
				String[] expertCountries = this.getParaValues("countries");
				if(expertCountries!=null){
					boolean flag=true;
					StringBuffer cts = new StringBuffer();
					for(String ct:expertCountries){
						if(flag){
							cts.append(ct);
							flag=false;
						}
						else{
							cts.append(",");
							cts.append(ct);
						}
					}
					
					su.setExpertCountry(cts.toString());
				}
				
				//名片状态
				String index_show = pp.getNormStr("index_show");
				if(index_show != null)
					su.set("index_show", Integer.parseInt(index_show));
				
				//修改创建时间
				LoginUserInfo lui = this.getSessionAttr("LoginUserInfo");
				if(lui!=null){
					su.set("update_user",lui.getUserName());
				}
				su.set("update_time",StringUtil.yyyymmddhmsTime(new Date()));
				
				String release_mark = pp.getNormStr("release_mark");
				if(release_mark!=null)
					su.set("release_mark", release_mark);
				
				try {
					user.update();
					su.update();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				}
				
				/***
				 * 跳转到跳出时列表页地址
				 */
				
				String fromurl = getPara("fromurl");
				this.redirect(fromurl);
			}
			else
			{
				ProfessionalTeam su = ProfessionalTeam.dao.findById(pp.getId());
				User mu = User.dao.findById(su.getUserId());
				if(mu!=null){
					//加载对象数据
					this.setAttr("teamUser", su);
					this.setAttr("User", mu);
					this.setAttr("operation", "编辑");
					
		            if(mu.getProvinceId()!=null){
			            Dictionary province = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+mu.getProvinceId()+"'");
			            	if(province!=null){
			            		setAttr("province",province.getName());
			            	}
		            }
		            
		            	if(mu.getCityId()!=null){
			            	Dictionary city = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+mu.getCityId()+"'");
			            	if(city!=null){
			            		setAttr("city",city.getName());
			            	}
		            	}
		            	
		            	if(su.getExpertCountry()!=null && !su.getExpertCountry().isEmpty()){
		            		String[] eps = su.getExpertCountry().split(",");
		            		ArrayList<String> Countries = new ArrayList<String>();
		            		for(String ep:eps){
		            			Countries.add(ep);
		            		}
		            		setAttr("Countries",Countries);
		            	}
		            	
		            	Dict countries = DictionaryManager.getInstance().getSubDictionariesByDegree("0003", 2);
		            	setAttr("countries",countries);
		            	
		            	this.setAttr("teamTypeList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("team_type"), 1).getSubDictionaries());
		            	
		            
					
		            	this.renderJsp("/views/team/team_user_opt.jsp");
				}
				else{
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			} 
	}
 
	@Clear
	public void check(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		
		String tt = pp.getNormStr("tt");
		
		Record r = Db.findFirst("select count(*) as c from crm_professional_team where index_show=1 and team_type='"+tt+"'");
		if(r!=null){
			Long num = r.getLong("c");
			if(num==4){
				rst.put("status", 0);
				rst.put("msg", "首页推荐人数已满额，请重新选择!");
				this.renderJson(rst);
				return ;
			}
		}
		rst.put("status", 100);
		this.renderJson(rst);
	}
	
	///////////////////////树状图加载//////////////////////////////////////////////////////////////
	private String loadTree(){
		return loadTree("");
	}
	private String loadTree(String code){
		List<Record> records = Db.find("select * from console_orgnization where delete_flag='0' order by org_code asc");
		NodeTree ct = new NodeTree("orgTree","所属部门",10);
		
		/***
		 * 初始化时将选中的节点，描红显示
		 */
		if(!code.isEmpty()){
			ct.getSelectedCodes().add(code);
		}
		
		/**
		 * 显示选择框
		 */
		ct.setSelectMode(true);
		
		/**
		 * 不显示编辑按钮
		 */
		ct.setAllownEdit(false);
		
		for(Record r:records){
			Node node = new Node();
			node.setName(r.getStr("name"));
			node.setCode(r.getStr("org_code"));
			node.setId(r.getStr("org_id"));
			
			node.setExtInfo(r.getStr("org_type"));
			ct.addNode(node);
		}
		
		return ct.buildTree();
	}
	
	@Clear
	//@Before(AjaxLoginInterCeptor.class)
	public void upsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		ProfessionalTeam t = ProfessionalTeam.dao.findById(id);
		ProfessionalTeam t1 = findPreOrNextOne(id,true);
		
		if(t!=null && t1!=null){
			if(t.getSort()==t1.getSort()){
				t.setSort(t.getSort()+1);
				t.update();
			}
			else{
				int sort = t1.getSort();
				t1.setSort(t.getSort());
				t1.update();
				t.setSort(sort);
				t.update();
			}

			rst.put("status", 0);
			rst.put("msg", "上移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "已经置顶");
			this.renderJson(rst);
		}
	}
	
	@Clear
	//@Before(AjaxLoginInterCeptor.class)
	public void downsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		ProfessionalTeam t = ProfessionalTeam.dao.findById(id);
		ProfessionalTeam t1= findPreOrNextOne(id,false);
		if(t!=null && t1!=null){
			if(t.getSort()==t1.getSort()){
				t1.setSort(t1.getSort()+1);
				t1.update();
			}
			else{
				int sort = t1.getSort();
				t1.setSort(t.getSort());
				t1.update();
				t.setSort(sort);
				t.update();
			}
			
			rst.put("status", 0);
			rst.put("msg", "下移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "已经置底");
			this.renderJson(rst);
		}
	}
	
	@Clear
	//@Before(AjaxLoginInterCeptor.class)
	public void topsort(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		ProfessionalTeam t = ProfessionalTeam.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(t!=null){
			int sort=10000;
			Record rd = Db.findFirst("select * from crm_professional_team where delete_flag='0' order by sort desc");
			if(rd!=null && rd.getInt("sort")!=null){
				sort = rd.getInt("sort");
			}
			sort++;
			t.setSort(sort);
			t.update();
			rst.put("status", 0);
			rst.put("msg", "置顶成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "删除失败");
			this.renderJson(rst);
		}
	}
	
	private ProfessionalTeam findPreOrNextOne(String id,boolean flag){
		List<ProfessionalTeam> acts = ProfessionalTeam.dao.find("select * from crm_professional_team where delete_flag='0' order by sort desc");
		ProfessionalTeam pre=null;
		ProfessionalTeam next=null;
		for(int i=0;i<acts.size();i++){
			ProfessionalTeam act = acts.get(i);
			if(act.getTeamId()==Integer.valueOf(id)){
				int pidx=i-1;
				int nidx=i+1;
				if(pidx>-1)
					pre=acts.get(pidx);
				if(nidx<acts.size())
					next=acts.get(nidx);
			}
		}
		//上一个
		if(flag){
			return pre;
		}
		else{
			return next;
		}
	}

}
 
	
	
	
	
	
	
	
	

