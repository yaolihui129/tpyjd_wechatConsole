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
import cn.pacificimmi.common.models.InformationArticle;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Section;
import cn.pacificimmi.common.utils.ConstantUtil;
import cn.pacificimmi.common.utils.StringUtils;


@Before(LoginInterCeptor.class) //用户权限拦截器
public class ArticleInfoController extends Controller{
	private static Logger log = LoggerFactory.getLogger(ArticleInfoController.class);
	Prop dp = PropKit.use("debug_config.txt");
	public void index(){
		ArticleInfoParams sp = new ArticleInfoParams(this);
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
		this.renderJsp("/views/cms/articleinfo/main.jsp");
	}
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class ArticleInfoParams extends ParamsParser{

		public ArticleInfoParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select a.*,d.name statusZN ");
			this.setFromStr("from crm_information_article a left join console_dictionary d on a.status = d.dict_code and d.delete_flag = 0");
			
			//查找有效数据
			this.addWhereSegmentByAnd("a.delete_flag='0'");
					
			//查询名称
			String name = this.getNormStr("name");
			if(name!=null)
				this.addWhereSegmentByAnd("a.name like '%"+name+"%'");
			
			
			this.setDefaultOrderStr("order by a.sort desc");
		}
	}
	
	
	/**
	 * 新增
	 */
	public void add(){
		ParamsParser pp = new ParamsParser(this);
		try{
			//未发布、已发布、已下线
			this.setAttr("no_publish", PropKit.use("constants.txt").get("publish_status_wfb"));
			this.setAttr("published", PropKit.use("constants.txt").get("publish_status_yfb"));
			this.setAttr("off_line", PropKit.use("constants.txt").get("publish_status_yxx"));
			if(pp.getAllStr("title") != null && !pp.getAllStr("title").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				String title = pp.getAllStr("title");
				String section_id = pp.getAllStr("section_id");
				String section_name = pp.getAllStr("section_name");
				String author = pp.getAllStr("author");//作者
				String source = pp.getAllStr("source");//来源
				String sort = pp.getNormStr("sort");
				String summary = pp.getAllStr("summary");//摘要
				String contents = pp.getAllStr("contents");//内容
				String status = pp.getNormStr("status");//状态
				String tags = pp.getAllStr("tag_v");//标签
				String pushLocation = pp.getAllStr("push_location");//推送位置
				String country = pp.getNormStr("country");
				String thumbImg = pp.getAllStr("thumb_img");//缩略图
				String listImg = pp.getAllStr("list_img");//列表图
				int indexShow = Integer.parseInt(pp.getAllStr("index_show")) * Integer.parseInt(pp.getAllStr("index_enable"));
				
				InformationArticle article = new InformationArticle();
				article.setClickCount(0);
				//article.setCity("");
				article.setCountry(country);
				article.setCreateTime(new Date());
				article.setCreateUser(u.getLoginName());
				article.setCreateUserid(Integer.parseInt(u.getUid()));
				article.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				article.setContents(contents);
				article.setSectionId(section_id);
				article.setSectionName(section_name == null ? "" : section_name);
				article.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				article.setTitle(title);
				article.setSummary(summary);
				article.setAuthor(author);
				article.setSource(source);
				article.setStatus(status);
				article.setTags(tags);
				article.setPushLocation(pushLocation);
				article.setThumbImg(thumbImg);
				article.setListImg(listImg);
				article.setIndexShow(indexShow);
				if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
					article.setPublishTime(new Date());
					article.setPublishUser(u.getLoginName());
					article.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				
				article.save();
				Section section = Section.dao.findById(section_id);
				if(section != null){
					this.redirect("/cms/information?secId="+section.getCode());
				}else{
					this.redirect("/cms/information");
				}
				
			}else{
				log.debug("page forward to article_edit.jsp");
				this.setAttr("operation", "新增");
				this.setAttr("op_code", "add");
				//从国家管理中跳转时传国家信息
				String coun_id = pp.getNormStr("coun_id");
				if(StringUtils.notEmpty(coun_id)){
					InformationArticle info = new InformationArticle();
					info.setCountry(coun_id);
					this.setAttr("info", info);
				}
				//查询已有栏目
				List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0 and section_type != '"+PropKit.use("constants.txt").get("section_type_shty")+"'");
				String pcode = pp.getNormStr("pcode");
				this.setAttr("secId", pcode);
				pcode = (pcode == null || pcode.isEmpty()) ? "":pcode;
				String[] ids = pcode.split(",");
				for(Section s : slist){
					for(String id : ids){
						if(s.getCode().equals(id)){
							s.setDeleteFlag(9);
							this.setAttr("listImgSize", s.getImgSizeGw());
							continue;
						}
					}
				}
				this.setAttr("slist", slist);
				
				//查询栏目类型
				List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
				setAttr("typeList", typeList);
				
				//查询资讯推送位置
				List<Dict> pushList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
				setAttr("pushList", pushList);
				
				//查询国家、城市(项目)
				List<Record> countryList = Db.find("select p.project_id, d.name,c.cover_pic,p.country country_code, c.id country_id " +
						" from crm_project p JOIN console_dictionary d on p.country = d.dict_code and d.delete_flag = 0 " +
						" LEFT JOIN crm_country c on p.country = c.country_id and c.delete_flag = 0" +
						" where p.delete_flag = 0 and p.project_status = '" + PropKit.use("constants.txt").get("project_status_sx") + "'" +
						" GROUP BY country_code");
				this.setAttr("countryList", countryList);
				
				this.renderJsp("/views/cms/information/article_edit.jsp");
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
			//未发布、已发布、已下线
			this.setAttr("no_publish", PropKit.use("constants.txt").get("publish_status_wfb"));
			this.setAttr("published", PropKit.use("constants.txt").get("publish_status_yfb"));
			this.setAttr("off_line", PropKit.use("constants.txt").get("publish_status_yxx"));
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getNormStr("info_id") != null && !pp.getNormStr("info_id").isEmpty()){
					LoginUserInfo u = getSessionAttr("LoginUserInfo");
					//保存
					String title = pp.getAllStr("title");
					String section_id = pp.getAllStr("section_id");
					String section_name = pp.getAllStr("section_name");
					String author = pp.getAllStr("author");//作者
					String source = pp.getAllStr("source");//来源
					//String sort = pp.getNormStr("sort");
					String summary = pp.getAllStr("summary");//摘要
					String contents = pp.getAllStr("contents");//内容
					String status = pp.getNormStr("status");//状态
					String tags = pp.getAllStr("tag_v");//标签
					String pushLocation = pp.getAllStr("push_location");//推送位置
					String country = pp.getNormStr("country");
					String thumbImg = pp.getAllStr("thumb_img");//缩略图
					String listImg = pp.getAllStr("list_img");//列表图
					int indexShow = Integer.parseInt(pp.getAllStr("index_show")) * Integer.parseInt(pp.getAllStr("index_enable"));
					
					InformationArticle article = InformationArticle.dao.findById(Integer.parseInt(pp.getNormStr("info_id")));
					//article.setCity("");
					article.setCountry(country);
					article.setEditTime(new Date());
					article.setEditUserid(Integer.parseInt(u.getUid()));
					article.setEditUser(u.getLoginName());
					article.setContents(contents);
					article.setSectionId(section_id);
					article.setSectionName(section_name == null ? "" : section_name);
					//article.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
					article.setTitle(title);
					article.setSummary(summary);
					article.setAuthor(author);
					article.setSource(source);
					article.setStatus(status);
					article.setTags(tags);
					article.setPushLocation(pushLocation);
					article.setThumbImg(thumbImg);
					article.setListImg(listImg);
					article.setIndexShow(indexShow);
					if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
						article.setPublishTime(new Date());
						article.setPublishUser(u.getLoginName());
						article.setPublishUserid(Integer.parseInt(u.getUid()));
					}

					article.update();
					
					Section section = Section.dao.findById(section_id);
					if(section != null){
						this.redirect("/cms/information?secId="+section.getCode());
					}else{
						this.redirect("/cms/information");
					}
				}else{
					log.debug("page forward to article_edit.jsp");
					this.setAttr("operation", "编辑");
					this.setAttr("op_code", "edit");
					this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
					
					InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(pp.getId()));
					this.setAttr("info", info);
					
					//查询已有栏目
					List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0 and section_type != '"+PropKit.use("constants.txt").get("section_type_shty")+"'");
					String[] ids = info.getSectionId().split(",");
					for(Section s : slist){
						for(String id : ids){
							if(s.getSectionId() == Integer.parseInt(id)){
								s.setDeleteFlag(9);
								this.setAttr("listImgSize", s.getImgSizeGw());
								continue;
							}
						}
					}
					this.setAttr("slist", slist);
					
					//查询栏目类型
					List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
					setAttr("typeList", typeList);
					
					//查询资讯推送位置
					List<Dict> pushList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
					setAttr("pushList", pushList);
					
					//查询国家、城市(项目)
					List<Record> countryList = Db.find("select p.project_id, d.name,c.cover_pic,p.country country_code, c.id country_id " +
							" from crm_project p JOIN console_dictionary d on p.country = d.dict_code and d.delete_flag = 0 " +
							" LEFT JOIN crm_country c on p.country = c.country_id and c.delete_flag = 0" +
							" where p.delete_flag = 0 and p.project_status = '" + PropKit.use("constants.txt").get("project_status_sx") + "'" +
							" GROUP BY country_code");
					this.setAttr("countryList", countryList);
					
					this.renderJsp("/views/cms/information/article_edit.jsp");
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
	 * 明细
	 */
	public void detail(){
		ParamsParser pp = new ParamsParser(this);
		try{
			log.debug("page forward to article_detail.jsp");
			this.setAttr("operation", "明细");
			this.setAttr("op_code", "edit");
			
			InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(pp.getId()));
			this.setAttr("info", info);
			//查询已有栏目
			List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0 and section_type != '"+PropKit.use("constants.txt").get("section_type_shty")+"'");
			String[] ids = info.getSectionId().split(",");
			for(Section s : slist){
				for(String id : ids){
					if(s.getSectionId() == Integer.parseInt(id)){
						s.setDeleteFlag(9);
						continue;
					}
				}
			}
			this.setAttr("slist", slist);
			
			//查询栏目类型
			List<Dict> typeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("section_type"), 1).getSubDictionaries();
			setAttr("typeList", typeList);
			
			//查询资讯推送位置
			List<Dict> pushList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
			setAttr("pushList", pushList);
			
			//查询国家、城市(项目)
			List<Record> countryList = Db.find("select p.project_id, d.name,c.cover_pic,p.country country_code, c.id country_id " +
					" from crm_project p JOIN console_dictionary d on p.country = d.dict_code and d.delete_flag = 0 " +
					" LEFT JOIN crm_country c on p.country = c.country_id and c.delete_flag = 0" +
					" where p.delete_flag = 0 and p.project_status = '" + PropKit.use("constants.txt").get("project_status_sx") + "'" +
					" GROUP BY country_code");
			this.setAttr("countryList", countryList);
			
			this.renderJsp("/views/cms/information/article_detail.jsp");
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
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				for(String id : ids){
					InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(id));
					if(info != null){
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
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "删除成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除结果：成功[" + success + "],失败["+ fail +"]");
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
	 * 发布
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void publish(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(pp.getIds() != null && !pp.getIds().isEmpty()){
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				for(String id : ids){
					InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(id));
					if(info != null){
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
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "发布成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "发布结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("栏目发布出错：参数栏目ID缺失");
				this.setAttr("errorInfo", "栏目发布时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "栏目发布时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 下线
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void offline(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(pp.getIds() != null && !pp.getIds().isEmpty()){
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				for(String id : ids){
					InformationArticle info = InformationArticle.dao.findById(Integer.parseInt(id));
					if(info != null){
						info.setStatus(PropKit.use("constants.txt").get("publish_status_yxx"));
						info.setEditTime(new Date());
						info.setEditUserid(Integer.parseInt(u.getUid()));
						info.setEditUser(u.getLoginName());
						//info.setPublishTime(null);
						
						if(info.update()){
							success++;
						}else{
							fail++;
						}
					}else{
						fail++;
					}
					
					
				}
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "下线成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "操作结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("资讯下线出错：参数资讯ID缺失");
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
	 * 校验资讯标题是否存在-根据名称
	 */
	@Clear
	public void valiName(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		try {
			String infoId = pp.getNormStr("info_id");
			String title = pp.getAllStr("title");
			String sql = "select info_id from crm_information_article where delete_flag = 0 and title = '" + title + "' ";
			if(infoId != null && !infoId.isEmpty()){
				sql += " and info_id != " + infoId;
			}
			List<Record> list = Db.find(sql);
			if(list != null && list.size() > 0){
				rst.put("status", 100);
				rst.put("msg", "该标题已存在");
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
	 * 保存并发布
	 */
	public void saveAndPublish(){
		ParamsParser pp = new ParamsParser(this);
		try{
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			String title = pp.getAllStr("title");
			String section_id = pp.getAllStr("section_id");
			String section_name = pp.getAllStr("section_name");
			String author = pp.getNormStr("author");//作者
			String source = pp.getNormStr("source");//来源
			String sort = pp.getNormStr("sort");
			String summary = pp.getAllStr("summary");//摘要
			String contents = pp.getAllStr("contents");//内容
			String status = pp.getNormStr("status");//状态
			String tags = pp.getAllStr("tag_v");//标签
			String pushLocation = pp.getAllStr("push_location");//推送位置
			String country = pp.getNormStr("country");
			String thumbImg = pp.getAllStr("thumb_img");//缩略图
			String listImg = pp.getAllStr("list_img");//列表图
			int indexShow = Integer.parseInt(pp.getAllStr("index_show")) * Integer.parseInt(pp.getAllStr("index_enable"));
			
			if(pp.getNormStr("info_id") != null && !pp.getNormStr("info_id").isEmpty()){
				InformationArticle article = InformationArticle.dao.findById(Integer.parseInt(pp.getNormStr("info_id")));
				article.setEditTime(new Date());
				article.setEditUserid(Integer.parseInt(u.getUid()));
				article.setEditUser(u.getLoginName());
				article.setContents(contents);
				article.setSectionId(section_id);
				article.setSectionName(section_name == null ? "" : section_name);
				//article.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				article.setTitle(title);
				article.setSummary(summary);
				article.setAuthor(author);
				article.setSource(source);
				article.setStatus(status);
				article.setTags(tags);
				article.setPushLocation(pushLocation);
				article.setCountry(country);
				article.setThumbImg(thumbImg);
				article.setListImg(listImg);
				article.setIndexShow(indexShow);
				if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
					article.setPublishTime(new Date());
					article.setPublishUser(u.getLoginName());
					article.setPublishUserid(Integer.parseInt(u.getUid()));
				}

				article.update();
				Section section = Section.dao.findById(section_id);
				if(section != null){
					this.redirect("/cms/information?secId="+section.getCode());
				}else{
					this.redirect("/cms/information");
				}
			}else{
				InformationArticle article = new InformationArticle();
				article.setClickCount(0);
				article.setCreateTime(new Date());
				article.setCreateUser(u.getLoginName());
				article.setCreateUserid(Integer.parseInt(u.getUid()));
				article.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				article.setContents(contents);
				article.setSectionId(section_id);
				article.setSectionName(section_name == null ? "" : section_name);
				article.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				article.setTitle(title);
				article.setSummary(summary);
				article.setAuthor(author);
				article.setSource(source);
				article.setStatus(status);
				article.setTags(tags);
				article.setPushLocation(pushLocation);
				article.setCountry(country);
				article.setThumbImg(thumbImg);
				article.setListImg(listImg);
				article.setIndexShow(indexShow);
				if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
					article.setPublishTime(new Date());
					article.setPublishUser(u.getLoginName());
					article.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				
				article.save();
				Section section = Section.dao.findById(section_id);
				if(section != null){
					this.redirect("/cms/information?secId="+section.getCode());
				}else{
					this.redirect("/cms/information");
				}
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 置顶
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void setTop(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			String id = pp.getNormStr("id");
			String sid = pp.getNormStr("sid");
			if(id != null && !id.isEmpty()){
				//查询已置顶的资讯
				List<InformationArticle> list = InformationArticle.dao.find(
						"select * from crm_information_article where delete_flag = 0 and sort >= 999999 and status = '" +
								PropKit.use("constants.txt").get("publish_status_yfb")
						+"' and section_id ="+sid+" order by publish_time asc");
				//当已有三个设置置顶时，按发布时间最早的取消置顶
				if(list != null && list.size() == 3){
					InformationArticle article = list.get(0);
					article.setSort(-999999);
					article.update();
				}
				
				//查询当前最大排序序号
				Record r = Db.findFirst("select max(sort) maxSort from crm_information_article where delete_flag = 0 and status = '" +
								PropKit.use("constants.txt").get("publish_status_yfb")
						+"' and section_id ="+sid+" order by sort desc");
				int topSort = 999999;
				if(r.getInt("maxSort") >= 999999){
					topSort = r.getInt("maxSort") + 1;
				}
				
				InformationArticle article = InformationArticle.dao.findById(id);
				article.setSort(topSort);
				article.update();
				
				rst.put("status", 0);
				rst.put("msg", "置顶成功");
				this.renderJson(rst);
			}else{
				log.error("文章资讯置顶出错：参数资讯ID缺失");
				this.setAttr("errorInfo", "文章资讯置顶时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "文章资讯时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
}
