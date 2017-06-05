<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

						<h3 class="page-title">国家管理</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li><a href="/country">国家管理</a><i class="icon-angle-right"></i>
							</li>

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
								<div class="actions" align="left" style="display:none;">
									<a href="/country/add" class="btn blue addnew">
									<i class=" icon-plus"></i> 新增</a>
								</div>
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
									<table border="0">
										<tr>
											<td width="120">国家名：</td>
											<td width="250"><input type="text" id="country_name" name="country_name" value="${country_name}"></td>
											<td width="100"></td>
											<td width="250" ></td>
											<td >
												
												
											</td>
										</tr>
										<tr>
											<td>地理分类：</td>
											<td>
												<select name=continent_name id="continent_name">
													<option value=""></option>
													<c:forEach items="${continent}" var="continent">
															<option value="${continent.name}" <c:if test="${continent_name == continent.name}">selected="selected"</c:if>>${continent.name}</option>
													</c:forEach>
												</select>
											</td>
											<td>发布状态：</td>
											<td>
												<select name="release_status" id="release_status">
													<option value=""></option>
													<option value="0" <c:if test="${release_status == 0}">selected="selected"</c:if>>未发布</option>
													<option value="1" <c:if test="${release_status == 1}">selected="selected"</c:if>>已发布</option>
													<option value="2" <c:if test="${release_status == 2}">selected="selected"</c:if>>已下线</option>
												</select>
											</td>
											<td valign="top">
												<button class="btn black" id="searchBtn">查询 <i class="icon-search"></i></button>
												<a href="/country/add" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
											</td>
									</table>

									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th style="text-align: center" id="all"><span>编号</span></th>
												<th style="text-align: center" data-field="dictionary.name">国家名</th>
												<th style="text-align: center" data-field="coun.english_name">英文名</th>
												<th style="text-align: center"
															data-field="dictionary_continent.name">地理分类</th>
												<th class="" style="text-align: center"
													data-field="coun.hotspots_id">移民目的</th>

												<th style="text-align: center"
													data-field="coun.country_brief">简介</th>
															
												<th style="text-align: center"
															data-field="coun.release_status">发布状态</th>

												<c:choose>
													<c:when test="${field=='coun.release_time' && way=='asc'}">
														<th class="sorting_asc"
															style="text-align: center;" data-field="coun.release_time">发布时间</th>
													</c:when>
													<c:when test="${field=='coun.release_time' && way=='desc'}">
														<th class="sorting_desc"
															style="text-align: center;" data-field="coun.release_time">发布时间</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" style="text-align: center;"
															data-field="coun.release_time">发布时间</th>
													</c:otherwise>
												</c:choose>
												<th style="text-align: center"
															data-field="coun.release_user">操作人</th>
												<th style="text-align: center">快捷操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item" varStatus="status">
												<tr style="height:40px;">
													<td style="text-align: center" data-title="编号">${status.count}</td>
													<td style="text-align: center" data-title="国家名"><a id="sd" href="/country/detail/${item.id}"><u style="color:blue">${item.name}</u></a>
													</td>
													<td style="text-align: center" data-title="英文名">${item.english_name}</td>
													<td style="text-align: center" data-title="地理分类">${item.continent_name}</td>
													<td style="text-align: center;width:100px;" data-title="移民目的">
													<div style="width:100px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="<c:forEach var="hotspot" items="${hotspots}"><c:if test="${fn:contains(item.hotspots_id, hotspot.dictCode)}">${hotspot.name} </c:if></c:forEach>">
														<c:forEach var="hotspot" items="${hotspots}">
															<c:if test="${fn:contains(item.hotspots_id, hotspot.dictCode)}">${hotspot.name}</c:if>
														</c:forEach>
													</div>	
													</td>
													<td style="text-align: center;width:100px;" data-title="简介">
													<div style="width:100px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title=${fn:replace(item.country_brief, '\"', '&quot;')}>
														${fn:replace(item.country_brief, '\"', '&quot;')}
													</div>
													</td>
													<td style="text-align: center" data-title="发布状态">
														<p><c:if test="${item.release_status == 0}">未发布</c:if><c:if test="${item.release_status == 1}">已发布</c:if><c:if test="${item.release_status == 2}">已下线</c:if></p>
													</td>
													
													
													<td style="text-align: center;" data-title="发布时间">
														<fmt:formatDate value="${item.release_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td style="text-align: center" data-title="操作人">
														<p>${item.release_user}</p>
													</td>
													<td style="text-align: center;" data-title="操作">
														<div data-id="${item.id}">
															<a href="/country/edit?coun_id=${item.id}" class="btn green-stripe mini"><i class="icon-edit">编辑</i></a>
															<a class="btn purple-stripe mini" href="#" onclick="del(${item.id})"><i class="icon-trash m-icon-black">删除</i></a>
															 <c:if test="${item.release_status != '1'}">
																<a href="#" onclick="release(${item.id})" class="btn blue-stripe mini"><i class="icon-share" >发布</i></a>
															</c:if>
															<c:if test="${item.release_status == '1'}">
																<a href="#" onclick="offline(${item.id})" class="btn red-stripe mini"><i class="icon-share" >下线</i></a>
															</c:if>
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



		<!-- 模态弹出窗内容 -->

		<div id="add_detail" class="modal hide modal-lg">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"></button>
				<h3 id="boxTitle">客户详情</h3>
			</div>

			<div class="modal-body"></div>

			<div class="modal-footer">
				<a data-dismiss="modal" class="btn ">关闭</a>
				
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
								
								
								
								
								

								//绑定删除按钮
								$("")
										.each(
												function(index, element) {
													$(this)
															.click(
																	function(e) {
																		var id = $(
																				this)
																				.parent()
																				.parent()
																				.attr(
																						"data-id");
																				return false;
																		if(confirm("确定要删除该国家吗？")){
																			$.post(
																					"/country/delete",
																					{
																						"coun_id" : id
																					},
																					function(
																							data) {
																						if (data.code == 0) {
																							alert("删除成功！");
																							location.reload();
																						} else
																							alert("删除失败！");
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

							});
							//发布
							function release(id) {
							if(!id){return false;}
							if(confirm("确定要发布该国家吗？")){
								$.post(
									"/country/release",
									{"coun_id":id},
									function(data){
										if(data.status == 0){
											alert("发布成功！");
											location.reload();
										}else if(data.status == 1){
											alert(data.msg);
										}else if(data.status == 2){
											alert(data.msg);
										}
									}
							)}
							}
							//下线
							function offline(id){
							if(!id){return false;}
							if(confirm("是否要将发布的内容进行下线？")){
								$.post(
									"/country/offline",
									{"coun_id":id},
									function(data){
										if(data.status == 0){
											alert("下线成功！");
											location.reload();
										}else if(data.status == 1){
											alert(data.msg);
										}else if(data.status == 2){
											alert(data.msg);
										}
									}
							)}
							}
							//删除
							function del(id){
							if(!id){return false;}
							if(confirm("确定要删除该国家吗？")){
									$.post(
											"/country/delete",
											{
												"coun_id" : id
											},
											function(
													data) {
												if (data.status == 0) {
													alert("删除成功！");
													location.reload();
												} else if(data.status == 1){
													alert(data.msg);
												}else if(data.status == 2){
													alert(data.msg);
												}
											});
								}
							}
				
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>