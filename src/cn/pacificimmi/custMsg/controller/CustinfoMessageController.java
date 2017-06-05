package cn.pacificimmi.custMsg.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.ContentType;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.CustinfoMessage;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.common.utils.StringUtils;
import cn.pacificimmi.custMsg.models.view.CustMsgInfo;

/**
 * 客户留言板
 * @author yang
 * @date 2017年5月31日 下午2:20:34
 */
@Before(LoginInterCeptor.class)
public class CustinfoMessageController extends Controller {
	
	/**
	 * 列表
	 */
	public void index() {
		CustMsgParams cp = new CustMsgParams(this);
		Page<Record> page = Db.paginate(cp.getPageNum(), cp.getPageSize(), cp.getSelectStr(), cp.getFromStr()); 
		List<Record> list = page.getList();
		List<CustMsgInfo> result = new ArrayList<CustMsgInfo>();
		for(Record rd : list) {
			CustMsgInfo ci = new CustMsgInfo();
			ci.bindingData(ci, rd);
			/*ci.setPhone(StringUtil.getMaskMobile(ci.getPhone()));//手机号隐藏中间4位*/
			result.add(ci);
		}
		
		String pagesView = PagesBar.getShortPageBar(cp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		this.setAttr("pageBar",pagesView);
		this.setAttr("list", result);
		this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
		this.renderJsp("/views/custMsg/list.jsp");
	}
	
	
	/**
	 * 编辑留言
	 */
	public void updata() {
		ParamsParser pp = new ParamsParser(this);
		
		String id = pp.getId();
		
		if(StringUtils.notEmpty(id)) {
			CustinfoMessage cm = CustinfoMessage.dao.findById(id);
			if(pp.getNormStr("operation") != null) {
				String remark = pp.getAllStr("remark");
				if(StringUtils.notEmpty(remark)) {
					cm.set("remark", remark);
				}
				cm.set("updata_time", new Date());
				
				cm.update();
				this.redirect("/data/custMsg");
			} else {
				
				/*cm.setPhone(StringUtil.getMaskMobile(cm.getPhone()));//手机号隐藏中间4位*/	
				this.setAttr("OFFICIAL_URL", PropKit.use("debug_config.txt").get("OFFICIAL_URL"));
				this.setAttr("custinfoMessage", cm);
				this.setAttr("operation", "编辑");
				this.renderJsp("/views/custMsg/edit.jsp");
			}
		} else {
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
		}
	}
	
	
	/**
	 * 删除
	 */
	public void delete() {
		Map<String, Object> map = new HashMap<String, Object>();
		String id = this.getPara(0);
		if(StringUtils.notEmpty(id)) {
			Db.update("update official_custinfo_message set delete_flag = 1 where custinfo_message_id="+id);
			map.put("status", 0);
			map.put("msg", "删除成功");
		} else {
			map.put("status", 1);
			map.put("msg", "参数不正确");
		}
		this.renderJson(map);
	}
	
	
	/**
	 * 查询
	 * @author yang
	 * @date 2017年5月31日 下午2:26:15
	 */
	private class CustMsgParams extends ParamsParser {

		public CustMsgParams(Controller ct) {
			super(ct);
			// TODO Auto-generated constructor stub
			this.setSelectStr("select * ");
			this.setFromStr("from official_custinfo_message");
			this.addWhereSegmentByAnd("delete_flag=0");
			this.setDefaultOrderStr("ORDER BY create_time desc");
		}
		
	}
	
}
