package cn.pacificimmi.common.controllers;

import java.util.Date;
import java.util.List;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.AddressCity;
import cn.pacificimmi.common.models.City;
import cn.pacificimmi.common.models.Country;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.StringUtil;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * 热门城市管理
 * @author xiangbin
 *
 */
@Before(LoginInterCeptor.class)
public class CityController extends Controller{
	/**
	 * 城市列表查询
	 */
	@Clear
	public void index(){
		String provinceId = this.getPara();
		List<Dictionary> citys = Dictionary.dao.find("select * from console_dictionary where dict_pcode = '"+provinceId+"'");
		this.setAttr("citys", citys);
		this.renderJson();
	}
	/**
	 * 根据国家跳转到对应的热门城市列表
	 */
	public void hotCityList(){
		CityParams params = new CityParams(this);
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		String coun_id = params.getNormStr("coun_id" );
		if(coun_id != null && !"".equals(coun_id)){
			Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
			if(null != country){this.setAttr("coun", country);}
			this.setAttr("coun_id", coun_id);
		}
		this.setAttr("citys", list);
		this.renderJsp("/views/country/city_list.jsp");
	}
	public void addHotCity(){
		ParamsParser pp = new ParamsParser(this);
		
		
		String operation = pp.getNormStr("operation");
		
		if(StringUtil.isEmpty(operation)){//跳转到添加城市页面
			String countryId = pp.getNormStr("coun_id");
//			Country country = Country.dao.findById(countryId);
			if(StringUtil.notEmpty(countryId)){
				Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+countryId+"' and delete_flag='0'");
				if(null != country){this.setAttr("coun", country);}
				List<Dictionary> dicts = Dictionary.dao.find("select * from console_dictionary where dict_pcode = '"+countryId+"' and delete_flag = 0");
				this.setAttr("citys", dicts);
				this.setAttr("operation", "添加");
				this.setAttr("coun_id", countryId);
//				this.setAttr("coun_name", country.getCountryName());
				this.renderJsp("/views/country/city_add.jsp");
			}
			
		}else{//添加城市
			String countryId = pp.getNormStr("coun_id");
			
			if(StringUtil.notEmpty(countryId)){
				City city = new City();
				city.set("country_id", countryId);
				String country_name = pp.getNormStr("coun_name");
				if(null != country_name && !"".equals(country_name)) {
					city.set("country_name", country_name);
				}
				String city_id = pp.getNormStr("city_id");
				if(null != city_id && !"".equals(city_id)) {
					City city2 = City.dao.findFirst("select * from crm_city where city_id='"+city_id+"' and delete_flag='0'");
					if(null != city2){
						this.setAttr("errorInfo", "不可重复添加热门城市!");
						this.renderJsp("/common/error.jsp");
					}else{
						city.set("city_id", city_id);
						String city_name = pp.getNormStr("city_name");
						if(null != city_name && !"".equals(city_name)) {
							city.set("city_name", city_name);
						}
						String city_egname = pp.getAllStr("city_egname");
						if(null != city_egname && !"".equals(city_egname)) {
							city.set("city_egname", city_egname);
						}
						String description = pp.getAllStr("description");
						if(null != description && !"".equals(description)) {
							city.set("description", description);
						}
						String thumb_img = pp.getAllStr("thumb_img");
						if(null != thumb_img && !"".equals(thumb_img)) {
							city.set("thumb_img", thumb_img);
						}
						String big_img = pp.getAllStr("big_img");
						if(null != big_img && !"".equals(big_img)) {
							city.set("big_img", big_img);
						}
						city.set("delete_flag", "0");
						city.set("create_time", new Date());
						LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
						if(null != user){
							city.set("create_userid", user.getUid());
							city.set("create_username", user.getLoginName());
						}
						city.set("is_hot", "0");
						city.save();
						this.redirect("/country/city/hot/hotCityList?coun_id="+countryId);
					}
				}
			}
		}
	}
	
	/**
	 * 修改
	 */
	public void editHotCity(){
		ParamsParser pp = new ParamsParser(this);
 		String operation = pp.getNormStr("operation");
		
		String city_id = pp.getNormStr("city_id");
		String coun_id = pp.getNormStr("coun_id");
		City city = City.dao.findById(city_id);
		if(null != city && StringUtil.notEmpty(coun_id)){
			this.setAttr("city", city);
			this.setAttr("coun_id", coun_id);
			if(StringUtil.notEmpty(operation)){//修改保存后跳转到热门城市列表页
				
				String city_name = pp.getNormStr("city_name");
				if(null != city_name && !"".equals(city_name)) {
					city.set("city_name", city_name);
				}
				String city_egname = pp.getNormStr("city_egname");
				if(null != city_egname && !"".equals(city_egname)) {
					city.set("city_egname", city_egname);
				}
				String description = pp.getAllStr("description");
				if(null != description && !"".equals(description)) {
					city.set("description", description);
				}
				String thumb_img = pp.getAllStr("thumb_img");
				if(null != thumb_img && !"".equals(thumb_img)) {
					city.set("thumb_img", thumb_img);
				}
				String big_img = pp.getAllStr("big_img");
				if(null != big_img && !"".equals(big_img)) {
					city.set("big_img", big_img);
				}
				city.set("modify_time", new Date());
				LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
				if(null != user){
					city.set("modify_userid", user.getUid());
					city.set("modify_username", user.getLoginName());
				}
				boolean isOk = city.update();
				if(isOk){
					this.redirect("/country/city/hot/hotCityList?coun_id="+coun_id);
				}
		}else{//跳转到修改页面
//				Country country = Country.dao.findFirst("select * from crm_country where country_id"+coun_id+"' and delete_flag = 0");
				if(StringUtil.notEmpty(coun_id)){
					Country country = Country.dao.findFirst("select * from crm_country where country_id = '"+coun_id+"' and delete_flag='0'");
					if(null != country){this.setAttr("coun", country);}
					List<Dictionary> dicts = Dictionary.dao.find("select * from console_dictionary where dict_pcode = '"+coun_id+"' and delete_flag = 0");
					this.setAttr("citys", dicts);
					this.setAttr("operation", "编辑");
//					this.setAttr("coun_name", country.getCountryName());
					this.renderJsp("/views/country/city_add.jsp");
				}
			
			}
			
		}
	
		
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete(){
 		ParamsParser pp = new ParamsParser(this);
		String cityId = pp.getNormStr("city_id");
		String coun_id = pp.getNormStr("coun_id");
		City city = City.dao.findById(cityId);
		if(null != city && StringUtil.notEmpty(coun_id)){
			city.set("delete_flag", "1");
			city.set("delete_time", new Date());
			LoginUserInfo user = this.getSessionAttr("LoginUserInfo");
			if(null != user){
				city.set("delete_userid", user.getUid());
				city.set("delete_username", user.getLoginName());
			}
			boolean isOk = city.update();
			if(isOk){
				this.setAttr("status", "0");
				this.renderJson();
			}else{
				this.setAttr("status", "1");
				this.setAttr("msg","数据库异常！");
				this.renderJson();
			}
		}
	}
	/**
	 * 单独上传缩略图的方法
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void uploadPic(){
		ParamsParser pp = new ParamsParser(this);
		
		String city_id = pp.getNormStr("city_id");
		String thumb_img = pp.getAllStr("thumb_img");
		City city = City.dao.findById(city_id);
		if(null != city && StringUtil.notEmpty(thumb_img)){
			city.set("thumb_img", thumb_img);
			boolean isOk = city.update();
			if(isOk){
				this.setAttr("status", "0");
				this.renderJson();
			}else{
				this.setAttr("status", "1");
				this.setAttr("msg", "数据库异常！");
				this.renderJson();
			}
		}else{
			this.setAttr("status", "1");
			this.setAttr("msg", "未查询到该城市信息！");
			this.renderJson();
		}
		
		
	}
	private class CityParams extends ParamsParser{

		public CityParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select id,country_id,country_name,city_id,city_name,city_egname,description,thumb_img,big_img,is_hot,"+
			"create_time,create_userid,create_username,modify_time,modify_userid,modify_username,delete_flag,delete_time,delete_userid,delete_username");
			this.setFromStr("from crm_city city ");
			
			this.addWhereSegmentByAnd("city.delete_flag = 0");
			
			
			//按照国家名称查询
			String coun_id = this.getNormStr("coun_id" );
			if(coun_id != null && !"".equals(coun_id)){
				this.addWhereSegmentByAnd(" city.country_id = '" + coun_id + "'");
				this.ctr.setAttr("coun_id", coun_id);
			}
			String coun_name = this.getNormStr("coun_name" );
			if(coun_name != null && !"".equals(coun_name)){
				this.addWhereSegmentByAnd(" city.country_name = '" + coun_name + "'");
				this.ctr.setAttr("coun_name", coun_name);
			}
			
			this.setDefaultOrderStr("order by city.create_time desc");
		}
	}
}
