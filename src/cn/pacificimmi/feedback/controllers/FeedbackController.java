package cn.pacificimmi.feedback.controllers;

import java.util.ArrayList;
import java.util.List;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.feedback.models.view.FeedbackInfo;

@Before(LoginInterCeptor.class)
public class FeedbackController extends Controller{
	
	/**
	 * 客户反馈列表
	 */
	public void index() {
		FeedbackParams fp = new FeedbackParams(this);
		
		Page<Record> page = Db.paginate(fp.getPageNum(), fp.getPageSize(), fp.getSelectStr(), fp.getFromStr());
		List<Record> list = page.getList();
		List<FeedbackInfo> result = new ArrayList<FeedbackInfo>();
		
		for(Record rd:list) {
			FeedbackInfo di = new FeedbackInfo();
			di.bindingData(di, rd);
			if(StringUtil.notEmpty(di.getPhone_num())) {
				di.setPhone_num(StringUtil.getMaskMobile(di.getPhone_num()));
			}
			result.add(di);
		}
		
		this.setAttr("list", result);
		String pagesView = PagesBar.getShortPageBar(fp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		this.render("/views/feedback/list.jsp");
	}
	
	/**
	 * 查询
	 * @author yang
	 */
	private class FeedbackParams extends ParamsParser {
		
		public FeedbackParams(Controller ct) {
			super(ct);
			
			this.setSelectStr("SELECT "+
					 "custinfo_feedback_id,contact_way,version,message,create_time, "+
					 "(select name from crm_custinfo cus where delete_flag=0 and custinfo_id=crm_custinfo_feedback.custinfo_id)custinfo_name, "+
					 "(select phone_num from crm_custinfo where delete_flag=0 and custinfo_id=crm_custinfo_feedback.custinfo_id)phone_num, "+
					 "(select name from console_dictionary where delete_flag=0 and dict_code=crm_custinfo_feedback.feedback)feedback_name, "+
					 "(select name from console_dictionary where delete_flag=0 and dict_code=crm_custinfo_feedback.profession_degree)profession_degree_name, "+
					 "(select name from console_dictionary where delete_flag=0 and dict_code=crm_custinfo_feedback.call_back)call_back_name");
			this.setFromStr("FROM crm_custinfo_feedback");
			this.setDefaultOrderStr("order by create_time desc");
		}
	}
	
}
