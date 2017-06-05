package cn.pacificimmi.topic.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.pacificimmi.common.Dict;
import cn.pacificimmi.common.DictionaryManager;
import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.interceptor.AjaxLoginInterCeptor;
import cn.pacificimmi.common.interceptor.LoginInterCeptor;
import cn.pacificimmi.common.models.LoginUserInfo;
import cn.pacificimmi.common.models.Topics;
import cn.pacificimmi.common.tree.Node;
import cn.pacificimmi.common.tree.NodeTree;
import cn.pacificimmi.common.utils.StringUtil;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.render.ContentType;

@Before(LoginInterCeptor.class)
public class TopicController extends Controller {
	private static Logger log = LoggerFactory.getLogger(TopicController.class);
	public void index(){
		this.renderText("路径错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
	public void add(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		if(pp.getNormStr("operation")!=null){
			Topics topic = new Topics();
			String topic_name = pp.getAllStr("topic_name");
			if(topic_name!=null){
				List<Topics> topics = Topics.dao.find("select * from crm_topics where topic_name='"+topic_name+"' and delete_flag = '0'");
				if(null != topics && topics.size()>0){
					this.setAttr("errorInfo", "专题名称不能重复！");
					this.renderJsp("/common/error.jsp");
				}else{
					topic.setTopicName(topic_name);
					String topic_mark = pp.getNormStr("topic_mark");
		 			if(topic_mark!=null){
						topic.setTopicMark(topic_mark);
					}
					
					/**
					String topic_sort = pp.getNormStr("topic_sort");
					if(topic_sort!=null){
						topic.setTopicSort(Integer.valueOf(topic_sort));
					}
					**/
					
					Topics rd = Topics.dao.findFirst("select * from crm_topics where delete_flag='0' order by topic_sort desc");
		 			if(rd!=null && rd.getTopicSort()!=null){
						Integer sort = rd.getTopicSort();
						sort++;
						topic.setTopicSort(sort);
					}
					
					String topic_image =  pp.getAllStr("topic_image");
					if(topic_image!=null){
						topic.setTopicImage(topic_image);
					}
					
					String topic_url = pp.getAllStr("topic_url");
					if(topic_url!=null){
						topic.setTopicUrl(topic_url);
					}
					
					String seo_keywords = pp.getNormStr("seo_keywords");
					if(seo_keywords!=null){
						topic.setSeoKeywords(seo_keywords);
					}
					
					String seo_mark = pp.getNormStr("seo_mark");
					if(seo_mark!=null){
						topic.setSeoMark(seo_mark);
					}
					String send_position =  pp.getAllStr("send_position");
					if(send_position!=null){
						topic.setSendPosition(send_position);
					}
					
//					String topic_status = pp.getNormStr("topic_status");
//					if(topic_status!=null){
//						topic.setTopicStatus(topic_status);
//					}
					topic.setTopicStatus("未发布");
					topic.setCreateTime(new Date());
					LoginUserInfo lui = getSessionAttr("LoginUserInfo");
					if(lui!=null){
						topic.setCreateUser(lui.getLoginName());
					}
					
					String[] chks = this.getParaValues("chks");
					String positions = "";
					boolean first = true;
					for(String c:chks){
						if(first){
							positions+=c;
							first=false;
						}
						else{
							positions+=",";
							positions+=c;
						}
					}
					topic.setSendPosition(positions);
					
					topic.save();
					/***
					 * 跳转到跳出时列表页地址
					 */
					String fromurl = getPara("fromurl");
					this.redirect(fromurl);
				}
				
			}else{this.setAttr("errorInfo", "专题名称不能为空！");
			this.renderJsp("/common/error.jsp");
			}
		}
		else{
			List<Dict> sendPositions = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
			this.setAttr("sendPositions", sendPositions);
			this.setAttr("operation", "新增");
			
			List<String> poss = new ArrayList<String>();
			String tree = loadTree(poss);
			this.setAttr("tree", tree);
			
			this.renderJsp("/views/cms/topic.jsp");
		}
	}
	
	public void update(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			String operation = pp.getNormStr("operation");
			if(operation!=null){
				Topics topic = Topics.dao.findById(id);
				
				String topic_name = pp.getAllStr("topic_name");
				if(topic_name!=null){
					List<Topics> topics = Topics.dao.find("select * from crm_topics where topic_name='"+topic_name+"' and delete_flag = '0' and topic_id <> '"+id+"'");
					if(null != topics && topics.size()>0){
						this.setAttr("errorInfo", "专题名称不能重复！");
						this.renderJsp("/common/error.jsp");
					}else{
						topic.setTopicName(topic_name);
						String topic_mark = pp.getNormStr("topic_mark");
						if(topic_mark!=null){
							topic.setTopicMark(topic_mark);
						}
						
//						String topic_sort = pp.getNormStr("topic_sort");
//						if(topic_sort!=null){
//							topic.setTopicSort(Integer.valueOf(topic_sort));
//						}
						
						String topic_image =  pp.getAllStr("topic_image");
						if(topic_image!=null){
							topic.setTopicImage(topic_image);
						}
						
						String topic_url = pp.getAllStr("topic_url");
						if(topic_url!=null){
							topic.setTopicUrl(topic_url);
						}
						
						String seo_keywords = pp.getNormStr("seo_keywords");
						if(seo_keywords!=null){
							topic.setSeoKeywords(seo_keywords);
						}
						
						String seo_mark = pp.getNormStr("seo_mark");
						if(seo_mark!=null){
							topic.setSeoMark(seo_mark);
						}
						String send_position =  pp.getAllStr("send_position");
						if(send_position!=null){
							topic.setSendPosition(send_position);
						}
//						String topic_status = pp.getNormStr("topic_status");
//						if(topic_status!=null){
//							topic.setTopicStatus(topic_status);
//						}
						
						LoginUserInfo lui = getSessionAttr("LoginUserInfo");
						if(lui!=null){
							topic.setEditUser(lui.getLoginName());
							topic.setUpdateTime(new Date());
						}
						
						String[] chks = this.getParaValues("chks");
						String positions = "";
						boolean first = true;
						for(String c:chks){
							if(first){
								positions+=c;
								first=false;
							}
							else{
								positions+=",";
								positions+=c;
							}
						}
						topic.setSendPosition(positions);
						
						topic.update();
						
						//跳转
						String fromurl = getPara("fromurl");
						this.redirect(fromurl);
					}
					
				}else{
					this.setAttr("errorInfo", "专题名称不能为空！");
					this.renderJsp("/common/error.jsp");
				}
				
				
			}
			else{
				Topics topic = Topics.dao.findById(id);
				if(topic!=null){
					this.setAttr("id", id);
					this.setAttr("topic", topic);
					this.setAttr("operation", "编辑");
					
					Dict dict = DictionaryManager.getInstance().getAllSubDictionaries(PropKit.use("constants.txt").get("publish_status"), 1);
					setAttr("statusDict",dict);
					List<Dict> sendPositions = DictionaryManager.getInstance().getSubDictionariesByDegree(PropKit.use("constants.txt").get("push_location"), 1).getSubDictionaries();
					this.setAttr("sendPositions", sendPositions);
					
					List<String> poss = new ArrayList<String>();
					if(topic.getSendPosition()!=null){
						String[] posStr = topic.getSendPosition().split(",");
						for(String p:posStr){
							poss.add(p);
						}
					}
					String tree = loadTree(poss);
					this.setAttr("tree", tree);
					
					this.renderJsp("/views/cms/topic.jsp");
				}
				else{
					this.renderText("无此数据!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
				}
			}
		}
		else
			this.renderText("参数错误!<a href='javascript:window.history.back()'>返回</a>", ContentType.HTML);
	}
	
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void publish(){
		/**
		 * 创建参数解析类
		 */
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			Topics topic = Topics.dao.findById(id);
			
				String topic_name = pp.getAllStr("topic_name");
				if(topic_name!=null){
					List<Topics> retopic = Topics.dao.find("select * from crm_topics where topic_name='"+topic_name+"' and delete_flag = '0' and topic_id <> '"+id+"'");
					if(null != retopic && retopic.size()>0){
						this.setAttr("errorInfo", "专题名称不能重复！");
						this.renderJsp("/common/error.jsp");
					}else{
						topic.setTopicName(topic_name);
						String topic_mark = pp.getNormStr("topic_mark");
						if(topic_mark!=null){
							topic.setTopicMark(topic_mark);
						}
						
//						String topic_sort = pp.getNormStr("topic_sort");
//						if(topic_sort!=null){
//							topic.setTopicSort(Integer.valueOf(topic_sort));
//						}
						Topics rd = Topics.dao.findFirst("select * from crm_topics where delete_flag='0' order by topic_sort desc");
						if(rd!=null && rd.getTopicSort()!=null){
							Integer sort = rd.getTopicSort();
							sort++;
							topic.setTopicSort(sort);
						}
						String topic_image =  pp.getAllStr("topic_image");
						if(topic_image!=null){
							topic.setTopicImage(topic_image);
						}
						
						String topic_url = pp.getAllStr("topic_url");
						if(topic_url!=null){
							topic.setTopicUrl(topic_url);
						}
						
						String seo_keywords = pp.getNormStr("seo_keywords");
						if(seo_keywords!=null){
							topic.setSeoKeywords(seo_keywords);
						}
						
						String seo_mark = pp.getNormStr("seo_mark");
						if(seo_mark!=null){
							topic.setSeoMark(seo_mark);
						}
						String send_position =  pp.getAllStr("send_position");
						if(send_position!=null){
							topic.setSendPosition(send_position);
						}
//						String topic_status = pp.getNormStr("topic_status");
//						if(topic_status!=null){
//							topic.setTopicStatus(topic_status);
//						}
						
						String[] chks = this.getParaValues("chks");
						String positions = "";
						boolean first = true;
						for(String c:chks){
							if(first){
								positions+=c;
								first=false;
							}
							else{
								positions+=",";
								positions+=c;
							}
						}
						topic.setSendPosition(positions);
						
						topic.setTopicStatus("已发布");
						topic.setReleaseTime(new Date());
						
						LoginUserInfo lui = getSessionAttr("LoginUserInfo");
						if(lui!=null){
							topic.setReleaseUser(lui.getLoginName());
						}
					
//						//跳转
//						String fromurl = getPara("fromurl");
//						this.redirect(fromurl);
						boolean isOk = topic.update();
//						String sizes = PropKit.use("constants.txt").get("release_num");
//						List<Topics> topics= Topics.dao.find("select * from crm_topics where delete_flag = '0' and topic_status = '已发布' order by release_time asc");
//						if(null != topics && topics.size() > Integer.valueOf(sizes)){
//							
//							//大于5个时下线最先发布的专题
//							for(int i=0;i<topics.size()-Integer.valueOf(sizes);i++){
//								Topics offtopic = topics.get(i);
//								offtopic.setTopicStatus("已下线");
//								if(lui!=null){
//									log.info(lui.getLoginName()+"at "+new Date().getTime()+"offline"+topic.getTopicName()+"topic");
//								}
//								offtopic.update();
//							}
//						}
						
						if(isOk){
							String fromurl = getPara("fromurl");
							if(null != fromurl && "" != fromurl){
								this.redirect(fromurl);
							}else{
								this.setAttr("status", "0");
								this.renderJson();
							}
						}else{
							this.setAttr("status", "1");
							this.setAttr("msg", "数据库异常！");
							this.renderJson();
						}
					}
					
				}else{
					Topics rd = Topics.dao.findFirst("select * from crm_topics where delete_flag='0' order by topic_sort desc");
					if(rd!=null && rd.getTopicSort()!=null){
						Integer sort = rd.getTopicSort();
						sort++;
						topic.setTopicSort(sort);
					}
					topic.setTopicStatus("已发布");
					topic.setReleaseTime(new Date());
					
					LoginUserInfo lui = getSessionAttr("LoginUserInfo");
					if(lui!=null){
						topic.setReleaseUser(lui.getLoginName());
					}
				
//					//跳转
//					String fromurl = getPara("fromurl");
//					this.redirect(fromurl);
					boolean isOk = topic.update();
//					String sizes = PropKit.use("constants.txt").get("release_num");
//					List<Topics> topics= Topics.dao.find("select * from crm_topics where delete_flag = '0' and topic_status = '已发布' order by release_time asc");
//					if(null != topics && topics.size() > Integer.valueOf(sizes)){
//						
//						//大于5个时下线最先发布的专题
//						for(int i=0;i<topics.size()-Integer.valueOf(sizes);i++){
//							Topics offtopic = topics.get(i);
//							offtopic.setTopicStatus("已下线");
//							if(lui!=null){
//								log.info(lui.getLoginName()+"at "+new Date().getTime()+"offline"+topic.getTopicName()+"topic");
//							}
//							offtopic.update();
//						}
//					}
					if(isOk){
						String fromurl = getPara("fromurl");
						if(null != fromurl && "" != fromurl){
							this.redirect(fromurl);
						}else{
							this.setAttr("status", "0");
							this.renderJson();
						}
					}else{
						this.setAttr("status", "1");
						this.setAttr("msg", "数据库异常！");
						this.renderJson();
					}
				}
				
		}else{
			
			Topics topic = new Topics();
			String topic_name = pp.getAllStr("topic_name");
			if(topic_name!=null){
				List<Topics> retopic = Topics.dao.find("select * from crm_topics where topic_name='"+topic_name+"' and delete_flag = '0'");
				if(null != retopic && retopic.size()>0){
					this.setAttr("errorInfo", "专题名称不能重复！");
					this.renderJsp("/common/error.jsp");
				}else{
					topic.setTopicName(topic_name);	
					String topic_mark = pp.getNormStr("topic_mark");
					if(topic_mark!=null){
						topic.setTopicMark(topic_mark);
					}
					
					/**
					String topic_sort = pp.getNormStr("topic_sort");
					if(topic_sort!=null){
						topic.setTopicSort(Integer.valueOf(topic_sort));
					}
					**/
					
					Topics rd = Topics.dao.findFirst("select * from crm_topics where delete_flag='0' order by topic_sort desc");
					if(rd!=null && rd.getTopicSort()!=null){
						Integer sort = rd.getTopicSort();
						sort++;
						topic.setTopicSort(sort);
					}
					
					String topic_image =  pp.getAllStr("topic_image");
					if(topic_image!=null){
						topic.setTopicImage(topic_image);
					}
					
					String topic_url = pp.getAllStr("topic_url");
					if(topic_url!=null){
						topic.setTopicUrl(topic_url);
					}
					
					String seo_keywords = pp.getNormStr("seo_keywords");
					if(seo_keywords!=null){
						topic.setSeoKeywords(seo_keywords);
					}
					
					String seo_mark = pp.getNormStr("seo_mark");
					if(seo_mark!=null){
						topic.setSeoMark(seo_mark);
					}
					String send_position =  pp.getAllStr("send_position");
					if(send_position!=null){
						topic.setSendPosition(send_position);
					}
//					String topic_status = pp.getNormStr("topic_status");
//					if(topic_status!=null){
//						topic.setTopicStatus(topic_status);
//					}
					
					topic.setTopicStatus("已发布");
					topic.setReleaseTime(new Date());
					LoginUserInfo lui = getSessionAttr("LoginUserInfo");
					if(lui!=null){
						topic.setReleaseUser(lui.getLoginName());
					}
					topic.save();
//					String sizes = PropKit.use("constants.txt").get("release_num");
//					List<Topics> topics= Topics.dao.find("select * from crm_topics where delete_flag = '0' and topic_status = '已发布' order by release_time asc");
//					if(null != topics && topics.size() > Integer.valueOf(sizes)){
//						
//						//大于5个时下线最先发布的专题
//						for(int i=0;i<topics.size()-Integer.valueOf(sizes);i++){
//							Topics offtopic = topics.get(i);
//							offtopic.setTopicStatus("已下线");
//							if(lui!=null){
//								log.info(lui.getLoginName()+"at "+new Date().getTime()+"offline"+topic.getTopicName()+"topic");
//							}
//							offtopic.update();
//						}
//					}
					
					/***
					 * 跳转到跳出时列表页地址
					 */
					String fromurl = getPara("fromurl");
					this.redirect(fromurl);
				}
				
			}else{
				this.setAttr("errorInfo", "专题名称不能为空！");
				this.renderJsp("/common/error.jsp");
			}
		}
	}
	@Clear
	@Before(AjaxLoginInterCeptor.class)
	public void offline(){
		ParamsParser pp = new ParamsParser(this);
		String id = pp.getId();
		if(id!=null && !id.isEmpty()){
			Topics topic = Topics.dao.findById(id);
			
				topic.setTopicStatus("已下线");
				
				LoginUserInfo lui = getSessionAttr("LoginUserInfo");
				if(lui!=null){
					log.info(lui.getLoginName()+"at "+new Date().getTime()+"offline"+topic.getTopicName()+"topic");
				}
				boolean isOk = topic.update();
				if(isOk){
					String fromurl = getPara("fromurl");
					if(StringUtil.isEmpty(fromurl)){
						this.setAttr("status", "0");
						this.renderJson();
					}else{
						this.redirect(fromurl);
					}
				}else{
					this.setAttr("status", "1");
					this.setAttr("msg", "数据库异常！");
					this.renderJson();
				}
		}else{
			this.setAttr("errorInfo", "请选择要下线的专题！");
			this.renderJsp("/common/error.jsp");
		}
	}
	@Clear
	public void checkReleaseNum(){
		String sizes = PropKit.use("constants.txt").get("release_num");
		List<Topics> topics = Topics.dao.find("select * from crm_topics where delete_flag = '0' and topic_status = '已发布'");
		if(null != topics && topics.size() >= Integer.valueOf(sizes)){
			this.setAttr("code", 1);
			this.renderJson();
		}else{
			this.setAttr("code", 0);
			this.renderJson();
		}
	}
	
	private String loadTree(List<String> codes){
		List<Record> records;
		records = Db.find("select * from console_dictionary where delete_flag='0' and dict_code like '0024%'  order by dict_code asc");
		NodeTree nt = new NodeTree("posTree","全部",10);
	
		/***
		* 初始化时将选中的节点，描红显示
		*/
		if(codes!=null)
			nt.setSelectedCodes(codes);
		/**
		* 显示选择框
		*/
		nt.setSelectMode(true);
		
		/**
		* 不显示编辑按钮
		*/
		nt.setAllownEdit(false);
		
		for(Record r:records){
			Node node = new Node();
			node.setName(r.getStr("name"));
			node.setCode(r.getStr("dict_code"));
			node.setId(r.getStr("name"));
			
			node.setExtInfo(r.getStr("dict_type"));
			nt.addNode(node);
		}
		
		return nt.buildTree();
	}
}
