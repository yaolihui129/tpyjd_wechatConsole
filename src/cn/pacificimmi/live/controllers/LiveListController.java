package cn.pacificimmi.live.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
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
import cn.pacificimmi.common.models.Channel;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.Live;
import cn.pacificimmi.common.models.LiveApplication;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.LiveUtil;
import cn.pacificimmi.common.utils.MajorKeyFactory;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.live.controllers.models.view.LiveInfo;
import cn.pacificimmi.live.controllers.models.view.Steward;

@Before(LoginInterCeptor.class)
public class LiveListController extends Controller {
	private static Logger log = LoggerFactory.getLogger(LiveListController.class);
	public void index(){
		LiveParamsParser lpp = new LiveParamsParser(this);
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(lpp.getPageNum(), lpp.getPageSize(), lpp.getSelectStr(), lpp.getFromStr());
		List<Record> list = page.getList();
		List<LiveInfo> result = new ArrayList<LiveInfo>();
		for(Record rd:list){
			LiveInfo li =new LiveInfo();
			li.bindingData(li, rd);
			result.add(li);
		}
		/**for(LiveInfo li:result){
			if(!li.getLiveStatus().isEmpty()){
				Dictionary dict = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+li.getLiveStatus()+"'");
				li.setLiveStatus(dict.getName());
			}
			if(!li.getLiveType().isEmpty()){
				Dictionary dict = Dictionary.dao.findFirst("select * from console_dictionary where dict_code='"+li.getLiveType()+"'");
				li.setLiveType(dict.getName());
			}
		}**/
		
		log.info("live list search finished");
		/***
		 * 保存数据列表
		 */
		this.setAttr("list", result);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(lpp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		/**
		 * 初始化直播状态列表
		 */
		List<Dict> live_statuses = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("live_status"), 1).getSubDictionaries();
		setAttr("live_statuses",live_statuses);
		
		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/live/lives.jsp");
	}
	
	private class LiveParamsParser extends ParamsParser{

		public LiveParamsParser(Controller ct) {
			super(ct);
			
			this.setSelectStr("select pl.*,cu.user_name as steward_name ");
			this.setFromStr("from portal_live as pl left join crm_steward_user as csu on pl.live_steward_id=csu.steward_id left join console_user as cu on csu.user_id=cu.user_id");
			
			//查找有效数据
			this.addWhereSegmentByAnd("pl.delete_flag='0'");
					
			//查询条件
			String live_title = this.getNormStr("live_title");
			if(live_title!=null){
				this.addWhereSegmentByAnd("pl.live_title like '%"+live_title+"%'");
				setAttr("live_title",live_title);
			}
			
			String living_time = this.getAllStr("living_time");
			if(living_time!=null){
				this.addWhereSegmentByAnd("pl.live_start_time>='"+living_time+"'");
				setAttr("living_time",living_time);
			}
			
			String living_time1 = this.getAllStr("living_time1");
			if(living_time1!=null){
				this.addWhereSegmentByAnd("pl.live_end_time<='"+living_time1+"'");
				setAttr("living_time1",living_time1);
			}
			
			String live_status = this.getNormStr("live_status");
			if(live_status!=null){
				this.addWhereSegmentByAnd("pl.live_status='"+live_status+"'");
				setAttr("live_status",live_status);
			}
			
			String steward_name = this.getNormStr("steward_name");
			if(steward_name!=null){
				this.addWhereSegmentByAnd("cu.user_name like '%"+steward_name+"%'");
				setAttr("steward_name",steward_name);
			}
			
			String create_time = this.getAllStr("create_time");
			if(create_time!=null){
				this.addWhereSegmentByAnd("pl.create_time>="+create_time);
				setAttr("create_time",create_time);
			}
			
			String create_time1 = this.getAllStr("create_time1");
			if(create_time1!=null){
				this.addWhereSegmentByAnd("pl.create_time<="+create_time1);
				setAttr("create_time1",create_time1);
			}
			
			//默认排序
			this.setDefaultOrderStr("order by pl.create_time desc");
		}
		
	}
	
