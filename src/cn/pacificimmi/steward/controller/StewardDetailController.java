package cn.pacificimmi.steward.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.StewardEvaluate;
import cn.pacificimmi.common.models.StewardUser;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.steward.models.view.SignInfo;
import cn.pacificimmi.steward.models.view.StewardEvaluateInfo;

@Before(LoginInterCeptor.class)
public class StewardDetailController extends Controller {
	
	public void index(){
		ParamsParser pp = new ParamsParser(this);
		String id=pp.getId();
		if(id!=null){
			this.setAttr("stewardId", id);
			StewardUser su = StewardUser.dao.findFirst("select * from crm_steward_user where delete_flag=0 and steward_id='"+id+"'");
			User mu = User.dao.findById(su.getUserId());
			
			Record rc = Db.findFirst("select count(*) as num from crm_steward_sign where steward_id="+id);
			if(rc!=null){
				long num = rc.getLong("num");
				setAttr("num",num);
			}
			
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
           
            mu.setPhone(StringUtil.getMaskMobile(mu.getPhone()));
            
            if(mu.getCityId()!=null){
	            	Dictionary city = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+mu.getCityId()+"'");
	            	if(city!=null){
	            		setAttr("city",city.getName());
	            	}
            	}
            	
			this.setAttr("su", su);
			this.setAttr("cu", mu);
			this.renderJsp("/views/steward/steward_detail.jsp");
		}
		else{
			this.setAttr("errorInfo","参数错误");
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	public void evalute(){
		ParamsParser pp = new ParamsParser(this);
		String id=pp.getId();
		if(id!=null){
			//管家信息
			StewardUser su = StewardUser.dao.findFirst("select * from crm_steward_user where delete_flag=0 and steward_id='"+id+"'");
			User mu = User.dao.findById(su.getUserId());
			this.setAttr("cu", mu);
			//统计综合评价
			float level = getDynamicScore(su.getStewardId());
			int stars = (new BigDecimal(String.valueOf(level)).setScale(0, BigDecimal.ROUND_HALF_UP)).intValue();
			String score = new DecimalFormat("#.#").format(level);
			setAttr("score",score);
			setAttr("stars",stars);
			//count percent
			Percent service = new Percent();
			Percent specialized = new Percent();
			Percent feedback = new Percent();
			
			String sql="select * from crm_steward_evaluate where hidden=0 and steward_id="+id;
			List<StewardEvaluate> ses = StewardEvaluate.dao.find(sql);
			for(StewardEvaluate se:ses){
				//态度服务统计
				if(se.getServiceAttitude()==0){
					service.setGood(service.getGood()+1.0f);
				}
				else if(se.getServiceAttitude()==1){
					service.setNormal(service.getNormal()+1.0f);
				}
				else{
					service.setBad(service.getBad()+1.0f);
				}
				//专业只是统计
				if(se.getSpecializedKnowledge()==0){
					specialized.setGood(specialized.getGood()+1.0f);
				}
				else if(se.getSpecializedKnowledge()==1){
					specialized.setNormal(specialized.getNormal()+1.0f);
				}
				else{
					specialized.setBad(specialized.getBad()+1.0f);
				}
				//反馈效率统计
				if(se.getFeedbackEfficiency()==0){
					feedback.setGood(feedback.getGood()+1.0f);
				}
				else if(se.getFeedbackEfficiency()==1){
					feedback.setNormal(feedback.getNormal()+1.0f);
				}
				else{
					feedback.setBad(feedback.getBad()+1.0f);
				}
				
			}
			
			float totle=service.getGood()+service.getNormal()+service.getBad();
			if(totle>0){
				service.setGood(service.getGood()*100f/totle);
				service.setNormal(service.getNormal()*100f/totle);
				service.setBad(service.getBad()*100f/totle);
			}
			
			totle=specialized.getGood()+specialized.getNormal()+specialized.getBad();
			if(totle>0){
				specialized.setGood(specialized.getGood()*100f/totle);
				specialized.setNormal(specialized.getNormal()*100f/totle);
				specialized.setBad(specialized.getBad()*100f/totle);
			}
			
			totle=feedback.getGood()+feedback.getNormal()+feedback.getBad();
			if(totle>0){
				feedback.setGood(feedback.getGood()*100f/totle);
				feedback.setNormal(feedback.getNormal()*100f/totle);
				feedback.setBad(feedback.getBad()*100f/totle);
			}
			setAttr("service",service);
			setAttr("specialized",specialized);
			setAttr("feedback",feedback);
			
			//列表
			this.setAttr("stewardId", id);
			pp.setSelectStr("select cc.wx_name,cse.*");
			pp.setFromStr("from crm_steward_evaluate as cse,crm_custinfo as cc where cc.custinfo_id=cse.custinfo_id and cse.delete_flag='0' and steward_id="+id);
			pp.setDefaultOrderStr("order by create_time desc");
			
			List<StewardEvaluateInfo> list = new ArrayList<StewardEvaluateInfo>();
			Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
			for(Record r:page.getList()){
				StewardEvaluateInfo sei = new StewardEvaluateInfo();
				sei.setSteward_id(r.getInt("steward_id"));
				sei.setContent(r.getStr("content"));
				sei.setCustinfo_id(r.getInt("custinfo_id"));
				sei.setEvaluate_id(r.getInt("evaluate_id"));
				sei.setFeedback_efficiency(r.getInt("service_attitude"));
				sei.setName(r.getStr("wx_name"));
				sei.setService_attitude(r.getInt("service_attitude"));
				sei.setSpecialized_knowledge(r.getInt("specialized_knowledge"));
				
				if(r.getFloat("star_level")!=null)
					sei.setStar_level(Double.valueOf(r.getFloat("star_level")));
				sei.setSteward_id(r.getInt("steward_id"));
				sei.setHidden(r.getInt("hidden"));
				sei.setHidden_reason(r.getStr("hidden_reason"));
				sei.setCreate_time(r.getDate("create_time"));
				list.add(sei);
			}
			setAttr("list",list);
			
			/*** 
			 * 保存翻页
			 */
			String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/steward/steward_evaluate.jsp");
		}else{
			this.setAttr("errorInfo","参数错误");
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	@Clear
	public void removeEvaluate(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id=pp.getId();
		if(id!=null){
			StewardEvaluate se = StewardEvaluate.dao.findById(id);
			se.setDeleteFlag(1);
			se.update();
			
			rst.put("status", 0);
			rst.put("msg","ok");
			this.renderJson(rst);
		}else{
			rst.put("status", 2);
			rst.put("msg","参数错误");
			this.renderJson(rst);
		}
	}
	
	@Clear
	public void evaluateShow(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id=pp.getId();
		if(id!=null){
			StewardEvaluate se = StewardEvaluate.dao.findById(id);
			se.setHidden(0);
			se.update();
			
			rst.put("status", 0);
			rst.put("msg","ok");
			this.renderJson(rst);
		}else{
			rst.put("status", 2);
			rst.put("msg","参数错误");
			this.renderJson(rst);
		}	
	}
	
	@Clear
	public void evaluateHide(){
		ParamsParser pp = new ParamsParser(this);
		String id=pp.getInt("vid");
		if(id!=null){
			StewardEvaluate se = StewardEvaluate.dao.findById(id);
			se.setHidden(1);
			String hideReason = pp.getNormStr("reason");
			if(hideReason!=null){
				se.setHiddenReason(hideReason);
			}
			se.update();
			
			String from = "/";
			if(pp.getAllStr("from")!=null){
				from = pp.getAllStr("from");
			}
			this.redirect(from);
		}else{
			this.setAttr("errorInfo","参数错误");
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	public void sign(){
		SignParamsParser spp = new SignParamsParser(this);
		String id=spp.getId();
		if(id!=null){
			
			//管家信息
			StewardUser su = StewardUser.dao.findFirst("select * from crm_steward_user where delete_flag=0 and steward_id='"+id+"'");
			User mu = User.dao.findById(su.getUserId());
			this.setAttr("stewardName", mu.getUserName());
			this.setAttr("englishName", mu.getEnglishName());
			this.setAttr("stewardId", id);
			
			Page<Record> page = Db.paginate(spp.getPageNum(), spp.getPageSize(), spp.getSelectStr(), spp.getFromStr());
			List<SignInfo> list= new ArrayList<SignInfo>();
			for(Record rs:page.getList()){
				//赋值
				SignInfo si = new SignInfo();
				si.setCustomMobile(StringUtil.getMaskMobile(rs.getStr("phone_num")));
				si.setStewardName(rs.getStr("user_name"));
				si.setCustomNickName(rs.getStr("wx_name"));
				String reason = rs.getStr("unsign_reason");
				if(reason!=null && !reason.isEmpty() && reason.length()>25){
					si.setUnsignReason(reason.substring(0, 25)+"...");
				}
				else
					si.setUnsignReason(reason);
				si.setUnsignReasonTitle(reason);
				
				String opt = rs.getStr("sign_status");
				if(opt.equals("聘用")){
					si.setOptTime(rs.getDate("update_time"));
				}
				else{
					si.setOptTime(rs.getDate("update_time"));
				}
				si.setSignStatus(opt);
				
				list.add(si);
			}
			
			/**
			 * 绑定列表数据
			 */
			setAttr("list",list);
			
			/***
			 * 保存翻页
			 */
			String pagesView = PagesBar.getShortPageBar(spp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			//聘用次数
			int signed=0;
			Record r = Db.findFirst("select count(*) as num from crm_steward_sign as css,crm_custinfo as cc where css.custinfo_id=cc.custinfo_id and css.sign_status='聘用' and css.steward_id="+id);
			if(r!=null){
				signed=r.getLong("num").intValue();
			}
			
			int unsiged = page.getTotalRow()-signed;
			setAttr("signed",signed);
			setAttr("unsigned",unsiged);
			setAttr("all",page.getTotalRow());
			
			this.renderJsp("/views/steward/steward_detail_signs.jsp");
		}
		else{
			this.setAttr("errorInfo","参数错误");
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	public void customer(){
		ParamsParser pp = new ParamsParser(this);
		String id=pp.getId();
		if(id!=null){
			setAttr("stewardId",id);
			pp.setSelectStr("select cc.*");
			pp.setFromStr("from crm_steward_sign as css, crm_custinfo as cc ");

			pp.addWhereSegmentByAnd("css.custinfo_id=cc.custinfo_id");
			pp.addWhereSegmentByAnd("css.steward_id="+id);
			pp.setDefaultOrderStr("order by css.update_time desc");
			String nick_name = pp.getNormStr("nick_name");
			
			if(nick_name!=null){
				try {
					pp.addWhereSegmentByAnd("cc.wx_name like '%"+URLEncoder.encode(nick_name, "UTF-8")+"%'");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				setAttr("nick_name",nick_name);
			}
			Page<Custinfo> page = Custinfo.dao.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(), pp.getFromStr());
			List<Custinfo> list = page.getList();
			for(Custinfo cf:list){
				cf.setCustStatus(getDictionaryName(cf.getCustStatus()));
				cf.setCustSource(getDictionaryName(cf.getCustSource()));
				cf.setPhoneNum(StringUtil.getMaskMobile(cf.getPhoneNum()));
			}
			/**
			 * 绑定列表数据
			 */
			setAttr("list",list);
			
			/***
			 * 保存翻页
			 */
			String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/steward/steward_detail_customer.jsp");
		}
		else{
			this.setAttr("errorInfo","参数错误");
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	public void like(){
		ParamsParser pp = new ParamsParser(this);
		String id=pp.getId();
		if(id!=null){
			//管家信息
			StewardUser su = StewardUser.dao.findFirst("select * from crm_steward_user where delete_flag=0 and steward_id='"+id+"'");
			User mu = User.dao.findById(su.getUserId());
			this.setAttr("stewardName", mu.getUserName());
			this.setAttr("englishName", mu.getEnglishName());
			this.setAttr("stewardId", id);
			
			pp.setSelectStr("select cc.cust_source,"
					+ "cc.cust_status,"
					+ "cc.wx_name,"
					+ "cc.phone_num,"
					+ "csl.create_time");
			pp.setFromStr("from crm_steward_like as csl , crm_custinfo as cc where csl.custinfo_id=cc.custinfo_id and csl.steward_id="+id);
			
			List<Customer> list = new ArrayList<Customer>();
			Page<Record> page = Db.paginate(pp.getPageNum(), pp.getPageSize(), pp.getSelectStr(),pp.getFromStr());
			for(Record r:page.getList()){
				Customer cs = new Customer();
				cs.setCustSource(getDictionaryName(r.getStr("cust_source")));
				cs.setCustStatus(r.getStr("cust_status"));
				cs.setNickName(r.getStr("wx_name"));
				cs.setPhoneNum(StringUtil.getMaskMobile(r.getStr("phone_num")));
				cs.setTime(r.getDate("create_time"));
				
				list.add(cs);
			}
			/**
			 * 绑定列表数据
			 */
			setAttr("list",list);
			setAttr("totle",page.getTotalRow());
			/***
			 * 保存翻页
			 */
			String pagesView = PagesBar.getShortPageBar(pp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/steward/steward_detail_like.jsp");
		}
		else{
			this.setAttr("errorInfo","参数错误");
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	private float getDynamicScore(Integer steward_id){
		
		//统计该管家有多少个参与评价的客户
		float countStar=0.0f;
		//统计该管家所有参与评价的客户的总的评分
		Float sumStar=0.0f;  
		
		float result=5.00f;
		List<StewardEvaluate> find = StewardEvaluate.dao.find("select se.evaluate_id as evaluate_id, "
				+ "se.star_level as star_level FROM crm_steward_evaluate AS se WHERE  se.delete_flag = '0' AND se.hidden=0 and se.steward_id='"+steward_id+"' order by se.create_time  desc");
		if(find.size()>0){
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
	
//	private String getProcessStatus(String id){
//		return "";
//	}
	
	public class Customer{
		private String nickName;
		private String phoneNum;
		private String custStatus;
		private String custSource;
		private Date time;
		
		public Date getTime() {
			return time;
		}
		public void setTime(Date time) {
			this.time = time;
		}
		public String getNickName() {
			return nickName;
		}
		public void setNickName(String nickName) {
			this.nickName = nickName;
		}
		public String getPhoneNum() {
			return phoneNum;
		}
		public void setPhoneNum(String phoneNum) {
			this.phoneNum = phoneNum;
		}
		public String getCustStatus() {
			return custStatus;
		}
		public void setCustStatus(String custStatus) {
			this.custStatus = custStatus;
		}
		public String getCustSource() {
			return custSource;
		}
		public void setCustSource(String custSource) {
			this.custSource = custSource;
		}
		
	}
	
	public class Percent{
		private float good=0.0f;
		private float normal=0.0f;
		private float bad=0.0f;
		
		public float getGood() {
			return good;
		}
		public void setGood(float good) {
			this.good = good;
		}
		public float getNormal() {
			return normal;
		}
		public void setNormal(float normal) {
			this.normal = normal;
		}
		public float getBad() {
			return bad;
		}
		public void setBad(float bad) {
			this.bad = bad;
		}
	}
	
	private class SignParamsParser extends ParamsParser{
		public SignParamsParser(Controller ct) {
			super(ct);
			
			String id = "0";
			if(this.getId()!=null)
				id = this.getId();
			this.setSelectStr("select cu.user_name,css.*,cc.wx_name,cc.phone_num");
			this.setFromStr("from crm_steward_sign css,crm_steward_user as csu,console_user as cu, crm_custinfo as cc ");
			this.setDefaultOrderStr("order by css.update_time desc");
			this.addWhereSegmentByAnd("css.custinfo_id=cc.custinfo_id");
			this.addWhereSegmentByAnd("css.steward_id=csu.steward_id");
			this.addWhereSegmentByAnd("csu.user_id=cu.user_id");
			this.addWhereSegmentByAnd("css.steward_id='"+id+"'");
			String nick_name = this.getAllStr("nick_name");
			if(nick_name!=null){
				try {
					this.addWhereSegmentByAnd("cc.wx_name like '%"+URLEncoder.encode(nick_name, "UTF-8")+"%'");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				setAttr("nick_name",nick_name);
			}
			
			String sign_status = this.getNormStr("sign_status");
			if(sign_status!=null){
				this.addWhereSegmentByAnd("css.sign_status='"+sign_status+"'");
				setAttr("sign_status",sign_status);
			}
		}	
	}
	
	private String getDictionaryName(String code){
		String name="";
		Dictionary dict = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+code+"' and delete_flag=0");
		if(dict!=null){
			name=dict.getName();
		}
		return name;
	}
}
