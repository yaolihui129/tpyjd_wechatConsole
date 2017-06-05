package cn.pacificimmi.estimate.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.EstimateQuestion;
import cn.pacificimmi.common.models.EstimateQuestionVersion;
import cn.pacificimmi.common.models.EstimateSelect;
import cn.pacificimmi.common.models.EstimateSelectAdditional;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.utils.ConstantUtil;

/**
 * 评估管理控制器
 * @author Gorge
 */
@Before(LoginInterCeptor.class)
public class EstimateController extends Controller {
	private static Logger log = LoggerFactory.getLogger(EstimateController.class);
	//评估管理
	public void index() {
		log.debug("评估管理查询问题列表");
		ParamsParser pp = new ParamsParser(this);
		String sversion = pp.getNormStr("sversion");
		String yfb = PropKit.use("constants.txt").get("question_version_status_yfb");
		this.setAttr("yfb", yfb);
		String wfb = PropKit.use("constants.txt").get("question_version_status_wfb");
		this.setAttr("wfb", wfb);
		String yxx = PropKit.use("constants.txt").get("question_version_status_yxx");
		this.setAttr("yxx", yxx);
		//查询问卷版本信息
		String versionSql = "select version_id,version_no,case when status = '"+yfb+"' then 1 else 0 end s from wx_estimate_question_version where delete_flag = 0 "+
		" order by s desc ,version_id desc";
		List<Record> versionList = Db.find(versionSql);
		this.setAttr("versionList", versionList);
		
		if(sversion != null && !sversion.isEmpty()){
			String sql1 = "select v.publish_time,d.name,v.status" +
					" from wx_estimate_question_version v left join console_dictionary d " + 
					" on v.status = d.dict_code and d.delete_flag = 0 " +
					" where v.delete_flag = 0 and v.version_id =" + sversion;
			Record v = Db.findFirst(sql1);
			this.setAttr("versionInfo", v);
			this.setAttr("sversion", sversion);
			
			String sql="SELECT q.estimate_question_id,q.title,q.annotation,d.name answerZN,"+
					" case q.isrequired when 1 then '是' else '否' end  isrequiredZN,q.weight"+
					" FROM wx_estimate_question q"+
					" left join console_dictionary d on q.answer = d.dict_code and d.delete_flag = 0 "+
					" where q.delete_flag = 0 and q.version_id = "+ sversion +" order by q.priority asc";
			List<Record> list = Db.find(sql);
			this.setAttr("list", list);
		}else{
			if(versionList != null && versionList.size()>0){
				Record r = versionList.get(0);
				String sql1 = "select v.publish_time,d.name,v.status" +
							" from wx_estimate_question_version v left join console_dictionary d " + 
							" on v.status = d.dict_code and d.delete_flag = 0 " +
							" where v.delete_flag = 0 and v.version_id =" + r.get("version_id");
				Record v = Db.findFirst(sql1);
				this.setAttr("versionInfo", v);
				this.setAttr("sversion", r.get("version_id"));
				
				String sql="SELECT q.estimate_question_id,q.title,q.annotation,d.name answerZN,"+
						" case q.isrequired when 1 then '是' else '否' end  isrequiredZN,q.weight"+
						" FROM wx_estimate_question q"+
						" left join console_dictionary d on q.answer = d.dict_code and d.delete_flag = 0 "+
						" where q.delete_flag = 0 and q.version_id = "+ r.get("version_id") +" order by q.priority asc";
				List<Record> list = Db.find(sql);
				this.setAttr("list", list);
			}
		}
		
		this.renderJsp("/views/estimate/estimates.jsp");
	}
	
