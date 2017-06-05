package cn.pacificimmi.country.controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.City;
import cn.pacificimmi.common.models.Country;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.ImmigrationPolicy;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.StringUtils;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * 国家管理
 * @author xiangbin
 *
 */

@Before(LoginInterCeptor.class)
public class CountryController extends Controller{
	private static Logger log = LoggerFactory.getLogger(CountryController.class);
	Prop dp = PropKit.use("debug_config.txt");
	/****
	 * 默认初始化页面
	 */
	public void index(){
		log.debug("国家查询");
		CountryParams params = new CountryParams(this);
		ContinentDictionaryParams continents = new ContinentDictionaryParams(this);
//		CountryDictionaryParams countrys = new CountryDictionaryParams(this);
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("list", list); 
		
		continents.setOrderStr("order by dictionary.create_time desc ");
		Page<Record> page1 = Db.paginate(continents.getPageNum(), continents.getPageSize(), continents.getSelectStr(), continents.getFromStr());
		List<Record> continent = page1.getList();
		
//		countrys.setOrderStr("order by dictionary.create_time desc ");
//		Page<Record> page2 = Db.paginate(countrys.getPageNum(), countrys.getPageSize(), countrys.getSelectStr(), countrys.getFromStr());
//		List<Record> country = page2.getList();
		List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
		this.setAttr("hotspots", hotspots);//移民目的
		
		this.setAttr("continent", continent);//有多少个大洲
//		this.setAttr("country", country);//有多少国家
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		//页面
		this.renderJsp("/views/country/country_list.jsp");
	}
	
