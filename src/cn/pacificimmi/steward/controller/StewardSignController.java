package cn.pacificimmi.steward.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
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
import cn.pacificimmi.steward.models.view.SignInfo;

@Before(LoginInterCeptor.class)
public class StewardSignController extends Controller {
	public void index(){
		SignParamsParser spp = new SignParamsParser(this);
		
		Page<Record> page = Db.paginate(spp.getPageNum(), spp.getPageSize(), spp.getSelectStr(), spp.getFromStr());
		List<SignInfo> list= new ArrayList<SignInfo>();
		for(Record rs:page.getList()){
			//赋值
			SignInfo si = new SignInfo();
			si.setCustomMobile(StringUtil.getMaskMobile(rs.getStr("phone_num")));
			si.setStewardName(rs.getStr("user_name"));
			si.setEnglishName(rs.getStr("english_name"));
			si.setCustomNickName(rs.getStr("wx_name"));
			String reason = rs.getStr("unsign_reason");
			if(reason!=null && !reason.isEmpty() && reason.length()>25){
				si.setUnsignReason(reason.substring(0, 25)+"...");
			}
			else
				si.setUnsignReason(reason);
			si.setUnsignReasonTitle(reason);
			
			String opt = rs.getStr("sign_status");
//			if(opt.equals("聘用")){
//				si.setOptTime(rs.getDate("sign_time"));
//			}
//			else{
//				si.setOptTime(rs.getDate("unsign_time"));
//			}
			si.setOptTime(rs.getDate("update_time"));
			si.setSignStatus(opt);
			
			list.add(si);
		}
		
		/**
		 * 绑定列表数据
		 */
		setAttr("list",list);
		
		/***
		 * 保存翻页
		 */
		String pagesView = PagesBar.getShortPageBar(spp.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		this.renderJsp("/views/steward/steward_signs.jsp");
		
	}
	
	private class SignParamsParser extends ParamsParser{
		public SignParamsParser(Controller ct) {
			super(ct);
			
			this.setSelectStr("select cu.user_name,cu.english_name,css.*,cc.wx_name,cc.phone_num");
			this.setFromStr("from crm_steward_sign css,crm_steward_user as csu,console_user as cu, crm_custinfo as cc ");
			this.setDefaultOrderStr("order by css.update_time desc");
			this.addWhereSegmentByAnd("css.custinfo_id=cc.custinfo_id");
			this.addWhereSegmentByAnd("css.steward_id=csu.steward_id");
			this.addWhereSegmentByAnd("csu.user_id=cu.user_id");
			
			String nick_name = this.getAllStr("nick_name");
			if(nick_name!=null){
				try {
					this.addWhereSegmentByAnd("cc.wx_name like '%"+URLEncoder.encode(nick_name,"UTF-8")+"%'");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				setAttr("nick_name",nick_name);
			}
			
			String user_name = this.getNormStr("user_name");
			if(user_name!=null){
				this.addWhereSegmentByAnd("cu.user_name like '%"+user_name+"%'");
				setAttr("user_name",user_name);
			}
			
			String sign_status = this.getNormStr("sign_status");
			if(sign_status!=null){
				this.addWhereSegmentByAnd("css.sign_status='"+sign_status+"'");
				setAttr("sign_status",sign_status);
			}
		}
	}
	
}