	/**
	 * 查询版本信息
	 */
	@Clear
	public void versionInfo(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			String sql1 = "select v.create_time,d.name" +
					" from wx_estimate_question_version v left join console_dictionary d " + 
					" on v.status = d.dict_code and d.delete_flag = 0 " +
					" where v.delete_flag = 0 and v.version_id =" + pp.getId();
			Record v = Db.findFirst(sql1);
			this.setAttr("versionInfo", v);
			
			rst.put("status", 0);
			rst.put("msg", v);
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", null);
		}finally {
			this.renderJson(rst);
		}
	}
	
	
	/**
	 * 新增
	 */
	public void add(){
		ParamsParser pp = new ParamsParser(this);
		String redirectUrl = "/estimates?sversion="+pp.getAllStr("version_id");
		try{
			if(pp.getAllStr("title") != null && !pp.getAllStr("title").isEmpty()){
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				//保存
				EstimateQuestion question = new EstimateQuestion();
				question.setAnnotation(pp.getAllStr("annotation"));//注解
				question.setAnswer(pp.getNormStr("answer"));//作答模式
				question.setCreateTime(new Date());
				question.setDeleteFlag(ConstantUtil.DATA_STATUS_NORMAL);
				question.setDictCode(pp.getNormStr("dict_code"));//项目特性
				question.setIsrequired(Integer.parseInt(pp.getNormStr("isrequired")));//是否必填 1-是; 0-否;
				question.setQuestionStatus("");
				question.setCreateUser(Integer.parseInt(u.getUid()));
				question.setCreateUsername(u.getLoginName());
				question.setWeight(0);
				question.setVersionId(Integer.parseInt(pp.getNormStr("version_id")));
				question.setTitle(pp.getAllStr("title"));
				
				int priority = 1;
				Record r = Db.findFirst("select max(priority) maxSort from wx_estimate_question where delete_flag = 0 and version_id = " + pp.getNormStr("version_id"));
				if(!(r == null || r.get("maxSort") == null || r.get("maxSort").toString().isEmpty())){
					priority = Integer.parseInt(r.get("maxSort").toString()) + 1;
				}
				
				question.setPriority(priority);
				question.save();
				
				
				String params = pp.getAllStr("jsonParam");
				if(params != null && !params.isEmpty()){
					JSONArray json = new JSONArray(params);
					for(int i = 0;i<json.length();i++){
						JSONObject o = (JSONObject)json.get(i);
						String options = (String)o.get("options");
						JSONArray a = (JSONArray)o.get("selects");
						EstimateSelect es = new EstimateSelect();
						es.setCreateTime(new Date());
						es.setDeleteFlag(0);
						es.setEstimateQuestionId(question.getEstimateQuestionId());
						es.setContent(options);
						es.save();
						
						for(int j=0;j<a.length();j++){
							String ob = (String)a.get(j);
							EstimateSelectAdditional esa = new EstimateSelectAdditional();
							esa.setEstimateSelectId(es.getEstimateSelectId());
							esa.setDictCode(ob);
							esa.save();
						}
						
					}
				}
				this.setAttr("sversion", pp.getNormStr("version_id"));
				this.redirect(redirectUrl);
			}else{
				log.debug("page forward to edit.jsp");
				this.setAttr("operation", "新增");
				
				String vid = pp.getNormStr("vid");
				EstimateQuestionVersion ver = EstimateQuestionVersion.dao.findById(vid);
				this.setAttr("qversion", ver);
				
				
				//国家、移民目的
				String country = PropKit.use("constants.txt").get("country");
				String hotspot = PropKit.use("constants.txt").get("hotspot");
				List<Dictionary> addList = Dictionary.dao.find("select * from console_dictionary where dict_code in ('"+
						hotspot+"','"+country+"')"+" and delete_flag=0");
				
				// 项目属性
				List<Dict> propertyList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("project_property"), 1).getSubDictionaries();
				for(Dictionary d : addList){
					Dict tmp = new Dict();
					tmp.setDictCode(d.getDictCode());
					tmp.setName(d.getName());
					propertyList.add(0, tmp);
				}
				setAttr("propertyList", propertyList);
				
				//作答模式
				List<Dict> answerModeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("answer_mode"), 1).getSubDictionaries();
				setAttr("answerModeList", answerModeList);
				
				this.setAttr("single", PropKit.use("constants.txt").get("answer_mode_single"));
				this.setAttr("much", PropKit.use("constants.txt").get("answer_mode_much"));
				
				
				this.renderJsp("/views/estimate/edit.jsp");
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
		
	}
	
	/**
	 * 编辑
	 */
	public void edit(){
		ParamsParser pp = new ParamsParser(this);
		try{
			if(pp.getId() != null && !pp.getId().isEmpty()){
				if(pp.getNormStr("question_id") != null && !pp.getNormStr("question_id").isEmpty()){
					//保存
					EstimateQuestion question = EstimateQuestion.dao.findById(pp.getId());
					question.setAnnotation(pp.getAllStr("annotation"));//注解
					//question.setAnswer(pp.getNormStr("answer"));//作答模式
					question.setDictCode(pp.getNormStr("dict_code"));//项目特性
					question.setIsrequired(Integer.parseInt(pp.getNormStr("isrequired")));//是否必填 1-是; 0-否;
					question.setTitle(pp.getAllStr("title"));
					question.update();
					
					//删除旧的答案选项
					Db.update("update wx_estimate_select set delete_flag = 1 where estimate_question_id ="+pp.getId());
					String params = pp.getAllStr("jsonParam");
					if(params != null && !params.isEmpty()){
						JSONArray json = new JSONArray(params);
						
						for(int i = 0;i<json.length();i++){
							JSONObject o = (JSONObject)json.get(i);
							String options = (String)o.get("options");
							JSONArray a = (JSONArray)o.get("selects");
							EstimateSelect es = new EstimateSelect();
							es.setCreateTime(new Date());
							es.setDeleteFlag(0);
							es.setEstimateQuestionId(question.getEstimateQuestionId());
							es.setContent(options);
							es.save();
							
							for(int j=0;j<a.length();j++){
								String ob = (String)a.get(j);
								EstimateSelectAdditional esa = new EstimateSelectAdditional();
								esa.setEstimateSelectId(es.getEstimateSelectId());
								esa.setDictCode(ob);
								esa.save();
							}
							
						}
					}
					
					this.redirect("/estimates?sversion="+question.getVersionId());
				}else{
					log.debug("page forward to edit.jsp");
					this.setAttr("operation", "编辑");
					EstimateQuestion question = EstimateQuestion.dao.findById(pp.getId());
					this.setAttr("question", question);
					
					//问卷版本信息
					EstimateQuestionVersion ver = EstimateQuestionVersion.dao.findById(question.getVersionId());
					this.setAttr("qversion", ver);
					
					//国家、移民目的
					String country = PropKit.use("constants.txt").get("country");
					String hotspot = PropKit.use("constants.txt").get("hotspot");
					List<Dictionary> addList = Dictionary.dao.find("select * from console_dictionary where dict_code in ('"+
							hotspot+"','"+country+"')");
					
					// 项目属性
					List<Dict> propertyList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("project_property"), 1).getSubDictionaries();
					for(Dictionary d : addList){
						Dict tmp = new Dict();
						tmp.setDictCode(d.getDictCode());
						tmp.setName(d.getName());
						propertyList.add(0, tmp);
					}
					setAttr("propertyList", propertyList);
					
					//作答模式
					List<Dict> answerModeList = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("answer_mode"), 1).getSubDictionaries();
					setAttr("answerModeList", answerModeList);
					
					this.setAttr("single", PropKit.use("constants.txt").get("answer_mode_single"));
					this.setAttr("much", PropKit.use("constants.txt").get("answer_mode_much"));
					
					//问题答案选项集
					List<EstimateSelect> esList = EstimateSelect.dao.find(
							"select * from wx_estimate_select where delete_flag = 0 and estimate_question_id =" + question.getEstimateQuestionId() + " order by estimate_select_id asc");
					for(EstimateSelect es : esList){
						List<EstimateSelectAdditional> esaList = EstimateSelectAdditional.dao.find("select * from wx_estimate_select_additional where estimate_select_id =" + es.getEstimateSelectId());
						es.setEsaList(esaList);
						
						//根据项目特性查询问题选项匹配项
						String code = question.getDictCode();
						List<Dict> list = new ArrayList<Dict>();
						if(country.equals(code)){//项目特性选择国家时需要特殊处理,以国家为根，取二级节点
							list = DictionaryManager.getInstance().getSubDictionariesByDegree(code,2).getSubDictionaries();
						}else{
							list = DictionaryManager.getInstance().getAllSubDictionaries(code,1).getSubDictionaries();
						}
						for(Dict d : list){
							for(EstimateSelectAdditional tmp : esaList){
								if(tmp.getDictCode().equals(d.getDictCode())){
									d.setDeleteFlag(9);
									continue;
								}
							}
						}
						es.setDictList(list);
					}
					this.setAttr("esList", esList);
					
					//根据项目特性查询问题选项匹配项
					String code = question.getDictCode();
					List<Dict> dlist = new ArrayList<Dict>();
					if(country.equals(code)){//项目特性选择国家时需要特殊处理,以国家为根，取二级节点
						dlist = DictionaryManager.getInstance().getSubDictionariesByDegree(code,2).getSubDictionaries();
					}else{
						dlist = DictionaryManager.getInstance().getAllSubDictionaries(code,1).getSubDictionaries();
					}
					
					StringBuffer sb = new StringBuffer();
		            sb.append("<div class=\"controls\">")
		                .append("<input type=\"text\" class=\"m-wrap span4\" style=\"float:left;\" placeholder=\"请填写用户可选答案\">")
		                .append("<div class=\"span4\">")
		                    .append("<select class=\"ms\"  multiple=\"multiple\" data-type=\"select\" data-label=\"答案选项\">");
					
					for(Dict d : dlist){
						sb.append("<option value=\"" + d.getDictCode() + "\">" + d.getName() + "</option>");
					}
					
		            sb.append("</select>")
		                .append("</div>")
		                .append("<div class=\"add-btn span2\" style=\"float:left;margin-bottom:20px;\">")
		                    .append("<a class=\"btn  icn-only remove\"><i class=\" icon-minus\" style=\"color:#999;\"></i></a>")
		                    .append("<a class=\"btn  icn-only add\" style=\"margin-left:3px;\"><i class=\"icon-plus\" style=\"color:#999;\"></i></a>")
		                .append("</div>")
		            .append("</div>");
					
					this.setAttr("answerOptions", sb.toString());
					
					
					this.renderJsp("/views/estimate/edit.jsp");
				}
			}else{
				log.error("编辑问题出错:参数ID缺失");
				this.setAttr("errorInfo", ConstantUtil.PARAM_ERROR);
				this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
				
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	
	/**
	 * 删除
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void delete(){
		try{
			ParamsParser pp = new ParamsParser(this);
			Map<String,Object> rst = new HashMap<String,Object>();
			if(pp.getIds() != null && !pp.getIds().isEmpty()){
				String[] ids = pp.getIds().split(",");
				int fail = 0;
				int success = 0;
				String failMsg = "";
				for(String id : ids){
					int rlt = Db.update("update wx_estimate_question set delete_flag = 1 where estimate_question_id = " + id);
					if(rlt > 0){
						success++;
						Db.update("update wx_estimate_select set delete_flag = 1 where estimate_select_id =" + id);
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
					rst.put("msg", "删除结果：成功[" + success + "],失败["+ fail +"]."+failMsg);
					this.renderJson(rst);
				}
			}else{
				log.error("删除评估问题出错：参数ID缺失");
				rst.put("status", 100);
				rst.put("msg", "参数错误");
				this.renderJson(rst);
			}
		}catch(Exception e){
			log.error(e.getMessage(), e);
			this.setAttr("errorInfo", "删除评估问题时" + ConstantUtil.RENDERTEXT_SYS_ERROR);
			this.renderJsp(ConstantUtil.ERROR_PAGE_PATH);
		}
	}
	
	/**
	 * 上移
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void upsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		EstimateQuestion s = EstimateQuestion.dao.findById(id);
		EstimateQuestion s1= findPreOrNextOne(id,true);
		
		if(s!=null && s1!=null){
			//交换排序
			int t1 = s.getPriority();
			int t2 = s1.getPriority();
			
			s.setPriority(t2);
			s.update();
			
			s1.setPriority(t1);
			s1.update();

			rst.put("status", 0);
			rst.put("msg", "上移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "上移失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * 下移
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void downsort(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		String id = pp.getId();
		
		EstimateQuestion s = EstimateQuestion.dao.findById(id);
		EstimateQuestion s1= findPreOrNextOne(id,false);
		if(s!=null && s1!=null){
			//交换排序
			int t1 = s.getPriority();
			int t2 = s1.getPriority();
			
			s.setPriority(t2);
			s.update();
			
			s1.setPriority(t1);
			s1.update();
			
			rst.put("status", 0);
			rst.put("msg", "下移成功");
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "下移失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * 置顶
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void topsort(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		EstimateQuestion s = EstimateQuestion.dao.findById(id);
		Map<String,Object> rst = new HashMap<String,Object>();
		if(s!=null){
			
			int sort = s.getPriority();
			
//			Record r = Db.findFirst("select max(priority) maxSort from wx_estimate_question where delete_flag = 0 and version_id=" + s.getVersionId());
//			if(!(r == null || r.get("maxSort") == null || r.get("maxSort").toString().isEmpty())){
//				sort = Integer.parseInt(r.get("maxSort").toString()) + 1;
//			}
		
			Record r = Db.findFirst("select min(priority) minSort from wx_estimate_question where delete_flag = 0 and version_id=" + s.getVersionId());
			if(!(r == null || r.get("minSort") == null || r.get("minSort").toString().isEmpty())){
				sort = Integer.parseInt(r.get("minSort").toString()) - 1;
			}
			
			
			s.setPriority(sort);
			if(s.update()){
				rst.put("status", 0);
				rst.put("msg", "置顶成功");
			}else{
				rst.put("status", 100);
				rst.put("msg", "置顶失败");
			}
			this.renderJson(rst);
		}
		else{
			rst.put("status", 100);
			rst.put("msg", "置顶失败");
			this.renderJson(rst);
		}
	}
	
	/**
	 * @param id 当前id
	 * @param flag true 上一个     false  下一个
	 * @return 
	 */
	private EstimateQuestion findPreOrNextOne(String id,boolean flag){
		EstimateQuestion s = EstimateQuestion.dao.findById(Integer.parseInt(id));
		if(s!=null){
			List<EstimateQuestion> tops = EstimateQuestion.dao.find("select * from wx_estimate_question where delete_flag = 0 and version_id = "+ s.getVersionId() +" order by priority asc");
			EstimateQuestion pre=null;
			EstimateQuestion next=null;
			for(int i=0;i<tops.size();i++){
				EstimateQuestion act = tops.get(i);
				if(act.getEstimateQuestionId()==Integer.valueOf(id)){
					int pidx=i-1;
					int nidx=i+1;
					if(pidx>-1)
						pre=tops.get(pidx);
					if(nidx<tops.size())
						next=tops.get(nidx);
				}
			}
			//上一个
			if(flag){
				return pre;
			}
			else{
				return next;
			}
		}else{
			return null;
		}
		
	}
	
	
	/**
	 * 校验问题名称是否存在
	 */
	@Clear
	public void valiTitle(){
		Map<String,Object> rst = new HashMap<String,Object>();
		ParamsParser pp = new ParamsParser(this);
		try {
			String questionId = pp.getAllStr("question_id");
			String title = pp.getAllStr("title");
			String versionId = pp.getAllStr("version_id");//版本号
			String sql = "select estimate_question_id from wx_estimate_question where delete_flag = 0 and version_id = '"+ versionId +"' and title = '" + title + "' ";
			if(questionId != null && !questionId.isEmpty()){
				sql += " and estimate_question_id != " + questionId;
			}
			List<Record> list = Db.find(sql);
			if(list != null && list.size() > 0){
				rst.put("status", 100);
				rst.put("msg", "同一问卷版本下已存在该问题名称");
			}else{
				rst.put("status", 0);
				rst.put("msg", "成功");
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "请求服务器出错");
		}
		this.renderJson(rst);
	}
	
	/**
	 * 新增问卷版本
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void newVersion(){
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			String newVNo = createVersionNo();
			if(!"error".equals(newVNo)){
				EstimateQuestionVersion v = new EstimateQuestionVersion();
				v.setCreateTime(new Date());
				v.setCreateUserid(Integer.parseInt(u.getUid()));
				v.setCreateUsername(u.getLoginName());
				v.setDeleteFlag(0);
				v.setVersionNo(createVersionNo());
				v.setStatus(PropKit.use("constants.txt").get("question_version_status_wfb"));
				
				v.save();
				rst.put("status", 0);
				rst.put("msg", v.getVersionId());
			}else{
				rst.put("status", 100);
				rst.put("msg", "新增失败:问卷版本号生成失败.");
			}
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", "服务器错误");
		}finally {
			this.renderJson(rst);
		}
		
	}
	
	/**
	 * 保存权重
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void saveWeight(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			String ids = pp.getAllStr("ids");
			String wvs = pp.getAllStr("wvs");
			String[] qids = ids.split(",");
			String[] qwvs = wvs.split(",");
			for(int i = 0;i<qids.length;i++){
				EstimateQuestion q = EstimateQuestion.dao.findById(qids[i]);
				q.setWeight(Integer.parseInt(qwvs[i]));
				q.update();
			}
			rst.put("status", 0);
			rst.put("msg", "保存成功");
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", "服务器错误");
		}finally {
			this.renderJson(rst);
		}
	}
	
	/**
	 * 校验权重并发布问卷
	 */
	public void publishVersion(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			//1、保存权重
			String ids = pp.getAllStr("ids");
			String wvs = pp.getAllStr("wvs");
			String vid = pp.getNormStr("vid");
			String[] qids = ids.split(",");
			String[] qwvs = wvs.split(",");
			for(int i = 0;i<qids.length;i++){
				EstimateQuestion q = EstimateQuestion.dao.findById(qids[i]);
				q.setWeight(Integer.parseInt(qwvs[i]));
				q.update();
			}
			//2、发布问卷
			if(vid != null && !vid.isEmpty()){
				String yfb = PropKit.use("constants.txt").get("question_version_status_yfb");
				String yxx = PropKit.use("constants.txt").get("question_version_status_yxx");
				//设置当前已发布版本状态为下线
				String updWfb = "update wx_estimate_question_version set status = '" + yxx + "' where version_id !=" + vid + " and status ='" + yfb +"'";
				Db.update(updWfb);
				
				LoginUserInfo u = getSessionAttr("LoginUserInfo");
				EstimateQuestionVersion qv = EstimateQuestionVersion.dao.findById(vid);
				qv.setPublishTime(new Date());
				qv.setPublishUserid(Integer.parseInt(u.getUid()));
				qv.setPublishUsername(u.getLoginName());
				qv.setStatus(yfb);
				qv.update();
				rst.put("status", 0);
				rst.put("msg", "发布成功");
			}else{
				rst.put("status", 1);
				rst.put("msg", "参数错误");
			}
			
		}catch(Exception e){
			log.error(e.getMessage(),e);
			rst.put("status", 100);
			rst.put("msg", "服务器错误");
		}finally {
			this.renderJson(rst);
		}
	}
	
	/**
	 * 问卷复制新增
	 */
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void copyAndCreate(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			LoginUserInfo u = getSessionAttr("LoginUserInfo");
			//1、新增问卷版本
			EstimateQuestionVersion qv = new EstimateQuestionVersion();
			qv.setCreateTime(new Date());
			qv.setCreateUserid(Integer.parseInt(u.getUid()));
			qv.setCreateUsername(u.getLoginName());
			qv.setDeleteFlag(0);
			qv.setStatus(PropKit.use("constants.txt").get("question_version_status_wfb"));
			qv.setVersionNo(createVersionNo());
			qv.save();
			
			//2、复制问卷的问题内容，生成新的问卷问题
			String vid = pp.getAllStr("vid");
			List<EstimateQuestion> list = EstimateQuestion.dao.find("select * from wx_estimate_question where delete_flag = 0 and version_id="+vid);
			for(EstimateQuestion q : list){
				EstimateQuestion tmp = new EstimateQuestion();
				tmp.setAnnotation(q.getAnnotation());
				tmp.setAnswer(q.getAnswer());
				tmp.setCreateTime(new Date());
				tmp.setCreateUser(Integer.parseInt(u.getUid()));
				tmp.setCreateUsername(u.getLoginName());
				tmp.setDeleteFlag(0);
				tmp.setDictCode(q.getDictCode());
				tmp.setIsrequired(q.getIsrequired());
				tmp.setPriority(q.getPriority());
				tmp.setSelectNum(q.getSelectNum());
				tmp.setTitle(q.getTitle());
				tmp.setVersionId(qv.getVersionId());
				tmp.setWeight(q.getWeight());
				
				tmp.save();
				
				//3、复制问题答案选项
				List<EstimateSelect> esList = EstimateSelect.dao.find("select * from wx_estimate_select where delete_flag = 0 and estimate_question_id =" + q.getEstimateQuestionId());
				for(EstimateSelect es : esList){
					EstimateSelect entity = new EstimateSelect();
					entity.setCreateTime(new Date());
					entity.setDeleteFlag(0);
					entity.setCreateUser(Integer.parseInt(u.getUid()));
					entity.setContent(es.getContent());
					entity.setEstimateQuestionId(tmp.getEstimateQuestionId());
					entity.save();
					
					//4、复制问题答案匹配项
					List<EstimateSelectAdditional> esaList = 
							EstimateSelectAdditional.dao.find("select * from wx_estimate_select_additional where estimate_select_id =" + es.getEstimateSelectId());
					for(EstimateSelectAdditional tp : esaList){
						EstimateSelectAdditional esa = new EstimateSelectAdditional();
						esa.setDictCode(tp.getDictCode());
						esa.setEstimateSelectId(entity.getEstimateSelectId());
						esa.save();
					}
				}
				
			}
			rst.put("status", 0);
			rst.put("msg", qv.getVersionId());
		}catch(Exception e){
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "服务器错误");
		}finally {
			this.renderJson(rst);
		}
	}
	
	/**
	 * 生成问卷版本
	 */
	private String createVersionNo(){
		String newVersionNo = "";
		try{
			String sql = "select version_id,version_no from wx_estimate_question_version where delete_flag = 0 order by version_id desc";
			Record r = Db.findFirst(sql);
			if(r == null || r.getStr("version_no") == null || r.getStr("version_no").isEmpty()){
				newVersionNo = "V1.0.0";
			}else{
				String versionNo = r.getStr("version_no");
				versionNo = versionNo.replace("V", "").replace(".", "");
				String tmp = (Integer.parseInt(versionNo) + 1) + "";
				newVersionNo = "V" + tmp.substring(0,1) + "." + tmp.substring(1, 2) + "." + tmp.substring(2);
			}
		}catch(Exception e){
			log.error("生成问卷版本号出错" + e.getMessage(), e);
			newVersionNo = "error";
		}
		return newVersionNo;
	}
	
	/**
	 * 根据项目特性加载问题答案匹配选项
	 */
	@Clear
	public void selectChildenDict(){
		ParamsParser pp = new ParamsParser(this);
		Map<String,Object> rst = new HashMap<String,Object>();
		try{
			String code = pp.getNormStr("code");
			String country = PropKit.use("constants.txt").get("country");
			List<Dict> list = new ArrayList<Dict>();
			if(country.equals(code)){//项目特性选择国家时需要特殊处理,以国家为根，取二级节点
				list = DictionaryManager.getInstance().getSubDictionariesByDegree(code,2).getSubDictionaries();
			}else{
				list = DictionaryManager.getInstance().getAllSubDictionaries(code,1).getSubDictionaries();
			}
			StringBuffer sb = new StringBuffer();
            //sb.append("<label class=\"control-label \"></label>")
            sb.append("<div class=\"controls\">")
                .append("<input type=\"text\" class=\"m-wrap span4\" style=\"float:left;\" placeholder=\"请填写用户可选答案\">")
                .append("<div class=\"span4\">")
                    .append("<select class=\"ms\"  multiple=\"multiple\" data-type=\"select\" data-label=\"答案选项\">");
			
			for(Dict d : list){
				sb.append("<option value=\"" + d.getDictCode() + "\">" + d.getName() + "</option>");
			}
			
            sb.append("</select>")
                .append("</div>")
                .append("<div class=\"add-btn span2\" style=\"float:left;margin-bottom:20px;\">")
                    .append("<a class=\"btn  icn-only remove\"><i class=\" icon-minus\" style=\"color:#999;\"></i></a>")
                    .append("<a class=\"btn  icn-only add\" style=\"margin-left:3px;\"><i class=\"icon-plus\" style=\"color:#999;\"></i></a>")
                .append("</div>")
        .append("</div>");
            rst.put("status", 0);
			rst.put("msg", sb.toString());
		}catch(Exception e){
			log.error(e.getMessage(), e);
			rst.put("status", 100);
			rst.put("msg", "服务器错误");
		}finally {
			this.renderJson(rst);
		}
	}
}
