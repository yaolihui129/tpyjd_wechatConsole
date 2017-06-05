
package cn.pacificimmi.team.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.Orgnization;
import cn.pacificimmi.common.models.ProfessionalTeam;
import cn.pacificimmi.common.models.Station;
import cn.pacificimmi.common.models.StewardUser;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.models.UserStation;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree; 
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.steward.models.view.UserInfo;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 *	@version pacific 1.0.0
 * @author 
 * @date : 2016年10月28日 上午11:42:22
 * @category 扩展公司员工到专业团队..
 **/
@Before(LoginInterCeptor.class) //用户权限拦截器
public class EmploiesController extends Controller {
	public void index(){
		UserParams sp = new UserParams(this);
		sp.setPageSize(20);
		/***
		 * 获取数据列表
		 */ 
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();
		List<UserInfo> result = new ArrayList<UserInfo>();
		for(Record rd:list){
			UserInfo su =new UserInfo(); 
			su.setLogin_name(rd.getStr("login_name"));
			su.setEnglish_name(rd.getStr("english_name"));
			su.setUser_name(rd.getStr("user_name"));
			su.setJob_title(rd.getStr("job_title"));
			su.setPhone(rd.getStr("phone"));
			su.setEmail(rd.getStr("email")); 
			su.setDep_id(rd.getInt("dep_id"));
			String orgnizationLineName = getOrgnizationLineName(rd.getInt("dep_id"));
			su.setDep_name(orgnizationLineName); 

			String stationName = getUserStationByUserId(rd.getInt("user_id"));
			su.setStation_name(stationName); 
			su.setGender(rd.getStr("gender"));
			su.setNote(rd.getStr("note"));
			 
			su.setProvince_id(rd.getStr("province_id")); 
			su.setUser_id(rd.getInt("user_id"));
			String provinceId = rd.getStr("province_id");
			if(provinceId!=null){
				Dictionary province = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+provinceId+"'");
				if(province!=null)
					su.setProvince_name(province.getName());
			}
			result.add(su);
		}

		/**
		 * 加载机构树
		 */
		ArrayList<String> checked = new ArrayList<String>();
		String org_id = sp.getNormStr("org_id");
		if(org_id!=null){
			checked.add(org_id);
		}
		else
			org_id="0";
		this.setAttr("org_id", org_id);
		
		String org_name = sp.getNormStr("org_name");
		if(org_name==null)
			org_name="所属部门";
		this.setAttr("org_name", org_name);
		
		String tree = loadTree(checked);
		this.setAttr("tree", tree);
		
