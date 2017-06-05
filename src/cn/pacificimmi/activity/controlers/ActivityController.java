package cn.pacificimmi.activity.controlers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Activity;
import cn.pacificimmi.common.models.Topics;
import cn.pacificimmi.common.models.User;

@Before(LoginInterCeptor.class)
public class ActivityController extends Controller {
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");                
	
	public void index(){
		this.renderText("路径错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
	public void add(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getAllStr("operation")!=null){
			Activity activity = new Activity();
			String activity_name = pp.getAllStr("activity_name");
			if(activity_name!=null){
				activity.setActivityName(activity_name);
				//名称不能重复
				Activity ac = Activity.dao.findFirst("select * from crm_activity where activity_name='"+activity_name+"' and delete_flag='0'");
				if(ac!=null){
					/***
					 * 跳转到跳出时列表页地址
					 */
					String fromurl = getPara("fromurl");
					this.redirect(fromurl);
					return;
				}
			}
			
			
			String activity_mark = pp.getAllStr("activity_mark");
			if(activity_mark!=null){
				activity.setActivityMark(activity_mark);
			}
			
			/**
			String activity_sort = pp.getAllStr("activity_sort");
			if(activity_sort!=null){
				activity.setActivitySort(Integer.valueOf(activity_sort));
			}
			**/
			Activity rd = Activity.dao.findFirst("select * from crm_activity where delete_flag='0' order by activity_sort asc");
			if(rd!=null && rd.getActivitySort()!=null){
				Integer sort = rd.getActivitySort();
				sort--;
				activity.setActivitySort(sort);
			}
			
			String activity_thumb_image =  pp.getAllStr("activity_thumb_image");
			if(activity_thumb_image!=null){
				activity.setActivityThumbImage(activity_thumb_image);
			}
			
			String activity_image =  pp.getAllStr("activity_image");
			if(activity_image!=null){
				activity.setActivityImage(activity_image);
			}
			
			activity.setActivityStatus("未发布");
			
			String start_time = pp.getAllStr("start_time");
			if(start_time!=null){
				 try {
					Date date = sdf.parse(start_time);
					activity.setStartTime(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			
			String activity_type = pp.getNormStr("activity_type");
			if(activity_type!=null){
				activity.setActivityType(activity_type);
			}
			
			String end_time = pp.getAllStr("end_time");
			if(end_time!=null){
				 try {
					Date date = sdf.parse(end_time);
					activity.setEndTime(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			
			String activity_image1 =  pp.getAllStr("activity_image1");
			if(activity_image1!=null){
				activity.setActivityImage1(activity_image1);
			}
			
			String[] chks = this.getParaValues("position");
			String positions = "";
			boolean first = true;
			for(String c:chks){
				if(first){
					positions+=c;
					first=false;
				}
				else{
					positions+=",";
					positions+=c;
				}
			}
			activity.setPosition(positions);
			
			String url = pp.getAllStr("url");
			if(url!=null){
				activity.setUrl(url);
			}
			
			String activity_address = pp.getAllStr("activity_address");
			if(activity_address!=null){
				activity.setActivityAddress(activity_address);
			}
			
			activity.save();
			/***
			 * 跳转到跳出时列表页地址
			 */
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else{
			Dict activityType = DictionaryManager.getInstance().getAllSubDictionaries(PropKit.use("constants.txt").get("activityType"), 1);
			setAttr("activityType",activityType);
			
			//查询资讯推送位置
			List<Dict> pushList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
			setAttr("positions", pushList);
			
			this.setAttr("operation", "新增");
			this.renderJsp("/views/cms/activity.jsp");
		}
	}
	
	@Clear
	public void publish(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			Activity activity = Activity.dao.findById(id);
			
			String activity_name = pp.getAllStr("activity_name");
			if(activity_name!=null){
				activity.setActivityName(activity_name);
				//名称不能重复
				Activity ac = Activity.dao.findFirst("select * from crm_activity where activity_name='"+activity_name+"' and delete_flag='0' and activity_id<>'"+id+"'");
				if(ac!=null){
					/***
					 * 跳转到跳出时列表页地址
					 */
					String fromurl = getPara("fromurl");
					this.redirect(fromurl);
					return;
				}
			}
			
			String activity_mark = pp.getAllStr("activity_mark");
			if(activity_mark!=null){
				activity.setActivityMark(activity_mark);
			}
			
			String activity_sort = pp.getAllStr("activity_sort");
			if(activity_sort!=null){
				activity.setActivitySort(Integer.valueOf(activity_sort));
			}
			
			String activity_thumb_image =  pp.getAllStr("activity_thumb_image");
			if(activity_thumb_image!=null){
				activity.setActivityThumbImage(activity_thumb_image);
			}
		
			String activity_image =  pp.getAllStr("activity_image");
			if(activity_image!=null){
				activity.setActivityImage(activity_image);
			}
			
//			String activity_status = pp.getAllStr("activity_status");
//			if(activity_status!=null){
//				activity.setActivityStatus(activity_status);
//			}
			
			activity.setActivityStatus("已发布");
			
			String start_time = pp.getAllStr("start_time");
			if(start_time!=null){
				 try {
					Date date = sdf.parse(start_time);
					activity.setStartTime(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			
			String activity_type = pp.getNormStr("activity_type");
			if(activity_type!=null){
				activity.setActivityType(activity_type);
			}
			
			String end_time = pp.getAllStr("end_time");
			if(end_time!=null){
				 try {
					Date date = sdf.parse(end_time);
					activity.setEndTime(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			
			String activity_image1 =  pp.getAllStr("activity_image1");
			if(activity_image1!=null){
				activity.setActivityImage1(activity_image1);
			}
			
			String[] chks = this.getParaValues("position");
			String positions = "";
			boolean first = true;
			for(String c:chks){
				if(first){
					positions+=c;
					first=false;
				}
				else{
					positions+=",";
					positions+=c;
				}
			}
			activity.setPosition(positions);
			
			String url = pp.getAllStr("url");
			if(url!=null){
				activity.setUrl(url);
			}
			
			String activity_address = pp.getAllStr("activity_address");
			if(activity_address!=null){
				activity.setActivityAddress(activity_address);
			}
			
			activity.update();
			
			//跳转
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else{
			Activity activity = new Activity();
			String activity_name = pp.getAllStr("activity_name");
			if(activity_name!=null){
				activity.setActivityName(activity_name);
			}
			
			String activity_mark = pp.getAllStr("activity_mark");
			if(activity_mark!=null){
				activity.setActivityMark(activity_mark);
			}
			
			/**
			String activity_sort = pp.getAllStr("activity_sort");
			if(activity_sort!=null){
				activity.setActivitySort(Integer.valueOf(activity_sort));
			}
			**/
			Activity rd = Activity.dao.findFirst("select * from crm_activity where delete_flag='0' order by activity_sort asc");
			if(rd!=null && rd.getActivitySort()!=null){
				Integer sort = rd.getActivitySort();
				sort--;
				activity.setActivitySort(sort);
			}
			
			String activity_thumb_image =  pp.getAllStr("activity_thumb_image");
			if(activity_thumb_image!=null){
				activity.setActivityThumbImage(activity_thumb_image);
			}
			
			String activity_image =  pp.getAllStr("activity_image");
			if(activity_image!=null){
				activity.setActivityImage(activity_image);
			}
			
			String index_show = pp.getInt("index_show");
			if(index_show!=null){
				activity.setIndexShow(Integer.valueOf(index_show));
			}
			
			activity.setActivityStatus("已发布");
			
			String start_time = pp.getAllStr("start_time");
			if(start_time!=null){
				 try {
					Date date = sdf.parse(start_time);
					activity.setStartTime(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			
			String activity_type = pp.getNormStr("activity_type");
			if(activity_type!=null){
				activity.setActivityType(activity_type);
			}
			
			String end_time = pp.getAllStr("end_time");
			if(end_time!=null){
				 try {
					Date date = sdf.parse(end_time);
					activity.setEndTime(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			}
			
			String activity_image1 =  pp.getAllStr("activity_image1");
			if(activity_image1!=null){
				activity.setActivityImage1(activity_image1);
			}
			
			String[] chks = this.getParaValues("position");
			String positions = "";
			boolean first = true;
			for(String c:chks){
				if(first){
					positions+=c;
					first=false;
				}
				else{
					positions+=",";
					positions+=c;
				}
			}
			activity.setPosition(positions);
			
			String url = pp.getAllStr("url");
			if(url!=null){
				activity.setUrl(url);
			}
			
			String activity_address = pp.getAllStr("activity_address");
			if(activity_address!=null){
				activity.setActivityAddress(activity_address);
			}
			
			activity.save();
			/***
			 * 跳转到跳出时列表页地址
			 */
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
	}
	
	public void update(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			String operation = pp.getAllStr("operation");
			if(operation!=null){
				Activity activity = Activity.dao.findById(id);
				
				String activity_name = pp.getAllStr("activity_name");
				if(activity_name!=null){
					activity.setActivityName(activity_name);
					//名称不能重复
					Activity ac = Activity.dao.findFirst("select * from crm_activity where activity_name='"+activity_name+"' and delete_flag='0' and activity_id<>'"+id+"'");
					if(ac!=null){
						/***
						 * 跳转到跳出时列表页地址
						 */
						String fromurl = getPara("fromurl");
						this.redirect(fromurl);
						return;
					}
				}
				
				String activity_mark = pp.getAllStr("activity_mark");
				if(activity_mark!=null){
					activity.setActivityMark(activity_mark);
				}
				
				String activity_sort = pp.getAllStr("activity_sort");
				if(activity_sort!=null){
					activity.setActivitySort(Integer.valueOf(activity_sort));
				}
				
				String activity_thumb_image =  pp.getAllStr("activity_thumb_image");
				if(activity_thumb_image!=null){
					activity.setActivityThumbImage(activity_thumb_image);
				}
			
				String activity_image =  pp.getAllStr("activity_image");
				if(activity_image!=null){
					activity.setActivityImage(activity_image);
				}
				
				String start_time = pp.getAllStr("start_time");
				if(start_time!=null){
					 try {
						Date date = sdf.parse(start_time);
						activity.setStartTime(date);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}	
				}
				
				String activity_type = pp.getNormStr("activity_type");
				if(activity_type!=null){
					activity.setActivityType(activity_type);
				}
				
				String end_time = pp.getAllStr("end_time");
				if(end_time!=null){
					 try {
						Date date = sdf.parse(end_time);
						activity.setEndTime(date);
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}	
				}
				
				String activity_image1 =  pp.getAllStr("activity_image1");
				if(activity_image1!=null){
					activity.setActivityImage1(activity_image1);
				}
				
				String[] chks = this.getParaValues("position");
				String positions = "";
				boolean first = true;
				for(String c:chks){
					if(first){
						positions+=c;
						first=false;
					}
					else{
						positions+=",";
						positions+=c;
					}
				}
				activity.setPosition(positions);
				
				String url = pp.getAllStr("url");
				if(url!=null){
					activity.setUrl(url);
				}
				
				String activity_address = pp.getAllStr("activity_address");
				if(activity_address!=null){
					activity.setActivityAddress(activity_address);
				}
				
				activity.update();
				
				//跳转
				String fromurl = getPara("fromurl");
				this.redirect(fromurl);
			}
			else{
				Activity activity = Activity.dao.findById(id);
				if(activity!=null){
					this.setAttr("id", id);
					this.setAttr("activity", activity);
					this.setAttr("operation", "编辑");
					
					Dict activityType = DictionaryManager.getInstance().getAllSubDictionaries(PropKit.use("constants.txt").get("activityType"), 1);
					setAttr("activityType",activityType);
					
					//查询资讯推送位置
					List<Dict> pushList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
					setAttr("positions", pushList);
					
					this.renderJsp("/views/cms/activity.jsp");
				}
				else{
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			}
		}
		else
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
	@Clear
	public void offline(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			Activity activity = Activity.dao.findById(id);
			
			activity.setActivityStatus("已下线");
			activity.update();
			
			//跳转
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else{
			//跳转
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
	}
	
	@Clear
	public void chkActivity(){
		ParamsParser pp = new ParamsParser(this);
		String aname = pp.getAllStr("activity_name");
		if(aname!=null){
			Activity activity = Activity.dao.findFirst("select * from crm_activity where activity_name='"+aname+"' and delete_flag='0'");
			if(activity!=null){
				this.renderJson("{\"status\":500,\"msg\":\"exist item\"}");
			}
			else
				this.renderJson("{\"status\":0,\"msg\":\"ok\"}");
		}
		else
			this.renderJson("{\"status\":1,\"msg\":\"param error\"}");
	}
}
