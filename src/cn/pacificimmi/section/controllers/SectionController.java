package cn.pacificimmi.section.controllers;

import java.util.Date;
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
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Section;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.StringUtil;


/**
 * @author Gorge
 * 2016年12月29日
 */
/**
 * @author Gorge
 * 2016年12月29日
 */
@Before(LoginInterCeptor.class) //用户权限拦截器
public class SectionController extends Controller{
	private static Logger log = LoggerFactory.getLogger(SectionController.class);
	public void index(){
		SectionParams sp = new SectionParams(this);
		
		ParamsParser pp = new ParamsParser(this);
		String secId = (pp.getNormStr("secId") == null || pp.getNormStr("secId").isEmpty()) ? "" : pp.getNormStr("secId");
		this.setAttr("secId", secId);
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
		
		//栏目树
		this.setAttr("sectionTree", loadTree("0".equals(secId) ? "":secId));

		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/cms/section/main.jsp");
	}
	
	public String loadTree(String code){
		List<Record> records = Db.find("select section_id,name,pname,code,sort from crm_section where delete_flag = 0 order by code asc");
		NodeTree ct = new NodeTree("sectionTree","栏目结构",1);
		/***
		 * 初始化时将选中的节点，描红显示
		 */
		if(!code.isEmpty())
			ct.getSelectedCodes().add(code);
		/**
		* 显示选择框
		*/
		ct.setSelectMode(false);
		ct.setLimitDepth(100);//展开级别
		/**
		* 不显示编辑按钮
		*/
		ct.setAllownEdit(false);
		for(Record r:records){
			Node node = new Node();
			node.setName(r.getStr("name"));
			node.setCode(r.get("code"));
			node.setId(String.valueOf(r.getInt("section_id")));
			
			node.setExtInfo(String.valueOf(r.getInt("section_id")));
			node.setSort(r.getInt("sort"));
			ct.addNode(node);
		}
		return ct.buildTree();
	}
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class SectionParams extends ParamsParser{

		public SectionParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select section_id,name,code,pname,pcode,sort,section_img");
			this.setFromStr("from crm_section");
			
			//查找有效数据
			this.addWhereSegmentByAnd("delete_flag='0'");
					
			//查询名称
			String name = this.getAllStr("name");
			if(name!=null && !name.isEmpty()){
				this.addWhereSegmentByAnd("name like '%"+name.trim()+"%'");
				setAttr("name", name.trim());
			}
				
			
			String secId = this.getNormStr("secId");
			
			String ifParent = this.getNormStr("ifParent");
			if(ifParent == null || ifParent.isEmpty()){//默认
				ifParent = "1";
				secId = "0";
			}
			if("1".equals(ifParent)){
				this.addWhereSegmentByAnd("pcode = '"+secId+"'");
			}else{
				if(secId!=null && !secId.isEmpty())
					this.addWhereSegmentByAnd("pcode = '"+secId+"'");
			}
			
			this.setDefaultOrderStr("order by sort desc");
		}
	}
	/**
	 * 创建当前节点下新自节点的code编码值
	 * @param code
	 * @param table
	 * @param code_field
	 * @return
	 */
	private String createSubCode(String code,String table,String code_field){
		String ncode="";
		if(code.equals("0")){
			String sql="select * from "+table+" where delete_flag='0' and length("+code_field+")=4 order by "+code_field+" desc";
			Record rs = Db.findFirst(sql);
			if(rs!=null){
				String lastcode = rs.getStr(code_field);
				ncode = StringUtil.getNextCategoryCode(lastcode);
			}
			else{
				ncode="0001";
			}
		}
		else{
			String sql="select * from "+table+" where delete_flag='0' and "+code_field+" like '"+code+"%' and length("+code_field+")="+(code.length()+4)+" order by "+code_field+" desc";
			Record rs = Db.findFirst(sql);
			if(rs!=null){
				String lastcode = rs.getStr(code_field);
				ncode = StringUtil.getNextCategoryCode(lastcode);
			}
			else{
				ncode=code+"0001";
			}
		}
		return ncode;
	}
	
	/**
	 * 新增
	 */
	public void add(){
		ParamsParser pp = new ParamsParser(this);
		String redirectUrl = "/cms/section";
		try{
			if(pp.getNormStr("section_name") != null && !pp.getNormStr("section_name").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				String sname = pp.getNormStr("section_name");
				String type = pp.getNormStr("section_type");
				String pname = pp.getNormStr("pname");
				String pcode = pp.getNormStr("pcode");
				pcode = (pcode == null || "NULL".equalsIgnoreCase(pcode) || pcode.isEmpty())?"0" : pcode;
				String staticDir = pp.getAllStr("static_dir");//静态目录
				String img = pp.getAllStr("section_img");
				String imgSizeGw = pp.getAllStr("img_size_gw");//官网图片尺寸
				int indexEnable =  Integer.parseInt(pp.getInt("index_enable"));//是否显示首页推荐
				
				//获取当前同级栏目最大排序
				int sort = 1;
				Record r = Db.findFirst("select max(sort) maxSort from crm_section where delete_flag = 0 and pcode = '" + pcode + "'");
				if(!(r == null || r.get("maxSort") == null || r.get("maxSort").toString().isEmpty())){
					sort = Integer.parseInt(r.get("maxSort").toString()) + 1;
				}
				
				Section s = new Section();
				s.setName(sname);
				s.setPcode(pcode);
				
				//无父栏目
				if(pcode == null || pcode.isEmpty()){
					s.setCode(createSubCode("0","crm_section","code"));
				}else{//有父栏目
					s.setCode(createSubCode(pcode,"crm_section","code"));
					redirectUrl = "/cms/section?ifParent=1&secId="+pcode;
				}
				
				s.setPname(pname);
				s.setSectionImg(img);
				s.setStaticDir(staticDir);
				s.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				s.setCreateTime(new Date());
				s.setCreateUser(u.getLoginName());
				s.setCreateUserid(Integer.parseInt(u.getUid()));
				s.setSort(sort);
				s.setSectionType(type);
				s.setImgSizeGw(imgSizeGw);
				s.setIndexEnable(indexEnable);
				s.save();
				
				this.redirect(redirectUrl);
				//this.redirect("/cms/section");
			}else{
				log.debug("page forward to edit.jsp");
				this.setAttr("operation", "新增");
				
				String pcode = pp.getNormStr("pcode");//
				Section section = new Section();
				section.setPcode(pcode);
				this.setAttr("section", section);
				
				//查询已有栏目
				List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
				this.setAttr("slist", slist);
				
				//查询栏目类型
				List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
				setAttr("typeList", typeList);
				
				this.renderJsp("/views/cms/section/edit.jsp");
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
		String redirectUrl = "/cms/section";
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getNormStr("section_id") != null && !pp.getNormStr("section_id").isEmpty()){
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					//保存
					String sname = pp.getNormStr("section_name");
					String type = pp.getNormStr("section_type");
					String pname = pp.getNormStr("pname");
					String pcode = pp.getNormStr("pcode");
					pcode = (pcode == null || "NULL".equalsIgnoreCase(pcode) || pcode.isEmpty())?"0" : pcode;
					String staticDir = pp.getAllStr("static_dir");//静态目录
					String img = pp.getAllStr("section_img");
					String imgSizeGw = pp.getAllStr("img_size_gw");//官网图片尺寸
					int indexEnable =  Integer.parseInt(pp.getInt("index_enable"));//是否显示首页推荐
					
					Section s = Section.dao.findById(Integer.parseInt(pp.getNormStr("section_id")));
					int sort = s.getSort();
					s.setName(sname);
					if(!s.getPcode().equals(pcode)){//父栏目未改变，不更新代码
						s.setPcode(pcode);
						if(pcode == null || pcode.isEmpty()){
							s.setCode(createSubCode("0","crm_section","code"));
						}else{//有父栏目
							s.setCode(createSubCode(pcode,"crm_section","code"));
						}
						//父栏目改变重置排序号
						Record r = Db.findFirst("select max(sort) maxSort from crm_section where delete_flag = 0 and pcode = '" + pcode + "'");
						if(!(r == null || r.get("maxSort") == null || r.get("maxSort").toString().isEmpty())){
							sort = Integer.parseInt(r.get("maxSort").toString()) + 1;
						}
						s.setSort(sort);
					}
					
					s.setPname(pname);
					s.setSectionImg(img);
					s.setStaticDir(staticDir);
					s.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
					s.setEditTime(new Date());
					s.setEditUser(u.getLoginName());
					s.setEditUserid(Integer.parseInt(u.getUid()));
					s.setSectionType(type);
					s.setImgSizeGw(imgSizeGw);
					s.setIndexEnable(indexEnable);
					s.update();
					
					this.redirect(redirectUrl + "?ifParent=1&secId=" + pcode);
					//this.redirect("/cms/section");
				}else{
					log.debug("page forward to edit.jsp");
					this.setAttr("operation", "编辑");
					
					Section section = Section.dao.findById(Integer.parseInt(pp.getId()));
					this.setAttr("section", section);
					
					//查询已有栏目
					List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0 and section_id !="+pp.getId());
					this.setAttr("slist", slist);
					
					//查询栏目类型
					List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
					setAttr("typeList", typeList);
					
					
					
					this.renderJsp("/views/cms/section/edit.jsp");
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
					List<Record> list = Db.find("select section_id from crm_section where delete_flag = 0 and pcode = (select code from crm_section where section_id = " + id + ")");
					if(list != null && list.size() > 0){
						fail++;
						Section s = Section.dao.findById(id);
						failMsg += "\n[" + (s==null ? "" : s.getName()) +"]栏目存在子栏目,不能删除;";
						continue;
					}
					
					int rlt = Db.update("update crm_section set delete_flag = 1 where section_id = " + id);
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
				log.error("删除栏目出错：参数栏目ID缺失");
				this.setAttr("errorInfo", "删除栏目时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除栏目时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
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
		
		Section s = Section.dao.findById(id);
		Section s1= findPreOrNextOne(id,true);
		
		if(s!=null && s1!=null){
			//交换排序
			int t1 = s.getSort();
			int t2 = s1.getSort();
			
			s.setSort(t2);
			s.update();
			
			s1.setSort(t1);
			s1.update();

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
		
		Section s = Section.dao.findById(id);
		Section s1= findPreOrNextOne(id,false);
		if(s!=null && s1!=null){
			//交换排序
			int t1 = s.getSort();
			int t2 = s1.getSort();
			
			s.setSort(t2);
			s.update();
			
			s1.setSort(t1);
			s1.update();
			
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
		Section s = Section.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(s!=null){
			
			int sort = s.getSort();
			Record r = Db.findFirst("select max(sort) maxSort from crm_section where delete_flag = 0 and pcode = '" + s.getPcode() + "'");
			if(!(r == null || r.get("maxSort") == null || r.get("maxSort").toString().isEmpty())){
				sort = Integer.parseInt(r.get("maxSort").toString()) + 1;
			}
			
			s.setSort(sort);
			if(s.update()){
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
	 * 校验栏目是否存在-根据名称
	 */
	@Clear
	public void valiName(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		try {
			String sectionId = pp.getNormStr("section_id");
			String sectionName = pp.getAllStr("section_name");
			String sql = "select section_id from crm_section where delete_flag = 0 and name = '" + sectionName + "' ";
			if(sectionId != null && !sectionId.isEmpty()){
				sql += " and section_id != " + sectionId;
			}
			List<Record> list = Db.find(sql);
			if(list != null && list.size() > 0){
				rst.put("status", 100);
				rst.put("msg", "该栏目已存在");
			}else{
				rst.put("status", 0);
				rst.put("msg", "成功");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "请求服务器出错");
		}
		this.renderJson(rst);
	}
	
	
	/**
	 * @param id 当前id
	 * @param flag true 上一个     false  下一个
	 * @return 
	 */
	private Section findPreOrNextOne(String id,boolean flag){
		Section s = Section.dao.findById(Integer.parseInt(id));
		if(s!=null){
			List<Section> tops = Section.dao.find("select * from crm_section where delete_flag = 0 and pcode = '" + s.getPcode() + "' order by sort desc");
			Section pre=null;
			Section next=null;
			for(int i=0;i<tops.size();i++){
				Section act = tops.get(i);
				if(act.getSectionId()==Integer.valueOf(id)){
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
		}else{
			return null;
		}
		
	}
}
