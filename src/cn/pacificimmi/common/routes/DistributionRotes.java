
package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.distribution.controller.DistributionController; 
import cn.pacificimmi.distribution.controller.DistributionSetController;
import cn.pacificimmi.distribution.controller.DistributionTypeController;

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月24日 下午3:43:50
 * 分销路由
 **/

public class DistributionRotes extends Routes{

	@Override
	public void config() {  
		add("/distribution/commissiontype",DistributionTypeController.class); 
		add("/distribution/set",DistributionSetController.class); 
		add("/distribution/main",DistributionController.class); 
		
	}
	
}
