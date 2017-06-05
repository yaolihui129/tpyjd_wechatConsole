package cn.pacificimmi.customer.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.PagesBar;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Letters;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.ConstantUtil;

/**
 * 站内信控制器
 * @author Gorge
 * 
 */
@Before(LoginInterCeptor.class)
public class LetterController extends Controller {
	private static Logger log = LoggerFactory.getLogger(LetterController.class);
	private String qryFlag = "";
	/****
	 * 默认初始化页面
	 */
	public void index(){
		log.debug("查询我的信件");
		LoginUserInfo u = getSessionAttr("LoginUserInfo");
		//收件箱
		qryFlag = "receive";
		String receiveSql = "select cl.* ,cu1.user_name as senderName,cu2.user_name as receiverName" +
							" from crm_letters cl left join console_user cu1 on cl.sender = cu1.user_id " +
							" left join console_user cu2 on cl.receiver = cu2.user_id" + 
							" where cl.delete_flag = 0 and cl.receiver = " + u.getUid();
		List<Record> receiveList = Db.find(receiveSql);
		this.setAttr("receiveList", receiveList);
		
		//发件箱
		qryFlag = "send";
		LetterParams params = new LetterParams(this);
		
		//列表数据
		Page<Record> page = Db.paginate(params.getPageNum(), params.getPageSize(), params.getSelectStr(), params.getFromStr());
		List<Record> list = page.getList();
		this.setAttr("sendList", list); 
		
		//翻页
		String pagesView = PagesBar.getShortPageBar(params.getPageNum(), page.getTotalPage(), page.getPageSize(), page.getTotalRow(), 5);
		setAttr("pageBar",pagesView);
		
		
		//页面
		this.renderJsp("/views/letters/letter_main.jsp");
	}
	
	
	/**
	 * 写信
	 */
	public void add(){
		log.debug("page forward to letter_send.jsp");
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("receiver") == null || "".equals(pp.getNormStr("receiver"))){//跳转新增页面
			
			//查询组织机构树
			String tree = loadTree(new ArrayList<String>());
			this.setAttr("tree", tree);
			
			//查询部门和用户
			String sql = "select cuser.user_id,cuser.user_name, org.name" + 
						" from console_user cuser LEFT JOIN console_orgnization org on cuser.dep_id = org.org_id" +
						" where cuser.delete_flag = 0";
			List<Record> list = Db.find(sql);
			List<String> gl = new ArrayList<String>();
			for(Record r : list){
				if(gl.indexOf(r.get("name")) < 0){
					gl.add(r.getStr("name"));
				}
			}
			this.setAttr("gl", gl);
			
			this.setAttr("list", list);
			
			this.renderJsp("/views/letters/letter_send.jsp");
		}else{//保存新增
			try {
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				if(u == null || u.getUid() == null){
					this.redirect("/");
				}
				
				String title = pp.getNormStr("title");//主题
				String contents = pp.getNormStr("contents");//内容
				String receiver = pp.getNormStr("receiver");//收件人
				String[] receivers = receiver.split(",");
				
				for(String r : receivers){
					Letters ls = new Letters();
					ls.setContents(contents);
					ls.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
					ls.setReceiver(Integer.parseInt(r));
					ls.setSender(Integer.parseInt(u.getUid()));
					ls.setSendTime(new Date());
					ls.setStatus(0);//未读
					ls.setTitle(title);
					ls.save();
				}
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			this.redirect("/letters");
		}
	}
	
