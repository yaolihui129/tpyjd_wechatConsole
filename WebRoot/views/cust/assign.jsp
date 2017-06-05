<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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

<link href="/views/media/css/uniform.default.css"
	rel="styles
	<meta content="" name="author" />

	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
heet"
	type="text/css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="/views/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css"
	href="/views/media/css/bootstrap-tree.css" />
<link rel="stylesheet" type="text/css"
	href="/views/media/css/DT_bootstrap.css" />
<style type="text/css">
th {
	cursor: pointer;
}

th div {
	float: left;
}

.tree a.tree-toggle {
	padding-left: 20px;
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

						<h3 class="page-title">潜在客户管理</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li>客户管理<i class="icon-angle-right"></i>
							</li>

							<li>顾问列表</li>

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
						<div class="portlet box grey">
							<div class="portlet-title" >
								<div class="caption">
									
								</div>
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
									<table border="0">
										<tr>
											<td width="120">姓名：</td>
											<td width="250"><input type="text" id="uname" name="uname" value="${uname }"></td>
											<td >
												<button class="btn black" id="searchBtn">查询 <i class="icon-search"></i></button>
												
											</td>
										</tr>
									</table>

									<table class="table">
										<thead>
											<tr>
												<th width="5">
												</th>
												<th width="10" id="all">
												<!-- 
												<input type="checkbox" /><span>全选</span>
												 -->
												</th>
												<c:choose>
													<c:when test="${field=='cu.user_name' && way=='asc'}">
														<th width="80" class="sorting_asc" data-field="cu.user_name">姓名</th>
													</c:when>
													<c:when test="${field=='cu.user_name' && way=='desc'}">
														<th width="80" class="sorting_desc"
															data-field="cu.user_name" align="right">姓名</th>
													</c:when>
													<c:otherwise>
														<th width="80" class="sorting" data-field="cu.user_name">姓名</th>
													</c:otherwise>
												</c:choose>
												
													<th width="200">公司</th>
															
												
													<th  style="text-align: left">部门</th>
													
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item">
												<tr>
													<td></td>
													<td style="text-align: right;">
													<!-- 
													<input type="checkbox" class="checkboxes"
														value="${item.user_id}" />
														 -->
														 <label class="radio" >
															<input type="radio" name="ras" value="${item.steward_id}-${item.user_name}" />
															</label>
													</td>
													<td data-title="姓名">${item.user_name}
													</td>
													<td data-title="公司">${item.comName}</td>
													<td style="text-align: left" data-title="部门">
														<p>${item.depName}</p>
													</td>
													
												</tr>
											</c:forEach>
										</tbody>

									</table>
									<input id="field" name="field" type="hidden" /> 
									<input id="way" name="way" type="hidden" />
									<div id="pageBar">
										<input type="hidden" id="page" name="page" value="1" />
										${pageBar}
									</div>
									
									<div align="center">
										<input type="hidden" id="custId" value="${custId }">
										<a id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</a>
									</div>
								</form>
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

		<div class="footer">

			<div class="footer-inner">2016 &copy; copyright pacificimmi.</div>

			<div class="footer-tools">

				<span class="go-top"> <i class="icon-angle-up"></i>

				</span>

			</div>

		</div>

		<!-- FOOTER -->

		<!-- BEGIN J2.1.1RIPTS(Lll reduce page load time) -->

		<!-- BEGIN CORE PLUGINS -->

		<script src="/views/media/js/jquery-1.10.1.min.js"
			type="text/javascript"></script>

		<script src="/views/media/js/jquery-migrate-1.2.1.min.js"
			type="text/javascript"></script>

		<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

		<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js"
			type="text/javascript"></script>

		<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>

		<!--[if lt IE 9]>

	<script src="/views/media/js/excanvas.min.js"></script>

	<script src="/views/media/js/respond.min.js"></script>  

	<![endif]-->

		<script src="/views/media/js/jquery.slimscroll.min.js"
			type="text/javascript"></script>

		<script src="/views/media/js/jquery.blockui.min.js"
			type="text/javascript"></script>

		<script src="/views/media/js/jquery.cookie.min.js"
			type="text/javascript"></script>

		<script src="/views/media/js/jquery.uniform.min.js"
			type="text/javascript"></script>

		<!-- END CORE PLUGINS -->

		<!-- BEGIN PAGE LEVEL PLUGINS -->

		<script type="text/javascript" src="/views/media/js/select2.min.js"></script>

		<script type="text/javascript"
			src="/views/media/js/jquery.dataTables.js"></script>

		<!--<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>-->

		<!-- END PAGE LEVEL PLUGINS -->

		<!-- BEGIN PAGE LEVEL SCRIPTS -->

		<script src="/views/media/js/app.js"></script>
		<script src="/js/json/json2.js"></script>
		<script src="/views/media/js/form-validate.js"></script>
		<script>
			jQuery(document)
					.ready(
							function() {

								App.init(); // initlayout and core plugins
								//全选事件处理
								/*$("#all")
										.click(
												function(e) {
													if ($(this).children(
															":last").text() == "全选") {
														$(this).children(
																":last").text(
																"反选");
														$("input:checkbox")
																.prop(
																		"checked",
																		function(
																				i,
																				v) {
																			return true;
																		});
														$("div.checker>span")
																.addClass(
																		"checked");
													} else {
														$(this).children(
																":last").text(
																"全选");
														$("input:checkbox")
																.prop(
																		"checked",
																		function(
																				i,
																				v) {
																			return false;
																		});
														$("div.checker>span")
																.removeClass(
																		"checked");
													}
												});*/
								//搜索触发
								$("#searchBtn").click(function(e) {
									doRequest();
								});

								//排序事件处理
								$(".sorting,.sorting_asc,.sorting_desc")
										.each(
												function(index, element) {
													$(this)
															.click(
																	function(e) {
																		var field = $(
																				this)
																				.attr(
																						"data-field");
																		$(
																				"#field")
																				.val(
																						field);

																		$(this)
																				.siblings(
																						".sorting,.sorting_asc,.sorting_desc")
																				.attr(
																						"class",
																						"sorting");
																		if ($(
																				this)
																				.attr(
																						"class") == "sorting") {
																			$(
																					this)
																					.attr(
																							"class",
																							"sorting_asc");
																			$(
																					"#way")
																					.val(
																							"asc");
																			//do something
																			doRequest();
																		} else if ($(
																				this)
																				.attr(
																						"class") == "sorting_asc") {
																			$(
																					this)
																					.attr(
																							"class",
																							"sorting_desc");
																			$(
																					"#way")
																					.val(
																							"desc");
																			//do something
																			doRequest();
																		} else {
																			$(
																					this)
																					.attr(
																							"class",
																							"sorting_asc");
																			$(
																					"#way")
																					.val(
																							"asc");
																			//do something
																			doRequest();
																		}
																	});
												});

								

								//绑定删除按钮
								$("#subBtn")
										.click(
												function(e) {
													var id = $('input[name="ras"]:checked ').val();
													if(id == null || id == ""){
														alert("请选择要分配的顾问!");
														return;
													}
													var custId = $("#custId").val();
													if(confirm("确定要分配给该顾问吗？")){
														$.post(
																"/cust/saveCustAdviser",
																{
																	"id" : id,
																	"custId" : custId
																},
																function(data) {
																	if (data.status == 0) {
																		alert(data.msg);
																		location.href = "/cust/potential";
																	} else
																		alert(data.msg);
																});
													}
												});

								//绑定翻页
								$('li.pages')
										.each(
												function(index, element) {
													if ($(element).attr(
															"data-page") != undefined) {
														$(this)
																.click(
																		function(
																				e) {
																			$(
																					"#page")
																					.val(
																							$(
																									element)
																									.attr(
																											"data-page"));
																			doRequest();
																		});
													}
												});

								//提交查询请求
								function doRequest() {
									$("#searchForm").formValidate();
								}

							});

			
				
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>