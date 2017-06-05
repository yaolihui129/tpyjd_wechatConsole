<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<meta charset="utf-8" />
	<title>太平洋加达出国－后台管理系统 v1.0</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	<!-- BEGIN GLOBAL MANDATORY STYLES -->
	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<!-- END GLOBAL MANDATORY STYLES -->
    <link href="/views/media/css/timeline.css" rel="stylesheet" type="text/css"/>
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link href="/views/media/css/jquery.gritter.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/daterangepicker.css" rel="stylesheet" type="text/css" />
	<link href="/views/media/css/fullcalendar.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/jqvmap.css" rel="stylesheet" type="text/css" media="screen"/>
	<link href="/views/media/css/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="/views/media/css/add.css" rel="stylesheet" type="text/css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
	<!-- END PAGE LEVEL STYLES -->
	<link rel="shortcut icon" href="/views/media/image/logo3232.ico" /> 
	<script src="/js/laydate/laydate.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@ include  file="../navi.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@ include  file="../menus.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="pull-left">分销商管理</h3>
						<ul class="breadcrumb clear">
							<li>
								<i class="icon-home"></i>
								<a href="/console">首页</a> 
								<i class="icon-angle-right"></i>
							</li>
                            <li><a href="/proxy/proxy">渠道分销</a><i class="icon-angle-right"></i></li>
                            <li>分销商查看</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
							
							
								
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet-body form">
							<div class="form-horizontal form-view">
								<h4 class="form-section">分销商查看</h4>
								<div class="row-fluid">
									<div class="span2 ">
										<div class="control-group">
											<label class="control-label" for="firstName">邀请客户数：</label>
											<div class="controls">
												<span class="text">${proxyInfo.sub_custinfo_count}</span>
											</div>
										</div>
									</div>
									<div class="span2 ">
										<div class="control-group">
											<label class="control-label" for="firstName">下级代理：</label>
											<div class="controls">
												<span class="text">${proxyInfo.sub_proxy_count}</span>
											</div>
										</div>
									</div>
									<div class="span2 ">
										<div class="control-group">
											<label class="control-label" for="firstName">下级代理获客：</label>
											<div class="controls">
												<span class="text">${proxyInfo.sub_proxy_custinfo_count}</span>
											</div>
										</div>
									</div>
								</div>
								<h4 class="form-section">基本信息</h4>
								<div class="row-fluid">
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">姓名：</label>
											<div class="controls">
												<span class="text">${proxyInfo.name}</span>
											</div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">所在省份：</label>
											<div class="controls">
												<span class="text">${proxyInfo.province_name}</span>
											</div>
										</div>
									</div>
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">分销等级：</label>
											<div class="controls">
												<span class="text">${proxyInfo.proxy_level_name}</span>
											</div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">所在城市：</label>
											<div class="controls">
												<span class="text">${proxyInfo.city_name}</span>
											</div>
										</div>
									</div>
									<div class="span5 ">
										<div class="control-group">
											<label class="control-label" for="firstName">当前状态：</label>
											<div class="controls">
												<span class="text">
													<span class="span3">${proxyInfo.audit_status_name}</span>
													<c:choose>
	                                            		<c:when test="${proxyInfo.proxy_status==proxy_status_enabled}">
	                                            			<span class="span3"><a  href="#updataStatus" onclick="updateStatus('${custinfo_id}', '${proxy_status_disabled}', '${proxy_status}', '禁用');" role="button" data-toggle="modal" >禁用此账号</a></span>
	                                            		</c:when>
	                                            		<c:otherwise>
	                                            			<span class="span3"><a  href="#updataStatus" onclick="updateStatus('${custinfo_id}', '${proxy_status_enabled}', '${proxy_status}', '启用');" role="button" data-toggle="modal" >启用此账号</a></span>
	                                            		</c:otherwise>
	                                            	</c:choose>
													<span class="span3"><a  href="/proxy/proxy/statusRecord/${custinfo_id}">查看变更历史</a></span>
												</span>
											</div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">联系电话：</label>
											<div class="controls">
												<span class="text">${proxyInfo.phone_num}</span>
											</div>
										</div>
									</div>
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">注册时间：</label>
											<div class="controls">
												<span class="text"><fmt:formatDate value="${proxyInfo.passed_time}" type="date" dateStyle="default"/></span>
											</div>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">备用电话：</label>
											<div class="controls">
												<span class="text">${proxyInfo.contact}</span>
											</div>
										</div>
									</div>
									<div class="span4 ">
										<div class="control-group">
											<label class="control-label" for="firstName">关联时间：</label>
											<div class="controls">
												<span class="text"><fmt:formatDate value="${proxyInfo.bind_proxy_time}" type="date" dateStyle="default"/></span>
											</div>
										</div>
									</div>
								</div>
								<form id="searchForm" method="post">
								<div class="tabbable tabbable-custom bodr-bm1 clear" style="margin-top:30px;">
									<ul class="nav nav-tabs">
										<li <c:if test="${sel_proxy !=null and sel_proxy != ''}">class="active"</c:if>>
											<a href="#tab_1_1" data-toggle="tab" onclick="selectTab('sel_proxy_pid', 'sel_proxy', 'passed_time');">发展客户</a>
										</li>
										<li <c:if test="${sel_proxy_pid !=null and sel_proxy_pid != ''}">class="active"</c:if>>
											<a href="#tab_1_2" data-toggle="tab" onclick="selectTab('sel_proxy', 'sel_proxy_pid', 'bind_proxy_time');">下级代理</a>
										</li>
									</ul>
									<input id="sel_proxy_pid"  type="hidden" name="sel_proxy_pid" value="${sel_proxy_pid}">
                                    <input id="sel_proxy"  type="hidden" name="sel_proxy" value="${sel_proxy}">
								</div>
								<c:choose>
									<c:when test="${sel_proxy != null and sel_proxy != ''}">
										<div class="row-fluid" style="border-left:1px solid #ddd;border-right:1px solid #ddd;">
											<div class="span12" style="padding:20px 0px;">
												<div class="span4">
													<div class="control-group">
														<label class="control-label">关联时间：</label>
														<div class="controls">
															<input type="text" id="start_bind_proxy_time" placeholder="开始时间" class="m-wrap small" name="start_bind_proxy_time" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${start_bind_proxy_time}"/>
															 -- 
															 <input type="text" id="end_bind_proxy_time" placeholder="结束时间" class="m-wrap small" name="end_bind_proxy_time" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${end_bind_proxy_time}"/>
														</div>
													</div>
												</div>
												<div class="span2">
													<a href="javascript:;" class="btn blue" id="searchBtn" >
														<i class="icon-search"></i> 搜索
													</a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-bordered table-hover" id="sample_2">
											<thead>
												<tr>
													<th>序号</th>
													<th>姓名</th>
													<th>头像</th>
													<th>手机号</th>
													<th>备用电话</th>
													<th>所在城市</th>
													<th>关联时间</th>
													<th>注册方式</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${list}" varStatus="status">
													<tr class="odd gradeX">
														<td><c:out value="${status.count}"/></td>
														<td>${item.name}</td>
														<td>
															<c:choose>
																<c:when test="${item.head_img != null and item.head_img !=''}">
																	<img width="30px" height="30px" src="${item.head_img}" alt="">
																</c:when>
																<c:otherwise>
																	<img width="30px" height="30px" src="/views/media/image/avatar1_small.jpg" alt="">
																</c:otherwise>
															</c:choose>
														</td>
														<td>${item.phone_num}</td>
														<td>${item.contact}</td>
														<td>${item.city_name}</td>
														<td><fmt:formatDate value="${item.bind_proxy_time}" type="date" dateStyle="default"/></td>
														<td>${item.cust_source_name}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
									<c:when test="${sel_proxy_pid != null and sel_proxy_pid != ''}">
										<div class="row-fluid" style="border-left:1px solid #ddd;border-right:1px solid #ddd;">
											<div class="span12" style="padding:20px 0px;">
												<div class="span4">
													<div class="control-group">
														<label class="control-label">审核通过时间：</label>
														<div class="controls">
															<input type="text" id="start_passed_time" placeholder="开始时间" class="m-wrap small" name="start_passed_time" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${start_passed_time}"/>
															 -- 
															 <input type="text" id="end_passed_time" placeholder="结束时间" class="m-wrap small" name="end_passed_time" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${end_passed_time}"/>
														</div>
													</div>
												</div>
												<div class="span2">
													<a href="javascript:;" class="btn blue" id="searchBtn" >
														<i class="icon-search"></i> 搜索
													</a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-bordered table-hover" id="sample_2">
											<thead>
												<tr>
													<th>序号</th>
													<th>姓名</th>
													<th>手机号</th>
													<th>备用电话</th>
													<th>所在城市</th>
													<th>发展客户</th>
													<th>审核通过时间</th>
													<th>注册方式</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="item" items="${list}" varStatus="status">
													<tr class="odd gradeX">
														<td><c:out value="${status.count}"/></td>
														<td>${item.name}</td>
														<td>${item.phone_num}</td>
														<td>${item.contact}</td>
														<td>${item.city_name}</td>
														<td>${item.sub_custinfo_count}</td>
														<td><fmt:formatDate value="${item.passed_time}" type="date" dateStyle="default"/></td>
														<td>${item.cust_source_name}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</c:when>
								</c:choose>
								<input id="field" name="field" type="hidden" />
								<input id="way" name="way" type="hidden" />
								<div id="pageBar">
									<input type="hidden" id="page" name="page" value="1" />
									${pageBar}
								</div>
								</form>
							</div>
					   </div>
					</div>
				</div>		
					
						
		        <div id="updataStatus" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updataStatus" aria-hidden="true" >
	                <div class="modal-header">
	                    <button type="button" class="close" onclick="clearInput();" data-dismiss="modal" aria-hidden="true"></button>
	                   <h3  style="margin-top:5px;" id="statusTitle"></h3>
	                 </div>
	                 <div class="modal-body">
	                 	<div class="portlet-body form">
							<div class="row-fluid">
								<div class="span12 "></div>
					  			<div class="span12 ">
                                     <div class="control-group">
                                 		<label id="intpuTitle" >请输入原因:</label>
                                 	</div>
                                 </div>
                                 <div class="span12 ">
                                     <div class="control-group">
                                         <div class="controls">
                                         	<textarea id="reason" must-be="true"  data-length="50" data-label="输入原因" class="span10 m-wrap"   rows="4" name="reason"></textarea>
                                         	<!-- <span style="color:red;margin-left:10px;">*</span> -->
                                         	<input id="us_custinfo_id"  name="custinfo_id" type="hidden" value=""/>
											<input id="us_column" name="column" type="hidden" value=""/>
											<input id="us_status_code" name="status_code" type="hidden" value="" />
                                         </div>
                                     </div>
                                 </div>
                             </div>
                        </div>
                    </div>
					<div class="modal-footer">
					    <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="clearInput();">取消</button>
					     <button type="button"  onclick="valiStatusDate();"  class="btn blue">确定</button>
					</div>
              </div>
              
		              
            </div>
			<!-- END PAGE CONTAINER-->    
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<div class="footer">
		<div class="footer-inner">
			2013 &copy; 北京太平洋加达出国顾问股份有限公司
		</div>
		<div class="footer-tools">
			<span class="go-top">
			<i class="icon-angle-up"></i>
			</span>
		</div>
	</div>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
	<script src="/views/media/js/excanvas.min.js"></script>
	<script src="/views/media/js/respond.min.js"></script>  
	<![endif]-->   
	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script src="/views/media/js/jquery.vmap.js" type="text/javascript"></script>   
	<script src="/views/media/js/jquery.vmap.russia.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.world.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.europe.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.germany.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.usa.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.sampledata.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.flot.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.flot.resize.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.pulsate.min.js" type="text/javascript"></script>
	<script src="/views/media/js/date.js" type="text/javascript"></script>
	<script src="/views/media/js/daterangepicker.js" type="text/javascript"></script>     
	<script src="/views/media/js/jquery.gritter.js" type="text/javascript"></script>
	<script src="/views/media/js/fullcalendar.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.easy-pie-chart.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.sparkline.min.js" type="text/javascript"></script>  
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<script src="/views/media/js/index.js" type="text/javascript"></script>     
	<script src="/views/media/js/form-validate.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->  
	<script>
		jQuery(document).ready(function() {    
		   App.init(); // initlayout and core plugins
		   //绑定翻页
			$('li.pages').each(function(index, element) {
				if($(element).attr("data-page")!=undefined){
					$(this).click(function(e) {
						$("#page").val($(element).attr("data-page"));
						doRequest();
					});
				}
          });
		});
		
		//搜索触发
		$("#searchBtn").click(function(e) {
	        doRequest();
	    });
	
		 //选择级别数据
		 function selectTab(emId, setId, timeId) {
			 $("#"+emId).val('');
			 $("#"+setId).val('${custinfo_id}');
			 $("#start_"+timeId).val('');
			 $("#end_"+timeId).val('');
			 doRequest();
		 }
		 
		//提交查询请求
		function doRequest(){
			$("#searchForm").formValidate();
		}
		
		 //修改状态
		 function updateStatus(custinfo_id, status_code, column, ts) {
			$("#intpuTitle").text("请输入"+ts+"原因");
			if(custinfo_id && status_code && column) {
				clearInput();
				$("#us_custinfo_id").val(custinfo_id);
				 $("#us_column").val(column);
				 $("#us_status_code").val(status_code);
			}
		 }
		 
		 function clearInput() {
			 $("#us_custinfo_id").val("");
			 $("#us_column").val("");
			 $("#us_status_code").val("");
			 $("#reason").val("");
		 }
		 
		 function valiStatusDate() {
			 var $reason = $("#reason");
			var reason=$reason.val();
			var dataLen = $reason.attr("data-length");
			var label = $reason.attr("data-label");
			var be = $reason.attr("must-be");
			//字数验证
			if(dataLen!=undefined && reason.length>dataLen){
				alert(label+"字数不能超过"+dataLen+"!");
				flag=false;
				return false;
			} else if(be && !reason) {
				alert(label+"不能为空!");
				flag=false;
				return false;
			}
			submitStatus(reason);
		 }
		 
		 //提交修改状态
		function submitStatus(reason) {
			var custinfo_id=$("#us_custinfo_id").val();
			var column=$("#us_column").val();
			var status_code=$("#us_status_code").val();
			
			if(custinfo_id && status_code && column) {
				 $.post("/proxy/proxy/status",{'custinfo_id':custinfo_id, 'status_code':status_code, 'column':column, 'reason':reason}, function(data) {
					 if(data.status==0) {
						 alert(data.msg);
						 doRequest();
					 } else {
						 alert(data.msg);
					 }
				 });
			 }
		 }
	</script>
</body>
<!-- END BODY -->
</html>