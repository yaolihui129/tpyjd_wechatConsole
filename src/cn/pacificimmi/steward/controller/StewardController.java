package cn.pacificimmi.steward.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import cn.pacificimmi.common.models.StewardEvaluate;
import cn.pacificimmi.common.models.StewardSign;
import cn.pacificimmi.common.models.StewardUser;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.StringUtil;  
import cn.pacificimmi.steward.models.view.StewardUserInfo; 
/**
 * @version pacific 1.0.0
 * @author jeff
 * @date : 2016年10月27日 上午11:38:49
 * @category 移民管家
 **/
@Before(LoginInterCeptor.class)
public class StewardController extends Controller {
	
	public void index() { 
		Object sessionAttr = this.getSessionAttr("LoginUserInfo");
		if(null!=sessionAttr){
			LoginUserInfo login =(LoginUserInfo)sessionAttr; 
			
			String loginName = login.getLoginName();
			String headImg = login.getHeadImg(); 
				StewardUserParams sp = new StewardUserParams(this);
				ArrayList<StewardUserInfo> result = new ArrayList<StewardUserInfo>();

				/***
				 * 获取数据列表
				 */
				Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
				List<Record> stewardUser = page.getList();
			 
				for(Record rd:stewardUser){
					StewardUserInfo su = new StewardUserInfo();   
					su.setEmail(rd.getStr("email"));
					su.setSteward_id(rd.getInt("steward_id"));
					su.setEnglish_name(rd.getStr("english_name"));
					su.setGender(rd.getStr("gender"));
					su.setJob_title(rd.getStr("job_title"));
					su.setPhone(rd.getStr("phone"));
					su.setProvince_id(rd.getStr("province_id"));
					su.setRelease_mark(rd.getStr("release_mark")); 
					su.setUser_id(rd.getInt("user_id"));
					su.setUser_name(rd.getStr("user_name"));
					
					su.setLike_count(String.valueOf(getLikeCount(rd.getInt("steward_id"))));
					su.setSign_count(getSignCount(rd.getInt("steward_id")));
					String provinceId = rd.getStr("province_id");
					if(provinceId!=null){
						Dictionary province = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+provinceId+"'");
						if(province!=null)
							su.setProvince_name(province.getName());
					}
					
					su.setDep_id(String.valueOf(rd.getInt("dep_id")));
					String orgnizationLineName = getOrgnizationLineName(String.valueOf(rd.getInt("dep_id")));
					su.setDep_name(orgnizationLineName); 
					float level = getDynamicScore(rd.getInt("steward_id"));
					int dynamicScore = (new BigDecimal(String.valueOf(level)).setScale(0, BigDecimal.ROUND_HALF_UP)).intValue();
					su.setDynamicScore(dynamicScore);
					result.add(su);
				}
				
				this.setAttr("statusList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("publish_status"), 1).getSubDictionaries());
				/***
				 * 保存数据列表
				 */
				this.setAttr("list", result); 
				/***
				 * 保存翻页
				 */
				String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
				setAttr("pageBar",pagesView);
				
				setAttr("headImg",headImg);
				setAttr("loginName",loginName);
				/**
				 * 渲染视图
				 */
				this.renderJsp("/views/steward/stewards.jsp");
		} 
		
	}

	private int getSignCount(Integer steward_id){
		int rst=0;
		Record signs = Db.findFirst("select count(*) as num from crm_steward_sign as css,crm_custinfo as cc where css.custinfo_id=cc.custinfo_id and css.sign_status='聘用' and css.steward_id='"+steward_id+"'");
		if(signs.getLong("num")>0)
			rst = signs.getLong("num").intValue();
		return rst;
	}
	
