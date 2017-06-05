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
import cn.pacificimmi.common.models.InformationArticle;
import cn.pacificimmi.common.models.InformationImg;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Section;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.ConstantUtil;


/**资讯发布
 * @author Gorge
 * 2016年12月21日
 */
@Before(LoginInterCeptor.class) //用户权限拦截器
public class InformationController extends Controller{
	private static Logger log = LoggerFactory.getLogger(InformationController.class);
	public void index(){
		InfotmationParams sp = new InfotmationParams(this);
		sp.setPageSize(15);
		ParamsParser pp = new ParamsParser(this);
		//this.setAttr("title", (pp.getNormStr("title") == null || pp.getNormStr("title").isEmpty()) ? "" : pp.getNormStr("title"));
		this.setAttr("publish_status", (pp.getNormStr("pub_status") == null || pp.getNormStr("pub_status").isEmpty()) ? "" : pp.getNormStr("pub_status"));
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
		
		//资讯状态
		this.setAttr("statusList", DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("publish_status"), 1).getSubDictionaries());
		
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
		this.renderJsp("/views/cms/information/main.jsp");
	}
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class InfotmationParams extends ParamsParser{

		public InfotmationParams(Controller ctr) {
			super(ctr);
			this.setSelectStr("select * ");
			this.setFromStr("from (" +
			"select a.info_id,a.section_id,section_name,a.title,a.status,d.name statusZN,a.click_count,a.publish_user,a.publish_time,a.create_time,a.sort,\"图片\" section_type" +
			" from crm_information_img a left join console_dictionary d on a.status = d.dict_code and d.delete_flag = 0" +
			" where a.delete_flag = 0 " +

			" union " + 

			" select a.info_id,a.section_id,section_name,a.title,a.status,d.name statusZN,a.click_count,a.publish_user,a.publish_time,a.create_time,a.sort,\"文章\" section_type" +
			" from crm_information_article a left join console_dictionary d on a.status = d.dict_code and d.delete_flag = 0" + 
			" where a.delete_flag = 0 " +
			") t");
					
			//资讯名称
			String title = this.getAllStr("title");
			if(title !=null && !title.isEmpty()){
				this.addWhereSegmentByAnd("title like '%"+title.trim()+"%'");
				setAttr("title", title.trim());
			}
			
			//发布状态
			String pubStatus = this.getNormStr("pub_status");
			if(pubStatus != null){
				this.addWhereSegmentByAnd(" status = '" + pubStatus +"'");
			}
			
			//栏目
			String secId = this.getNormStr("secId");
			
			String ifParent = this.getNormStr("ifParent");
			if("1".equals(ifParent)){
				this.addWhereSegmentByAnd("section_id in (select section_id from crm_section where pcode = '"+secId+"')");
			}else{
				if(secId!=null && !secId.isEmpty())
					//this.addWhereSegmentByAnd("section_id in (select section_id from crm_section where code = '"+secId+"')");
					this.addWhereSegmentByAnd("find_in_set((select section_id from crm_section where delete_flag = 0 and code = '" + secId + "'), section_id)");
			}
			
			this.setDefaultOrderStr("order by sort desc,publish_time desc");
		}
	}
	
	public String loadTree(String code){
		List<Record> records = Db.find("select section_id,name,pname,code from crm_section where delete_flag = 0 order by code asc");
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
		ct.setLimitDepth(6);
		
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
			ct.addNode(node);
		}
		return ct.buildTree();
	}
	
	/**
	 * 统一新增入口(废弃)
	 */
	public void add(){
		this.redirect("/cms/imageinfo/add");
	}
	
	/**
	 * 新增-图片资讯(废弃)
	 */
	public void addImage(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getNormStr("title") != null && !pp.getNormStr("title").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				String title = pp.getNormStr("title");
				String section_id = pp.getNormStr("section_id");

				String infoImg = pp.getAllStr("info_img");
				String thumbImg = pp.getAllStr("thumb_img");//缩略图
				String sort = pp.getNormStr("sort");
				String remark = pp.getNormStr("remark");
				String status = pp.getNormStr("status");
				
				InformationImg infoImage = new InformationImg();
				infoImage.setClickCount(0);
				infoImage.setCity("");
				infoImage.setCountry("");
				infoImage.setCreateTime(new Date());
				infoImage.setCreateUser(u.getLoginName());
				infoImage.setCreateUserid(Integer.parseInt(u.getUid()));
				infoImage.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				infoImage.setInfoImg(infoImg);
				infoImage.setThumbImg(thumbImg);
				infoImage.setRemark(remark);
				infoImage.setSectionId(section_id);
				Section s = Section.dao.findById(section_id);
				infoImage.setSectionName(s == null ? "" : s.getName());
				infoImage.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				infoImage.setTitle(title);
				infoImage.setStatus(status);
				
				if(status.equalsIgnoreCase(PropKit.use("constants.txt").get("publish_status_yfb"))){
					infoImage.setPublishTime(new Date());
					infoImage.setPublishUser(u.getLoginName());
					infoImage.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				
				infoImage.save();
				this.redirect("/cms/information");
			}else{
				log.debug("page forward to image_edit.jsp");
				this.setAttr("operation", "新增");
				
				//查询已有栏目
				List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
				this.setAttr("slist", slist);
				
				//查询国家、城市
				List<Record> countryList = Db.find("select id,country_id,cover_pic,country_name from crm_country where release_status = 1");
				setAttr("countryList", countryList);
				
				List<Dict> cityList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
				setAttr("cityList", cityList);
				
				//未发布、已发布、已下线
				this.setAttr("no_publish", PropKit.use("constants.txt").get("publish_status_wfb"));
				this.setAttr("published", PropKit.use("constants.txt").get("publish_status_yfb"));
				this.setAttr("off_line", PropKit.use("constants.txt").get("publish_status_yxx"));
				
				this.renderJsp("/views/cms/information/image_edit.jsp");
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 编辑-图片资讯(废弃)
	 */
	public void editImage(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getNormStr("info_id") != null && !pp.getNormStr("info_id").isEmpty()){
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					//保存
					String title = pp.getNormStr("title");
					String section_id = pp.getNormStr("section_id");

					String infoImg = pp.getAllStr("info_img");
					String thumbImg = pp.getAllStr("thumb_img");//缩略图
					String sort = pp.getNormStr("sort");
					String remark = pp.getNormStr("remark");
					String status = pp.getNormStr("status");
					
					InformationImg infoImage = InformationImg.dao.findById(Integer.parseInt(pp.getNormStr("info_id")));
					infoImage.setClickCount(0);
					infoImage.setCity("");
					infoImage.setCountry("");
					infoImage.setEditTime(new Date());
					infoImage.setEditUserid(Integer.parseInt(u.getUid()));
					infoImage.setEditUser(u.getLoginName());
					infoImage.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
					infoImage.setInfoImg(infoImg);
					infoImage.setThumbImg(thumbImg);
					infoImage.setRemark(remark);
					infoImage.setSectionId(section_id);
					Section s = Section.dao.findById(section_id);
					infoImage.setSectionName(s == null ? "" : s.getName());
					infoImage.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
					infoImage.setTitle(title);
					infoImage.setStatus(status);
					if(status.equalsIgnoreCase(PropKit.use("constants.txt").get("publish_status_yfb"))){
						infoImage.setPublishTime(new Date());
						infoImage.setPublishUser(u.getLoginName());
						infoImage.setPublishUserid(Integer.parseInt(u.getUid()));
					}
					
					infoImage.update();
					
					this.redirect("/cms/information");
				}else{
					log.debug("page forward to image_edit.jsp");
					this.setAttr("operation", "编辑");
					
					//查询已有栏目
					List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
					this.setAttr("slist", slist);
					
					//查询栏目类型
					List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
					setAttr("typeList", typeList);
					
					InformationImg info = InformationImg.dao.findById(Integer.parseInt(pp.getId()));
					this.setAttr("info", info);
					
					this.renderJsp("/views/cms/information/image_edit.jsp");
				}
			}else{
				log.error("保存图片资讯编辑出错:ID为空");
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
	 * 新增-文章资讯(废弃)
	 */
	public void addArticle(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getNormStr("title") != null && !pp.getNormStr("title").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				String title = pp.getNormStr("title");
				String section_id = pp.getNormStr("section_id");
				String author = pp.getNormStr("author");//作者
				String source = pp.getNormStr("source");//来源
				String sort = pp.getNormStr("sort");
				String summary = pp.getNormStr("summary");//摘要
				String contents = pp.getAllStr("contents");//内容
				String status = pp.getNormStr("status");//状态
				
				InformationArticle article = new InformationArticle();
				article.setClickCount(0);
				article.setCity("");
				article.setCountry("");
				article.setCreateTime(new Date());
				article.setCreateUser(u.getLoginName());
				article.setCreateUserid(Integer.parseInt(u.getUid()));
				article.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				article.setContents(contents);
				article.setSectionId(section_id);
				Section s = Section.dao.findById(section_id);
				article.setSectionName(s == null ? "" : s.getName());
				article.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				article.setTitle(title);
				article.setSummary(summary);
				article.setAuthor(author);
				article.setSource(source);
				article.setStatus(status);
				if(status.equalsIgnoreCase(PropKit.use("constants.txt").get("publish_status_yfb"))){
					article.setPublishTime(new Date());
					article.setPublishUser(u.getLoginName());
					article.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				
				article.save();
				this.redirect("/cms/information");
			}else{
				log.debug("page forward to article_edit.jsp");
				this.setAttr("operation", "新增");
				
				//查询已有栏目
				List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
				this.setAttr("slist", slist);
				
				//查询国家、城市
				List<Record> countryList = Db.find("select id,country_id,cover_pic,country_name from crm_country where release_status = 1");
				setAttr("countryList", countryList);
				
				List<Dict> cityList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
				setAttr("cityList", cityList);
				
				//未发布、已发布、已下线
				this.setAttr("no_publish", PropKit.use("constants.txt").get("publish_status_wfb"));
				this.setAttr("published", PropKit.use("constants.txt").get("publish_status_yfb"));
				this.setAttr("off_line", PropKit.use("constants.txt").get("publish_status_yxx"));
				
				this.renderJsp("/views/cms/information/article_edit.jsp");
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	/**
	 * 编辑-文章资讯(废弃)
	 */
	public void editArticle(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getNormStr("info_id") != null && !pp.getNormStr("info_id").isEmpty()){
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					//保存
					String title = pp.getNormStr("title");
					String section_id = pp.getNormStr("section_id");
					String author = pp.getNormStr("author");//作者
					String source = pp.getNormStr("source");//来源
					String sort = pp.getNormStr("sort");
					String summary = pp.getNormStr("summary");//摘要
					String contents = pp.getAllStr("contents");//内容
					String status = pp.getNormStr("status");//状态
					
					InformationArticle article = InformationArticle.dao.findById(Integer.parseInt(pp.getNormStr("info_id")));
					article.setCity("");
					article.setCountry("");
					article.setEditTime(new Date());
					article.setEditUserid(Integer.parseInt(u.getUid()));
					article.setEditUser(u.getLoginName());
					article.setContents(contents);
					article.setSectionId(section_id);
					Section s = Section.dao.findById(section_id);
					article.setSectionName(s == null ? "" : s.getName());
					article.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
					article.setTitle(title);
					article.setSummary(summary);
					article.setAuthor(author);
					article.setSource(source);
					article.setStatus(status);
					if(status.equalsIgnoreCase(PropKit.use("constants.txt").get("publish_status_yfb"))){
						article.setPublishTime(new Date());
						article.setPublishUser(u.getLoginName());
						article.setPublishUserid(Integer.parseInt(u.getUid()));
					}

					article.update();
					
					this.redirect("/cms/information");
				}else{
					log.debug("page forward to article_edit.jsp");
					this.setAttr("operation", "编辑");
					
					//查询已有栏目
					List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
					this.setAttr("slist", slist);
					
					//查询栏目类型
					List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
					setAttr("typeList", typeList);
					
					InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(pp.getId()));
					this.setAttr("info", info);
					
					this.renderJsp("/views/cms/information/article_edit.jsp");
				}
			}else{
				log.error("保存文章资讯编辑出错:ID为空");
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
	 * 资讯删除(只能删除未发布、已下线的)
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			String idvs = pp.getAllStr("ids");
			if(idvs != null && !idvs.isEmpty()){
				String[] ids = idvs.split(",");
				int fail = 0;
				int success = 0;
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				for(String id : ids){
					String[] v = id.split("#");
					
					if("图片".equals(v[1])){
						InformationImg info = InformationImg.dao.findById(Integer.parseInt(v[0]));
						if(info != null && (
								PropKit.use("constants.txt").get("publish_status_wfb").equals(info.getStatus())
								|| PropKit.use("constants.txt").get("publish_status_yxx").equals(info.getStatus())
								)){
							info.setDeleteFlag(ConstantUtil.DATA_STATUS_DELETE);
							info.setDeleteTime(new Date());
							info.setDeleteUser(u.getLoginName());
							info.setDeleteUserid(Integer.parseInt(u.getUid()));
							
							if(info.update()){
								success++;
							}else{
								fail++;
							}
						}else{
							fail++;
						}
					}else if("文章".equals(v[1])){
						InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(v[0]));
						if(info != null && (
								PropKit.use("constants.txt").get("publish_status_wfb").equals(info.getStatus())
								|| PropKit.use("constants.txt").get("publish_status_yxx").equals(info.getStatus())
								)){
							info.setDeleteFlag(ConstantUtil.DATA_STATUS_DELETE);
							info.setDeleteTime(new Date());
							info.setDeleteUser(u.getLoginName());
							info.setDeleteUserid(Integer.parseInt(u.getUid()));
							
							if(info.update()){
								success++;
							}else{
								fail++;
							}
						}else{
							fail++;
						}
					}
					
				}
				if(success == ids.length){
					rst.put("status", ConstantUtil.STATUS_SUCCESS);
					rst.put("msg", "删除成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("删除资讯出错：参数ID缺失");
				this.setAttr("errorInfo", "删除资讯时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除资讯时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 资讯发布（发布未发布和已下线的）
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void publish(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			String idvs = pp.getAllStr("ids");
			if(idvs != null && !idvs.isEmpty()){
				String[] ids = idvs.split(",");
				int fail = 0;
				int success = 0;
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				for(String id : ids){
					String[] v = id.split("#");
					if("图片".equals(v[1])){
						InformationImg info = InformationImg.dao.findById(Integer.parseInt(v[0]));
						if(info != null && (
								PropKit.use("constants.txt").get("publish_status_wfb").equals(info.getStatus())
								|| PropKit.use("constants.txt").get("publish_status_yxx").equals(info.getStatus())
								)){
							info.setStatus(PropKit.use("constants.txt").get("publish_status_yfb"));
							info.setPublishTime(new Date());
							info.setPublishUser(u.getLoginName());
							info.setPublishUserid(Integer.parseInt(u.getUid()));
							
							if(info.update()){
								success++;
							}else{
								fail++;
							}
						}else{
							fail++;
						}
					}else if("文章".equals(v[1])){
						InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(v[0]));
						if(info != null && (
								PropKit.use("constants.txt").get("publish_status_wfb").equals(info.getStatus())
								|| PropKit.use("constants.txt").get("publish_status_yxx").equals(info.getStatus())
								)){
							info.setStatus(PropKit.use("constants.txt").get("publish_status_yfb"));
							info.setPublishTime(new Date());
							info.setPublishUser(u.getLoginName());
							info.setPublishUserid(Integer.parseInt(u.getUid()));
							
							if(info.update()){
								success++;
							}else{
								fail++;
							}
						}else{
							fail++;
						}
					}
					
				}
				if(success == ids.length){
					rst.put("status", ConstantUtil.STATUS_SUCCESS);
					rst.put("msg", "发布成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "发布结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("资讯发布出错：参数ID缺失");
				this.setAttr("errorInfo", "资讯发布时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "资讯发布时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 资讯下线
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void offline(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			String idvs = pp.getAllStr("ids");
			if(idvs != null && !idvs.isEmpty()){
				String[] ids = idvs.split(",");
				int fail = 0;
				int success = 0;
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				for(String id : ids){
					String[] v = id.split("#");
					if("图片".equals(v[1])){
						InformationImg info = InformationImg.dao.findById(Integer.parseInt(v[0]));
						if(info != null && PropKit.use("constants.txt").get("publish_status_yfb").equals(info.getStatus())){
							info.setStatus(PropKit.use("constants.txt").get("publish_status_yxx"));
							info.setEditTime(new Date());
							info.setEditUserid(Integer.parseInt(u.getUid()));
							info.setEditUser(u.getLoginName());
							
							if(info.update()){
								success++;
							}else{
								fail++;
							}
						}else{
							fail++;
						}
					}else if("文章".equals(v[1])){
						InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(v[0]));
						if(info != null && PropKit.use("constants.txt").get("publish_status_yfb").equals(info.getStatus())){							
							info.setStatus(PropKit.use("constants.txt").get("publish_status_yxx"));
							info.setEditTime(new Date());
							info.setEditUserid(Integer.parseInt(u.getUid()));
							info.setEditUser(u.getLoginName());
							
							if(info.update()){
								success++;
							}else{
								fail++;
							}
						}else{
							fail++;
						}
					}
					
				}
				if(success == ids.length){
					rst.put("status", ConstantUtil.STATUS_SUCCESS);
					rst.put("msg", "下线成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "资讯下线：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("资讯下线出错：参数ID缺失");
				this.setAttr("errorInfo", "资讯下线时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "资讯下线时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 根据国家查城市(关联项目)
	 */
	@Clear
	public void qryCityByCountry(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		try{
			List<Record> list = Db.find("select d.name,p.city from crm_project p JOIN console_dictionary d on p.city = d.dict_code " +
					 " where d.delete_flag = 0 and p.country = '" + pp.getNormStr("country") + "' group by p.city");
			
			StringBuffer sb = new StringBuffer();
			String city = (pp.getNormStr("city") == null || pp.getNormStr("city").isEmpty()) ? "" : pp.getNormStr("city");
			sb.append("<select class=\"span3 chosen\" data-placeholder=\"城市\" tabindex=\"1\" id=\"city\" name=\"city\">");
			for(Record r : list){
				sb.append("<option value=\""+r.getStr("city")+ "\"" +(city.equals(r.getStr("city")) ? "selected" : "") +">" + r.getStr("name") + "</option>");
			}
			sb.append("</select>");
			rst.put("status", ConstantUtil.STATUS_SUCCESS);
			rst.put("result", sb.toString());
		}catch(Exception e){
			log.error(e.getMessage(), e);
			StringBuffer sb = new StringBuffer();
			sb.append("<select class=\"span3 chosen\" data-placeholder=\"城市\" tabindex=\"1\" id=\"city\" name=\"city\">");
			sb.append("</select>");
			rst.put("status", ConstantUtil.STATUS_FAILTURE);
			rst.put("result", sb.toString());
		}finally {
			this.renderJson(rst);
		}
		
	}
}
