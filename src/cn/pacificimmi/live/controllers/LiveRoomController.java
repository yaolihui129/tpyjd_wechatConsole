package cn.pacificimmi.live.controllers;

import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Channel;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.Live;
import cn.pacificimmi.common.models.LiveApplication;
import cn.pacificimmi.common.models.LiveMessage;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.MsgUtils;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.TpyDateUtil;
/**直播间控制器
*@author Gorge
*2017年3月14日
*/
@Before(LoginInterCeptor.class)
public class LiveRoomController extends Controller {
	private static Logger log = LoggerFactory.getLogger(LiveRoomController.class);
	/**
	 * 在线用户
	 */
	public void index(){
		Prop p = PropKit.use("constants.txt");
		try{
			this.setAttr("living", p.get("live_status_living_name"));//直播中
			ParamsParser pp = new ParamsParser(this);
			String liveId = pp.getId();
			this.setAttr("liveId", liveId);
			Live live = Live.dao.findById(liveId);
			this.setAttr("live", live);
			long[] dhms = new long[]{};
			if(live != null){
				dhms = TpyDateUtil.getDistanceTimesNow(live.getLiveStartTime());
				Channel ch = Channel.dao.findById(live.getChannelId());
				this.setAttr("channel", ch);
			}else{
				dhms = TpyDateUtil.getDistanceTimesNow(new Date());
			}
			this.setAttr("d", dhms[0]);
			this.setAttr("h", dhms[1]);
			this.setAttr("m", dhms[2]);
			this.setAttr("s", dhms[3]);
			
			OnlineUsersParams params = new OnlineUsersParams(this);

			//列表数据
			Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
			List<Record> list = page.getList();
			for(Record r : list){
				r.set("timeOnline", TpyDateUtil.getDistanceMinutes(r.get("online_time")));
			}
			this.setAttr("list", list);
			
			//翻页
			String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/live/live_room_online_users.jsp");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 取消资格
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void cancelParticipation(){
		LoginUserInfo u = getSessionAttr("LoginUserInfo");
		Map<String,Object> rst = new HashMap<String,Object>();
		Prop p = PropKit.use("constants.txt");
		try{
			ParamsParser pp = new ParamsParser(this);
			LiveApplication la = LiveApplication.dao.findById(pp.getId());
			if(la !=null){
				la.setStatus(p.get("cancel_participation"));
				la.setOnlineStatus("0");
				la.setCancelOperator(Integer.parseInt(u.getUid()));
				la.setCancelOperatorName(u.getLoginName());
				la.setCancelTime(new Date());
				la.update();
				
				rst.put("status", 0);
				rst.put("msg", "取消参与资格成功");
			}else{
				log.debug("申请信息不存在");
				rst.put("status", 1);
				rst.put("msg", "申请信息不存在");
			}
			
		}catch(Exception e){
			log.error("取消参与资格时" + e.getMessage(), e);
			rst.put("status", 1);
			rst.put("msg", "取消参与资格失败");
		}finally {
			this.renderJson(rst);
		}
	}
	
	/**
	 * 临时申请
	 */
	public void application(){
		Prop p = PropKit.use("constants.txt");
		try{
			this.setAttr("living", p.get("live_status_living_name"));//直播中
			ParamsParser pp = new ParamsParser(this);
			String liveId = pp.getId();
			this.setAttr("liveId", liveId);
			Live live = Live.dao.findById(liveId);
			this.setAttr("live", live);
			
			long[] dhms = new long[]{};
			if(live != null){
				dhms = TpyDateUtil.getDistanceTimesNow(live.getLiveStartTime());
				Channel ch = Channel.dao.findById(live.getChannelId());
				this.setAttr("channel", ch);
			}else{
				dhms = TpyDateUtil.getDistanceTimesNow(new Date());
			}
			this.setAttr("d", dhms[0]);
			this.setAttr("h", dhms[1]);
			this.setAttr("m", dhms[2]);
			this.setAttr("s", dhms[3]);
			
			TempApplicationParams params = new TempApplicationParams(this);

			//列表数据
			Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
			List<Record> list = page.getList();
			this.setAttr("list", list);
			
			//翻页
			String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/live/live_room_temp_application.jsp");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 短信发送听课码
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void sendInvitationCode(){
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			ParamsParser pp = new ParamsParser(this);
			
			LiveApplication la = LiveApplication.dao.findById(pp.getId());
			if(null != la){
				Custinfo c = Custinfo.dao.findById(la.getCustinfoId());
				Live l = Live.dao.findById(la.getLiveId());
				Channel ch = Channel.dao.findById(l.getChannelId());
				
				String invitationCode = la.getInvitationCode();
				if(null == invitationCode || invitationCode.isEmpty()){
					invitationCode = StringUtil.getInvitationCode();
					la.setInvitationCode(invitationCode);
					la.update();
				}
				
				
				//发送短信
				MsgUtils.sendLiveInvitationCode(c.getPhoneNum(), invitationCode, l.getLiveTitle(), TpyDateUtil.dateToStrLong(l.getLiveStartTime()), ch.getRtmpPullUrl());
				
				rst.put("status", 0);
				rst.put("msg", "删除成功");
			}else{
				log.debug("申请信息不存在");
				rst.put("status", 1);
				rst.put("msg", "申请信息不存在,发码失败");
			}
			
		}catch(Exception e){
			log.error("发送短信码时" + e.getMessage(), e);
			rst.put("status", 1);
			rst.put("msg", "发码失败");
		}finally {
			this.renderJson(rst);
		}
	}
	
	
	/**
	 * 用户留言
	 */
	public void message(){
		Prop p = PropKit.use("constants.txt");
		try{
			this.setAttr("living", p.get("live_status_living_name"));//直播中
			ParamsParser pp = new ParamsParser(this);
			String liveId = pp.getId();
			this.setAttr("liveId", liveId);
			Live live = Live.dao.findById(liveId);
			this.setAttr("live", live);
			long[] dhms = new long[]{};
			if(live != null){
				dhms = TpyDateUtil.getDistanceTimesNow(live.getLiveStartTime());
				Channel ch = Channel.dao.findById(live.getChannelId());
				this.setAttr("channel", ch);
			}else{
				dhms = TpyDateUtil.getDistanceTimesNow(new Date());
			}
			this.setAttr("d", dhms[0]);
			this.setAttr("h", dhms[1]);
			this.setAttr("m", dhms[2]);
			this.setAttr("s", dhms[3]);
			
			LiveMessageParams params = new LiveMessageParams(this);

			//列表数据
			Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
			List<Record> list = page.getList();
			for(Record r:list){
				if(null != r.getStr("contents") && !r.getStr("contents").isEmpty() && !"NULL".equalsIgnoreCase(r.getStr("contents"))){
					r.set("contents", URLDecoder.decode(r.getStr("contents"), "UTF-8"));
				}
				
			}
			this.setAttr("list", list);
			
			//翻页
			String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
			setAttr("pageBar",pagesView);
			
			this.renderJsp("/views/live/live_room_messages.jsp");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 删除留言
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delMessage(){
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			ParamsParser pp = new ParamsParser(this);
			
			LiveMessage lm = LiveMessage.dao.findById(pp.getId());
			if(lm != null){
				lm.setDeleteFlag(1);
				lm.update();
			}else{
				log.error("留言不存在");
			}
			rst.put("status", 0);
			rst.put("msg", "删除成功");
		}catch(Exception e){
			log.error("删除直播留言时" + e.getMessage(), e);
			rst.put("status", 1);
			rst.put("msg", "发码失败");
		}finally {
			this.renderJson(rst);
		}
	}
	
	/**
	 * 结束直播
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void endLive(){
		Map<String,Object> rst = new HashMap<String,Object>();
		Prop p = PropKit.use("constants.txt");
		try{
			ParamsParser pp = new ParamsParser(this);
			Live live = Live.dao.findById(pp.getId());
			if(live != null){
				live.setLiveEndTime(new Date());
				live.setLiveStatus(p.get("live_status_ended_name"));
				live.update();
			}else{
				log.error("直播不存在");
			}
			rst.put("status", 0);
			rst.put("msg", "结束直播成功");
		}catch(Exception e){
			log.error("结束直播时" + e.getMessage(), e);
			rst.put("status", 1);
			rst.put("msg", "结束直播失败");
		}finally {
			this.renderJson(rst);
		}
	}
	
	/**
	 * 在线用户
	 * @author Gorge
	 *
	 */
	private class OnlineUsersParams extends ParamsParser{
		
		public OnlineUsersParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select la.application_id,la.live_id,la.custinfo_id,la.online_time,"+
							"c.name,c.phone_num,d2.name as city,d1.name as application_method");
			this.setFromStr("from portal_live_application la left join crm_custinfo c on la.custinfo_id = c.custinfo_id "+
							"left join console_dictionary d1 on la.application_method = d1.dict_code and d1.delete_flag = 0 " +
							"left join console_dictionary d2 on c.city = d2.dict_code and d2.delete_flag = 0 ");
			this.addWhereSegmentByAnd("la.online_status = '1' ");
			this.addWhereSegmentByAnd("la.live_id = "+this.getId());
			
			this.setDefaultOrderStr("order by la.online_time desc");
		}
	}
	
	/**
	 * 临时申请
	 * @author Gorge
	 *
	 */
	private class TempApplicationParams extends ParamsParser{
		
		public TempApplicationParams(Controller ctr) {
			super(ctr);
			Prop p = PropKit.use("constants.txt");
			
			this.setSelectStr("select a.application_id,a.create_time,a.invitation_code, c.name,c.phone_num,d1.name as province,d2.name as status");
			this.setFromStr("from portal_live_application a left join crm_custinfo c on a.custinfo_id = c.custinfo_id " +
							"left join console_dictionary d1 on c.province = d1.dict_code and d1.delete_flag = 0 "+
							"left join console_dictionary d2 on a.status = d2.dict_code and d2.delete_flag = 0 ");
			
			this.addWhereSegmentByAnd("a.live_id = "+this.getId());
			this.addWhereSegmentByAnd("a.application_method = '"+p.get("listening_code")+"'");
			
			this.setDefaultOrderStr("order by a.online_time desc");
		}
	}
	
	/**
	 * 直播留言
	 * @author Gorge
	 *
	 */
	private class LiveMessageParams extends ParamsParser{
		
		public LiveMessageParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select m.create_time,m.message_id,c.name,c.wx_name,c.phone_num,m.contents");
			this.setFromStr("from portal_live_message m left join crm_custinfo c on m.custinfo_id = c.custinfo_id");
			this.addWhereSegmentByAnd("m.delete_flag = 0 ");
			this.addWhereSegmentByAnd("m.live_id = "+this.getId());
			
			this.setDefaultOrderStr("order by m.message_id desc");
		}
	}
}
