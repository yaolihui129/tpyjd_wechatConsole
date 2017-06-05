<%@page import="java.net.URLDecoder"%>
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

						<h3 class="page-title">商务合作</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li><a href="/cooperation">商务合作</a>
							</li>

							<!-- <li><i class="icon-angle-right"></i>商务合作列表</li> -->

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
											<td width="80">地区：</td>
											<td width="250">
											
											<select name="applicant_province" id="applicant_province" style="width:42%">
												<option value="">省份</option>
												<c:forEach items="${provinces}" var="province">
														<option value="${province.name}" id="${province.dictCode}" <c:if test="${applicant_province == province.name}">selected</c:if>>${province.name}</option>
												</c:forEach>
											</select>
											
											<select name="applicant_city" id="applicant_city" style="width:43%">
												<option value="">城市</option>
												<c:forEach items="${citys}" var="city">
														<option value="${city.name}" <c:if test="${applicant_city == city.name}">selected</c:if>>${city.name}</option>
													</c:forEach>
											</select>
											
											<%-- <input type="text" id="country_name" name="country_name" value="${country_name}"></td> --%>
											<td width="80">合作方式：</td>
											<td width="250">
												<select name="cooperation_mode" id="cooperation_mode">
													<option value="" >全部</option>
													<option value="1" <c:if test="${cooperation_mode == '1'}">selected</c:if>>地方子公司</option>
													<%-- <option value="2" <c:if test="${cooperation_mode == '2'}">selected</c:if>>事业合伙人</option> --%>
												</select>
											</td>
										</tr>
										<tr>
											
											<td>状态：</td>
											<td>
												<select name="treatment_status" id="treatment_status">
													<option value="">全部</option>
													<option value="0" <c:if test="${treatment_status == '0'}">selected</c:if>>已提交</option>
													<option value="1" <c:if test="${treatment_status == '1'}">selected</c:if>>洽谈中</option>
													<option value="2" <c:if test="${treatment_status == '2'}">selected</c:if>>合作已达成</option>
													<option value="3" <c:if test="${treatment_status == '3'}">selected</c:if>>合作未达成</option>
												</select>
											</td>
											<td>联系电话：</td>
											<td>
												<input type="text" id="applicant_phone" name="applicant_phone" value="${applicant_phone}">
											</td>
											<td valign="top">
												<button class="btn blue" id="searchBtn">查询 </button>
											</td>
									</table>

									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="45" style="text-align: center"><span>序号</span></th>
														<th width="80" style="text-align: center" data-field="business_cooperation.applicant_name">姓名</th>
														<th width="100" style="text-align: center" data-field="business_cooperation.applicant_phone">联系电话</th>
														<th width="120" style="text-align: center"
															data-field="business_cooperation.applicant_province">省份</th>

														<th width="120" style="text-align: center"
															data-field="business_cooperation.applicant_city">城市</th>
												<c:choose>
													<c:when test="${field=='business_cooperation.cooperation_mode' && way=='asc'}">
														<th width="100" class="sorting_asc" style="text-align: center" data-field="business_cooperation.cooperation_mode">合作方式</th>
													</c:when>
													<c:when test="${field=='business_cooperation.cooperation_mode' && way=='desc'}">
														<th width="100" class="sorting_desc" style="text-align: center"
															data-field="business_cooperation.cooperation_mode">合作方式</th>
													</c:when>
													<c:otherwise>
														<th width="100" class="sorting" style="text-align: center" data-field="business_cooperation.cooperation_mode">合作方式</th>
													</c:otherwise>
												</c:choose>
															
												<th width="100"  style="text-align: center"
															data-field="business_cooperation.treatment_status">状态</th>

												<c:choose>
													<c:when test="${field=='business_cooperation.submit_time' && way=='asc'}">
														<th width="90" class="sorting_asc"
															style="text-align: center" data-field="business_cooperation.submit_time">提交时间</th>
													</c:when>
													<c:when test="${field=='business_cooperation.submit_time' && way=='desc'}">
														<th width="90" class="sorting_desc"
															style="text-align: center" data-field="business_cooperation.submit_time">提交时间</th>
													</c:when>
													<c:otherwise>
														<th width="90" class="sorting" style="text-align: center"
															data-field="business_cooperation.submit_time">提交时间</th>
													</c:otherwise>
												</c:choose>
												<th width="150"  style="text-align: center"
															data-field="business_cooperation.submit_user">提交用户</th>
												<th width="110" style="text-align: center">操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
										<% int i = 0; %>
											<c:forEach items="${list}" var="item">
												<tr style="height:12px;">
													<td data-title="序号" style="text-align: center"><%=++i%></td>
													<td data-title="姓名" style="text-align: center">${item.applicant_name}
													</td>
													<td data-title="联系电话" style="text-align: center">${item.applicant_phone}</td>
													<td style="text-align: center" data-title="省份">${item.applicant_province}</td>
													<td style="text-align: center" data-title="城市">
														<p>${item.applicant_city}</p>
													</td>
													<c:choose>
														<c:when test="${item.cooperation_mode==2}">
														<td style="text-align: center" data-title="合作方式">
															<p>事业合伙人</p>
														</td>
														</c:when>
														<c:when test="${item.cooperation_mode==1}">
														<td style="text-align: center" data-title="合作方式">
															<p>地方子公司</p>
														</td>
														</c:when>
													</c:choose>
													
													<c:choose>
														<c:when test="${item.treatment_status==0}">
														<td style="text-align: center" data-title="状态">
														<p>已提交</p>
														</td>
														</c:when>
														<c:when test="${item.treatment_status==1}">
														<td style="text-align: center" data-title="状态">
														<p>洽谈中</p>
														</td>
														</c:when>
														<c:when test="${item.treatment_status==2}">
														<td style="text-align: center" data-title="状态">
														<p>合作已达成</p>
														</td>
														</c:when>
														<c:otherwise>
														<td style="text-align: center" data-title="状态">
														<p>合作未达成</p>
														</td>
														</c:otherwise>
													</c:choose>
													
													
													
													<td style="text-align: center" data-title="提交时间">
														<p>
														<fmt:formatDate value="${item.submit_time}" pattern="yyyy-MM-dd"/>
														</p>
													</td>
													<td style="text-align: center" data-title="提交用户">
														<p><script type="text/javascript">
															document.write(decodeURI("${item.wx_name }"))
															</script>
														</p>
													</td>
													<td data-title="操作">
														<div data-id="${item.id}">
															<c:if test="${item.treatment_status == '0' || item.treatment_status == '1'}">
																<i class="icon-pencil" ><a>编辑进度</a></i>
															</c:if>
															<c:if test="${item.treatment_status == '2' || item.treatment_status == 3}">
																<i class="icon-search" ><a>查看进度</a></i>
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
																location.href = "/cooperation/progress/"
																		+ id;
															});
										});
								//查看签约信息
								$("i.icon-search")
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
																location.href = "/cooperation/progress/"
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

							});

			
				
		</script>
<script type="text/javascript">
	$("#applicant_province").change(function(){
		 var applicant_province = $("#applicant_province").find("option:selected").attr("id");
		 var provinceName = $("#applicant_province").find("option:selected").text();
			 $.post(
	                 "/city/" + applicant_province,
	                 function (data) {
	                     //			   			console.log(data)
	                     if (data) {
	                    	 $("#applicant_city").empty();
	                         $("#applicant_city").val("");
	                         $("#applicant_city").append($("<option value=''></option>"));
	                         for (i = 0; i < data.citys.length; i++) {
	                             var city_li = $("<option value='" + data.citys[i].name + "'>" + data.citys[i].name + "</option>");
	                             $("#applicant_city").append(city_li);
	                         }
	                     }
	                 }
	             );
	});
</script>


		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>