	public void add(){
		log.debug("request for addCountry");
		ParamsParser pp = new ParamsParser(this);
		if(pp.getAllStr("operation") == null || "".equals(pp.getAllStr("operation"))){//跳转新增页面
			//国家列表
			List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
			List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
			this.setAttr("countryList", countryList);
			this.setAttr("hotspots", hotspots);
			this.setAttr("operation", "添加");
			this.renderJsp("/views/country/country_add.jsp");
		}else{
			Country country = null;
			String coun_id = pp.getNormStr("coun_id");
			
			if(null == coun_id || "".equals(coun_id)) {//只有为空的时候判断是否重复添加国家
				country = new Country();
				//二次保存时已经存在
				String country_name = pp.getAllStr("country_name");
				if(null != country_name && !"".equals(country_name)) {
					country.set("country_name", country_name);
				}
				
				String english_name = pp.getAllStr("english_name");
				if(null != english_name && !"".equals(english_name)) {
					country.set("english_name", english_name);
				}
				
				String continent_name = pp.getNormStr("continent");
				if(null != continent_name && !"".equals(continent_name)) {
					country.set("continent_name", continent_name);
				}
				String country_id = pp.getNormStr("country_id");
				
				if(null != country_id && !"".equals(country_id)) {
					Country country2 = Country.dao.findFirst("select * from crm_country where country_id = '"+country_id+"' and delete_flag='0'");
					if(null != country2){
//						this.renderText("不可重复添加国家!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
						this.setAttr("errorInfo", "不可重复添加国家!");
						this.renderJsp("/common/error.jsp");
					}else{
						country.set("country_id", country_id);
						String[] hotspots1 = pp.getIntegers("hot_spot");
						String hotspot = "";
						if(null != hotspots1 && !"".equals(hotspots1)) {
							for(int i=0;i<hotspots1.length;i++){
								hotspot += hotspots1[i]+",";
							}
							country.set("hotspots_id", hotspot.subSequence(0, hotspot.length()-1));
						}
						
						String stand_pic = pp.getAllStr("stand_pic");
						if(null != stand_pic && !"".equals(stand_pic)) {
							this.setAttr("saveSuccess", "1");
							country.set("stand_pic", stand_pic);
						}
						String stand_pic_official = pp.getAllStr("stand_pic_official");
						if(null != stand_pic_official && !"".equals(stand_pic_official)) {
							country.set("stand_pic_official", stand_pic_official);
						}
						String style_pic = pp.getAllStr("style_pic");
						if(null != style_pic && !"".equals(style_pic)) {
							country.set("style_pic", style_pic);
						}
						String cover_pic = pp.getAllStr("cover_pic");
						if(null != cover_pic && !"".equals(cover_pic)) {
							country.set("cover_pic", cover_pic);
						}
						String style_pic_official = pp.getAllStr("style_pic_official");
						if(null != style_pic_official && !"".equals(style_pic_official)) {
							country.set("style_pic_official", style_pic_official);
						}
						String country_brief = pp.getAllStr("country_brief");
						if(null != country_brief && !"".equals(country_brief)) {
							country.set("country_brief", country_brief);
						}
						String living_environment = pp.getAllStr("living_environment");
						if(null != living_environment && !"".equals(living_environment)) {
							this.setAttr("saveSuccess", "1");
							country.set("living_environment", living_environment);
						}
						String social_welfare = pp.getAllStr("social_welfare");
						if(null != social_welfare && !"".equals(social_welfare)) {
							this.setAttr("saveSuccess", "1");
							country.set("social_welfare", social_welfare);
						}
						String educational_level = pp.getAllStr("educational_level");
						if(null != educational_level && !"".equals(educational_level)) {
							this.setAttr("saveSuccess", "1");
							country.set("educational_level", educational_level);
						}
						String invest_home = pp.getAllStr("invest_home");
						if(null != invest_home && !"".equals(invest_home)) {
							this.setAttr("saveSuccess", "1");
							country.set("invest_home", invest_home);
						}
						String employment_environment = pp.getAllStr("employment_environment");
						if(null != employment_environment && !"".equals(employment_environment)) {
							this.setAttr("saveSuccess", "1");
							country.set("employment_environment", employment_environment);
						}
						String passport_nationality = pp.getAllStr("passport_nationality");
						if(null != passport_nationality && !"".equals(passport_nationality)) {
							this.setAttr("saveSuccess", "1");
							country.set("passport_nationality", passport_nationality);
						}
						if(null == coun_id || "".equals(coun_id)) {
							LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
							country.set("create_time",new Date());
							country.set("release_status",0);
							if(null != user){
								country.set("create_user",user.getLoginName());
							}
							
							country.save();
						}else{
							country.update();
						}
						this.setAttr("coun", country);
						//国家列表
						List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
						List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
						this.setAttr("countryList", countryList);
						this.setAttr("hotspots", hotspots);
						this.setAttr("operation", "编辑");
						this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
						this.renderJsp("/views/country/country_add.jsp");
					}
				}
			}else{
				country = Country.dao.findById(coun_id);
				
				
				String[] hotspots1 = pp.getIntegers("hot_spot");
				String hotspot = "";
				if(null != hotspots1 && !"".equals(hotspots1)) {
					for(int i=0;i<hotspots1.length;i++){
						hotspot += hotspots1[i]+",";
					}
					country.set("hotspots_id", hotspot.subSequence(0, hotspot.length()-1));
				}
				
				String stand_pic = pp.getAllStr("stand_pic");
				if(null != stand_pic && !"".equals(stand_pic)) {
					this.setAttr("saveSuccess", "1");
					country.set("stand_pic", stand_pic);
				}
				String stand_pic_official = pp.getAllStr("stand_pic_official");
				if(null != stand_pic_official && !"".equals(stand_pic_official)) {
					country.set("stand_pic_official", stand_pic_official);
				}
				String style_pic = pp.getAllStr("style_pic");
				if(null != style_pic && !"".equals(style_pic)) {
					country.set("style_pic", style_pic);
				}
				String cover_pic = pp.getAllStr("cover_pic");
				if(null != cover_pic && !"".equals(cover_pic)) {
					country.set("cover_pic", cover_pic);
				}
				String style_pic_official = pp.getAllStr("style_pic_official");
				if(null != style_pic_official && !"".equals(style_pic_official)) {
					country.set("style_pic_official", style_pic_official);
				}
				String country_brief = pp.getAllStr("country_brief");
				if(null != country_brief && !"".equals(country_brief)) {
					country.set("country_brief", country_brief);
				}
				String living_environment = pp.getAllStr("living_environment");
				if(null != living_environment && !"".equals(living_environment)) {
					this.setAttr("saveSuccess", "1");
					country.set("living_environment", living_environment);
				}
				String social_welfare = pp.getAllStr("social_welfare");
				if(null != social_welfare && !"".equals(social_welfare)) {
					this.setAttr("saveSuccess", "1");
					country.set("social_welfare", social_welfare);
				}
				String educational_level = pp.getAllStr("educational_level");
				if(null != educational_level && !"".equals(educational_level)) {
					this.setAttr("saveSuccess", "1");
					country.set("educational_level", educational_level);
				}
				String invest_home = pp.getAllStr("invest_home");
				if(null != invest_home && !"".equals(invest_home)) {
					this.setAttr("saveSuccess", "1");
					country.set("invest_home", invest_home);
				}
				String employment_environment = pp.getAllStr("employment_environment");
				if(null != employment_environment && !"".equals(employment_environment)) {
					this.setAttr("saveSuccess", "1");
					country.set("employment_environment", employment_environment);
				}
				String passport_nationality = pp.getAllStr("passport_nationality");
				if(null != passport_nationality && !"".equals(passport_nationality)) {
					this.setAttr("saveSuccess", "1");
					country.set("passport_nationality", passport_nationality);
				}
				if(null == coun_id || "".equals(coun_id)) {
					LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
					country.set("create_time",new Date());
					country.set("release_status",0);
					if(null != user){
						country.set("create_user",user.getLoginName());
					}
					
					country.save();
				}else{
					country.update();
				}
				this.setAttr("coun", country);
				//国家列表
				List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
				List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
				this.setAttr("countryList", countryList);
				this.setAttr("hotspots", hotspots);
				this.setAttr("operation", "编辑");
				this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
				this.renderJsp("/views/country/country_add.jsp");
			}
		}
	}
	@Clear
	public void checkRelease(){
		ParamsParser pp = new ParamsParser(this);
		String coun_id = pp.getNormStr("coun_id");
		if(StringUtils.notEmpty(coun_id)){
			Country country = Country.dao.findById(coun_id);
			if(!(null == country) && !(null == country.getId())){
				//增加判断是否补全信息后发布
				if(StringUtil.isEmpty(country.getPassportNationality())
						&&StringUtil.isEmpty(country.getEmploymentEnvironment())
						&&StringUtil.isEmpty(country.getInvestHome())
						&&StringUtil.isEmpty(country.getEducationalLevel())
						&&StringUtil.isEmpty(country.getSocialWelfare())
						&&StringUtil.isEmpty(country.getLivingEnvironment())){this.setAttr("errorinfo", "居住环境不能为空！");}
				if(StringUtil.isEmpty(country.getCountrySurvey())){this.setAttr("errorinfo", "国家概况不能为空！");}
				if(StringUtil.isEmpty(country.getCountryBrief())){this.setAttr("errorinfo", "国家简介不能为空！");}
				if(StringUtil.isEmpty(country.getCoverPic())){this.setAttr("errorinfo", "封面图片不能为空！");}
				if(StringUtil.isEmpty(country.getStandPic())){this.setAttr("errorinfo", "代表图片不能为空！");}
				if(StringUtil.isEmpty(country.getHotspotsId())){this.setAttr("errorinfo", "移民目的不能为空！");}
				if(StringUtil.isEmpty(country.getEnglishName())){this.setAttr("errorinfo", "英文名不能为空！");}
				if(StringUtil.isEmpty(country.getContinentName())){this.setAttr("errorinfo", "地理分类不能为空！");}
				if(StringUtil.isEmpty(country.getCountryName())){this.setAttr("errorinfo", "国家名不能为空！");}
				
				if(StringUtil.isEmpty(this.getAttr("errorinfo"))){
					this.setAttr("code", "0");
				}else{
					this.setAttr("code", "1");
					this.setAttr("msg", this.getAttr("errorinfo")+" 请填写国家介绍");
				}
			}else{
				this.setAttr("code", "1");
				this.setAttr("msg", "未查询到国家信息");
			}
		}else{
			this.setAttr("code", "1");
			this.setAttr("msg", "未查询到国家信息");
		}
		this.renderJson();
	}
	
