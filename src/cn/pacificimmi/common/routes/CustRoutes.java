package cn.pacificimmi.common.routes;

import com.jfinal.config.Routes;

import cn.pacificimmi.customer.controllers.ClueController;
import cn.pacificimmi.customer.controllers.CustController;
import cn.pacificimmi.customer.controllers.CustFollowController;
import cn.pacificimmi.customer.controllers.CustSignController;
import cn.pacificimmi.customer.controllers.FileController;
import cn.pacificimmi.customer.controllers.LetterController;
import cn.pacificimmi.customer.controllers.MembersController;


/**客户信息
 * @author guyic
 *
 */
public class CustRoutes extends Routes {

	@Override
	public void config() {
		// TODO Auto-generated method stub
		add("/cust",CustController.class);//潜在客户
		add("/cust/followrecord",CustFollowController.class);//客户跟进记录
		add("/cust/signrecord",CustSignController.class);//客户签约信息
		add("/members",MembersController.class);//会员管理
		add("/letters",LetterController.class);//站内信
		add("/cust/clue",ClueController.class);//线索管理
		
		add("/filedemo",FileController.class);
	}

}
