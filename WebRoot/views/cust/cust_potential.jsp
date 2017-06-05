<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

							<li>潜在客户</li>

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
								<div class="actions" align="left">
									<button class="btn blue" id="addBtn"> <i class="icon-plus"></i>新增</button>
									<button class="btn green" id="assignBtn"> <i class="icon-user"></i>分配</button>
									<button class="btn yellow" id="invalidBtn"> <i class="icon-remove"></i>无效</button>
									
								</div>
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
									<table>
										<tr>
											<td width="120">客户姓名/手机号：</td>
											<td width="250"><input type="text" id="paras" name="paras" value="${paras }"></td>
											<td width="100">推荐人：</td>
											<td width="250" ><input type="text" id="recommender" name="recommender" value="${recommender }"></td>
											<td >
												
												
											</td>
										</tr>
										<tr>
											<td>客户状态：</td>
											<td>
												<select name="status" id="status">
													<option value="">全部</option>
													<c:forEach items="${cstatusList}" var="cstatus">
														<c:if test="${custStatus == cstatus.dictCode }">
															<option value="${cstatus.dictCode }" selected>${cstatus.name}</option>
														</c:if>
														<c:if test="${custStatus != cstatus.dictCode }">
															<option value="${cstatus.dictCode }">${cstatus.name}</option>
														</c:if>
													</c:forEach>
												</select>
											</td>
											<td>客户来源：</td>
											<td>
												<select name="source" id="source">
													<option value="">全部</option>
													<c:forEach items="${csourceList}" var="csource">
														<c:if test="${custSource == csource.dictCode }">
															<option value="${csource.dictCode }" selected>${csource.name}</option>
														</c:if>
														<c:if test="${custSource != csource.dictCode }">
															<option value="${csource.dictCode }">${csource.name}</option>
														</c:if>
													</c:forEach>
												</select>
											</td>
											<td valign="top">
												<input type="hidden" name="fast" id="fast" value="">
												<button class="btn black" id="searchBtn">查询 <i class="icon-search"></i></button>
												<!-- <a href="/cust/add" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
												<button class="btn green" id="exportBtn" style="display:none;">导出 <i class="icon-signout"></i></button> -->
											</td>
									</table>
									
									<div class="tabbable  boxless">
										<ul class="nav nav-tabs">
											<li <c:if test="${fast == null || fast == ''}">class="active"</c:if>><a href="#" data-toggle="tab" onclick="fastOper('')">全部(${all })</a></li>
											<li <c:if test="${fast == 'assigned'}">class="active"</c:if>><a class="" href="#" data-toggle="tab" onclick="fastOper('assigned')">已分配(${assigned })</a></li>
											<li <c:if test="${fast == 'noAssigned'}">class="active"</c:if>><a class="" href="#" data-toggle="tab" onclick="fastOper('noAssigned')">未分配(${noAssigned })</a></li>
											<li <c:if test="${fast == 'signed'}">class="active"</c:if>><a class="" href="#" data-toggle="tab" onclick="fastOper('signed')">已签约(${signed })</a></li>
											<li <c:if test="${fast == 'invalid'}">class="active"</c:if>><a class="" href="#" data-toggle="tab" onclick="fastOper('invalid')">无效(${invalid })</a></li>
										</ul>
									</div>

									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="45" id="all"><input type="checkbox" /><span>全选</span></th>
												<c:choose>
													<c:when test="${field=='cust.name' && way=='asc'}">
														<th width="80" class="sorting_asc" data-field="cust.name">客户名称</th>
													</c:when>
													<c:when test="${field=='cust.name' && way=='desc'}">
														<th width="80" class="sorting_desc"
															data-field="cust.name">客户名称</th>
													</c:when>
													<c:otherwise>
														<th width="80" class="sorting" data-field="cust.name">客户名称</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='cust.phone_num' && way=='asc'}">
														<th width="100" class="sorting_asc"
															data-field="cust.phone_num">手机号</th>
													</c:when>
													<c:when test="${field=='cust.phone_num' && way=='desc'}">
														<th width="100" class="sorting_desc"
															data-field="cust.phone_num">手机号</th>
													</c:when>
													<c:otherwise>
														<th width="100" class="sorting" data-field="cust.phone_num">手机号</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='cust.gender' && way=='asc'}">
														<th width="30" class="sorting_asc"
															style="text-align: center" data-field="cust.gender">性别</th>
													</c:when>
													<c:when test="${field=='cust.gender' && way=='desc'}">
														<th width="30" class="sorting_desc"
															style="text-align: center" data-field="cust.gender">性别</th>
													</c:when>
													<c:otherwise>
														<th width="30" class="sorting" style="text-align: center"
															data-field="cust.gender">性别</th>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${field=='cust.cust_source' && way=='asc'}">
														<th width="100" class="sorting_asc"
															style="text-align: center" data-field="cust.cust_source">客户来源</th>
													</c:when>
													<c:when test="${field=='cust.cust_source' && way=='desc'}">
														<th width="100" class="sorting_desc"
															style="text-align: center" data-field="cust.cust_source">客户来源</th>
													</c:when>
													<c:otherwise>
														<th width="100" class="sorting" style="text-align: center"
															data-field="cust.cust_source">客户来源</th>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${field=='cust.area' && way=='asc'}">
														<th width="80" class="sorting_asc"
															style="text-align: center" data-field="cust.area">所在地区</th>
													</c:when>
													<c:when test="${field=='cust.area' && way=='desc'}">
														<th width="80" class="sorting_desc"
															style="text-align: center" data-field="cust.area">所在地区</th>
													</c:when>
													<c:otherwise>
														<th width="80" class="sorting" style="text-align: center"
															data-field="cust.area">所在地区</th>
													</c:otherwise>
												</c:choose>
												
												<th width="80"  style="text-align: center;"
															data-field="cust.area">状态</th>
												<!-- 
												<th width="80"  style="text-align: center;"
															data-field="cust.area">归属部门</th> -->
															
												<th width="60"  style="text-align: center"
															data-field="cust.area">负责顾问</th>

												<c:choose>
													<c:when test="${field=='cust.create_time' && way=='asc'}">
														<th width="150" class="sorting_asc"
															style="text-align: center" data-field="cust.create_time">创建时间</th>
													</c:when>
													<c:when test="${field=='cust.create_time' && way=='desc'}">
														<th width="150" class="sorting_desc"
															style="text-align: center" data-field="cust.create_time">创建时间</th>
													</c:when>
													<c:otherwise>
														<th width="150" class="sorting" style="text-align: center"
															data-field="cust.create_time">创建时间</th>
													</c:otherwise>
												</c:choose>

												<th >快捷操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item">
												<tr style="height:40px;">
													<td><input type="checkbox" class="checkboxes"
														value="${item.custinfo_id}" /></td>
													<td data-title="客户名称"><a id="sd" href="/cust/detail/${item.custinfo_id}">${item.name}</a>
													</td>
													<td data-title="手机号">${item.phone_num}</td>
													<td style="text-align: center" data-title="性别">
														<p>
															<c:choose>
																<c:when test="${item.gender == \"m\"}">
																男
															</c:when>
															<c:otherwise>
																女
															</c:otherwise>
															</c:choose>
														</p>
													</td>
													<td style="text-align: center" data-title="客户来源">
														<p>${item.cust_sourceZN}</p>
													</td>
													<td style="text-align: center" data-title="所在地区">
														<p>${item.area}</p>
													</td>
													<td style="text-align: center" data-title="所在地区">
														<p>${item.cust_statusZN}</p>
													</td>
													<!-- 
													<td style="text-align: center" data-title="归属部门">
														<p>${item.cust_source}</p>
													</td> -->
													<td style="text-align: center" data-title="负责顾问">
														<p>${item.user_name}</p>
													</td>
													
													
													<td style="text-align: center" data-title="创建日期">
														<p>
														<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
														
														</p>
													</td>
													<td data-title="操作">
														<div data-id="${item.custinfo_id}">
															<i class="icon-edit">编辑</i>
															<i class="icon-comments" >跟进记录</i>
															<!-- 
															<c:if test="${item.user_name == '' || item.user_name == null}">
																<i class="icon-share" >分配</i>
															</c:if>
															<c:if test="${item.user_name != '' && item.user_name != null}">
																<i class="icon-share" >重新分配</i>
															</c:if>
															<i class="icon-pencil" >签约信息</i>
															<i class="icon-trash m-icon-black">删除</i>
															 -->
														</div>
													</td>
												</tr>
											</c:forEach>
										</tbody>

									</table>
									<input id="field" name="field" type="hidden" /> <input
										id="way" name="way" type="hidden" />
									<div id="pageBar">
										<input type="hidden" id="page" name="page" value="1" />
										${pageBar}
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
																		location.href = "/cust/edit/"
																				+ id;
																	});
												});
								
								//查看客户的沟通记录
								$("i.icon-comments")
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
																location.href = "/cust/followrecord/"
																		+ id;
															});
										});
								//查看签约信息
								$("i.icon-pencil")
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
																location.href = "/cust/signrecord/"
																		+ id;
															});
										});
								
								//分配
								$("i.icon-share")
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
																		location.href = "/cust/assign/"
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
																		if(confirm("确定要删除该客户吗？")){
																			$.post(
																					"/cust/delete",
																					{
																						"id" : id
																					},
																					function(
																							data) {
																						if (data.status == 0) {
																							alert(data.msg);
																							location.reload();
																						} else
																							alert(data.msg);
																					});
																		}
																	});
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
								
								//新增
								$("#addBtn").click(function(e) {
									location.href="/cust/add";
								});
								
								//获取选中行id
								function getSelectedRowIds(){
									var checks = $("input.checkboxes:checked");
									if (checks.size() > 0) {
										var ids = "";
										checks.each(
												function(index,element) {
													if (ids == "")
														ids = $(this).val();
													else {
														ids = ids + "," + $( this) .val();
													}
												});
										return ids;
									} else {
										return "";
									}
								}
								
								
								//分配
								$("#assignBtn").click(function(e) {
									var ids = getSelectedRowIds();
									if (ids != "") {
										//if(confirm("确定将选中的线索分配给同一个人吗?")){
											location.href = "/cust/assign/"+ ids;
										//}
									}else{
										alert("请选择要分配的客户");
									}
									
								});
								
								//无效
								$("#invalidBtn").click(function(e) {
									var ids = getSelectedRowIds();
									if (ids != "") {
										if(confirm("确定将选中的客户置为无效吗?")){
											$.post("/cust/setInvalid",
													{
														"ids":ids
													},
													function(data) {
														if (data.status == 0) {
															alert(data.msg);
															location.reload();
														} else{
															alert(data.msg);
														}
															
													}
											);
										}
										
									} else {
										alert("请选择要置为无效的客户");
									}
								});

							});
			//快捷操作
			function fastOper(v){
				document.getElementById("fast").value = v;
				document.getElementById("searchForm").submit();
			}
			
				
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>