	private int getLikeCount(Integer steward_id){
		int rst=0;
		Record liked = Db.findFirst("select count(*) as num from crm_steward_like as csl , crm_custinfo as cc where csl.custinfo_id=cc.custinfo_id and csl.steward_id='"+steward_id+"'");
		if(liked.getLong("num")>0)
			rst = liked.getLong("num").intValue();
		return rst;
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void pub(){
		StewardUserParams sp = new StewardUserParams(this);
		Map<String,Object> rst = new HashMap<String,Object>(); 
		if(!sp.getIds().isEmpty()){
			String opt = sp.getInt("opt");
			if(opt!=null){
				if(opt.equals("0")){
					String ids = sp.getIds();
					String[] split = ids.split(",");
					if(this.checkUserInfo(split[0])){
						//for (int i = 0; i < split.length; i++) {
							Db.update("update crm_steward_user set release_mark='已发布' where steward_id='"+split[0]+"'");
						//}  
				 		rst.put("status", 0);
						rst.put("msg", "操作成功");
						this.renderJson(rst);
					}
					else{
						rst.put("status", 100);
						rst.put("msg", "请补充完成管家信息!");
						this.renderJson(rst);
					}
				}
				else{
					String ids = sp.getIds();
					String[] split = ids.split(",");
					//for (int i = 0; i < split.length; i++) {
						List<StewardSign> sss = StewardSign.dao.find("select * from crm_steward_sign where steward_id='"+split[0]+"' and sign_status='聘用'");
						if(sss.size()==0){
							Db.update("update crm_steward_user set release_mark='已下线',card_status='0'  where steward_id='"+split[0]+"'");
							rst.put("status", 0);
							rst.put("msg", "操作成功");
							this.renderJson(rst);
						}
						else{
							rst.put("status", 100);
							rst.put("msg", "该管家下有服务中的客户，不允许下线");
							this.renderJson(rst);
						}
					//}  
			 		
				}
			}
			else{
				String ids = sp.getIds();
				String[] split = ids.split(",");
				//for (int i = 0; i < split.length; i++) {
					StewardUser su = StewardUser.dao.findById(split[0]);
					if(su.getReleaseMark().equals("未发布")){
						if(this.checkUserInfo(split[0])){
							Db.update("update crm_steward_user set release_mark='已发布' where steward_id='"+split[0]+"'");
							rst.put("status", 0);
							rst.put("msg", "操作成功");
							this.renderJson(rst);
						}
						else{
							rst.put("status", 100);
							rst.put("msg", "请补充完成管家信息!");
							this.renderJson(rst);
						}
					}else if(su.getReleaseMark().equals("已发布")){
						List<StewardSign> sss = StewardSign.dao.find("select * from crm_steward_sign where steward_id='"+split[0]+"' and sign_status='聘用'");
						if(sss.size()==0){
							Db.update("update crm_steward_user set release_mark='已下线',card_status='0' where steward_id='"+split[0]+"'");
							rst.put("status", 0);
							rst.put("msg", "操作成功");
							this.renderJson(rst);
						}else{
							rst.put("status", 100);
							rst.put("msg", "该管家下有服务中的客户，不允许下线");
							this.renderJson(rst);
						}
					}
				//}  
		 			
			}
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "删除失败");
			this.renderJson(rst);
		}
	}
	
	private boolean checkUserInfo(String stewardid){
		boolean flag=true;
		try{
			StewardUser  su = StewardUser.dao.findById(stewardid);
			User user = User.dao.findById(su.getUserId());
			if(user.getJobTitle().isEmpty())
				flag=false;
			if(user.getHeadImg().isEmpty())
				flag=false;
			if(user.getPhone().isEmpty())
				flag=false;
			if(user.getIntroduce().isEmpty())
				flag=false;
		}
		catch(Exception e){
			flag=false;
		}
		return flag;
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove(){
		StewardUserParams sp = new StewardUserParams(this);
		Map<String,Object> rst = new HashMap<String,Object>(); 
		if(!sp.getIds().isEmpty()){
			String ids = sp.getIds();
			String[] split = ids.split(",");
			//for (int i = 0; i < split.length; i++) {
			List<StewardSign> sss = StewardSign.dao.find("select * from crm_steward_sign where steward_id='"+split[0]+"' and sign_status='聘用'");
			if(sss.size()==0){
				Db.update("update crm_steward_user set delete_flag='1' where steward_id='"+split[0]+"'");
				rst.put("status", 0);
				rst.put("msg", "操作成功");
				this.renderJson(rst);
			}else{
				rst.put("status", 100);
				rst.put("msg", "该管家下有服务中的客户，不允许删除");
				this.renderJson(rst);
			}
				//}  
	 			
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "删除失败");
			this.renderJson(rst);
		}
	}


