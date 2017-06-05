<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->
<!-- 多出来的 -->
<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
<!-- 这个css为移民目的引用的样式 -->
<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css" />
<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>


    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	
	
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
	<div class="page-container row-fluid">
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
						<h3 class="page-title">${operation}移民政策<i style="font-size: 12px;">（${coun.countryName}）</i></h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li><a href="/country/immiPolicy/listPolicy?coun_id=${coun_id}">移民政策</a><i class="icon-angle-right"></i>
							</li>
							<li>${operation}移民政策</li>
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
				<div class="span12">
				<div class="tabbable tabbable-custom">
                  <ul class="nav nav-tabs">
                      <li><a href="/country/add?coun_id=${coun.id}&operation=编辑">基本信息</a></li>
                      <li><a href="/country/countrySurvey?coun_id=${coun.countryId}">国家概况</a></li>
                      <li><a href="/country/livingEnvironment?coun_id=${coun.countryId}">居住环境</a></li>
                      <li><a href="/country/socialWelfare?coun_id=${coun.countryId}">社会福利</a></li>
					  <li><a href="/country/educationalLevel?coun_id=${coun.countryId}">教育水准</a></li>
					  <li><a href="/country/investHome?coun_id=${coun.countryId}">投资置业</a></li>
					  <li><a href="/country/employmentEnvironment?coun_id=${coun.countryId}">就业环境</a></li>
					  <li><a href="/country/passportNationality?coun_id=${coun.countryId}">护照国籍</a></li>
					  <li><a href="/country/city/hot/hotCityList?coun_id=${coun.countryId}">热门城市</a></li>
					  <li class="active"><a href="javascript:;">移民政策</a></li>
                 </ul>
               <div class="tab-content">
               <!-- 基本信息开始 -->
                  <div class="tab-pane active" id="tab_1">
					<div class="portlet-title">
						<div class="caption">
							<b>${operation}移民政策</b>
						</div>
					</div>
					<!-- 添加表单 -->
					<div class="portlet-body form">
						<!-- BEGIN FORM-->
						<div class="form-horizontal form-bordered">
							<form id="sform" method="post">
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>标题：</span> 
										<input  placeholder="标题" class="m-wrap span3" type="text" data-label="标题"
										must-be="true" name="title" id="title" value="${policy.title}"/>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>国家：</span> 
											<input  placeholder="国家" class="m-wrap span3" type="text" data-label="国家"
											must-be="true" name="coun_name" id="coun_name" value="${coun_name}" readonly="readonly"/>
											<input class="m-wrap span3" type="hidden" name="coun_id" id="coun_id" value="${coun_id}"/>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>相关项目：</span> 
											<select class="m-wrap span3" id="project_id" name="project_id" <c:if test="${!empty city.cityName}">disabled="disabled"</c:if>>
											<option value=""></option>
											<c:forEach var="item" items="${projects}">
												<option value="${item.projectId}"<c:if test="${item.projectId == policy.projectId}">selected="selected"</c:if>>${item.projectName}</option>
											</c:forEach>
											</select>
											<input type="hidden" class="m-wrap span3" data-label="相关项目需要在字典表中维护，"
											must-be="true" id="project_name" name="project_name" value="${policy.projectName}"/>
									</div>
								</div>

								<div class="control-group"> 
								 	<div class="controls">
								 		<span class="m-wrap span2" style="margin-top: 10px;">内容：</span>   
										<textarea style="width:320px;height: 100px;" placeholder="内容" data-label="内容" name="content" id="content">${policy.content}</textarea>
									</div>
									
								</div>
								
								<input id="coun_id" name="coun_id" type="hidden" value="${coun_id}"/>
								<input id="policy_id" name="policy_id" type="hidden" value="${policy.id}"/>
								<input id="operation" name="operation" type="hidden" value="${operation}"/>
								<div class="form-actions">
									<a class="subBtn btn blue" style="width:80px;"><i class="icon-ok"></i> 保存</a>
									<a class="btn back"><i class="icon-remove"></i>取消</a>
								</div>
							</form>
						<!-- END FORM-->
						</div>
						</div>
						</div>
						</div>
						</div>
					</div>
				</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->
				</div>
				 <!-- 基本信息开结束-->
				 
	<div class="footer">
		<div class="footer-inner">2016 &copy; copyright pacificimmi.</div>
		<div class="footer-tools">
			<a href="#tab_1"><span class="go-top"> <i class="icon-angle-up"></i>
			</span></a>
		</div>
	</div>
	<!-- END FOOTER -->
	</body>
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>


	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/form-validate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->

	<script>
		jQuery(document)
				.ready(
						function() {
							//取消、返回
							$(".back").click(function(e) {
								window.history.back();
							});

							

							//提交表单
							$(".subBtn")
									.click(
											function(e) {
												var title = $("#title").val();
												if(title.length > 20){
													alert("标题内容不能超过20个字！");
													return false;
												}
												//调用验证插件，进行form表单的验证
												$("#sform").formValidate();
											});
						});
		
		$("#project_id").change(function(){
			var project_id = $("#project_id").val();
			var project_name = $("#project_id").find("option:selected").text();
			if(!policy_id){
				$("#project_name").val('');
			}else{
				$("#project_name").val(project_name);
			}
			
			
		});
		
	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>