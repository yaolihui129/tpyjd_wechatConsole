<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
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
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
	<!-- END PAGE LEVEL SCRIPTS -->
	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@ include file="../navi.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container row-fluid">
		<!-- BEGIN SIDEBAR -->
		<%@ include file="../menus.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->  
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<div id="portlet-config" class="modal hide">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"></button>
					<h3>portlet Settings</h3>
				</div>
				<div class="modal-body">
					<p>Here will be a configuration form</p>
				</div>
			</div>
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->   
				<div class="row-fluid">
					<div class="span12">
						<h3 class="page-title">
							会员${operation }
							 <small></small>
						</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>
							<li>会员管理 - 会员${operation }</li>
						</ul>
					</div>
				</div>
				<!-- END PAGE HEADER-->
				<!-- BEGIN PAGE CONTENT-->
				<div class="row-fluid">
					<!--  --><div class="span12">
						<div class="tabbable tabbable-custom boxless">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab_1" data-toggle="tab">会员信息</a></li>
								<li><a class="" href="#tab_2" data-toggle="tab">发票信息</a></li>
								<li><a href="#tab_3" data-toggle="tab">地址信息</a></li>
							</ul>
							<div class="tab-content">
								<!-- 会员信息 开始 -->
								<div class="tab-pane active" id="tab_1">
									<div class="portlet box green">
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>会员信息</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>
										<div class="portlet-body form">
											<!-- BEGIN FORM-->
											<form action="#" class="form-horizontal" id="memberForm" method="get">
												<h3 class="form-section">基本信息</h3>
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">登录名：</label>
															<input type="text" value="${cust.login_name }" id="login_name" name="login_name" class="m-wrap span6" placeholder="登录名">
															<span class="help-inline"></span>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">昵称：</label>
															<input type="text" value="${cust.nick_name }" id="nick_name" name = "nick_name" class="m-wrap span6" placeholder="昵称">
														</div>
													</div>
													<!--/span-->
												</div>
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">姓名：</label>
															<input type="text" value="${cust.name }" id="name" name="name" class="m-wrap span6" placeholder="姓名">
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">姓名拼音：</label>
															<input type="text" value="${cust.name_pinyin }" id="name_pinyin" name="name_pinyin" class="m-wrap span6" placeholder="姓名拼音">
														</div>
													</div>
													<!--/span-->
												</div>
												<!--/row-->
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">性别：</label>
															<div class="controls">                                                
																<label class="radio">
																<input type="radio" id="gender" name="gender" value="m" <c:if test="${cust.gender == 'm' }"> checked</c:if>/>
																男
																</label>
																<label class="radio">
																<input type="radio" id="gender" name="gender" value="f"  <c:if test="${cust.gender == 'f' }"> checked</c:if>/>
																女
																</label>  
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label" >出生日期：</label>
															<input type="text" id="birthday1" name="birthday1" 
															value="<fmt:formatDate value="${cust.birthday }" pattern="yyyy-MM-dd HH:mm:ss"/>"
															class="m-wrap span6 laydate-icon" placeholder="YYYY-MM-DD" 
															onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
														</div>
													</div>
													<!--/span-->
												</div>
												<!--/row-->        
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">会员来源：</label>
															<select class="span6"  data-placeholder="会员来源" tabindex="1" name="cust_source" id="cust_source">
																<option value=""></option>
																<c:forEach items="${csourceList}" var="csource">
																	<c:if test="${cust.cust_source ==  csource.dictCode}">
																		<option value="${csource.dictCode }" selected>${csource.name}</option>
																	</c:if>
																	<c:if test="${cust.cust_source !=  csource.dictCode}">
																		<option value="${csource.dictCode }">${csource.name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">学历：</label>
															<select class="span6"  data-placeholder="学历" tabindex="1" id="education" name="education">
																<option value=""></option>
																<c:forEach items="${eduList}" var="edu">
																	<c:if test="${cust.education == edu.dictCode }">
																		<option value="${edu.dictCode }" selected>${edu.name}</option>
																	</c:if>
																	<c:if test="${cust.education != edu.dictCode }">
																		<option value="${edu.dictCode }">${edu.name}</option>
																	</c:if>
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
												</div>
												<!--/row-->        
												<h3 class="form-section">联系方式</h3>
												<!--/row-->                   
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">手机：</label>
															<input type="text" class="m-wrap span6" id="phone_num" name="phone_num" value="${cust.phone_num }">
														</div>
													</div>
												</div>
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">QQ：</label>
															<input type="text" class="m-wrap span6" id="qq" name="qq" value="${cust.qq }">
														</div>
													</div>
													<!--/span-->
												</div>
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label" >微信：</label>
															<input type="text"  class="m-wrap span6" id="wx" name="wx" value="${cust.wx }">
														</div>
													</div>
													<!--/span-->
												</div>
												<!--/row-->           
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">邮箱：</label>
															<input type="text" class="m-wrap span6" id="email" name="email" value="${cust.email }">
														</div>
													</div>
												</div>
												<!--/row-->
												<div class="form-actions">
													<input type="hidden" id="custinfo_id" name="custinfo_id" value="${cust.custinfo_id }">
													<button type="button" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存</button>
													<button type="button" class="btn" id="back">取消</button>
												</div>
											</form>
											<!-- END FORM-->                
										</div>
									</div>
								</div>
								<!-- 会员信息 结束 -->
								<!-- 发票信息 开始 -->
								<div class="tab-pane " id="tab_2">
									<!-- BEGIN EXAMPLE TABLE PORTLET-->
									<div class="portlet box yellow">
										<div class="portlet-title">
											<div class="caption"><i class="icon-globe"></i>发票信息</div>
											<div class="actions">
											</div>
										</div>
										<div class="portlet-body">
											<table class="table table-bordered table-hover">
												<thead>
													<tr>
														<th width="300">发票抬头 </th>
														<th width="100">是否默认</th>
													</tr>
												</thead>
												<tbody>
													<c:if test="${invoiceList == null || fn:length(invoiceList) == 0}">
													<tr>
														<td width="300" colspan="2">该会员尚未设置发票信息</td>
													</tr>
													</c:if>
													<c:if test="${invoiceList != null && fn:length(receiveList) != 0}">
													<c:forEach items="${invoiceList}" var="item">
														<tr>
															<td width="300">${item.invoice_title}</td>
															<td width="300">${item.title}
															</td>
														</tr>
													</c:forEach>
													</c:if>
												</tbody>
											</table>
										</div>
									</div>
									<!-- END EXAMPLE TABLE PORTLET-->
								</div>
								<!-- 发票信息 结束 -->
								<!-- 地址信息 开始 -->
								<div class="tab-pane " id="tab_3">
									<!-- BEGIN EXAMPLE TABLE PORTLET-->
									<div class="portlet box blue">
										<div class="portlet-title">
											<div class="caption"><i class="icon-globe"></i>地址信息</div>
											<div class="actions">
											</div>
										</div>
										<div class="portlet-body">
											<table class="table table-bordered table-hover table-full-width">
												<thead>
													<tr>
														<th width="100">发件人</th>
														<th width="100">手机</th>
														<th width="100">所在地区</th>
														<th width="300">详细地址</th>
														<th width="100">邮政编码</th>
														<th width="100">是否默认</th>
													</tr>
												</thead>
												<tbody>
													<c:if test="${receiveList == null || fn:length(receiveList) == 0}">
													<tr>
														<td width="300" colspan="6">该会员尚未设置地址信息</td>
													</tr>
													</c:if>
													<c:if test="${receiveList != null && fn:length(receiveList) != 0}">
													<c:forEach items="${receiveList}" var="item">
														<tr>
															<td width="100">${item.rec_name}</td>
															<td width="100">${item.rec_phone}
															</td>
															<td width="100">
																${item.rec_province}
															</td>
															<td width="300">${item.rec_address}</td>
															<td width="100">${item.post_code}</td>
															<td >
																<div data-id="${item.is_default}">
																	<i class="icon-edit">回复</i>
																	<i class="icon-trash m-icon-black">删除</i>
																</div>
															</td>
														</tr>
													</c:forEach>
													</c:if>
												</tbody>
											</table>
										</div>
									</div>
									<!-- END EXAMPLE TABLE PORTLET-->
								</div>
								<!-- 地址信息 结束 -->
							</div>
						</div>
					</div>
				</div>
				<!-- END PAGE CONTENT-->         
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->  
	</div>
	<!-- END CONTAINER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>	
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->
	<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	<script>
		jQuery(document).ready(function() {    
		   // initiate layout and plugins
		   App.init();
		   FormSamples.init();
		   TableAdvanced.init();
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		   //用户名校验
		   $("#login_name").blur(function(e) {
			   var loginName = $("#login_name").val();
			   if(loginName != "" && loginName != null){
				   $.post(
							"/members/invalidation",
							{
								"para_value" : loginName,
								"type" : "login_name",
								"key_id" : "${cust.custinfo_id }"
							},
							function(data) {
								if (data.status == 0) {
									$("#login_name").next().html("<font style='color:green;'>可用</font>");
								} else{
									$("#login_name").next().html("<font style='color:red;'>已存在</font>");
									$("#login_name").focus();
								}
									
							}
						);
			   }
			});
		   
		   
		 //提交表单
			$("#subBtn")
					.click(
							function(e) {
								var fromurl = document.referrer;
								$("#fromurl").val(fromurl);
								//调用验证插件，进行form表单的验证
								$("#memberForm").formValidate();
							});
		});
	</script>
	<!-- END JAVASCRIPTS -->   
<!-- 
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>
 -->
<!-- END BODY -->
</html>