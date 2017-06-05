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
import cn.pacificimmi.common.models.InformationImg;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Section;
import cn.pacificimmi.common.utils.ConstantUtil;


@Before(LoginInterCeptor.class) //用户权限拦截器
public class ImageInfoController extends Controller{
	private static Logger log = LoggerFactory.getLogger(ImageInfoController.class);
	public void index(){
		ImageInfoParams sp = new ImageInfoParams(this);
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
		this.renderJsp("/views/cms/imageinfo/main.jsp");
	}
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 */
	private class ImageInfoParams extends ParamsParser{

		public ImageInfoParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select a.*,d.name statusZN ");
			this.setFromStr("from crm_information_img a left join console_dictionary d on a.status = d.dict_code and d.delete_flag = 0");
			
			//查找有效数据
			this.addWhereSegmentByAnd("a.delete_flag=0");
					
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
			if(pp.getNormStr("title") != null && !pp.getNormStr("title").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				String title = pp.getNormStr("title");
				String section_id = pp.getAllStr("section_id");
				String sectionName = pp.getAllStr("section_name");

				String infoImg = pp.getAllStr("info_img");
				String thumbImg = pp.getAllStr("thumb_img");//缩略图
				String sort = pp.getNormStr("sort");
				String remark = pp.getAllStr("remark");
				String status = pp.getNormStr("status");
				String country = pp.getNormStr("country");
				String city = pp.getNormStr("city");
				String videoUrl = pp.getAllStr("videoUrl");
				
				InformationImg infoImage = new InformationImg();
				infoImage.setClickCount(0);
				infoImage.setCity(city);
				infoImage.setCountry(country);
				infoImage.setCreateTime(new Date());
				infoImage.setCreateUser(u.getLoginName());
				infoImage.setCreateUserid(Integer.parseInt(u.getUid()));
				infoImage.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				infoImage.setInfoImg(infoImg);
				infoImage.setThumbImg(thumbImg);
				infoImage.setRemark(remark);
				infoImage.setSectionId(section_id);
				infoImage.setSectionName(sectionName == null ? "" : sectionName);
				infoImage.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				infoImage.setTitle(title);
				infoImage.setStatus(status);
				infoImage.setVedioUrl(videoUrl);
				
				if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
					infoImage.setPublishTime(new Date());
					infoImage.setPublishUser(u.getLoginName());
					infoImage.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				
				infoImage.save();
				this.redirect("/cms/information");
			}else{
				log.debug("page forward to edit.jsp");
				this.setAttr("operation", "新增");
				this.setAttr("op_code", "add");

				//查询已有栏目
				List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
				String pcode = pp.getNormStr("pcode");
				this.setAttr("secId", pcode);
				pcode = (pcode == null || pcode.isEmpty()) ? "":pcode;
				String[] ids = pcode.split(",");
				for(Section s : slist){
					for(String id : ids){
						if(s.getCode().equals(id)){
							s.setDeleteFlag(9);
							continue;
						}
					}
				}
				this.setAttr("slist", slist);
				
				//查询国家、城市(项目)
				List<Record> countryList = Db.find("select p.project_id, d.name,c.cover_pic,p.country country_code, c.id country_id " +
						" from crm_project p JOIN console_dictionary d on p.country = d.dict_code " +
						" LEFT JOIN crm_country c on p.country = c.country_id " +
						" where d.delete_flag = 0 and p.project_status = '" + PropKit.use("constants.txt").get("project_status_sx") + "'" +
						" GROUP BY country_code");
				this.setAttr("countryList", countryList);
				
				List<Dict> cityList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
				setAttr("cityList", cityList);
				
				this.renderJsp("/views/cms/information/image_edit.jsp");
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
					String title = pp.getNormStr("title");
					String section_id = pp.getAllStr("section_id");
					String sectionName = pp.getAllStr("section_name");

					String infoImg = pp.getAllStr("info_img");
					String thumbImg = pp.getAllStr("thumb_img");//缩略图
					String sort = pp.getNormStr("sort");
					String remark = pp.getAllStr("remark");
					String status = pp.getNormStr("status");
					String country = pp.getNormStr("country");
					String city = pp.getNormStr("city");
					String videoUrl = pp.getAllStr("videoUrl");
					
					InformationImg infoImage = InformationImg.dao.findById(Integer.parseInt(pp.getNormStr("info_id")));
					infoImage.setCity(city);
					infoImage.setCountry(country);
					infoImage.setEditTime(new Date());
					infoImage.setEditUserid(Integer.parseInt(u.getUid()));
					infoImage.setEditUser(u.getLoginName());
					infoImage.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
					infoImage.setInfoImg(infoImg);
					infoImage.setThumbImg(thumbImg);
					infoImage.setRemark(remark);
					infoImage.setSectionId(section_id);
					infoImage.setSectionName(sectionName == null ? "" : sectionName);
					infoImage.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
					infoImage.setTitle(title);
					infoImage.setStatus(status);
					infoImage.setVedioUrl(videoUrl);
					if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
						infoImage.setPublishTime(new Date());
						infoImage.setPublishUser(u.getLoginName());
						infoImage.setPublishUserid(Integer.parseInt(u.getUid()));
					}
					
					infoImage.update();
					
