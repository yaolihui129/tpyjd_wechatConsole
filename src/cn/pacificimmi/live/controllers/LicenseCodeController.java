package cn.pacificimmi.live.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.InvitationCode;
import cn.pacificimmi.common.models.Live;
import cn.pacificimmi.common.utils.StringUtil;
import cn.pacificimmi.live.controllers.models.view.Steward;

@Before(LoginInterCeptor.class)
public class LicenseCodeController extends Controller {
	public void index(){
		ParamsParser pp = new ParamsParser(this);
		String liveid= pp.getId();
		if(liveid!=null){
			Live live = Live.dao.findById(liveid);
			setAttr("live",live);
			
			/**
			 * 已生成邀请码
			 */
			List<InvitationCode> ics = InvitationCode.dao.find("select * from portal_invitation_code where live_id="+liveid);
			setAttr("codeNum",ics.size());
			
			/**
			 * 剩余数量
			 */
			setAttr("rest",live.getLiveLimit()-ics.size());
			
			List<Steward> stewards = new ArrayList<Steward>();
			List<Record> stewardList = Db.find("select csu.steward_id,cu.user_name from crm_steward_user as csu,console_user as cu where csu.user_id=cu.user_id and csu.delete_flag='0' and csu.release_mark='已发布' order by csu.create_time desc");
			for(Record rc:stewardList){
				Steward steward = new Steward();
				steward.setStewardId(rc.getInt("steward_id"));
				steward.setStewardName(rc.getStr("user_name"));
				stewards.add(steward);
			}
			setAttr("stewards",stewards);
			this.renderJsp("/views/live/live_license_code.jsp");
		}
		else{
			setAttr("errorInfo","参数错误！");
			this.renderJsp("/common/error.jsp");
		}
	}
	
	@Clear
	public void ceateCode(){
		Map<String,Object> rst = new HashMap<String,Object>();
		
		ParamsParser pp = new ParamsParser(this);
		String liveId= pp.getInt("liveId");
		String stewardId = pp.getInt("stewardId");
		String num = pp.getInt("num");
		
		if(liveId!=null && stewardId!=null && num!=null){
			Live live = Live.dao.findById(liveId);
			
			/**
			 * 已生成邀请码
			 */
			List<InvitationCode> ics = InvitationCode.dao.find("select * from portal_invitation_code where live_id="+liveId);
			int codeNum = ics.size();
			
			/**
			 * 剩余数量
			 */
			int rest = live.getLiveLimit()-codeNum;
			codeNum=Integer.valueOf(num);
			
			if(rest>0 && codeNum<=rest && codeNum>0){
				String filename=liveId+"_"+stewardId+"_"+System.currentTimeMillis();
				try {
					String Root = PathKit.getWebRootPath();
					if(!Root.endsWith("/"))
						Root+="/";
					String filePath = Root+ "download/"+filename+".txt";
					FileOutputStream out = new FileOutputStream(new File(filePath));

					StringBuffer json = new StringBuffer();
					json.append("{\"status\":0,\"msg\":\"ok\",\"list\":[");
					
					boolean flag=false;
					for(int i=0;i<codeNum;i++){
						InvitationCode ic = new InvitationCode();
						ic.setCode(StringUtil.getInvitationCode());
						ic.setLiveId(Integer.valueOf(liveId));
						ic.setStewardId(Integer.valueOf(stewardId));
						ic.setUsed(0);
						
						ic.save();
						if(flag){
							json.append(",\"").append(ic.getCode()).append("\"");
							out.write("\r\n".getBytes());
							out.write(ic.getCode().getBytes());
						}
						else{
							json.append("\"").append(ic.getCode()).append("\"");
							out.write(ic.getCode().getBytes());
							flag=true;
						}
					}
					out.close(); 
					
					json.append("],");
					json.append("\"filename\":\""+filename+"\"}");
					this.renderJson(json.toString());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					rst.put("status", 100);
					rst.put("msg", "文件写入失败!");
					this.renderJson(rst);
				}
				
			}
			else{
				rst.put("status", 100);
				rst.put("msg", "没有足够生成邀请码名额!");
				this.renderJson(rst);
			}
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "参数错误!");
			this.renderJson(rst);
		}
	}
	
	@Clear
	public void download(){
		String filename = this.getPara(0);
		filename = filename+".txt";
		this.renderFile(filename);
	}
}
