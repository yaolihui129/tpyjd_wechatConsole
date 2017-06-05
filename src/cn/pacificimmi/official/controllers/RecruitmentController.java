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

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Configs;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Recruitment;
import cn.pacificimmi.common.models.Section;
import cn.pacificimmi.common.utils.ConstantUtil;
/**
 * 招聘
 * @author Gorge
 *
 */
@Before(LoginInterCeptor.class)
public class RecruitmentController extends Controller {
	private Logger log = LoggerFactory.getLogger(RecruitmentController.class);
	
	/**
	 * 列表页
	 */
	public void index(){
		RecruitmentParams sp = new RecruitmentParams(this);
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();
		

		/***
		 * 保存数据列表
		 */
		this.setAttr("list", list);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		

		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/official/about/zp_list.jsp");
	}
	
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class RecruitmentParams extends ParamsParser{

		public RecruitmentParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select r.*,d1.name provinceZH,d2.name cityZH ");
			this.setFromStr("from official_recruitment r left join console_dictionary d1 on r.province = d1.dict_code and d1.delete_flag = 0 "+
							"left join console_dictionary d2 on r.city = d2.dict_code and d2.delete_flag = 0 ");
			
			//查找有效数据
			this.addWhereSegmentByAnd("r.delete_flag=0");
					
			//职位名称
			String position = this.getAllStr("position");
			if(position!=null && !position.isEmpty()){
				this.addWhereSegmentByAnd("r.position like '%"+position.trim()+"%'");
				setAttr("position", position.trim());
			}
				
			
			
			this.setDefaultOrderStr("order by sort desc");
		}
	}
	
	
	/**
	 * 新增
	 */
	public void add(){
		Prop p = PropKit.use("constants.txt");
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getNormStr("position") != null && !pp.getNormStr("position").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				Recruitment r = new Recruitment();
				r.setCity(pp.getAllStr("city"));
				r.setPosition(pp.getAllStr("position"));
				r.setProvince(pp.getAllStr("province"));
				r.setComId(pp.getAllStr("company"));
				r.setCreateTime(new Date());
				r.setCreator(u.getLoginName());
				r.setDeleteFlag(0);
				r.setDemand(pp.getAllStr("demand"));
				r.setDescription(pp.getAllStr("description"));
				r.setEditor(u.getLoginName());
				r.setEditTime(new Date());
				r.setEducation(pp.getAllStr("education"));
				r.setNums(pp.getAllStr("nums"));
				r.setWorkExp(pp.getAllStr("work_exp"));
				
				Record record = Db.findFirst("select max(sort) maxSort from official_recruitment where delete_flag = 0 ");
				if(!(record == null || record.get("maxSort") == null || record.get("maxSort").toString().isEmpty())){
					r.setSort(Integer.parseInt(record.get("maxSort").toString()) + 1);
				}else{
					r.setSort(1);
				}
				
				r.save();
				
				this.redirect("/official/about/zp");
			}else{
				log.debug("page forward to edit.jsp");
				this.setAttr("operation", "新增");
				
				//工作经验
				List<Record> expList = Db.find("select * from console_dictionary where delete_flag='0' and dict_pcode = '" + p.get("zp_experience") +"' order by sort asc");
				this.setAttr("expList", expList);
				
				//学历要求
				List<Record> eduList = Db.find("select * from console_dictionary where delete_flag='0' and dict_pcode = '" + p.get("zp_education") +"' order by sort asc");
				this.setAttr("eduList", eduList);
				
				//省份
				List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country_china"), 1).getSubDictionaries();
				this.setAttr("provinceList", provinceList);
				
				
				//所属公司
				List<Record> comList = Db.find("select * from console_dictionary where delete_flag='0' and dict_pcode = '" + p.get("zp_company") +"' order by sort asc");
				this.setAttr("comList", comList);
				
				this.renderJsp("/views/official/about/zp_edit.jsp");
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
		Prop p = PropKit.use("constants.txt");
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getNormStr("position") != null && !pp.getNormStr("position").isEmpty()){
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					//保存
					Recruitment r = Recruitment.dao.findById(pp.getId());
					r.setCity(pp.getAllStr("city"));
					r.setPosition(pp.getAllStr("position"));
					r.setProvince(pp.getAllStr("province"));
					r.setComId(pp.getAllStr("company"));
					r.setCreateTime(new Date());
					r.setCreator(u.getLoginName());
					r.setDeleteFlag(0);
					r.setDemand(pp.getAllStr("demand"));
					r.setDescription(pp.getAllStr("description"));
					r.setEditor(u.getLoginName());
					r.setEditTime(new Date());
					r.setEducation(pp.getAllStr("education"));
					r.setNums(pp.getAllStr("nums"));
					r.setWorkExp(pp.getAllStr("work_exp"));
					r.update();
					
					this.redirect("/official/about/zp");
				}else{
					log.debug("page forward to edit.jsp");
					this.setAttr("operation", "编辑");
					
					Recruitment r = Recruitment.dao.findById(pp.getId());
					this.setAttr("job", r);
					
					//工作经验
					List<Record> expList = Db.find("select * from console_dictionary where delete_flag='0' and dict_pcode = '" + p.get("zp_experience") +"' order by sort asc");
					this.setAttr("expList", expList);
					
					//学历要求
					List<Record> eduList = Db.find("select * from console_dictionary where delete_flag='0' and dict_pcode = '" + p.get("zp_education") +"' order by sort asc");
					this.setAttr("eduList", eduList);
					
					//省份
					List<Dict> provinceList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country_china"), 1).getSubDictionaries();
					this.setAttr("provinceList", provinceList);
					
					//城市
					if(r.getProvince() != null && !r.getProvince().isEmpty()){
						List<Dict> cityList = DictionaryManager.getInstance().getSubDictionariesByDegree(r.getProvince(), 1).getSubDictionaries();
						this.setAttr("cityList", cityList);
					}
					
					
					//所属公司
					List<Record> comList = Db.find("select * from console_dictionary where delete_flag='0' and dict_pcode = '" + p.get("zp_company") +"' order by sort asc");
					this.setAttr("comList", comList);
					
					this.renderJsp("/views/official/about/zp_edit.jsp");
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
					int rlt = Db.update("update official_recruitment set delete_flag = 1 where or_id = " + id);
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
				log.error("删除招聘信息出错：参数ID缺失");
				this.setAttr("errorInfo", "删除招聘信息时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除招聘信息时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
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
		
		Recruitment r = Recruitment.dao.findById(id);
		Recruitment r1= findPreOrNextOne(id,true);
		
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
		
		Recruitment r = Recruitment.dao.findById(id);
		Recruitment r1= findPreOrNextOne(id,false);
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
		Recruitment rt = Recruitment.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(rt !=null){
			
			int sort = rt.getSort();
			Record r = Db.findFirst("select max(sort) maxSort from official_recruitment where delete_flag = 0 ");
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
	private Recruitment findPreOrNextOne(String id,boolean flag){
		Recruitment r = Recruitment.dao.findById(Integer.parseInt(id));
		if(r!=null){
			List<Recruitment> rs = Recruitment.dao.find("select * from official_recruitment where delete_flag = 0 order by sort desc");
			Recruitment pre=null;
			Recruitment next=null;
			for(int i=0;i<rs.size();i++){
				Recruitment rt = rs.get(i);
				if(rt.getOrId() == Integer.valueOf(id)){
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
	
	
	/**
	 * 设置
	 */
	public void set(){
		Configs c = Configs.dao.findFirst("select * from official_configs where code = '诚聘英才设置'");
		this.setAttr("config", c);
		this.renderJsp("/views/official/about/zp_set.jsp");
	}
	
	/**
	 * 保存诚聘英才设置
	 */
	@Clear
	public void saveConfig(){
		ParamsParser pp = new ParamsParser(this);
		String v = pp.getAllStr("contents");
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			Configs c = Configs.dao.findById(pp.getId());
			c.setValue(v);
			c.setStatus("已发布");
			c.update();
			
			rst.put("status", 0);
			rst.put("msg", "保存成功");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", "保存失败");
		}
		this.renderJson(rst);
	}
}