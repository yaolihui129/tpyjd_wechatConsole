package cn.pacificimmi.activity.controlers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Activity;
import cn.pacificimmi.activity.models.view.ActivityInfo;

@Before(LoginInterCeptor.class) //用户权限拦截器
public class ActivitysController extends Controller {
	private static Logger log = LoggerFactory.getLogger(ActivitysController.class);
	public void index(){
		ActivityParams sp = new ActivityParams(this);
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();
		List<ActivityInfo> result = new ArrayList<ActivityInfo>();
		for(Record rd:list){
			ActivityInfo ti =new ActivityInfo();
			ti.bindingData(ti, rd);
			result.add(ti);
		}	
		log.info("Activity list search finished");
		/***
		 * 保存数据列表
		 */
		this.setAttr("list", result);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		Dict dict = DictionaryManager.getInstance().getAllSubDictionaries(PropKit.use("constants.txt").get("publish_status"), 1);
		setAttr("status",dict);
		
		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/cms/activitys.jsp");
	}
	
	/**
	 * 查询参数解析类
	 * @author jeff
	 */
	private class ActivityParams extends ParamsParser{

		public ActivityParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select activity_id as activityId,"
					+ "activity_name as activityName,"
					+ "activity_mark as activityMark,"
					+ "activity_sort as activitySort,"
					+ "activity_thumb_image as activityThumbImage,"
					+ "activity_image as activityImage,"
					+ "index_show as indexShow,"
					+ "activity_status as activityStatus,"
					+ "join_users as joinUsers,"
					+ "start_time as startTime,"
					+ "create_time as createTime,"
					+ "activity_type as activityType,"
					+ "activity_address as activityAddress");
			this.setFromStr("from crm_activity");
			
			//查找有效数据
			this.addWhereSegmentByAnd("delete_flag='0'");
					
			//查询名称
			String name = this.getAllStr("name");//this.getNormStr("name");
			if(name!=null){
				name = name.trim();
				this.addWhereSegmentByAnd("activity_name like '%"+name+"%'");
				setAttr("name",name);
			}
			String status = this.getNormStr("status");
			if(status!=null){
				setAttr("status_selected",status);
				this.addWhereSegmentByAnd("activity_status='"+status+"'");
			}
			this.setDefaultOrderStr("order by create_time desc");
		}
	}
	
	/***
	 * 
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove(){
		ActivityParams sp = new ActivityParams(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(!sp.getIds().isEmpty()){
			Db.update("update crm_activity set delete_flag='1' where activity_id in ("+sp.getIds()+")");
			rst.put("status", 0);
			rst.put("msg", "删除成功");
			this.renderJson(rst);		
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "删除失败");
			this.renderJson(rst);
		}
	}

	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void publish(){
		ActivityParams sp = new ActivityParams(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(!sp.getIds().isEmpty() && !sp.getInt("opt").isEmpty()){
			String opt = sp.getInt("opt");
			if(opt.equals("1")){
				Db.update("update crm_activity set activity_status='已发布' where activity_id in ("+sp.getIds()+")");
				rst.put("status", 0);
				rst.put("msg", "发布成功");
				this.renderJson(rst);	
			}
			else if(opt.equals("2")){
				Db.update("update crm_activity set activity_status='已下线' where activity_id in ("+sp.getIds()+")");
				rst.put("status", 0);
				rst.put("msg", "下线成功");
				this.renderJson(rst);
			}
			else{
				rst.put("status", 2);
				rst.put("msg", "参数错误");
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
	public void upsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		Activity t = Activity.dao.findById(id);
		Activity t1 = findPreOrNextOne(id,true);
		
		if(t!=null && t1!=null){
			if(t.getActivitySort()==t1.getActivitySort()){
				t.setActivitySort(t.getActivitySort()+1);
				t.update();
			}
			else{
				int sort = t1.getActivitySort();
				t1.setActivitySort(t.getActivitySort());
				t1.update();
				t.setActivitySort(sort);
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
	@Before(AjaxLoginInterCeptor.class)
	public void downsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		Activity t = Activity.dao.findById(id);
		Activity t1= findPreOrNextOne(id,false);
		if(t!=null && t1!=null){
			if(t.getActivitySort()==t1.getActivitySort()){
				t1.setActivitySort(t1.getActivitySort()+1);
				t1.update();
			}
			else{
				int sort = t1.getActivitySort();
				t1.setActivitySort(t.getActivitySort());
				t1.update();
				t.setActivitySort(sort);
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
	@Before(AjaxLoginInterCeptor.class)
	public void topsort(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Activity t = Activity.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(t!=null){
			int sort=10000;
			Record rd = Db.findFirst("select * from crm_activity where delete_flag='0' order by activity_sort desc");
			if(rd!=null && rd.getInt("activity_sort")!=null){
				sort = rd.getInt("activity_sort");
			}
			sort++;
			t.setActivitySort(sort);
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
	
	private Activity findPreOrNextOne(String id,boolean flag){
		List<Activity> acts = Activity.dao.find("select * from crm_activity where delete_flag='0' order by activity_sort desc");
		Activity pre=null;
		Activity next=null;
		for(int i=0;i<acts.size();i++){
			Activity act = acts.get(i);
			if(act.getActivityId()==Integer.valueOf(id)){
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
