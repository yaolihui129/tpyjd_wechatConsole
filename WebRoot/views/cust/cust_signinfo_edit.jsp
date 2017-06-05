<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->

<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<!-- BEGIN HEAD -->

<head>
<meta charset="utf-8" />

<title>太平洋加达出国－后台管理系统 v1.0</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->

<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>

    <style type="text/css">
	th{
		cursor:pointer;
	}
	th div{
		float:left;
	}
	.tree a.tree-toggle{
		padding-left:20px;
	}
	</style>
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@ include file="../navi.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@ include file="../menus.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="page-title">${operation}</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li>客户管理<i class="icon-angle-right"></i>
							</li>
							<li>客户签约信息录入/编辑</li>
							<li class="pull-right no-text-shadow">
								<div id="dashboard-report-range"
									class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
									data-tablet="" data-desktop="tooltips" data-placement="top"
									data-original-title="Change dashboard date range">
									<i class="icon-calendar"></i> <span></span> <i
										class="icon-angle-down"></i>
								</div>
							</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->
				<div class="row-fluid">
					<div class="portlet-title">
						<div class="caption">
						</div>
					</div>
					<!-- 添加表单 -->
					<div class="portlet-body form">
						<!-- BEGIN FORM-->
						<div class="form-horizontal form-bordered">
							<form id="sform" action="/cust/signrecord/save"  method="post"  enctype="multipart/form-data">
								<div class="row-fluid">
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">客户：</label>
											<input type="text" readonly="readonly" value="${cust.name }">
										</div>
									</div>
									<!--/span-->
									
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">附申请人：</label>
											<input type="text" id="other_applicant" name ="other_applicant" value="${signinfo.otherApplicant }" >
										</div>
									</div>
									<!--/span-->
								</div>
								
								<div class="row-fluid">
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">国家：</label>
											<select id="country" name="country" onChange="country_change();">
												<option value="">全部</option>
												<c:forEach items="${countryList}" var="item">
													<c:if test="${item.dictCode == signinfo.country}">
														<option value="${item.dictCode }" selected>${item.name }</option>
													</c:if>
													<c:if test="${item.dictCode != signinfo.country}">
														<option value="${item.dictCode }">${item.name }</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>
									<!--/span-->
									
									<div class="span6 ">
										<div class="control-group" id="projects">
											<label class="control-label">项目：</label>
											<select id="project_id" name="project_id" >
												<option value="">全部</option>
											</select>
										</div>
									</div>
									<!--/span-->
								</div>
								
								<div class="row-fluid">
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">签约金额：</label>
											<input type="text" id="fee" name="fee" value="${signinfo.fee }">
										</div>
									</div>
									<!--/span-->
									
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">支付方式：</label>
											<select id="paycode" name="paycode">
												<option value="">全部</option>
												<c:forEach items="${paycodeList}" var="item">
													<c:if test="${item.dictCode == signinfo.paycode}">
														<option value="${item.dictCode }" selected>${item.name }</option>
													</c:if>
													<c:if test="${item.dictCode != signinfo.paycode}">
														<option value="${item.dictCode }">${item.name }</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>
									<!--/span-->
								</div>
								
								<div class="row-fluid">
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">服务律师：</label>
											<input type="text" id="service_lawyer" name="service_lawyer" value="${signinfo.serviceLawyer }">
										</div>
									</div>
									<!--/span-->
									
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">服务费：</label>
											<input type="text" id="service_fee" name="service_fee" value="${signinfo.serviceFee }">
										</div>
									</div>
									<!--/span-->
								</div>
								
								<div class="row-fluid">
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">签约日期：</label>
											<input type="text" id="sign_date" name="sign_date" value="${signinfo.signDate }" class="laydate-icon" onclick="laydate({istime: false,istoday:false, format: 'YYYY-MM-DD'})">
											<script>
											laydate({
											  elem: '#sign_date', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
											  event: 'focus' //响应事件。如果没有传入event，则按照默认的click
											});
											</script>
										</div>
									</div>
									<!--/span-->
									
									<div class="span6 ">
										<div class="control-group">
											<label class="control-label">合作方：</label>
											<input type="text" id="partner" name="partner" value="${signinfo.partner }">
										</div>
									</div>
									<!--/span-->
								</div>
								
								<div class="row-fluid">
									<div class="span12 ">
										<div class="control-group">
											<label class="control-label">备注：</label>
											<textarea rows="" cols="" id="remark" name="remark">${signinfo.remark }</textarea>
										</div>
									</div>
									<!--/span-->
									
								</div>
								
								<div class="row-fluid">
									<div class="span12 ">
										<div class="control-group">
											<label class="control-label">合同附件：</label>
											<input type="file" name = "deal" id="deal"/>
											<table style="width:600px;align:center;">
												<c:forEach items="${deals}" var="deal">
													<tr id="${deal.id}">
														<td width="400">${fn:substring(deal.filepath, 14, -1)}</td>
														<td width="200">
														<div data-id="${deal.id}">
															<i class="icon-trash">删除</i>
															<i class=" icon-download-alt" >下载</i>
														</div>
														</td>
													</tr>
												</c:forEach>
												
											</table>
										</div>
									</div>
									<!--/span-->
									
								</div>
								
								<div class="row-fluid">
									<div class="span12 ">
										<div class="control-group">
											<label class="control-label">个人简历：</label>
											<input type="file" name = "resume" id="resume"/>
											<table style="width:600px; algin:center;margin-left: 200px;" class="table">
												<c:forEach items="${resumes}" var="resume">
													<tr id="${resume.id}">
														<td width="400">${fn:substring(resume.filepath, 14, -1)}</td>
														<td width="200">
														<div data-id="${resume.id}">
															<i class="icon-trash">删除</i>
															<i class=" icon-download-alt" >下载</i>
														</div>
														</td>
													</tr>
												</c:forEach>
												
											</table>
										</div>
									</div>
									<!--/span-->
									
								</div>
								
								

								<div class="form-actions">
									<input id="custinfo_id" name="custinfo_id" type="hidden" value="${cust.custinfoId }">
									<input id="signed_id" name="signed_id" type="hidden" value="${signinfo.signedId }">
									<input type="submit" value="保存" id="subBtn" class="btn blue">
									<a id="back" class="btn">取消</a>
								</div>
								
							</form>
						</div>

						<!-- END FORM-->
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
		<div class="footer-inner">2016 &copy; copyright pacificimmi.</div>
		<div class="footer-tools">
			<span class="go-top"> <i class="icon-angle-up"></i>
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
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript"></script>
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
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
	<script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	<script src="/js/jquery.form.min.js"></script><!-- 表单异步提交 -->

	<script>
		jQuery(document)
				.ready(
						function() {
							App.init(); // initlayout and core plugin 
							
							/*$("#orgTree").find("li>a").each(function(index, element) {
							   $(this).click(function(e) {
				                 var id =$(this).attr("data-info");
									 $("#org_id").val(id);
									 $("#org_name").val($(this).text());
									 $("#orgName").text($(this).text());
								});
							});*/
							
							
							//取消、返回
							$("#back").click(function(e) {
								window.history.back();
							});
							
							
							//绑定删除按钮
							$("i.icon-trash")
									.each(
											function(index, element) {
												$(this)
														.click(
																function(e) {
																	var id = $(
																			this)
																			.parent()
																			.attr(
																					"data-id");
																	if(confirm("删除后不能恢复，确定要删除吗？")){
																		$.post(
																				"/cust/signrecord/deleteAnnex",
																				{
																					"id" : id
																				},
																				function(
																						data) {
																					if (data.status == 0) {
																						alert(data.msg);
																						//location.reload();
																						$("#"+id).remove();
																					} else
																						alert(data.msg);
																				});
																	}
																});
											});

							//绑定下载
							$("i.icon-download-alt")
									.each(
											function(index, element) {
												$(this)
														.click(
																function(e) {
																	var id = $(
																			this)
																			.parent()
																			.attr(
																					"data-id");
																	location.href="/cust/signrecord/download/" + id;
																	
																});
											});

							//提交表单
							$("#subBtn")
									.click(
											function(e) {

												var fromurl = document.referrer;
												$("#fromurl").val(fromurl);
												//调用验证插件，进行form表单的验证
												//$("#sform").formValidate();
												//$("#sform").submit();
												
												$("#sform").ajaxForm({
													dataType: "json",
													success: function(data) {
														if(data.status == 0){
															alert("保存成功");
															location.reload();
														}else{
															alert("保存失败");
														}
													}
												});
												
											});
							
						});
		
		
		//国家项目联动
		function country_change(p){
			var c = document.getElementById("country").value;
			if(c == ""){
				return;
			}
			
			$.post(
					"/cust/signrecord/getProjectsByCountry",
					{
						"country" : c,
						"pid":p
					},
					function(data) {
						document.getElementById("projects").innerHTML = data.result;
					});
		}
		
		window.onload = function(){
			if("${signinfo.signedId}" != null && "${signinfo.signedId}" != ""){
				country_change("${signinfo.projectId}");
			}
		}

	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>