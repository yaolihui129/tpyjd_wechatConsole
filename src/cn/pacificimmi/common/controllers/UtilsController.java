package cn.pacificimmi.common.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;

public class UtilsController extends Controller{
	
	/**
	 * 根据国家code获取归属的城市
	 * @param 国家dict_code
	 * @return json数据 status=0,获取成功；status=1, 获取失败；citys=城市数据
	 */
	public void getCity() {
		String country_id = this.getPara("country_code");
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(null != country_id && !"".equals(country_id)) {
			List<Dict> cytyList =  DictionaryManager.getInstance().
					getAllSubDictionaries(country_id, 1).getSubDictionaries();
			map.put("citys", cytyList);
			map.put("status", 0);
			map.put("msg", "获取成功");
		} else {
			map.put("status", 1);
			map.put("msg", "获取失败");
			map.put("tips", "国家ocde为空");
		}
		
		this.renderJson(map);
	}
	
}
