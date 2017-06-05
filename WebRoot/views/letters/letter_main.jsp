<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
						<h3 class="page-title">站内信管理</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li>站内信<i class="icon-angle-right"></i>
							</li>
							<li>我的信件</li>
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
				<!-- BEGIN PAGE CONTENT-->
				<div class="row-fluid">
					<div class="span12">
						<div class="tabbable tabbable-custom boxless">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab_1" data-toggle="tab">收件箱</a></li>
								<li><a class="" href="#tab_2" data-toggle="tab">发件箱</a></li>
							</ul>
							<div class="tab-content">
										<table>
											<tr>
												<td valign="top">
													<button class="btn black" id="searchBtn">查询 <i class="icon-search"></i></button>
													<a href="/letters/add" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
													<a href="#" class="btn red delete" id="signRead"><i class=" icon-eye-open"></i> 标记已读</a>
												</td>
										</table>
							
								<!-- 收件箱开始 -->
								<div class="tab-pane active" id="tab_1">
									<!-- BEGIN EXAMPLE TABLE PORTLET-->
									<div class="portlet box blue">
										<div class="portlet-title">
											<div class="caption"><i class="icon-globe"></i>收件箱</div>
											<div class="actions">
												<div class="btn-group">
													<a class="btn" href="#" data-toggle="dropdown">
													批量操作
													<i class="icon-angle-down"></i>
													</a>
													<div id="sample_2_column_toggler" class="dropdown-menu hold-on-click dropdown-checkboxes pull-right">
														<label><input type="checkbox" checked data-column="0">Rendering engine</label>
														<label><input type="checkbox" checked data-column="1">Browser</label>
														<label><input type="checkbox" checked data-column="2">Platform(s)</label>
														<label><input type="checkbox" checked data-column="3">Engine version</label>
														<label><input type="checkbox" checked data-column="4">CSS grade</label>
													</div>
												</div>
											</div>
										</div>
										<div class="portlet-body">
											<table class="table table-striped table-bordered table-hover table-full-width" id="sample_2">
												<thead>
													<tr>
														<th width="100">发件人</th>
														<th width="300">主题</th>
														<th width="200">时间</th>
														<th width="100">状态</th>
														<th >操作</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach items="${receiveList}" var="item">
														<tr>
															<td width="100">${item.senderName}</td>
															<td width="300">${item.title}
															</td>
															<td width="200">
																<fmt:formatDate value="${item.send_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
															</td>
															<td width="100">${item.status}</td>
															<td >
																<div data-id="${item.letter_id}">
																	<i class="icon-edit">回复</i>
																	<i class="icon-trash m-icon-black">删除</i>
																</div>
															</td>
														</tr>
													</c:forEach>
													
												</tbody>
											</table>
										</div>
									</div>
									<!-- END EXAMPLE TABLE PORTLET-->
									
								</div>
								<!-- 收件箱结束 -->
								
								<!-- 发件箱开始 -->
								<div class="tab-pane " id="tab_2">
									<div class="portlet box green">
										<div class="portlet-title">
											<div class="caption">
												<i class="icon-reorder"></i>发件箱
											</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a> <a
													href="#portlet-config" data-toggle="modal" class="config"></a>
												<a href="javascript:;" class="reload"></a> <a
													href="javascript:;" class="remove"></a>
											</div>
										</div>
										<div class="portlet-body form">
											<!-- BEGIN FORM-->
											<form id="sendForm" method="get">
												<table class="table table-striped table-bordered table-hover">
													<thead>
														<tr>
															<th width="45" id="all2"><input type="checkbox" /><span>全选</span></th>
															<c:choose>
																<c:when test="${field=='cu2.user_name' && way=='asc'}">
																	<th width="80" class="sorting_asc" data-field="cu2.user_name">收件人</th>
																</c:when>
																<c:when test="${field=='cu2.user_name' && way=='desc'}">
																	<th width="80" class="sorting_desc"
																		data-field="cu2.user_name">收件人</th>
																</c:when>
																<c:otherwise>
																	<th width="80" class="sorting" data-field="cu2.user_name">收件人</th>
																</c:otherwise>
															</c:choose>
															<c:choose>
																<c:when test="${field=='cl.title' && way=='asc'}">
																	<th width="300" class="sorting_asc"
																		data-field="cl.title">主题</th>
																</c:when>
																<c:when test="${field=='cl.title' && way=='desc'}">
																	<th width="300" class="sorting_desc"
																		data-field="cl.title">主题</th>
																</c:when>
																<c:otherwise>
																	<th width="300" class="sorting" data-field="cl.title">主题</th>
																</c:otherwise>
															</c:choose>
															<c:choose>
																<c:when test="${field=='cl.send_time' && way=='asc'}">
																	<th width="150" class="sorting_asc"
																		style="text-align: center" data-field="cl.send_time">时间</th>
																</c:when>
																<c:when test="${field=='cl.send_time' && way=='desc'}">
																	<th width="150" class="sorting_desc"
																		style="text-align: center" data-field="cl.send_time">时间</th>
																</c:when>
																<c:otherwise>
																	<th width="150" class="sorting" style="text-align: center"
																		data-field="cl.send_time">时间</th>
																</c:otherwise>
															</c:choose>
															<th width="100" class="sorting" style="text-align: center"
																		data-field="cl.status">状态</th>
															<th >快捷操作&nbsp;&nbsp;</th>
														</tr>
													</thead>
													<tbody id="list2">
														<c:forEach items="${sendList}" var="item">
															<tr style="height:40px;">
																<td><input type="checkbox" class="checkboxes"
																	value="${item.letter_id}" /></td>
																<td data-title="发件人">${item.receiverName}
																</td>
																<td data-title="主题">${item.title}</td>
																<td style="text-align: center" data-title="时间">
																	<p>
																		<fmt:formatDate value="${item.send_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
																	</p>
																</td>
																<td style="text-align: center" data-title="状态">
																	<p>${item.status}</p>
																</td>
																<td data-title="操作">
																	<div data-id="${item.letter_id}">
																		<i class="icon-trash m-icon-black">删除</i>
																	</div>
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
											</form>
											<!-- END FORM-->
										</div>
									</div>
								</div>
								<!-- 发件箱结束 -->
							</div>
						</div>
					</div>
				</div>
				<!-- END PAGE CONTENT-->
				<!-- END PAGE CONTAINER-->
			</div>
			<!-- END PAGE -->
		</div>
		</div>
		<!-- END CONTAINER -->
		<!-- BEGIN FOOTER -->
		<%@ include file="../footer.jsp"%>
		<!-- FOOTER -->
		<!-- BEGIN J2.1.1RIPTS(Lll reduce page load time) -->
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
		<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
		<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
		<script src="/views/media/js/table-advanced.js"></script>	
			
		<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
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
								
								TableAdvanced.init();
								
								//全选事件处理
								$("#all")
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
												});
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
								//绑定内容编辑
								$("i.icon-edit")
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
																		location.href = "/letters/detail/"
																				+ id;
																	});
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
																		if (confirm("确定要删除该信件吗？")) {
																			$
																					.post(
																							"/letters/delete",
																							{
																								"ids" : id
																							},
																							function(
																									data) {
																								if (data.status == 0) {
																									alert(data.msg);
																									location
																											.reload();
																								} else
																									alert(data.msg);
																							});
																		}
																	});
												});
								//标记已读
								$("#signRead")
										.click(
												function(e) {
													var checks = $("input.checkboxes:checked");
													if (checks.size() > 0) {
														var ids = "";
														checks
																.each(function(
																		index,
																		element) {
																	if (ids == "")
																		ids = $(
																				this)
																				.val();
																	else {
																		ids = ids
																				+ ","
																				+ $(
																						this)
																						.val();
																	}
																});
														//dosomething
														$
																.post(
																		"/letters/hadread",
																		{
																			"ids" : ids
																		},
																		function(
																				data) {
																			if (data.status == 0) {
																				alert(data.msg);
																				location
																						.reload();
																			} else
																				alert(data.msg);
																		});
													} else {
														alert("请选择其中一行");
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
									//$("#searchForm").submit();
									$("#searchForm").formValidate();
								}
							});
		</script>
		
		<!-- END JAVASCRIPTS -->
		<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>

<!-- END BODY -->
</html>