	/**
	 * 编辑客户
	 */
	public void replay(){
		log.debug("page forward to letter_send.jsp");
		ParamsParser pp = new ParamsParser(this);
		
		try {
			if(pp.getId() != null && !"".equals(pp.getId())){
				
				//查询发件人
				Letters letter = Letters.dao.findById(pp.getId());
				if(letter == null){
					this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
				
				this.setAttr("sender", letter.getSender());
				//查询部门和用户
				String sql = "select cuser.user_id,cuser.user_name, org.name" + 
							" from console_user cuser LEFT JOIN console_orgnization org on cuser.dep_id = org.org_id" +
							" where cuser.delete_flag = 0";
				List<Record> list = Db.find(sql);
				List<String> gl = new ArrayList<String>();
				for(Record r : list){
					if(gl.indexOf(r.get("name")) < 0){
						gl.add(r.getStr("name"));
					}
				}
				this.setAttr("gl", gl);
				this.setAttr("list", list);
				
				this.renderJsp("/views/letters/letter_send.jsp");
			}else{
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}

	
	/**
	 * 详情
	 */
	@Clear
	public void detail(){
		log.debug("page forward to letter_detail.jsp");
		try {
			ParamsParser pp = new ParamsParser(this);
			if(pp.getId() == null || "".equals(pp.getId())){
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}else{
				String sql = "select cl.* ,cu1.user_name senderName" +
							" from crm_letters cl ,console_user cu1" +
							" where cl.sender = cu1.user_id " +
							" and cl.delete_flag = 0 and cl.letter_id = " + pp.getId();
				Record letter = Db.findFirst(sql);
				if(letter != null){
					this.setAttr("letter", letter);
					this.renderJsp("/views/letters/letter_detail.jsp");
				}else{
					this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_DATA_NULL);
					this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				}
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 删除
	 */
	
	public void delete(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getIds().isEmpty()){
				
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				for(String id : ids){
					int rlt = Db.update("update crm_letters set delete_flag = 1 where letter_id = " + id);
					if(rlt > 0){
						success++;
					}else{
						fail++;
					}
				}
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "删除成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "删除结果：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("删除信件出错：参数信件ID缺失");
				this.setAttr("errorInfo", "删除信件时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除信件时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 标记已读
	 */
	
	public void hadread(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(!pp.getIds().isEmpty()){
				
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				for(String id : ids){
					int rlt = Db.update("update crm_letters set status = 1 where letter_id = " + id);
					if(rlt > 0){
						success++;
					}else{
						fail++;
					}
				}
				if(success == ids.length){
					rst.put("status", 0);
					rst.put("msg", "标记已读成功");
					this.renderJson(rst);
				}else{
					rst.put("status", 100);
					rst.put("msg", "标记已读：成功[" + success + "],失败["+ fail +"]");
					this.renderJson(rst);
				}
			}else{
				log.error("标记已读出错：参数信件ID缺失");
				this.setAttr("errorInfo", "标记已读时" + ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "标记已读时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 查询参数解析类
	 * @author Gorge
	 *
	 */
	private class LetterParams extends ParamsParser{

		public LetterParams(Controller ctr) {
			super(ctr);
			
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			
			this.setSelectStr("select cl.* ,cu1.user_name as senderName,cu2.user_name as receiverName");
			this.setFromStr("from crm_letters cl left join console_user cu1 on cl.sender = cu1.user_id " +
							"left join console_user cu2 on cl.receiver = cu2.user_id");
			
			this.addWhereSegmentByAnd(" cl.delete_flag = 0");
			if("send".equals(qryFlag)){//发件箱
				this.addWhereSegmentByAnd(" cl.sender = " + u.getUid());
			}else{//收件箱
				this.addWhereSegmentByAnd(" cl.receiver = " + u.getUid());
			}
			
			//状态
			String status = this.getNormStr("status");
			if(null != status && !"".equals(status)){
				ctr.setAttr("status", this.getNormStr("status"));
				this.addWhereSegmentByAnd(" cl.status = " + status);
			}
			
			
			this.setDefaultOrderStr("order by cl.send_time desc");
		}
	}
	
	/*======================== 加载组织机构树 =============================*/
	public String loadTree(List<String> codes){
		List<Record> records = Db.find("select * from console_orgnization where delete_flag='0' order by org_code asc");
		NodeTree ct = new NodeTree("orgTree","所属机构",10);
		
		/***
		* 初始化时将选中的节点，描红显示
		*/
		if(codes.size()>0){
			ct.setSelectedCodes(codes);
		}
		
		/**
		* 显示选择框
		*/
		ct.setSelectMode(false);
		
		/**
		* 不显示编辑按钮
		*/
		ct.setAllownEdit(false);
		
		for(Record r:records){
			Node node = new Node();
			node.setName(r.getStr("name"));
			node.setCode(r.getStr("org_code"));
			node.setId(String.valueOf(r.getInt("org_id")));
			
			node.setExtInfo(String.valueOf(r.getInt("org_id")));
			ct.addNode(node);
		}
		
		return ct.buildTree();
	}
}
