package cn.pacificimmi.official.controllers;

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
import cn.pacificimmi.common.models.Honor;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.ConstantUtil;
/**
 * 荣誉图片
 * @author Gorge
 *
 */
@Before(LoginInterCeptor.class)
public class HonorController extends Controller {
	private Logger log = LoggerFactory.getLogger(HonorController.class);
	private Prop dp = PropKit.use("debug_config.txt");
	
	/**
	 * 列表页
	 */
	public void index(){
		HonorParams sp = new HonorParams(this);
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();
		

		/***
		 * 保存数据列表
		 */
		this.setAttr("list", list);
		this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		

		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/official/about/honor_list.jsp");
	}
	
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class HonorParams extends ParamsParser{

		public HonorParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select * ");
			this.setFromStr("from official_honor ");
			
			//查找有效数据
			this.addWhereSegmentByAnd(" delete_flag = 0");
					
			//职位名称
			String title = this.getAllStr("title");
			if(title!=null && !title.isEmpty()){
				this.addWhereSegmentByAnd(" title like '%"+title.trim()+"%'");
				setAttr("title", title.trim());
			}
				
			
			
			this.setDefaultOrderStr("order by sort desc");
		}
	}
	
	
	/**
	 * 保存
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void save(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		LoginUserInfo u = getSessionAttr("LoginUserInfo");
		try{
			String ohId = pp.getAllStr("oh_id");
			String title = pp.getAllStr("title");
			if(null != ohId && !ohId.isEmpty()){
				Honor honor = Honor.dao.findById(ohId);
				honor.setEditor(u.getLoginName());
				honor.setEditTime(new Date());
				honor.setTitle(title);
				
				honor.update();
			}else{
				Honor honor = new Honor();
				honor.setCreateTime(new Date());
				honor.setCteator(u.getLoginName());
				honor.setStatus("未发布");
				honor.setTitle(title);
				Record record = Db.findFirst("select max(sort) maxSort from official_honor where delete_flag = 0 ");
				if(!(record == null || record.get("maxSort") == null || record.get("maxSort").toString().isEmpty())){
					honor.setSort(Integer.parseInt(record.get("maxSort").toString()) + 1);
				}else{
					honor.setSort(1);
				}
				
				honor.save();
			}
			rst.put("status", 0);
			rst.put("msg", "保存成功");
		}catch(Exception e){
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "保存失败");
		}
		this.renderJson(rst);
	}
	
	/**
	 * 发布
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void publish(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		rst.put("code", 0);
		rst.put("msg", "发布成功");
		try{
			String ohId = pp.getId();
			List<Record> imgList = Db.find("select ohi_id from official_honor_imgs where delete_flag = 0 and oh_id ="+ohId);
			if(imgList != null && imgList.size() > 0){
				Honor h = Honor.dao.findById(ohId);
				h.setStatus("已发布");
				h.update();
			}else{
				rst.put("code", 1);
				rst.put("msg", "发布失败，请上传图片");
			}
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("code", 1);
			rst.put("msg", "发布失败，服务异常");
		}
		this.renderJson(rst);
	}
	
	/**
	 * 下线
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void downline(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		rst.put("code", 0);
		rst.put("msg", "下线成功");
		try{
			Honor h = Honor.dao.findById(pp.getId());
			h.setStatus("未发布");
			h.update();
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("code", 1);
			rst.put("msg", "下线成功，服务异常");
		}
		this.renderJson(rst);
	}
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(pp.getIds() != null && !pp.getIds().isEmpty()){
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				String failMsg = "";
				for(String id : ids){
					int rlt = Db.update("update official_honor set delete_flag = 1 where oh_id = " + id);
					if(rlt > 0){
						success++;
					}else{
						fail++;
					}
				}
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "删除成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除结果：成功[" + success + "],失败["+ fail +"]."+failMsg);
					this.renderJson(rst);
				}
			}else{
				log.error("删除荣誉资质信息出错：参数ID缺失");
				this.setAttr("errorInfo", "删除荣誉资质信息时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除荣誉资质信息时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 上移
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void upsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		Honor r = Honor.dao.findById(id);
		Honor r1= findPreOrNextOne(id,true);
		
		if(r!=null && r1!=null){
			//交换排序
			int t1 = r.getSort();
			int t2 = r1.getSort();
			
			r.setSort(t2);
			r.update();
			
			r1.setSort(t1);
			r1.update();

			rst.put("status", 0);
			rst.put("msg", "上移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "上移失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * 下移
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void downsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		Honor r = Honor.dao.findById(id);
		Honor r1= findPreOrNextOne(id,false);
		if(r!=null && r1!=null){
			//交换排序
			int t1 = r.getSort();
			int t2 = r1.getSort();
			
			r.setSort(t2);
			r.update();
			
			r1.setSort(t1);
			r1.update();
			
			rst.put("status", 0);
			rst.put("msg", "下移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "下移失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * 置顶
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void topsort(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		Honor rt = Honor.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(rt !=null){
			
			int sort = rt.getSort();
			Record r = Db.findFirst("select max(sort) maxSort from official_honor where delete_flag = 0 ");
			if(!(r == null || r.get("maxSort") == null || r.get("maxSort").toString().isEmpty())){
				sort = Integer.parseInt(r.get("maxSort").toString()) + 1;
			}
			
			rt.setSort(sort);
			if(rt.update()){
				rst.put("status", 0);
				rst.put("msg", "置顶成功");
			}else{
				rst.put("status", 100);
				rst.put("msg", "置顶失败");
			}
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "置顶失败");
			this.renderJson(rst);
		}
	}
	
	
	/**
	 * @param id 当前id
	 * @param flag true 上一个     false  下一个
	 * @return 
	 */
	private Honor findPreOrNextOne(String id,boolean flag){
		Honor r = Honor.dao.findById(Integer.parseInt(id));
		if(r!=null){
			List<Honor> rs = Honor.dao.find("select * from official_honor where delete_flag = 0 order by sort desc");
			Honor pre=null;
			Honor next=null;
			for(int i=0;i<rs.size();i++){
				Honor rt = rs.get(i);
				if(rt.getOhId() == Integer.valueOf(id)){
					int pidx=i-1;
					int nidx=i+1;
					if(pidx>-1)
						pre=rs.get(pidx);
					if(nidx<rs.size())
						next=rs.get(nidx);
				}
			}
			//上一个
			if(flag){
				return pre;
			}
			else{
				return next;
			}
		}else{
			return null;
		}
		
	}
}