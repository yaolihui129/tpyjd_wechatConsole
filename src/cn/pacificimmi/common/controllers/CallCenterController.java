package cn.pacificimmi.common.controllers;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.utils.HttpUtils;
/**
 * 呼叫中心
 * @author Gorge
 * @date : 20170227
 **/
@Before(LoginInterCeptor.class)
public class CallCenterController extends Controller {
	private static Logger log = LoggerFactory.getLogger(CallCenterController.class);

	//默认外呼
	public void index(){
		ParamsParser pp = new ParamsParser(this);
		boolean canCall = true;
		Map<String,Object> result = new HashMap<String,Object>();
		try{
			Record caller = Db.findById("console_user","user_id", pp.getAllStr("Caller"));
			
			if(null == caller){
				canCall = false;
				result.put("code", 100);
				result.put("msg", "用户不存在!ID:["+pp.getAllStr("Caller")+"]");
			}else{
				if(null == caller.get("seat_number") || String.valueOf(pp.getAllStr("Caller")).isEmpty()){
					canCall = false;
					result.put("code", 100);
					result.put("msg", "座席号未设置");
				}
			}
			
			Custinfo called = Custinfo.dao.findById(pp.getAllStr("Called"));//被叫
			if(null == called || called.getPhoneNum().isEmpty()){
				canCall = false;
				result.put("code", 100);
				result.put("msg", "被叫号码错误");
			}
			if(canCall){
				String res = HttpUtils.icallDialoutV2(caller.get("seat_number").toString(),called.getPhoneNum(),"Local","");
				JSONObject json = JSONObject.parseObject(res);
				if(json.get("Succeed").equals(true)){
					result.put("code", 0);
					result.put("msg", "外呼成功");
				}else{
					result.put("code", 100);
					result.put("msg", "外呼失败："+json.getString("Message"));
					String message = json.getString("Message");
					log.error("调用外呼接口失败:"+message);
					
				}
				
			}
			this.renderJson(result);
		}catch(Exception e){
			log.error("拨打电话错误"+e.getMessage(), e);
			result.put("code", 100);
			result.put("msg", "服务器异常");
			this.renderJson(result);
		}
		
	} 
	
	
}
