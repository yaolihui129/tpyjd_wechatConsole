package cn.pacificimmi.distribution.controller;

import java.util.Date;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Role;
import cn.pacificimmi.common.models.Websys;
import cn.pacificimmi.common.utils.MajorKeyFactory;
import cn.pacificimmi.common.utils.StringUtil;

@Before(LoginInterCeptor.class) //用户权限拦截器
public class DistributionController extends Controller {
	public void index(){
		this.renderJsp("/views/distribution_type.jsp");
	}
	
	
	public void add(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation")!=null){
			/***
			 * 通过数据模型，保存数据
			 */
			Role  mw = new Role();
			mw.set("role_id", MajorKeyFactory.getInstance().getMajorKey());
			//角色名称
			String name = pp.getNormStr("name");
			if(name!=null)
				mw.set("name", name);//mw.setName(name);
			//所属平台
			String sys_id = pp.getNormStr("sys_id");
			if(sys_id!=null && !sys_id.equals("0"))
				mw.set("sys_id", sys_id);//mw.setDomain(domain);
			//角色描述
			String description = pp.getNormStr("description");
			if(description!=null){
				mw.set("description", description);
			}
			
			//保存操作人信息
			LoginUserInfo lui = this.getSessionAttr("LoginUserInfo");
			if(lui!=null){
				mw.set("create_user",lui.getUserName());
				mw.set("update_user",lui.getUserName());
			}
			mw.set("update_time",StringUtil.yyyymmddhmsTime(new Date()));
			//是否有效
			mw.set("delete_flag", "DELETE_NO").save();
			/***
			 * 跳转到跳出时列表页地址
			 */
			String fromurl = getPara("fromurl");
			this.redirect(fromurl);
		}
		else{
			/***
			 * 初始化系统选项列表
			 */
			List<Websys> websyss = Websys.dao.find("select * from console_websys where delete_flag='VALID'");
			StringBuffer bf = new StringBuffer();
			bf.append("<select class=\"medium m-wrap\" name=\"sys_id\" id=\"sys_id\">");
			//bf.append("<option value=\"0\">全部</option>");
			for(Websys mw:websyss){
				bf.append("<option value=\""+mw.getSysId()+"\">");
				bf.append(mw.getName());
				bf.append("</option>");
			}
			bf.append("</select>");
			this.setAttr("sys_id", bf.toString());
			
			this.setAttr("operation", "新增");
			this.renderJsp("/views/role.jsp");
		}
	}
	
}
