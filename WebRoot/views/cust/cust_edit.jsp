<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
							<li>客户录入/编辑</li>
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
							<i class="icon-list"></i>${operation}</div>
					</div>
					<!-- 添加表单 -->
					<div class="portlet-body form">
						<!-- BEGIN FORM-->
						<div class="form-horizontal form-bordered">
							<form id="sform" method="post">
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>姓名：</span> <input
											placeholder="必填项，客户姓名" maxlength="10"
											class="m-wrap span3" type="text" data-label="姓名"
											must-be="true" data-length="10" name="name"
											id="name" value="${cust.name }">
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>性别：</span> 
											<c:choose> 
													<c:when test="${empty cust.custinfoId || cust.gender == 'm'}">
														<label class="radio">
															<input type="radio" name="gender" value="m" checked/> 男
														</label>
														<label class="radio">
															<input type="radio" name="gender" value="f"/> 女
														</label>
													</c:when>
													<c:otherwise>
														<label class="radio">
															<input type="radio" name="gender" value="m" /> 男
														</label>
														<label class="radio">
															<input type="radio" name="gender" value="f" checked/> 女
														</label>
													</c:otherwise>
											</c:choose>
											
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>移动电话：</span> <input
											placeholder="必填项，请输入11位的数字合法手机号码。" maxlength="11"
											class="m-wrap span3" type="mobile" data-label="手机号"
											must-be="true" data-length="11" name="phone_num" id="phone_num" data-type="mobile"
											<c:if test="${!empty cust.custinfoId}">
												disabled
											</c:if>
											value="${cust.phoneNum }">
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;">常用电话：</span> <input
											placeholder="" maxlength="11"
											class="m-wrap span3" type="mobile" data-label="常用电话"
											must-be="true" data-length="11" name="phone_num" id="phone_num" data-type="mobile"
											value="${cust.phoneNum }">
									</div>
								</div>
								

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>客户来源：</span> 
											<select  class="medium m-wrap" name="cust_source" id="cust_source">
												<option value="" selected>全部</option>
												<c:forEach items="${ csourceList}" var="csource">
														<c:if test="${cust.custSource == csource.dictCode }">
															<option value="${csource.dictCode }" selected>${csource.name}</option>
														</c:if>
														<c:if test="${cust.custSource != csource.dictCode }">
															<option value="${csource.dictCode }">${csource.name}</option>
														</c:if>
												</c:forEach>
											</select> 
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>客户状态：</span> 
											<select  class="medium m-wrap" name="cust_status" id="cust_status">
												<option value="" selected>全部</option>
												<c:forEach items="${ cstatusList}" var="cstatus">
													<c:if test="${cust.custStatus == cstatus.dictCode }">
														<option value="${cstatus.dictCode }" selected>${cstatus.name}</option>
													</c:if>
													<c:if test="${cust.custStatus != cstatus.dictCode }">
														<option value="${cstatus.dictCode }">${cstatus.name}</option>
													</c:if>
												</c:forEach>
											</select> 
									</div>
								</div>



								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;">备注：</span>
										<textarea placeholder="选填项，一段文字介绍客户，最多可输入50个汉字。"
											maxlength="50" rows="7" class="m-wrap span6" type="text"
											data-label="备注" data-length="50" name="remark"
											id="remark" value="${cust.remark }"></textarea>
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>所属部门：</span>
										<div class="btn-group">
											<a class="btn green" href="#" data-toggle="dropdown">
	                                            <span id="orgName">${org_name}</span>
	                                            <i class="icon-angle-down"></i>
											</a>
	
											<ul class="dropdown-menu pull-left">
	                                        	<div style="width:450px;height:400px; overflow-y:scroll">
												${tree}
	                                            </div>
											</ul>
										</div> 
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>流向：</span> 
											<c:choose> 
													<c:when test="${empty cust.custinfoId || cust.gender == 'm'}">
														<label class="radio">
															<input type="radio" name="direction" value="0" checked/> 线索池
														</label>
														<label class="radio">
															<input type="radio" name="direction" value="1"/> 客户池
														</label>
													</c:when>
													<c:otherwise>
														<label class="radio">
															<input type="radio" name="direction" value="0" /> 线索池
														</label>
														<label class="radio">
															<input type="radio" name="direction" value="1" checked/> 客户池
														</label>
													</c:otherwise>
											</c:choose>
											
									</div>
								</div>

								<div class="form-actions">
									<a id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</a>
									<a id="back" class="btn">取消</a>
								</div>
								<input id="org_id" name="org_id" type="hidden" value="${org_id}"/>
                                <input id="org_name" name="org_name" type="hidden" value="${org_name}"/>
								<input id="custinfo_id" name="custinfo_id" type="hidden" value="${cust.custinfoId }">
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

	<script>
		jQuery(document)
				.ready(
						function() {
							App.init(); // initlayout and core plugin 
							
							$("#orgTree").find("li>a").each(function(index, element) {
							   $(this).click(function(e) {
				                 var id =$(this).attr("data-info");
									 $("#org_id").val(id);
									 $("#org_name").val($(this).text());
									 $("#orgName").text($(this).text());
								});
							});
							
							
							//取消、返回
							$("#back").click(function(e) {
								window.history.back();
							});

							

							//提交表单
							$("#subBtn")
									.click(
											function(e) {

												var fromurl = document.referrer;
												$("#fromurl").val(fromurl);
												//调用验证插件，进行form表单的验证
												$("#sform").formValidate();
											});
						});

	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>