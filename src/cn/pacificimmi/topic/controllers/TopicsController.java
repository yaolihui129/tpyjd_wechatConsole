package cn.pacificimmi.topic.controllers;

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
import cn.pacificimmi.common.controllers.IndexController;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Activity;
import cn.pacificimmi.common.models.TopicSetting;
import cn.pacificimmi.common.models.Topics;
import cn.pacificimmi.topic.models.view.TopicInfo;

@Before(LoginInterCeptor.class) //用户权限拦截器
public class TopicsController extends Controller {
	private static Logger log = LoggerFactory.getLogger(TopicsController.class);
	public void index(){
		TopicParams sp = new TopicParams(this);
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();
		List<TopicInfo> result = new ArrayList<TopicInfo>();
		for(Record rd:list){
			TopicInfo ti =new TopicInfo();
			ti.bindingData(ti, rd);
			result.add(ti);
		}	
		log.info("topic list search finished");
		
		/***
		 * 保存数据列表
		 */
		this.setAttr("list", result);
		
		/*** 
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		Dict status = DictionaryManager.getInstance().getAllSubDictionaries(PropKit.use("constants.txt").get("publish_status"), 1);
		setAttr("status",status);
		
		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/cms/topics.jsp");
	}
	
	public void setting(){
		String opt = this.getPara("opt");
		if(opt!=null && opt.equals("1")){
			ParamsParser pp = new ParamsParser(this);
			TopicSetting ts = TopicSetting.dao.findFirst("select * from crm_topic_setting");
			if(ts!=null){
				String wechat_number = pp.getInt("wechat_number");
				if(wechat_number!=null){
					ts.setWechatNumber(Integer.valueOf(wechat_number));
				}
				
				String wechat_frequency = pp.getInt("wechat_frequency");
				if(wechat_frequency!=null){
					ts.setWechatFrequency(Integer.valueOf(wechat_frequency));
				}
				
				String official_number = pp.getInt("official_number");
				if(official_number!=null){
					ts.setOfficialNumber(Integer.valueOf(official_number));
				}
				
				String official_frequency = pp.getInt("official_frequency");
				if(official_frequency!=null){
					ts.setOfficialFrequency(Integer.valueOf(official_frequency));
				}
				
				ts.update();
			}
			else{
				ts = new TopicSetting();
				
				String wechat_number = pp.getInt("wechat_number");
				if(wechat_number!=null){
					ts.setWechatNumber(Integer.valueOf(wechat_number));
				}
				
				String wechat_frequency = pp.getInt("wechat_frequency");
				if(wechat_frequency!=null){
					ts.setWechatFrequency(Integer.valueOf(wechat_frequency));
				}
				
				String official_number = pp.getInt("official_number");
				if(official_number!=null){
					ts.setOfficialNumber(Integer.valueOf(official_number));
				}
				
				String official_frequency = pp.getInt("official_frequency");
				if(official_frequency!=null){
					ts.setOfficialFrequency(Integer.valueOf(official_frequency));
				}
				
				ts.save();
			}
			
			/***
			 * 跳转到跳出时列表页地址
			 */
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else{
			TopicSetting ts = TopicSetting.dao.findFirst("select * from crm_topic_setting");
			if(ts!=null){
				setAttr("setting",ts);
			}
			this.renderJsp("/views/cms/setting.jsp");
		}
	}
	
	/**
	 * 查询参数解析类
	 * @author jeff
	 */
	private class TopicParams extends ParamsParser{

		public TopicParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select topic_id as topicId,"
					+ "topic_name as topicName,"
					+ "topic_mark as topicMark,"
					+ "topic_sort as topicSort,"
					+ "topic_url as topicUrl,"
					+ "topic_image as topicImage,"
					+ "edit_user as editUser,"
					+ "update_time as updateTime,"
					+ "topic_status as topicStatus,"
					+ "send_position as sendPosition,"
					+ "hits as hits,"
					+ "create_user as createUser,"
					+ "delete_user as deleteUser,"
					+ "release_user as releaseUser,"
					+ "release_time as releaseTime");
			this.setFromStr("from crm_topics");
			
			//查找有效数据
			this.addWhereSegmentByAnd("delete_flag='0'");
					
			//查询名称
			String name = this.getNormStr("name");
			if(name!=null){
				this.addWhereSegmentByAnd("topic_name like '%"+name+"%'");
				setAttr("name",name);
			}
			
			String status = this.getNormStr("status");
			if(status!=null){
				setAttr("status_selected",status);
				this.addWhereSegmentByAnd("topic_status='"+status+"'");
			}
			this.setDefaultOrderStr("order by topic_sort desc");
		}
	}
	
	/***
	 * 
	 */
	//@Before(Tx.class)
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void remove(){
		TopicParams sp = new TopicParams(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(!sp.getIds().isEmpty()){
			Db.update("update crm_topics set delete_flag='1' where topic_id in ("+sp.getIds()+")");
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
	public void upsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		Topics t = Topics.dao.findById(id);
		Topics t1 = findPreOrNextOne(id,true);
		
		if(t!=null && t1!=null){
			if(t.getTopicSort()==t1.getTopicSort()){
				t.setTopicSort(t.getTopicSort()+1);
				t.update();
			}
			else{
				int sort = t1.getTopicSort();
				t1.setTopicSort(t.getTopicSort());
				t1.update();
				t.setTopicSort(sort);
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
		
		Topics t = Topics.dao.findById(id);
		Topics t1= findPreOrNextOne(id,false);
		if(t!=null && t1!=null){
			if(t.getTopicSort()==t1.getTopicSort()){
				t1.setTopicSort(t1.getTopicSort()+1);
				t1.update();
			}
			else{
				int sort = t1.getTopicSort();
				t1.setTopicSort(t.getTopicSort());
				t1.update();
				t.setTopicSort(sort);
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
		Topics t = Topics.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(t!=null){
			int sort=10000;
			Record rd = Db.findFirst("select * from crm_topics where  delete_flag='0' order by topic_sort desc");
			if(rd!=null && rd.getInt("topic_sort")!=null){
				sort = rd.getInt("topic_sort");
			}
			sort++;
			t.setTopicSort(sort);
			t.update();
			rst.put("status", 0);
			rst.put("msg", "置顶成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "置顶失败");
			this.renderJson(rst);
		}
	}
	
	private Topics findPreOrNextOne(String id,boolean flag){
		List<Topics> tops = Topics.dao.find("select * from crm_topics where delete_flag='0' order by topic_sort desc");
		Topics pre=null;
		Topics next=null;
		for(int i=0;i<tops.size();i++){
			Topics act = tops.get(i);
			if(act.getTopicId()==Integer.valueOf(id)){
				int pidx=i-1;
				int nidx=i+1;
				if(pidx>-1)
					pre=tops.get(pidx);
				if(nidx<tops.size())
					next=tops.get(nidx);
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
