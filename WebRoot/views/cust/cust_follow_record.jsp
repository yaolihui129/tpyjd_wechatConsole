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
<meta content="" name="author" />
<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>
<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
<link rel="stylesheet" type="text/css" href="media/css/datetimepicker.css" />
<link rel="stylesheet" type="text/css" href="media/css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="media/css/timepicker.css" />
<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />
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

						<h3 class="page-title">客户沟通记录</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li>客户管理<i class="icon-angle-right"></i>
							</li>

							<li>沟通记录</li>

							<li class="pull-right no-text-shadow">

								

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
								<div class="actions" align="left" >
									<a data-toggle="modal" href="#" data-target="#add_follow_record" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
								</div>
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
									
									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="45" id="all" style="display:none;"><input type="checkbox" /><span>全选</span></th>
												<c:choose>
													<c:when test="${field=='cfr.title' && way=='asc'}">
														<th width="150" class="sorting_asc" data-field="cfr.title">沟通主题</th>
													</c:when>
													<c:when test="${field=='cfr.title' && way=='desc'}">
														<th width="150" class="sorting_desc"
															data-field="cfr.title">沟通主题</th>
													</c:when>
													<c:otherwise>
														<th width="150" class="sorting" data-field="cfr.title">沟通主题</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='cfr.remark' && way=='asc'}">
														<th width="150" class="sorting_asc"
															data-field="cfr.remark">描述</th>
													</c:when>
													<c:when test="${field=='cfr.remark' && way=='desc'}">
														<th width="150" class="sorting_desc"
															data-field="cfr.remark">描述</th>
													</c:when>
													<c:otherwise>
														<th width="150" class="sorting" data-field="cfr.remark">描述</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='cfr.remark' && way=='asc'}">
														<th width="75" class="sorting_asc"
															style="text-align: center" data-field="cfr.remark">沟通类型</th>
													</c:when>
													<c:when test="${field=='cfr.remark' && way=='desc'}">
														<th width="75" class="sorting_desc"
															style="text-align: center" data-field="cfr.remark">沟通类型</th>
													</c:when>
													<c:otherwise>
														<th width="75" class="sorting" style="text-align: center"
															data-field="cfr.remark">沟通类型</th>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${field=='cfr.start_time' && way=='asc'}">
														<th width="100" class="sorting_asc"
															style="text-align: center" data-field="cfr.start_time">开始时间</th>
													</c:when>
													<c:when test="${field=='cfr.start_time' && way=='desc'}">
														<th width="100" class="sorting_desc"
															style="text-align: center" data-field="cfr.start_time">开始时间</th>
													</c:when>
													<c:otherwise>
														<th width="100" class="sorting" style="text-align: center"
															data-field="cfr.start_time">开始时间</th>
													</c:otherwise>
												</c:choose>

												<c:choose>
													<c:when test="${field=='cfr.end_time' && way=='asc'}">
														<th width="100" class="sorting_asc"
															style="text-align: center" data-field="cfr.end_time">结束时间</th>
													</c:when>
													<c:when test="${field=='cfr.end_time' && way=='desc'}">
														<th width="100" class="sorting_desc"
															style="text-align: center" data-field="cfr.end_time">结束时间</th>
													</c:when>
													<c:otherwise>
														<th width="100" class="sorting" style="text-align: center"
															data-field="cfr.end_time">结束时间</th>
													</c:otherwise>
												</c:choose>
												<!-- 
												<th width="80"  style="text-align: center;"
															data-field="cust.area">归属部门</th> -->
															
												<th width="80"  style="text-align: center">客户状态</th>

												<c:choose>
													<c:when test="${field=='cfr.create_time' && way=='asc'}">
														<th width="80" class="sorting_asc"
															style="text-align: center" data-field="cfr.create_time">记录日期</th>
													</c:when>
													<c:when test="${field=='cfr.create_time' && way=='desc'}">
														<th width="80" class="sorting_desc"
															style="text-align: center" data-field="cfr.create_time">记录日期</th>
													</c:when>
													<c:otherwise>
														<th width="80" class="sorting" style="text-align: center"
															data-field="cfr.create_time">记录日期</th>
													</c:otherwise>
												</c:choose>
												<th width="60"  style="text-align: center">记录人</th>

												<th >快捷操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item">
												<tr style="height:40px;">
													<td style="display:none;"><input type="checkbox" class="checkboxes"
														value="${item.follow_record_id}" /></td>
													<td data-title="沟通主题">${item.title}
													</td>
													<td data-title="描述">${item.remark}</td>
													<td style="text-align: center" data-title="沟通类型">
														${item.remark}
													</td>
													<td style="text-align: center" data-title="开始时间">
														<p><fmt:formatDate value="${item.start_time }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
													</td>
													<td style="text-align: center" data-title="结束时间">
														<p><fmt:formatDate value="${item.end_time }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
													</td>
													
													<td style="text-align: center" data-title="客户状态">
														<p>${item.cust_status}</p>
													</td>
													
													
													<td style="text-align: center" data-title="记录日期">
														<p>
														<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd"/>
														
														</p>
													</td>
													<td style="text-align: center" data-title="记录人">
														<p>
														<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
														
														</p>
													</td>
													<td data-title="操作">
														<div data-id="${item.follow_record_id}">
															<!-- <i class="icon-edit">编辑</i>  -->
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

		<div id="add_follow_record" class="modal hide modal-lg">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"></button>
				<h3 id="boxTitle">新增沟通记录</h3>
			</div>

			<div class="modal-body">
				<form id="addRecord" action="/cust/followrecord/add" method="post">
					<table>
						<tr>
							<td>主题</td>
							<td><input type="text" id="title" name="title" class="m-wrap span3"/></td>
						</tr>
						<tr>
							<td>描述</td>
							<td><textarea name="remark" id="remark" cols="50" rows="2" class="m-wrap span3"></textarea></td>
						</tr>
						<tr>
							<td>开始时间</td>
							<td>
							<input type="text" id="start_time" name="start_time" 
															value="<fmt:formatDate value="${curTime }" pattern="YYYY-MM-DD hh:mm:ss"/>"
															class="m-wrap span3 laydate-icon" placeholder="YYYY-MM-DD hh:mm:ss" 
															onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
							</td>
						</tr>
						<tr>
							<td>结束时间</td>
							<td>
							<input type="text" id="end_time" name="end_time" 
															value="<fmt:formatDate value="${curTime }" pattern="YYYY-MM-DD hh:mm:ss"/>"
															class="m-wrap span3 laydate-icon" placeholder="YYYY-MM-DD hh:mm:ss" 
															onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
							</td>
						</tr>
						<tr>
							<td>沟通方式</td>
							<td>
								<select class="medium m-wrap" id="follow_type" name="follow_type">
									<c:forEach items="${followType}" var="follow">
										<option value="${follow.dictCode }">${follow.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td>客户状态</td>
							<td>
								<select class="medium m-wrap" id="cust_status" name="cust_status">
									<c:forEach items="${statusList}" var="custStatus">
										<option value="${custStatus.dictCode }">${custStatus.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td>客户类型</td>
							<td>
								<select class="medium m-wrap" id="cust_type" name="cust_type">
									<c:forEach items="${typeList}" var="type">
										<option value="${type.dictCode }">${type.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
					<input type="hidden" id="custId" name="custId" value="${custId }"/>
				</form>
			
			</div>

			<div class="modal-footer">
				<a id="btnSave" class="btn blue"><i class="icon-ok"></i> 保存</a>
				<a id="btnSaveNext" class="btn green"><i class=" icon-plus-sign-alt"></i> 继续新增</a>
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
		
		
		<script type="text/javascript" src="media/js/bootstrap-datetimepicker.js"></script>
		<script type="text/javascript" src="media/js/bootstrap-datepicker.js"></script>
		<script type="text/javascript" src="media/js/bootstrap-timepicker.js"></script>
		<script type="text/javascript" src="media/js/date.js"></script>
		<script type="text/javascript" src="media/js/daterangepicker.js"></script> 
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
																		if(confirm("确定要删除该记录吗？")){
																			$.post(
																					"/cust/followrecord/delete",
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
								
								
								//保存沟通记录
								$("#btnSave").click(function(e) {
									var custId = $("#custId").val();
									var title = $("#title").val();
									var remark = $("#remark").val();
									var start_time = $("#start_time").val();
									var end_time = $("#end_time").val();
									
									if(custId == null || custId == ""){
										alert("客户ID为空");
										return;
									}
									
									
									$.post(
											"/cust/followrecord/add",
											{
												"custId" : custId,
												"title" : title,
												"remark" : remark,
												"start_time" : start_time,
												"end_time" : end_time
											},
											function(data) {
												if (data.status == 0) {
													alert(data.msg);
													location.reload();
												} else
													alert(data.msg);
											});
								});
								
								
								//保存并继续
								$("#btnSaveNext")
										.click(
												function(e) {

													var custId = $("#custId").val();
													var title = $("#title").val();
													var remark = $("#remark").val();
													var start_time = $("#start_time").val();
													var end_time = $("#end_time").val();
													
													if(custId == null || custId == ""){
														alert("客户ID为空");
														return;
													}
													
													
													$.post(
															"/cust/followrecord/add",
															{
																"custId" : custId,
																"title" : title,
																"remark" : remark,
																"start_time" : start_time,
																"end_time" : end_time
															},
															function(data) {
																if (data.status == 0) {
																	alert(data.msg);
																	clearForm();
																} else
																	alert(data.msg);
															});
												});

							});

			//清空输入信息
			function clearForm(){
				document.getElementById("title").value = "";
				document.getElementById("remark").value = "";
			}
				
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>