		/***
		 * 保存数据列表
		 */
		this.setAttr("list", result);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/team/emploies.jsp");
	}
	
	
	/***
	 * 保存移民管家
	 */ 
	public void tryAdd(){ 
		UserParams sp = new UserParams(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		
		if(!sp.getIds().isEmpty()){
			String ids = sp.getIds();
			String[] split = ids.split(",");
			for (int i = 0; i < split.length; i++) {
				
				User user = User.dao.findFirst("SELECT * FROM console_user WHERE  user_id='"+split[i]+"'");
				if(null!=user){
					ProfessionalTeam su = ProfessionalTeam.dao.findFirst("select * from crm_professional_team where user_id="+split[i]);
					if(su==null){
						su=new ProfessionalTeam(); 
						su.set("user_id", user.get("user_id"))
						.set("delete_flag", 0)
						.set("create_user", user.get("create_user")).set("create_time", StringUtil.yyyymmddhmsTime(new Date()))
						.set("update_user", user.get("update_user")).set("update_time", StringUtil.yyyymmddhmsTime(new Date()));
						
						String release_mark = getPara("release_mark");
						if(release_mark!=null) {
							su.set("release_mark", release_mark);
						}
						su.save(); 
					}
					else{
						su.set("delete_flag", 0)
						.set("create_user", user.get("create_user")).set("create_time", StringUtil.yyyymmddhmsTime(new Date()))
						.set("update_user", user.get("update_user")).set("update_time", StringUtil.yyyymmddhmsTime(new Date()))
						.set("release_mark", "未发布");
						su.update();
					}
				}
				
			}  
	 		rst.put("status", 0);
			rst.put("msg", "保存成功");
			this.renderJson(rst);		
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "保存失败");
			this.renderJson(rst);
		}
	}
	
	
	/**
	 * 根据用户id 查出对应的 岗位名称
	 * @return
	 */
	public String  getUserStationByUserId(int user_id){
		String stationName="";
		if(0!=user_id){
			String sql="SELECT * FROM console_user_station WHERE user_id="+user_id;
			List<UserStation> find = UserStation.dao.find(sql);
			if(find.size()>0){
				for (int i = 0; i < find.size(); i++) {
					UserStation userStation = find.get(i);
					String stationId = String.valueOf(userStation.getStationId());
					String statSql="SELECT * FROM console_station WHERE  station_id='"+stationId+"'";
					Station findFirst = Station.dao.findFirst(statSql);
					if(null!=findFirst){
						stationName=stationName+findFirst.getName()+"<br>";
					}
				} 
				return stationName; 
			}
		}
		return stationName;
	}
	
	
	/**
	 * 查询参数解析类
	 * @author lijinglun
	 *
	 */
	private class UserParams extends ParamsParser{

		public UserParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select u.*,o.name as dep_name");
			this.setFromStr("from console_user as u left join console_orgnization as o on u.dep_id=o.org_id " );
			
			//查找有效数据
//			this.addWhereSegmentByAnd("u.delete_flag='0' and u.crm_id<>null and login_name<>'admin' AND  u.user_id NOT IN(SELECT user_id FROM crm_steward_user where delete_flag='0')");
			this.addWhereSegmentByAnd("u.delete_flag='0' and login_name<>'admin' AND  u.user_id NOT IN(SELECT user_id FROM crm_professional_team where delete_flag='0')");	
			//查询所属公司
			String org_id = this.getNormStr("org_id");
			if(org_id!=null && !org_id.equals("0"))
				this.addWhereSegmentByAnd("u.dep_id='"+org_id+"'");
			
			//查询登录名称
			String name = this.getNormStr("name");
			if(name!=null){
				this.addWhereSegmentByAnd("(u.login_name like '%"+name+"%' or u.user_name like '%"+name+"%')");
				ctr.setAttr("name", name);
			}
			
			this.setDefaultOrderStr("order by u.create_time desc");
		}
	}
	
	
///////////////////////树状图加载////////////////////////////////
	public String loadTree(List<String> codes){
		List<Record> records = Db.find("select * from console_orgnization where delete_flag='0' order by org_code asc");
		NodeTree ct = new NodeTree("orgTree","所属部门",10);
		
		/***
		* 初始化时将选中的节点，描红显示
		*/
		if(codes.size()>0){
			ct.setSelectedCodes(codes);
		}
		
		/**
		* 显示选择框
		*/
		ct.setSelectMode(false);
		
		/**
		* 不显示编辑按钮
		*/
		ct.setAllownEdit(false);
		
		for(Record r:records){
			Node node = new Node();
			node.setName(r.getStr("name"));
			node.setCode(r.getStr("org_code"));
			node.setId(r.getInt("org_id")+"");
			
			node.setExtInfo(r.getInt("org_id")+"");
			ct.addNode(node);
		}
		
		return ct.buildTree();
	}
	
	
			
		
		/**
		 * 获取当前管家 的部门结构列 例如:北京>顾问中心>顾问一部
		 * @param code
		 * @param table
		 * @param code_field
		 * @return
		 */
		private String getOrgnizationLineName(Integer dep_id){
			
			String orgnizName="";
			if(dep_id!=null){
				String sqlOne="SELECT * FROM  console_orgnization WHERE org_id="+dep_id+"";
				Orgnization orgnization = Orgnization.dao.findFirst(sqlOne);
				if(null!=orgnization.getOrgPcode()){
					String parentOrgnizationCode = getParentOrgnizationCode(orgnization);
					orgnizName=parentOrgnizationCode;
				}
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
	
}