	public void add(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation")!=null){
			
			Live live = new Live();
			String live_title = pp.getNormStr("live_title");
			if(live_title!=null){
				live.setLiveTitle(live_title);
			}
			
			String live_poster = pp.getAllStr("live_poster");
			if(live_poster!=null){
				live.setLivePoster(live_poster);
			}
			
			String live_introduce = pp.getNormStr("live_introduce");
			if(live_introduce!=null){
				live.setLiveIntroduce(live_introduce);
			}
			
			String live_limit = pp.getInt("live_limit");
			if(live_limit!=null){
				live.setLiveLimit(Integer.valueOf(live_limit));
			}
			
			String signup_start_time = pp.getAllStr("signup_start_time");
			if(signup_start_time!=null){
				live.setSignupStartTime(TpyDateUtil.strToDate(signup_start_time));
			}

			String signup_end_time = pp.getAllStr("signup_end_time");
			if(signup_end_time!=null){
				live.setSignupEndTime(TpyDateUtil.strToDate(signup_end_time));
			}
			
			String live_start_time = pp.getAllStr("live_start_time");
			if(live_start_time!=null){
				live.setLiveStartTime(TpyDateUtil.strToDateLong(live_start_time));
			}
			
			String live_type = pp.getAllStr("live_type");
			if(live_type!=null){
				live.setLiveType(live_type);
			}
			
			String live_steward_id = pp.getNormStr("live_steward_id");
			if(live_steward_id!=null)
				live.setLiveStewardId(Integer.valueOf(live_steward_id));
			
			live.setLiveStatus("未发布");
			live.setChannelId(getLiveChannelId());
			
			live.save();
			/***
			 * 跳转到跳出时列表页地址
			 */
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else{
			List<Steward> stewards = new ArrayList<Steward>();
			List<Record> stewardList = Db.find("select csu.steward_id,cu.user_name from crm_steward_user as csu,console_user as cu where csu.user_id=cu.user_id and csu.delete_flag='0' and csu.release_mark='已发布' order by csu.create_time desc");
			for(Record rc:stewardList){
				Steward steward = new Steward();
				steward.setStewardId(rc.getInt("steward_id"));
				steward.setStewardName(rc.getStr("user_name"));
				stewards.add(steward);
			}
			setAttr("stewards",stewards);
			
			List<Dict> live_typies = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("live_type"), 1).getSubDictionaries();
			setAttr("live_typies",live_typies);
			
			setAttr("operation","新增");
			
			this.renderJsp("/views/live/live.jsp");
		}
	}
	
	public void update(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			String operation = pp.getNormStr("operation");
			if(operation!=null){
				Live live = Live.dao.findById(id);
				/**
				 * 字段修改
				 */
				String live_title = pp.getNormStr("live_title");
				if(live_title!=null){
					live.setLiveTitle(live_title);
				}
				
				String live_poster = pp.getAllStr("live_poster");
				if(live_poster!=null){
					live.setLivePoster(live_poster);
				}
				
				String live_introduce = pp.getNormStr("live_introduce");
				if(live_introduce!=null){
					live.setLiveIntroduce(live_introduce);
				}
				
				String live_limit = pp.getInt("live_limit");
				if(live_limit!=null){
					live.setLiveLimit(Integer.valueOf(live_limit));
				}
				
				String signup_start_time = pp.getAllStr("signup_start_time");
				if(signup_start_time!=null){
					live.setSignupStartTime(TpyDateUtil.strToDate(signup_start_time));
				}

				String signup_end_time = pp.getAllStr("signup_end_time");
				if(signup_end_time!=null){
					live.setSignupEndTime(TpyDateUtil.strToDate(signup_end_time));
				}
				
				String live_start_time = pp.getAllStr("live_start_time");
				if(live_start_time!=null){
					live.setLiveStartTime(TpyDateUtil.strToDateLong(live_start_time));
				}
				
				String live_type = pp.getAllStr("live_type");
				if(live_type!=null){
					live.setLiveType(live_type);
				}
				
				String live_steward_id = pp.getNormStr("live_steward_id");
				if(live_steward_id!=null)
					live.setLiveStewardId(Integer.valueOf(live_steward_id));
				
				live.update();
				
				/**
				 * 跳转
				 */
				String fromurl = getPara("fromurl");
				this.redirect(fromurl);
			}
			else{
				Live live = Live.dao.findById(id);
				if(live!=null){
					this.setAttr("live", live);
					this.setAttr("operation", "编辑");
					
					List<Steward> stewards = new ArrayList<Steward>();
					List<Record> stewardList = Db.find("select csu.steward_id,cu.user_name from crm_steward_user as csu,console_user as cu where csu.user_id=cu.user_id and csu.delete_flag='0' and csu.release_mark='已发布' order by csu.create_time desc");
					for(Record rc:stewardList){
						Steward steward = new Steward();
						steward.setStewardId(rc.getInt("steward_id"));
						steward.setStewardName(rc.getStr("user_name"));
						stewards.add(steward);
					}
					setAttr("stewards",stewards);
					
					List<Dict> live_typies = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("live_type"), 1).getSubDictionaries();
					setAttr("live_typies",live_typies);
					
					this.renderJsp("/views/live/live.jsp");
				}
				else{
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			}
		}
		else
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
	/**
	 * 发布
	 */

	public void publish(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Map<String,Object> rst = new HashMap<String,Object>();
		
		if(id!=null){
			Live live = Live.dao.findById(id);
			if(live!=null){
				live.setLiveStatus("已发布");
				live.update();
				
				rst.put("status", 0);
				rst.put("msg","发布成功,请到直播频道查看" );
				this.renderJson(rst);
			}
			else{
				rst.put("status", 100);
				rst.put("msg","无此直播间" );
				this.renderJson(rst);
			}
		}
		else{
			rst.put("status", 1);
			rst.put("msg","参数错误" );
			this.renderJson(rst);
		}
		
	}
	
	/**
	 * 下线
	 */
	
	public void offline(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Map<String,Object> rst = new HashMap<String,Object>();
		
		if(id!=null){
			Live live = Live.dao.findById(id);
			if(live!=null){
				live.setLiveStatus("未发布");
				live.update();
				
				rst.put("status", 0);
				rst.put("msg","撤销发布成功" );
				this.renderJson(rst);
			}
			else{
				rst.put("status", 100);
				rst.put("msg","无此直播间" );
				this.renderJson(rst);
			}
		}
		else{
			rst.put("status", 1);
			rst.put("msg","参数错误" );
			this.renderJson(rst);
		}
	}

	
	public void start(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Map<String,Object> rst = new HashMap<String,Object>();
		
		if(id!=null){
			Live live = Live.dao.findById(id);
			if(live!=null){
				live.setLiveStatus("直播中");
				live.setLiveStartTime(new Date());
				live.update();
				
				rst.put("status", 0);
				rst.put("msg","直播启动成功" );
				this.renderJson(rst);
			}
			else{
				rst.put("status", 100);
				rst.put("msg","无此直播间" );
				this.renderJson(rst);
			}
		}
		else{
			rst.put("status", 1);
			rst.put("msg","参数错误" );
			this.renderJson(rst);
		}
	}
	
	private int getLiveChannelId(){
		String sql="select * from portal_channel where used=0 order by ctime desc";
		Channel channel = Channel.dao.findFirst(sql);
		if(channel!=null){
			channel.setUsed(1);
			channel.update();
			return channel.getChannelId();
		}
		else{
			String jstr = LiveUtil.CreateChannel(MajorKeyFactory.getInstance().getMajorKey());
			JSONObject json = new JSONObject(jstr);
	        int code =json.getInt("code");
	        if(code==200){
	        	JSONObject ret = json.getJSONObject("ret");
	        		channel = new Channel();
	        		channel.setCid(ret.getString("cid"));
	        		channel.setPushUrl(ret.getString("pushUrl"));
	        		channel.setHlsPullUrl(ret.getString("hlsPullUrl"));
	        		channel.setHttpPullUrl(ret.getString("httpPullUrl"));
	        		channel.setName(ret.getString("name"));
	        		channel.setRtmpPullUrl(ret.getString("rtmpPullUrl"));
	        		channel.setUsed(1);
	        		
	        		channel.save();
	        		
	        		return channel.getChannelId();
	        }
			
		}
		return 0;
	}

	public void signup(){
		try{
			SignUpUsersParams params = new SignUpUsersParams(this);
			
			Live live = Live.dao.findById(params.getId());
			setAttr("live_title",live.getLiveTitle());
			
			//列表数据
			Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
			List<Record> list = page.getList();
			
			this.setAttr("list", list);
			
			//翻页
			String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/live/live_room_signup_users.jsp");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void signupCheck(){
		ParamsParser pp = new ParamsParser(this);
		String type = pp.getInt("type");
		String aid = pp.getId();
		
		Map<String,Object> rst = new HashMap<String,Object>();
		LiveApplication la = LiveApplication.dao.findById(aid);
		if(la==null){
			rst.put("status", 100);
			rst.put("msg", "无此记录！");
			this.renderJson(rst);
			return ;
		}
			
		if(type!=null && aid!=null){
			if(type.equals("0")){
				la.setStatus("002700020001");
				la.update();
				
				rst.put("status", 0);
				rst.put("msg", "开通成功！");
				this.renderJson(rst);
			}
			else{
				la.setStatus("002700020002");
				la.update();
				
				rst.put("status", 0);
				rst.put("msg", "驳回成功！");
				this.renderJson(rst);
			}
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "参数错误！");
			this.renderJson(rst);
		}
	}
	
	public void channel(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		
		if(id!=null){
			Live live = Live.dao.findById(id);
			if(live!=null){
				setAttr("live",live);
				if(live.getChannelId()!=null){
					Channel channel = Channel.dao.findById(live.getChannelId());
					setAttr("channel",channel);
					this.renderJsp("/views/live/live_channel.jsp");
				}
				else{
					this.setAttr("errorInfo", "视频频道未开通!");
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
			}
			else{
				this.setAttr("errorInfo", "无此直播间!");
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}
		else{
			this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 在线用户
	 * @author Gorge
	 *
	 */
	private class SignUpUsersParams extends ParamsParser{
		
		public SignUpUsersParams(Controller ctr) {
			super(ctr);
			
			Prop p = PropKit.use("constants.txt");
			
			this.setSelectStr("select la.application_id,la.live_id,la.custinfo_id,la.create_time,la.status,"+
							"c.name,c.phone_num,d2.name as city");
			this.setFromStr("from portal_live_application la left join crm_custinfo c on la.custinfo_id = c.custinfo_id "+
							"left join console_dictionary d2 on c.city = d2.dict_code and d2.delete_flag = 0 ");
			this.addWhereSegmentByAnd("la.application_method = '"+p.get("apply")+"'");
			this.addWhereSegmentByAnd("la.live_id = "+this.getId());
			
			this.setDefaultOrderStr("order by la.create_time desc");
		}
	}
}