	 //获取每个管家评分
	private float getDynamicScore(Integer steward_id){
		
		//统计该管家有多少个参与评价的客户
		float countStar=0.0f;
		//统计该管家所有参与评价的客户的总的评分
		Float sumStar=0.0f;  
		
		float result=5.00f;
		List<StewardEvaluate> find = StewardEvaluate.dao.find("select se.evaluate_id as evaluate_id, "
				+ "se.star_level as star_level FROM crm_steward_evaluate AS se WHERE  se.delete_flag = '0'  AND se.hidden=0 and steward_id='"+steward_id+"' order by se.create_time  desc");
		if(find!=null && find.size()>0){
			for (int i = 0; i < find.size(); i++) {
				StewardEvaluate stewardEvaluate = find.get(i); 
				Float star_level=stewardEvaluate.getStarLevel(); 
				if(star_level==null)
					star_level=0f;
				countStar++;
				sumStar=sumStar+star_level;
			}
		}
		
		if(countStar!=0){
			result=sumStar/countStar;
		}
		
		return result;
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
	 * @author lijinglun
	 *
	 */
	private class StewardUserParams extends ParamsParser{


		public StewardUserParams(Controller ctr) {
			super(ctr);
			/***
			 * 处理传入参数
			 */
			this.setSelectStr("select csu.steward_id,csu.release_mark,csu.employ_count,csu.card_status,csu.like_count,cu.* ");
			this.setFromStr("from crm_steward_user as csu,console_user as cu ");
			this.addWhereSegmentByAnd("csu.user_id=cu.user_id and csu.delete_flag='0'");
			
			String name = this.getNormStr("name"); 
			if(name!=null){
				this.addWhereSegmentByAnd(" (cu.user_name like '%"+name+"%' or cu.english_name  like '%"+name+"%'  or cu.phone  like '%"+name+"%') ");
				ctr.setAttr("name", name);
			}
			
			String pub_status = this.getNormStr("pub_status");
			if(pub_status!=null){
				this.addWhereSegmentByAnd(" csu.release_mark='"+pub_status+"'");
				ctr.setAttr("publish_status", pub_status);
			}
			
			//默认排序
			this.setDefaultOrderStr("order by csu.create_time desc");
		}
	}
	
	
	public void update(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation")!=null){
			if(pp.getId()!=null){ 
			//	StewardUser su=new StewardUser(); 
				StewardUser su = StewardUser.dao.findById(pp.getId());
				User user = User.dao.findById(su.getUserId());
				
				//头衔
				String job_title = pp.getNormStr("job_title");
				if(job_title!=null)
					user.set("job_title", job_title);
				
				//头像
				String head_img = this.getPara("head_img");
				if(head_img!=null)
					user.set("head_img", head_img);  
				
				//qq
				String qq = pp.getNormStr("qq");
				if(qq!=null)
					user.set("qq", qq);
				
				//微信二维码
				String wechat = pp.getAllStr("wechat");
				if(wechat!=null)
					user.set("wechat", wechat);
				 
				//电子邮箱
				String email =getPara("email");
				if(email!=null)
					user.set("email", email);
				
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
				String cardStatus = pp.getNormStr("card_status");
				if(cardStatus != null)
					su.set("card_status", Integer.parseInt(cardStatus));
				
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
				StewardUser su = StewardUser.dao.findById(pp.getId());
				User mu = User.dao.findById(su.getUserId());
				if(mu!=null){
					//加载对象数据
					this.setAttr("stewardUser", su);
					this.setAttr("User", mu);
					this.setAttr("operation", "编辑");
					 
					StringBuffer bf = new StringBuffer(); 
		            
		            if(mu.getGender().equals("MALE"))
		            		bf.append("男");	
		            else
		            		bf.append("女");	
		            
		            this.setAttr("gender", bf.toString());
		            
		            if(mu.getWechat()!=null && !mu.getWechat().isEmpty() && !mu.getWechat().startsWith("http"))
		            		mu.setWechat("");
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
		            	
					this.renderJsp("/views/steward/stewards_opt.jsp");
				}
				else{
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			} 
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

}
 
	
	
	
	
	
	
	
	

