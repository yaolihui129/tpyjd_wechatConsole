
package cn.pacificimmi.common.routes;

import cn.pacificimmi.steward.controller.StewardController;
import cn.pacificimmi.steward.controller.StewardDetailController;
//import cn.pacificimmi.steward.controller.StewardDetailController;
import cn.pacificimmi.steward.controller.StewardSignController;
import cn.pacificimmi.steward.controller.StewardUserController;

import com.jfinal.config.Routes;

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月27日 下午2:02:28
 * @category 移民管家
 **/

public class StewardRotes  extends Routes {
	@Override
	public void config() { 
		//管家列表 ，非公司员工扩展为管家等..
		add("/steward/list",StewardController.class);
		//扩展公司员工为管家等..
		add("/steward/list/add",StewardUserController.class);  	
		//管家详情
		add("/steward/list/detail",StewardDetailController.class); 
		//聘用纪录
		add("/steward/sign/list",StewardSignController.class);
	}

}
