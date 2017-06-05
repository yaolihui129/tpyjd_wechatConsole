
package cn.pacificimmi.distribution.controller;

import java.util.ArrayList;
import java.util.List;

import cn.pacificimmi.common.interceptor.LoginInterCeptor;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller; 

/**
 *	@version pacific 1.0.0
 * @author lijinlun
 * @date : 2016年10月24日 下午5:14:43
 **/
@Before(LoginInterCeptor.class) 
public class DistributionSetController extends Controller {
	
	public void index(){
		this.renderJsp("/views/set.jsp");
		/*List<DistributionType> distributionTypes = distributionService.queryAllDistributionType();
		mv.addObject("distributionTypes", distributionTypes);
		 
		int version= distributionService.findLastDistributionScaleVersion();
		
		List<DistributionScale> distributionScales_model1= distributionService.findDistributionScaleListVersion_model_level(version,"1");
		List<DistributionScale> distributionScales_model2= distributionService.findDistributionScaleListVersion_model_level(version,"2");
		
		List<DistributionScale> distributionScales_model1s=new ArrayList<DistributionScale>();
		mv.addObject("distributionScales_model1", distributionScales_model1);
		
		if(distributionScales_model1.size()>0){
			mv.addObject("model1_size", distributionScales_model1.size());
			for (int i = 0; i < distributionScales_model1.size(); i++) {
				DistributionScale distributionScale=distributionScales_model1.get(i);
				distributionScale.setTypeScale(distributionScale.getTypeScale()); 
				distributionScales_model1s.add(distributionScale);
			}
			mv.addObject("distributionScales_model1", distributionScales_model1s);
		}else{
			mv.addObject("model1_size", 0);
			mv.addObject("distributionScales_model1", distributionScales_model1);
		}
			
		
		List<DistributionScale> distributionScales_model2s=new ArrayList<DistributionScale>();
		if(distributionScales_model2.size()>0){
			mv.addObject("model2_size", distributionScales_model2.size());
			for (int i = 0; i < distributionScales_model2.size(); i++) {
				DistributionScale distributionScale=distributionScales_model2.get(i);
				distributionScale.setLevel1Scale(distributionScale.getLevel1Scale());
				distributionScale.setLevel2Scale(distributionScale.getLevel2Scale());
				 distributionScales_model2s.add(distributionScale);
			}
			mv.addObject("distributionScales_model2", distributionScales_model2s);
		}else{
			mv.addObject("model2_size", 0);
			mv.addObject("distributionScales_model2", distributionScales_model2);
		}*/
	}
	
	
	
	
	
}
