
package cn.pacificimmi.distribution.controller;

import java.util.ArrayList;
import java.util.Date; 
import java.util.HashMap;
import java.util.List; 
import java.util.Map;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;  
import cn.pacificimmi.common.models.DistributionType; 
import cn.pacificimmi.common.models.Orgnization;
import cn.pacificimmi.common.models.Station;
import cn.pacificimmi.common.models.User;
import cn.pacificimmi.common.models.UserStation;
import cn.pacificimmi.common.utils.MD5Util;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.distribution.models.view.DistributionTypeInfo;   
import com.jfinal.aop.Before;
import com.jfinal.core.Controller; 
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record; 
import com.jfinal.render.ContentType;

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月24日 下午5:14:43
 **/
@Before(LoginInterCeptor.class) 
public class DistributionTypeController extends Controller {
	public void index(){
		DistributionParams sp = new DistributionParams(this);
		ArrayList<DistributionTypeInfo> result = new ArrayList<DistributionTypeInfo>();
		ParamsParser pp = new ParamsParser(this);
		//way
		String way= pp.getNormStr("way");
		String para = getPara("field"); 
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> distributionType = page.getList();
		for(Record rd:distributionType){
			DistributionTypeInfo dt = new DistributionTypeInfo(); 
			dt.setDist_type_id(rd.getInt("distribution_type_id").toString());
			dt.setDist_type_name(rd.getStr("type_name"));
			dt.setDist_type_sort(rd.getInt("sort").toString());
			dt.setDist_type_create_time(StringUtil.yyyymmddhmsTime(rd.getDate("create_time")));
			result.add(dt);
		}
		/***
		 * 保存数据列表
		 */
		this.setAttr("list", result); 
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/distribution_types.jsp");
	}
	
	
	
	
	/**
	 * 查询参数解析类
	 * @author lijinlun
	 *
	 */
	private class DistributionParams extends ParamsParser{

		public DistributionParams(Controller ctr) {
			super(ctr);
			/***
			 * 处理传入参数
			 */
			this.setSelectStr("select * ");
			this.setFromStr("from crm_distribution_type ");
			String type_name = this.getNormStr("type_name"); 
			if(type_name!=null){
				this.addWhereSegmentByAnd(" type_name like '%"+type_name+"%' ");
			}
			//默认排序
			this.setDefaultOrderStr("order by create_time desc");
		}
	}
	 
	
	/**
	 * 渲染新增视图
	 * @author lijinlun
	 */
	public void add(){
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation")!=null){
			/***
			 * 通过数据模型，保存数据
			 */
			DistributionType  dp = new DistributionType();
			//dp.set("distribution_type_id", MajorKeyFactory.getInstance().getMajorKey()); 
			//分销类型名称
			String type_name= pp.getNormStr("type_name");
			
			if(type_name!=null)
				dp.set("type_name", type_name);
			//排序
			Integer sort = Integer.parseInt(pp.getNormStr("sort"));
			if(sort!=null)
				dp.set("sort", sort);
			 //创建时间
			dp.set("create_time",StringUtil.yyyymmddhmsTime(new Date())); 
			dp.save();
			
			/***
			 * 跳转到跳出时列表页地址
			 */
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else
		{ 	
			this.setAttr("operation", "新增");
			this.renderJsp("/views/distribution_type.jsp");
		}
	}
	
	
	
	
	
	/***
	 * 
	 */ 
	public void remove(){
		DistributionParams sp = new DistributionParams(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		 
		if(!sp.getIds().isEmpty()){
			String ids = sp.getIds();
			String[] split = ids.split(",");
			for (int i = 0; i < split.length; i++) {
				Db.deleteById("crm_distribution_type", "distribution_type_id", split[i]);
			}  
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
	
	
	
	
	
	
	
	public void update(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getId()!=null){
			if(pp.getNormStr("operation")!=null){
				DistributionType model = DistributionType.dao.findById(pp.getId());
				//用于排序
				String sort= pp.getNormStr("sort");
				if(sort!=null)
					model.set("sort", sort);
				 
				//分销类型名称
				String type_name = pp.getNormStr("type_name");
				if(type_name!=null)
					model.set("type_name", type_name);
				 
				//修改创建时间  
				model.set("create_time",StringUtil.yyyymmddhmsTime(new Date())); 
				model.update();
				 
				/***
				 * 跳转到跳出时列表页地址
				 */
				
				String fromurl = getPara("fromurl");
				this.redirect(fromurl);
			}
			else
			{
				DistributionType model = DistributionType.dao.findById(pp.getId()); 
				if(model!=null){
					//加载对象数据
					this.setAttr("model", model);
					this.setAttr("operation", "编辑");  
					this.renderJsp("/views/distribution_type.jsp");
				}
				else{
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			}
		}
		else
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
}
