package cn.pacificimmi.activity.controlers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Activity;
import cn.pacificimmi.common.models.ActivitySign;
import cn.pacificimmi.common.utils.StringUtil;

@Before(LoginInterCeptor.class) //用户权限拦截器
public class SignsController extends Controller {
	private static Logger log = LoggerFactory.getLogger(SignsController.class);
	public void index(){
		SignParams sp = new SignParams(this);
		String id = sp.getId();
		if(id!=null){
			Activity activity = Activity.dao.findById(id);
			setAttr("activity_name",activity.getActivityName());
		}
		/***
		 * 获取数据列表
		 */
		Page<Record> page = Db.paginate(sp.getPageNum(), sp.getPageSize(), sp.getSelectStr(), sp.getFromStr());
		List<Record> list = page.getList();
		
		for(Record r:list){
			String mobile = r.getStr("sign_mobile");
			if(mobile!=null && !mobile.isEmpty()){
				r.set("sign_mobile", StringUtil.getMaskMobile(mobile));
			}
		}
	
		log.info("Activity list search finished");
		/***
		 * 保存数据列表
		 */
		this.setAttr("list", list);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(sp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		/**
		 * 渲染视图
		 */
		this.renderJsp("/views/cms/activity_sign.jsp");
	}
	
	/**
	 * 查询参数解析类
	 * @author jeff
	 */
	private class SignParams extends ParamsParser{

		public SignParams(Controller ctr) {
			super(ctr);
			
			this.setSelectStr("select cas.sign_name,"
					+ "cas.sign_mobile,"
					+ "cas.sign_user,"
					+ "cas.sign_time,"
					+ "cu.user_name,"
					+ "co.name as dep_name");
			this.setFromStr("from crm_activity_sign cas left join console_user cu on cas.share_userid=cu.user_id left join console_orgnization co on cu.dep_id=co.org_id");
			
			//查找有效数据
			//this.addWhereSegmentByAnd("delete_flag='0'");
			String id = this.getId();
			if(id==null)
				id="0";
			this.addWhereSegmentByAnd("cas.activity_id="+id);
			
			//查询名称
			String name = this.getNormStr("name");
			if(name!=null){
				this.addWhereSegmentByAnd("(cas.sign_name like '%"+name+"%' or cas.sign_mobile like '%"+name+"%')");
			}
			
			this.setDefaultOrderStr("order by cas.sign_time desc");
		}
	}
}