					this.redirect("/cms/information");
				}else{
					log.debug("page forward to edit.jsp");
					this.setAttr("operation", "编辑");
					this.setAttr("op_code", "edit");
					
					InformationImg info = InformationImg.dao.findById(Integer.parseInt(pp.getId()));
					this.setAttr("info", info);
					//查询已有栏目
					List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
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
					
					//查询国家、城市(项目)
					List<Record> countryList = Db.find("select p.project_id, d.name,c.cover_pic,p.country country_code, c.id country_id " +
							" from crm_project p JOIN console_dictionary d on p.country = d.dict_code " +
							" LEFT JOIN crm_country c on p.country = c.country_id " +
							" where d.delete_flag = 0 and p.project_status = '" + PropKit.use("constants.txt").get("project_status_sx") + "'" +
							" GROUP BY country_code");
					this.setAttr("countryList", countryList);
					
					List<Dict> cityList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
					setAttr("cityList", cityList);
					
					this.renderJsp("/views/cms/information/image_edit.jsp");
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
			log.debug("page forward to image_edit.jsp");
			this.setAttr("operation", "明细");
			this.setAttr("op_code", "edit");
			
			InformationImg info = InformationImg.dao.findById(Integer.parseInt(pp.getId()));
			this.setAttr("info", info);
			//查询已有栏目
			String sectionName = "";
			List<Section> slist = Section.dao.find("select * from crm_section where delete_flag = 0");
			if(info.getSectionId() != null && !info.getSectionId().isEmpty()){
				String[] ids = info.getSectionId().split(",");
				for(Section s : slist){
					for(String id : ids){
						if(s.getSectionId() == Integer.parseInt(id)){
							s.setDeleteFlag(9);//暂用删除标志9 判断是否选中
							sectionName += s.getName() + ",";
							continue;
						}
					}
				}
			}
			this.setAttr("sectionName", sectionName.endsWith(",")?sectionName.substring(0, sectionName.lastIndexOf(",")):sectionName);
			
			//this.setAttr("slist", slist);
			
			//查询国家、城市(项目)
			Record rcountry = Db.findFirst("select * from console_dictionary where delete_flag = 0 and dict_code="+info.getCountry());
			this.setAttr("countryName", rcountry.get("name"));
			
			Record rcity = Db.findFirst("select * from console_dictionary where delete_flag = 0 and dict_code="+info.getCity());
			this.setAttr("cityName", rcity.get("name"));
			
			//未发布、已发布、已下线
			this.setAttr("no_publish", PropKit.use("constants.txt").get("publish_status_wfb"));
			this.setAttr("published", PropKit.use("constants.txt").get("publish_status_yfb"));
			this.setAttr("off_line", PropKit.use("constants.txt").get("publish_status_yxx"));
			
			this.renderJsp("/views/cms/information/image_detail.jsp");
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
					InformationImg info = InformationImg.dao.findById(Integer.parseInt(id));
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
					InformationImg info = InformationImg.dao.findById(Integer.parseInt(id));
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
				log.error("资讯发布出错：参数资讯ID缺失");
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
					InformationImg info = InformationImg.dao.findById(Integer.parseInt(id));
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
			String sql = "select info_id from crm_information_img where delete_flag = 0 and title = '" + title + "' ";
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
			String title = pp.getNormStr("title");
			String section_id = pp.getAllStr("section_id");
			String sectionName = pp.getAllStr("section_name");

			String infoImg = pp.getAllStr("info_img");
			String thumbImg = pp.getAllStr("thumb_img");//缩略图
			String sort = pp.getNormStr("sort");
			String remark = pp.getNormStr("remark");
			String status = pp.getNormStr("status");
			String country = pp.getNormStr("country");
			String city = pp.getNormStr("city");
			String videoUrl = pp.getAllStr("videoUrl");
			
			//编辑-保存并发布
			if(pp.getNormStr("info_id") != null && !pp.getNormStr("info_id").isEmpty()){
				InformationImg infoImage = InformationImg.dao.findById(Integer.parseInt(pp.getNormStr("info_id")));
				infoImage.setCity(city);
				infoImage.setCountry(country);
				infoImage.setEditTime(new Date());
				infoImage.setEditUserid(Integer.parseInt(u.getUid()));
				infoImage.setEditUser(u.getLoginName());
				infoImage.setInfoImg(infoImg);
				infoImage.setThumbImg(thumbImg);
				infoImage.setRemark(remark);
				infoImage.setSectionId(section_id);
				infoImage.setSectionName(sectionName == null ? "" : sectionName);
				infoImage.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				infoImage.setTitle(title);
				infoImage.setStatus(status);
				infoImage.setVedioUrl(videoUrl);
				if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
					infoImage.setPublishTime(new Date());
					infoImage.setPublishUser(u.getLoginName());
					infoImage.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				infoImage.update();
				this.redirect("/cms/information");
			}else{
				InformationImg infoImage = new InformationImg();
				infoImage.setClickCount(0);
				infoImage.setCity(city);
				infoImage.setCountry(country);
				infoImage.setCreateTime(new Date());
				infoImage.setCreateUser(u.getLoginName());
				infoImage.setCreateUserid(Integer.parseInt(u.getUid()));
				infoImage.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				infoImage.setInfoImg(infoImg);
				infoImage.setThumbImg(thumbImg);
				infoImage.setRemark(remark);
				infoImage.setSectionId(section_id);
				infoImage.setSectionName(sectionName == null ? "" : sectionName);
				infoImage.setSort(Integer.parseInt((sort == null || sort.isEmpty())?"0" : sort));
				infoImage.setTitle(title);
				infoImage.setStatus(status);
				infoImage.setVedioUrl(videoUrl);
				
				if(status.equals(PropKit.use("constants.txt").get("publish_status_yfb"))){
					infoImage.setPublishTime(new Date());
					infoImage.setPublishUser(u.getLoginName());
					infoImage.setPublishUserid(Integer.parseInt(u.getUid()));
				}
				
				infoImage.save();
				this.redirect("/cms/information");
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
}
