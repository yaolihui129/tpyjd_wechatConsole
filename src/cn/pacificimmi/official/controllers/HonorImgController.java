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
import cn.pacificimmi.common.models.HonorImgs;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.ConstantUtil;
/**
 * 荣誉
 * @author Gorge
 *
 */
@Before(LoginInterCeptor.class)
public class HonorImgController extends Controller {
	private Logger log = LoggerFactory.getLogger(HonorImgController.class);
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
		this.renderJsp("/views/official/about/honorimg_list.jsp");
	}
	
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class HonorParams extends ParamsParser{

		public HonorParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select * ");
			this.setFromStr("from official_honor_imgs ");
			
			//查找有效数据
			this.addWhereSegmentByAnd(" delete_flag = 0 and oh_id ="+this.getId());
			setAttr("oh_id", this.getId());
					
			//职位名称
			String title = this.getAllStr("title");
			if(title!=null && !title.isEmpty()){
				this.addWhereSegmentByAnd(" name like '%"+title.trim()+"%'");
				setAttr("title", title.trim());
			}
				
			
			
			this.setDefaultOrderStr("order by sort desc");
		}
	}
	
	
	/**
	 * 新增
	 */
	public void add(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getAllStr("img_url") != null && !pp.getAllStr("img_url").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				HonorImgs himg = new HonorImgs();
				himg.setName(pp.getAllStr("name"));
				himg.setCreateTime(new Date());
				himg.setCreator(u.getLoginName());
				himg.setDeleteFlag(0);
				himg.setImgUrl(pp.getAllStr("img_url"));
				himg.setOhId(Integer.parseInt(pp.getAllStr("oh_id")));
				
				Record record = Db.findFirst("select max(sort) maxSort from official_honor_imgs where delete_flag = 0 and oh_id ="+pp.getId());
				if(!(record == null || record.get("maxSort") == null || record.get("maxSort").toString().isEmpty())){
					himg.setSort(Integer.parseInt(record.get("maxSort").toString()) + 1);
				}else{
					himg.setSort(1);
				}
				
				himg.save();
				
				this.redirect("/official/about/honorimg/"+himg.getOhId());
			}else{
				log.debug("page forward to edit.jsp");
				this.setAttr("operation", "新增");
				this.setAttr("oh_id", pp.getId());
				this.renderJsp("/views/official/about/honorimg_edit.jsp");
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	
	/**
	 * 编辑
	 */
	public void edit(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getAllStr("img_url") != null && !pp.getAllStr("img_url").isEmpty()){
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					//保存
					HonorImgs himg = HonorImgs.dao.findById(pp.getId());
					himg.setName(pp.getAllStr("name"));
					himg.setEditTime(new Date());
					himg.setEditor(u.getLoginName());
					himg.setDeleteFlag(0);
					himg.setImgUrl(pp.getAllStr("img_url"));
					himg.update();
					
					this.redirect("/official/about/honorimg/"+himg.getOhId());
				}else{
					log.debug("page forward to edit.jsp");
					this.setAttr("operation", "编辑");
					
					HonorImgs r = HonorImgs.dao.findById(pp.getId());
					this.setAttr("img", r);
				
					this.renderJsp("/views/official/about/honorimg_edit.jsp");
				}
			}else{
				log.error("保存栏目编辑出错:栏目ID为空");
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
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
					int rlt = Db.update("update official_honor_imgs set delete_flag = 1 where ohi_id = " + id);
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
				log.error("删除荣誉资质图片信息出错：参数ID缺失");
				this.setAttr("errorInfo", "删除荣誉资质图片信息时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除荣誉资质图片信息时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
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
		
		HonorImgs r = HonorImgs.dao.findById(id);
		HonorImgs r1= findPreOrNextOne(id,true);
		
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
		
		HonorImgs r = HonorImgs.dao.findById(id);
		HonorImgs r1= findPreOrNextOne(id,false);
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
		HonorImgs rt = HonorImgs.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(rt !=null){
			
			int sort = rt.getSort();
			Record r = Db.findFirst("select max(sort) maxSort from official_honor_imgs where delete_flag = 0 and oh_id ="+rt.getOhId());
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
	private HonorImgs findPreOrNextOne(String id,boolean flag){
		HonorImgs r = HonorImgs.dao.findById(Integer.parseInt(id));
		if(r!=null){
			List<HonorImgs> rs = HonorImgs.dao.find("select * from official_honor_imgs where delete_flag = 0 and oh_id = "+r.getOhId()+" order by sort desc");
			HonorImgs pre=null;
			HonorImgs next=null;
			for(int i=0;i<rs.size();i++){
				HonorImgs rt = rs.get(i);
				if(rt.getOhiId() == Integer.valueOf(id)){
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