	/**
	 * 保存并发布（会保存变更的信息）
	 */
	public void addAndRelease(){
		log.debug("request for addCountry");
		ParamsParser pp = new ParamsParser(this);
		if(pp.getAllStr("operation") == null || "".equals(pp.getAllStr("operation"))){//跳转新增页面
			//国家列表
			List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
			List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
			this.setAttr("countryList", countryList);
			this.setAttr("hotspots", hotspots);
			this.setAttr("operation", "添加");
			this.renderJsp("/views/country/country_add.jsp");
		}else{
			Country country = null;
			String coun_id = pp.getNormStr("coun_id");
			
			if(null == coun_id || "".equals(coun_id)) {//只有为空的时候判断是否重复添加国家
				country = new Country();
				//二次保存时已经存在
				String country_name = pp.getAllStr("country_name");
				if(null != country_name && !"".equals(country_name)) {
					this.setAttr("releaseSuccess", "1");
					country.set("country_name", country_name);
				}
				
				String english_name = pp.getAllStr("english_name");
				if(null != english_name && !"".equals(english_name)) {
					country.set("english_name", english_name);
				}
				
				String continent_name = pp.getNormStr("continent");
				if(null != continent_name && !"".equals(continent_name)) {
					country.set("continent_name", continent_name);
				}
				String country_id = pp.getNormStr("country_id");
				
				if(null != country_id && !"".equals(country_id)) {
					Country country2 = Country.dao.findFirst("select * from crm_country where country_id = '"+country_id+"' and delete_flag='0'");
					if(null != country2){
//						this.renderText("不可重复添加国家!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
						this.setAttr("errorInfo", "不可重复添加国家!");
						this.renderJsp("/common/error.jsp");
					}else{
						country.set("country_id", country_id);
						String[] hotspots1 = pp.getIntegers("hot_spot");
						String hotspot = "";
						if(null != hotspots1 && !"".equals(hotspots1)) {
							for(int i=0;i<hotspots1.length;i++){
								hotspot += hotspots1[i]+",";
							}
							country.set("hotspots_id", hotspot.subSequence(0, hotspot.length()-1));
						}
						
						String stand_pic = pp.getAllStr("stand_pic");
						if(null != stand_pic && !"".equals(stand_pic)) {
							country.set("stand_pic", stand_pic);
						}
						String stand_pic_official = pp.getAllStr("stand_pic_official");
						if(null != stand_pic_official && !"".equals(stand_pic_official)) {
							country.set("stand_pic_official", stand_pic_official);
						}
						String style_pic = pp.getAllStr("style_pic");
						if(null != style_pic && !"".equals(style_pic)) {
							country.set("style_pic", style_pic);
						}
						String cover_pic = pp.getAllStr("cover_pic");
						if(null != cover_pic && !"".equals(cover_pic)) {
							country.set("cover_pic", cover_pic);
						}
						String style_pic_official = pp.getAllStr("style_pic_official");
						if(null != style_pic_official && !"".equals(style_pic_official)) {
							country.set("style_pic_official", style_pic_official);
						}
						String country_brief = pp.getAllStr("country_brief");
						if(null != country_brief && !"".equals(country_brief)) {
							country.set("country_brief", country_brief);
						}
						String living_environment = pp.getAllStr("living_environment");
						if(null != living_environment && !"".equals(living_environment)) {
							country.set("living_environment", living_environment);
						}
						String social_welfare = pp.getAllStr("social_welfare");
						if(null != social_welfare && !"".equals(social_welfare)) {
							country.set("social_welfare", social_welfare);
						}
						String educational_level = pp.getAllStr("educational_level");
						if(null != educational_level && !"".equals(educational_level)) {
							country.set("educational_level", educational_level);
						}
						String invest_home = pp.getAllStr("invest_home");
						if(null != invest_home && !"".equals(invest_home)) {
							country.set("invest_home", invest_home);
						}
						String employment_environment = pp.getAllStr("employment_environment");
						if(null != employment_environment && !"".equals(employment_environment)) {
							country.set("employment_environment", employment_environment);
						}
						String passport_nationality = pp.getAllStr("passport_nationality");
						if(null != passport_nationality && !"".equals(passport_nationality)) {
							country.set("passport_nationality", passport_nationality);
						}
						if(null == coun_id || "".equals(coun_id)) {
							LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
							country.set("create_time",new Date());
							if(null != user){
								country.set("create_user",user.getLoginName());
							}
							
							country.save();
						}else{
							country.update();
						}
						//增加判断是否补全信息后发布
						if(StringUtil.isEmpty(country.getPassportNationality())
								&&StringUtil.isEmpty(country.getEmploymentEnvironment())
								&&StringUtil.isEmpty(country.getInvestHome())
								&&StringUtil.isEmpty(country.getEducationalLevel())
								&&StringUtil.isEmpty(country.getSocialWelfare())
								&&StringUtil.isEmpty(country.getLivingEnvironment())){this.setAttr("errorinfo", "居住环境不能为空！");}
						if(StringUtil.isEmpty(country.getCountrySurvey())){this.setAttr("errorinfo", "国家概况不能为空！");}
						if(StringUtil.isEmpty(country.getCountryBrief())){this.setAttr("errorinfo", "国家简介不能为空！");}
						if(StringUtil.isEmpty(country.getCoverPic())){this.setAttr("errorinfo", "封面图片不能为空！");}
						if(StringUtil.isEmpty(country.getStandPic())){this.setAttr("errorinfo", "代表图片不能为空！");}
						if(StringUtil.isEmpty(country.getHotspotsId())){this.setAttr("errorinfo", "移民目的不能为空！");}
						if(StringUtil.isEmpty(country.getEnglishName())){this.setAttr("errorinfo", "英文名不能为空！");}
						if(StringUtil.isEmpty(country.getContinentName())){this.setAttr("errorinfo", "地理分类不能为空！");}
						if(StringUtil.isEmpty(country.getCountryName())){this.setAttr("errorinfo", "国家名不能为空！");}
						
						if(StringUtil.isEmpty(this.getAttr("errorinfo"))){
							LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
							country.set("release_status",1);
							country.set("release_time",new Date());
							if(null != user){
								country.set("release_user",user.getLoginName());
							}
							
							country.update();
							
							this.setAttr("coun", country);
							//国家列表
							List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
							List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
							this.setAttr("countryList", countryList);
							this.setAttr("hotspots", hotspots);
							this.setAttr("operation", pp.getAllStr("operation"));
							this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
							this.renderJsp("/views/country/country_add.jsp");
						}else{
							this.setAttr("errorInfo", this.getAttr("errorinfo")+"请填写国家介绍");
							this.renderJsp("/common/error.jsp");
						}
						
					}
				}
			}else{
				country = Country.dao.findById(coun_id);
				
				
				String[] hotspots1 = pp.getIntegers("hot_spot");
				String hotspot = "";
				if(null != hotspots1 && !"".equals(hotspots1)) {
					for(int i=0;i<hotspots1.length;i++){
						hotspot += hotspots1[i]+",";
					}
					country.set("hotspots_id", hotspot.subSequence(0, hotspot.length()-1));
				}
				
				String stand_pic = pp.getAllStr("stand_pic");
				if(null != stand_pic && !"".equals(stand_pic)) {
					country.set("stand_pic", stand_pic);
				}
				String stand_pic_official = pp.getAllStr("stand_pic_official");
				if(null != stand_pic_official && !"".equals(stand_pic_official)) {
					country.set("stand_pic_official", stand_pic_official);
				}
				String style_pic = pp.getAllStr("style_pic");
				if(null != style_pic && !"".equals(style_pic)) {
					country.set("style_pic", style_pic);
				}
				String cover_pic = pp.getAllStr("cover_pic");
				if(null != cover_pic && !"".equals(cover_pic)) {
					country.set("cover_pic", cover_pic);
				}
				String style_pic_official = pp.getAllStr("style_pic_official");
				if(null != style_pic_official && !"".equals(style_pic_official)) {
					country.set("style_pic_official", style_pic_official);
				}
				String country_brief = pp.getAllStr("country_brief");
				if(null != country_brief && !"".equals(country_brief)) {
					country.set("country_brief", country_brief);
				}
				String living_environment = pp.getAllStr("living_environment");
				if(null != living_environment && !"".equals(living_environment)) {
					country.set("living_environment", living_environment);
				}
				String social_welfare = pp.getAllStr("social_welfare");
				if(null != social_welfare && !"".equals(social_welfare)) {
					country.set("social_welfare", social_welfare);
				}
				String educational_level = pp.getAllStr("educational_level");
				if(null != educational_level && !"".equals(educational_level)) {
					country.set("educational_level", educational_level);
				}
				String invest_home = pp.getAllStr("invest_home");
				if(null != invest_home && !"".equals(invest_home)) {
					country.set("invest_home", invest_home);
				}
				String employment_environment = pp.getAllStr("employment_environment");
				if(null != employment_environment && !"".equals(employment_environment)) {
					country.set("employment_environment", employment_environment);
				}
				String passport_nationality = pp.getAllStr("passport_nationality");
				if(null != passport_nationality && !"".equals(passport_nationality)) {
					country.set("passport_nationality", passport_nationality);
				}
				if(null == coun_id || "".equals(coun_id)) {
					LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
					country.set("create_time",new Date());
					if(null != user){
						country.set("create_user",user.getLoginName());
					}
					country.save();
				}else{
					country.update();
				}
				//增加判断是否补全信息后发布
				if(StringUtil.isEmpty(country.getPassportNationality())
						&&StringUtil.isEmpty(country.getEmploymentEnvironment())
						&&StringUtil.isEmpty(country.getInvestHome())
						&&StringUtil.isEmpty(country.getEducationalLevel())
						&&StringUtil.isEmpty(country.getSocialWelfare())
						&&StringUtil.isEmpty(country.getLivingEnvironment())){this.setAttr("errorinfo", "居住环境不能为空！");}
				if(StringUtil.isEmpty(country.getCountrySurvey())){this.setAttr("errorinfo", "国家概况不能为空！");}
				if(StringUtil.isEmpty(country.getCountryBrief())){this.setAttr("errorinfo", "国家简介不能为空！");}
				if(StringUtil.isEmpty(country.getCoverPic())){this.setAttr("errorinfo", "封面图片不能为空！");}
				if(StringUtil.isEmpty(country.getStandPic())){this.setAttr("errorinfo", "代表图片不能为空！");}
				if(StringUtil.isEmpty(country.getHotspotsId())){this.setAttr("errorinfo", "移民目的不能为空！");}
				if(StringUtil.isEmpty(country.getEnglishName())){this.setAttr("errorinfo", "英文名不能为空！");}
				if(StringUtil.isEmpty(country.getContinentName())){this.setAttr("errorinfo", "地理分类不能为空！");}
				if(StringUtil.isEmpty(country.getCountryName())){this.setAttr("errorinfo", "国家名不能为空！");}
				
				if(StringUtil.isEmpty(this.getAttr("errorinfo"))){
					LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
					country.set("release_time",new Date());
					country.set("release_status",1);
					if(null != user){
						country.set("release_user",user.getLoginName());
					}
					country.update();
					this.setAttr("coun", country);
					this.setAttr("releaseSuccess", "1");
					//国家列表
					List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
					List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
					this.setAttr("countryList", countryList);
					this.setAttr("hotspots", hotspots);
					this.setAttr("operation", pp.getAllStr("operation"));
					this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
					this.renderJsp("/views/country/country_add.jsp");
				}else{
					this.setAttr("errorInfo", this.getAttr("errorinfo")+"请填写国家介绍");
					this.renderJsp("/common/error.jsp");
				}
			}
		}
	}
	public void edit(){
		ParamsParser pp = new ParamsParser(this);
		
		String coun_id = pp.getNormStr("coun_id");
		if(null != coun_id && !"".equals(coun_id)){
			Country country =  Country.dao.findById(coun_id);
 			String[] hotspots1 = pp.getIntegers("hot_spot");
			String hotspot = "";
			if(null != hotspots1 && !"".equals(hotspots1)) {
				for(int i=0;i<hotspots1.length;i++){
					hotspot += hotspots1[i]+",";
				}
				country.set("hotspots_id", hotspot.subSequence(0, hotspot.length()-1));
			}
			
			String stand_pic = pp.getAllStr("stand_pic");
			if(null != stand_pic && !"".equals(stand_pic)) {
				this.setAttr("saveSuccess", "1");
				country.set("stand_pic", stand_pic);
			}
			String stand_pic_official = pp.getAllStr("stand_pic_official");
			if(null != stand_pic_official && !"".equals(stand_pic_official)) {
				country.set("stand_pic_official", stand_pic_official);
			}
			String style_pic = pp.getAllStr("style_pic");
			if(null != style_pic && !"".equals(style_pic)) {
				country.set("style_pic", style_pic);
			}
			String cover_pic = pp.getAllStr("cover_pic");
			if(null != cover_pic && !"".equals(cover_pic)) {
				country.set("cover_pic", cover_pic);
			}
			String style_pic_official = pp.getAllStr("style_pic_official");
			if(null != style_pic_official && !"".equals(style_pic_official)) {
				country.set("style_pic_official", style_pic_official);
			}
			String country_brief = pp.getAllStr("country_brief");
			if(null != country_brief && !"".equals(country_brief)) {
				this.setAttr("saveSuccess", "1");
				country.set("country_brief", country_brief);
			}
			String living_environment = pp.getAllStr("living_environment");
			if(null != living_environment && !"".equals(living_environment)) {
				this.setAttr("saveSuccess", "1");
				country.set("living_environment", living_environment);
			}
			String social_welfare = pp.getAllStr("social_welfare");
			if(null != social_welfare && !"".equals(social_welfare)) {
				this.setAttr("saveSuccess", "1");
				country.set("social_welfare", social_welfare);
			}
			
			String educational_level = pp.getAllStr("educational_level");
			if(null != educational_level && !"".equals(educational_level)) {
				this.setAttr("saveSuccess", "1");
				country.set("educational_level", educational_level);
			}
			String invest_home = pp.getAllStr("invest_home");
			if(null != invest_home && !"".equals(invest_home)) {
				this.setAttr("saveSuccess", "1");
				country.set("invest_home", invest_home);
			}
			String employment_environment = pp.getAllStr("employment_environment");
			if(null != employment_environment && !"".equals(employment_environment)) {
				this.setAttr("saveSuccess", "1");
				country.set("employment_environment", employment_environment);
			}
			String passport_nationality = pp.getAllStr("passport_nationality");
			if(null != passport_nationality && !"".equals(passport_nationality)) {
				this.setAttr("saveSuccess", "1");
				country.set("passport_nationality", passport_nationality);
			}
			country.update();
			this.setAttr("coun", country);
		}
		
		//国家列表
		List<Dict> countryList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("country"), 2).getSubDictionaries();
		List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
		this.setAttr("countryList", countryList);
		this.setAttr("hotspots", hotspots);
		this.setAttr("operation", "编辑");
		this.setAttr("OFFICIAL_URL", dp.get("OFFICIAL_URL"));
		this.renderJsp("/views/country/country_add.jsp");
	}
	/**
	 * 发布(没有需要变更的信息，直接发布)
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void release(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getNormStr("coun_id");
		if(StringUtil.notEmpty(id)){
			Country country = Country.dao.findById(id);
			
			//增加判断是否补全信息后发布
			if(StringUtil.isEmpty(country.getPassportNationality())
					&&StringUtil.isEmpty(country.getEmploymentEnvironment())
					&&StringUtil.isEmpty(country.getInvestHome())
					&&StringUtil.isEmpty(country.getEducationalLevel())
					&&StringUtil.isEmpty(country.getSocialWelfare())
					&&StringUtil.isEmpty(country.getLivingEnvironment())){this.setAttr("errorinfo", "居住环境不能为空！");}
//			if(StringUtil.isEmpty(country.getEmploymentEnvironment())){this.setAttr("errorinfo", "就业环境不能为空！");}
//			if(StringUtil.isEmpty(country.getInvestHome())){this.setAttr("errorinfo", "投资置业不能为空！");}
//			if(StringUtil.isEmpty(country.getEducationalLevel())){this.setAttr("errorinfo", "教育水准不能为空！");}
//			if(StringUtil.isEmpty(country.getSocialWelfare())){this.setAttr("errorinfo", "社会福利不能为空！");}
//			if(StringUtil.isEmpty(country.getLivingEnvironment())){this.setAttr("errorinfo", "居住环境不能为空！");}
			if(StringUtil.isEmpty(country.getCountrySurvey())){this.setAttr("errorinfo", "国家概况不能为空！");}
			if(StringUtil.isEmpty(country.getCountryBrief())){this.setAttr("errorinfo", "国家简介不能为空！");}
			if(StringUtil.isEmpty(country.getCoverPic())){this.setAttr("errorinfo", "封面图片不能为空！");}
			//if(StringUtil.isEmpty(country.getStylePic())){this.setAttr("errorinfo", "风貌图片不能为空！");}
			if(StringUtil.isEmpty(country.getStandPic())){this.setAttr("errorinfo", "代表图片不能为空！");}
			if(StringUtil.isEmpty(country.getHotspotsId())){this.setAttr("errorinfo", "移民目的不能为空！");}
			if(StringUtil.isEmpty(country.getEnglishName())){this.setAttr("errorinfo", "英文名不能为空！");}
			if(StringUtil.isEmpty(country.getContinentName())){this.setAttr("errorinfo", "地理分类不能为空！");}
			if(StringUtil.isEmpty(country.getCountryName())){this.setAttr("errorinfo", "国家名不能为空！");}
			
			if(StringUtil.isEmpty(this.getAttr("errorinfo"))){
				country.set("release_status",1);
				country.set("release_time",new Date());
				LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
				if(null != user){
					country.set("release_user",user.getLoginName());
				}
				boolean isOk = country.update();
				if(isOk){
					this.setAttr("status", "0");
				}else{
					this.setAttr("status", "1");
					this.setAttr("msg", "保存失败！");
				}
			}else{
				this.setAttr("status", "1");
				this.setAttr("msg", this.getAttr("errorinfo")+" 请填写国家介绍");
			}
		}else{
			this.setAttr("status", "1");
			this.setAttr("msg", "国家为空！");
		}
		this.renderJson();
	}
	
	/**
	 * 下线
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void offline(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getNormStr("coun_id");
		if(StringUtil.notEmpty(id)){
			Country country = Country.dao.findById(id);
			country.set("release_status",2);
			country.set("release_time",new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			if(null != user){
				country.set("release_user",user.getLoginName());
			}	
			boolean isOk = country.update();
			if(isOk){
				this.setAttr("status", "0");
			}else{
				this.setAttr("status", "1");
				this.setAttr("msg", "保存未成功！");
			}
			this.renderJson();
		}
	}
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getNormStr("coun_id");
		if(StringUtil.notEmpty(id)){
			Country country = Country.dao.findById(id);
			country.set("delete_flag",1);
			country.set("delete_time",new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			if(null != user){
				country.set("delete_user",user.getLoginName());
			}
			boolean isOk = country.update();
			if(isOk){
				List<City> citys = City.dao.find("select * from crm_city where country_id = '"+country.getCountryId()+"' and delete_flag='0'");
				if(null != citys && citys.size() > 0){
					for(City city:citys){
						city.setDeleteFlag(1);
						city.setDeleteTime(new Date());
						if(null != user){
							city.setDeleteUsername(user.getLoginName());
						}
						city.update();
					}
				}
				List<ImmigrationPolicy> policys = ImmigrationPolicy.dao.find("select * from crm_immigration_policy where country_id = '"+country.getCountryId()+"' and delete_flag='0'");
				for(ImmigrationPolicy policy:policys){
					policy.setDeleteFlag(1);
					policy.setDeleteTime(new Date());
					if(null != user){
						policy.setDeleteUser(user.getLoginName());
					}
					policy.update();
				}
				this.setAttr("status", "0");
			}else{
				this.setAttr("status", "1");
				this.setAttr("msg", "删除失败，数据库执行异常！");
			}
			this.renderJson();
		}
		
		
	}
	/**
	 * 基本信息详情页
	 */
	public void detail(){
		ParamsParser pp = new ParamsParser(this);
		String id = this.getPara();
		if(StringUtil.notEmpty(id)){
			List<Dict> hotspots = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("hotspot"), 1).getSubDictionaries();
			this.setAttr("hotspots", hotspots);
			Country country = Country.dao.findById(id);
			if(null != country){
				this.setAttr("coun", country);
				this.renderJsp("/views/country/detail/country_detail.jsp");
			}
		}
	}
	/**
	 * 国家概况
	 */
	public void countrySurvey(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String country_survey = pp.getAllStr("country_survey");
				country.setCountrySurvey(country_survey);
				boolean isOk = country.update();
				
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_survey.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_survey.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	/**
	 * 居住环境
	 */
	public void livingEnvironment(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String living_environment = pp.getAllStr("living_environment");
				country.setLivingEnvironment(living_environment);
				boolean isOk = country.update();
				
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_living_environment.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_living_environment.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	
	/**
	 * 社会福利
	 */
	public void socialWelfare(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String social_welfare = pp.getAllStr("social_welfare");
				country.setSocialWelfare(social_welfare);
				boolean isOk = country.update();
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_social_welfare.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_social_welfare.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	
	/**
	 * 教育水准
	 */
	public void educationalLevel(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String educational_level = pp.getAllStr("educational_level");
				country.setEducationalLevel(educational_level);
				boolean isOk = country.update();
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_educational_level.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_educational_level.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	/**
	 * 投资置业
	 */
	public void investHome(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String invest_home = pp.getAllStr("invest_home");
				country.setInvestHome(invest_home);
				boolean isOk = country.update();
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_invest_home.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_invest_home.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	/**
	 * 就业环境
	 */
	public void employmentEnvironment(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String employment_environment = pp.getAllStr("employment_environment");
				country.setEmploymentEnvironment(employment_environment);
				boolean isOk = country.update();
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_employment_environment.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_employment_environment.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	/**
	 * 护照国籍
	 */
	public void passportNationality(){
		ParamsParser pp = new ParamsParser(this);
 		String coun_id = pp.getNormStr("coun_id");
		String operation = pp.getNormStr("operation");
		Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
		if(StringUtil.notEmpty(operation)){
			if(null != country){
				String passport_nationality = pp.getAllStr("passport_nationality");
				country.setPassportNationality(passport_nationality);
				boolean isOk = country.update();
				if(isOk){
					this.setAttr("operation", "编辑");
					this.setAttr("coun", country);
					this.renderJsp("/views/country/country_add_passport_nationality.jsp");
				}
			}else{
				this.redirect("/country");
			}
		}else{
			if(null != country){
				this.setAttr("operation", "编辑");
				this.setAttr("coun", country);
				this.renderJsp("/views/country/country_add_passport_nationality.jsp");
			}else{
				this.redirect("/country");
			}
		}
	}
	/**
	 * 通过countryId在字典表查所属大洲及其英文名
	 */
	@Clear
	public void selectContinent(){
		log.debug("request for addCountry");
		Map<String,String> data = new HashMap<String, String>();
		ParamsParser pp = new ParamsParser(this);
		CountryDictionaryParams countryDictionarys = new CountryDictionaryParams(this);
		//根据countryId查询字典值
		String countryId = pp.getNormStr("countryId");
		if(StringUtil.notEmpty(countryId)){
			Page<Record> page2 = Db.paginate(countryDictionarys.getPageNum(), countryDictionarys.getPageSize(), countryDictionarys.getSelectStr(), countryDictionarys.getFromStr());
			List<Record> country = page2.getList();
			this.setAttr("enName", country.get(0).get("short_name"));
			data.put("enName", country.get(0).get("short_name"));
			String pCode = country.get(0).getStr("dict_pcode");
			this.setAttr("continentId", pCode);
			ContinentDictionaryParams continents = new ContinentDictionaryParams(this);
			Page<Record> page = Db.paginate(continents.getPageNum(), continents.getPageSize(), continents.getSelectStr(), continents.getFromStr());
			List<Record> continent = page.getList();
			this.setAttr("continent", continent.get(0).get("name"));
			data.put("continent",  continent.get(0).get("name"));
			data.put("code", "0");
			this.setAttr("code", "0");
			this.renderJson();
		}
	}
	@Clear
	public void getInfoByCountry(){
		ParamsParser pp = new ParamsParser(this);
		String countryId = pp.getNormStr("countryId");
		String sql = "select dict_pcode,value,name from console_dictionary wherer dict_code = '"+countryId+"'";
		List<Dictionary> dicts = Dictionary.dao.find(sql);
		String dict_pcode = dicts.get(0).getDictPcode();
		String enName = dicts.get(0).getValue();
		String psql = "select dict_pcode,value,name from console_dictionary wherer dict_code = '"+dict_pcode+"'";
		List<Dictionary> pdicts = Dictionary.dao.find(psql);
		String pName = pdicts.get(0).getName();
		this.setAttr("enName", enName);
		this.setAttr("pName", pName);
		this.renderJson();
	}
	/**
	 * 国家查询
	 * @author Gorge
	 *
	 */
	private class CountryParams extends ParamsParser{

	public CountryParams(Controller ctr) {
		super(ctr);
		
		this.setSelectStr("select dictionary_country.dict_code,dictionary_country.dict_pcode,dictionary_country.name,dictionary_country.short_name,dictionary_country.description,dictionary_country.value,"+
						"coun.id,coun.country_id,coun.country_name,coun.continent_name,coun.english_name,coun.hotspots_id,coun.stand_pic,coun.stand_pic_official,coun.style_pic ," +
						"coun.cover_pic,coun.style_pic_official,coun.country_typical,coun.country_brief,coun.living_environment,coun.social_welfare,coun.educational_level,"+
						"coun.invest_home,coun.employment_environment,coun.passport_nationality,coun.release_status,coun.release_time,coun.release_user,coun.create_time,coun.create_user,coun.delete_flag");
		this.setFromStr("from crm_country coun "+
				" LEFT JOIN console_dictionary dictionary_country on coun.country_id = dictionary_country.dict_code ");
		this.addWhereSegmentByAnd("dictionary_country.delete_flag = 0");
		this.addWhereSegmentByAnd("coun.delete_flag = 0");
		
		
		//按照国家名称查询
		String country_name = this.getAllStr("country_name" );
		if(country_name != null && !"".equals(country_name)){
			country_name = country_name.trim();
			this.addWhereSegmentByAnd(" coun.country_name like '%" + country_name + "%'");
			this.ctr.setAttr("country_name", country_name);
		}
		
		//按照大洲查询
		String continent_name = this.getNormStr("continent_name");
		if(continent_name != null && !"".equals(continent_name)){
			this.addWhereSegmentByAnd(" coun.continent_name = '" + continent_name + "'");
			this.ctr.setAttr("continent_name", continent_name);
		}
			
		//按照发布状态查询
		String release_status = this.getNormStr("release_status");
		if(release_status != null && !"".equals(release_status)){
			this.addWhereSegmentByAnd(" coun.release_status = '" + release_status + "'");
			this.ctr.setAttr("release_status", release_status);
		}
				
		this.setDefaultOrderStr("order by coun.create_time desc");
	}
}
	
	/**
	 * 查询都有哪些大洲
	 * @author xiangbin
	 *
	 */
	private class ContinentDictionaryParams extends ParamsParser{

	public ContinentDictionaryParams(Controller ctr) {
		super(ctr);
		
		this.setSelectStr("select dictionary.dict_id,dictionary.dict_code,dictionary.dict_pcode,dictionary.value,dictionary.name,dictionary.short_name ," +
						"dictionary.description,dictionary.create_time");
		this.setFromStr("from console_dictionary dictionary ");
		this.addWhereSegmentByAnd(" dictionary.delete_flag = '0' ");
		String countine = ctr.getAttr("countine");
		if(StringUtil.isEmpty(countine)){
			this.addWhereSegmentByAnd(" dictionary.dict_pcode = '0003' ");
		}else{
			this.addWhereSegmentByAnd(" dictionary.dict_pcode = '"+countine+"'");
		}
		
		String continentId = ctr.getAttr("continentId");
		if(StringUtil.notEmpty(continentId)){
			this.addWhereSegmentByAnd(" dictionary.dict_code = '"+continentId+"'");
		}
		
		
//		this.setDefaultOrderStr("order by dictionary.create_time desc");
	}
}
	/**
	 * 根据大洲查询国家
	 * @author xiangbin
	 *
	 */
	private class CountryDictionaryParams extends ParamsParser{

		public CountryDictionaryParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select dictionary.dict_id,dictionary.dict_code,dictionary.dict_pcode,dictionary.name,dictionary.short_name ," +
							"dictionary.description,dictionary.create_time");
			this.setFromStr("from console_dictionary dictionary ");
			this.addWhereSegmentByAnd(" dictionary.delete_flag = '0'");//未删除的，有效的
			//根据某大洲下的所有国家
			String continent = this.getNormStr("continent");
			if(continent!=null && !"".equals(continent.trim())){
				this.addWhereSegmentByAnd(" dictionary.dict_pcode = '"+continent+"'");
				this.ctr.setAttr("continent", continent);
			}
			//根据国家的id查询字典里这条记录
			String countryId = this.getNormStr("countryId");
			if(StringUtil.notEmpty(countryId)){
				this.addWhereSegmentByAnd(" dictionary.dict_code = '"+countryId+"'");
				this.ctr.setAttr("countryId", countryId);
			}
			
			
			this.setDefaultOrderStr("order by dictionary.create_time desc");
			
		}
	}
}
