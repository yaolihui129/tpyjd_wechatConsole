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

	<link rel="stylesheet" type="text/css" href="media/css/datetimepicker.css" />
	<link rel="stylesheet" type="text/css" href="media/css/datepicker.css" />
	<link rel="stylesheet" type="text/css" href="media/css/timepicker.css" />
	
	
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

						<h3 class="page-title">客户签约信息</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li>客户管理<i class="icon-angle-right"></i>
							</li>

							<li>签约信息</li>

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
								<div class="actions" align="left" >
									<a data-toggle="modal" href="#" data-target="#add_sign_record" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
								</div>
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="post">
									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="45" id="all"><input type="checkbox" /><span>全选</span></th>
												<c:choose>
													<c:when test="${field=='cc.name' && way=='asc'}">
														<th width="80" class="sorting_asc" data-field="cc.name">客户姓名</th>
													</c:when>
													<c:when test="${field=='cc.name' && way=='desc'}">
														<th width="80" class="sorting_desc"
															data-field="cc.name">客户姓名</th>
													</c:when>
													<c:otherwise>
														<th width="80" class="sorting" data-field="cc.name">客户姓名</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='ccs.deal_no' && way=='asc'}">
														<th width="150" class="sorting_asc"
															data-field="ccs.deal_no">合同号</th>
													</c:when>
													<c:when test="${field=='ccs.deal_no' && way=='desc'}">
														<th width="150" class="sorting_desc"
															data-field="ccs.deal_no">合同号</th>
													</c:when>
													<c:otherwise>
														<th width="150" class="sorting" data-field="ccs.deal_no">合同号</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='cp.project_name' && way=='asc'}">
														<th width="150" class="sorting_asc"
															style="text-align: center" data-field="cp.project_name">签约项目</th>
													</c:when>
													<c:when test="${field=='cp.project_name' && way=='desc'}">
														<th width="150" class="sorting_desc"
															style="text-align: center" data-field="cp.project_name">签约项目</th>
													</c:when>
													<c:otherwise>
														<th width="150" class="sorting" style="text-align: center"
															data-field="cp.project_name">签约项目</th>
													</c:otherwise>
												</c:choose>

												
													<th width="100" style="text-align: center"
															data-field="ccs.fee">签约费用</th>
												

												<c:choose>
													<c:when test="${field=='ccs.sign_date' && way=='asc'}">
														<th width="100" class="sorting_asc"
															style="text-align: center" data-field="ccs.sign_date">签约日期</th>
													</c:when>
													<c:when test="${field=='ccs.sign_date' && way=='desc'}">
														<th width="100" class="sorting_desc"
															style="text-align: center" data-field="ccs.sign_date">签约日期</th>
													</c:when>
													<c:otherwise>
														<th width="100" class="sorting" style="text-align: center"
															data-field="ccs.sign_date">签约日期</th>
													</c:otherwise>
												</c:choose>

												<th >快捷操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item">
												<tr style="height:40px;">
													<td><input type="checkbox" class="checkboxes"
														value="${item.signed_id}" /></td>
													<td data-title="客户姓名">${item.name}
													</td>
													<td data-title="合同号">${item.deal_no}</td>
													<td style="text-align: center" data-title="签约项目">
														${item.project_name}
													</td>
													<td style="text-align: center" data-title="签约费用">
														${item.fee}
													</td>
													<td style="text-align: center" data-title="签约日期">
														<p><fmt:formatDate value="${item.sign_date }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
													</td>
													<td data-title="操作">
														<div data-id="${item.signed_id}">
															<i class="icon-edit">编辑</i>
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

		<div id="add_sign_record" class="modal hide modal-lg">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true"></button>
				<h3 id="boxTitle">新增签约信息</h3>
			</div>

			<div class="modal-body">
				<form id="addRecord" method="post">
					<table>
						<tr>
							<td>客户姓名</td>
							<td><input type="text" id="custName" name="custName" disabled/></td>
							<td>附申请人</td>
							<td><input type="text" id="applicant" name="applicant"/></td>
						</tr>
						<tr>
							<td>合同号</td>
							<td><input type="text" id="deal_no" name="deal_no"/></td>
							<td>国家</td>
							<td><input type="text" id="country" name="country"/></td>
						</tr>
						<tr>
							<td>签约项目</td>
							<td><input type="text" id="project_id" name="project_id"/></td>
							<td>合作方</td>
							<td><input type="text" id="partner" name="partner"/></td>
						</tr>
						<tr>
							<td>服务律师</td>
							<td><input type="text" id="service_lawyer" name="service_lawyer"/></td>
							<td>服务费</td>
							<td><input type="text" id="service_fee" name="service_fee"/></td>
						</tr>
						<tr>
							<td>签约金额</td>
							<td><input type="text" id="fee" name="fee"/></td>
							<td>签约日期</td>
							<td><input type="text" id="sign_date" name="sign_date"/></td>
						</tr>
						<tr>
							<td>支付方式</td>
							<td><input type="text" id="paycode" name="paycode"/></td>
							<td>备注</td>
							<td><input type="text" id="remark" name="remark"/></td>
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
																					"/cust/signrecord/delete",
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
									var applicant = $("#applicant").val();
									var deal_no = $("#deal_no").val();
									var country = $("#country").val();
									var projectId = $("#project_id").val();
									var partner = $("#partner").val();
									var service_lawyer = $("#service_lawyer").val();
									var service_fee = $("#service_fee").val();
									var fee = $("#fee").val();
									var sign_date = $("#sign_date").val();
									var paycode = $("#paycode").val();
									var remark = $("#remark").val();
									
									if(custId == null || custId == ""){
										alert("客户ID为空");
										return;
									}
									
									
									$.post(
											"/cust/signrecord/add",
											{
												"custId" : custId,
												"applicant" : applicant,
												"dealNo" : deal_no,
												"country" : country,
												"projectId" : projectId,
												"partner" : partner,
												"serviceLawyer" : service_lawyer,
												"serviceFee" : service_fee,
												"fee" : fee,
												"signDate" : sign_date,
												"paycode" : paycode,
												"remark" : remark
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
													var applicant = $("#applicant").val();
													var deal_no = $("#deal_no").val();
													var country = $("#country").val();
													var projectId = $("#project_id").val();
													var partner = $("#partner").val();
													var service_lawyer = $("#service_lawyer").val();
													var service_fee = $("#service_fee").val();
													var fee = $("#fee").val();
													var sign_date = $("#sign_date").val();
													var paycode = $("#paycode").val();
													var remark = $("#remark").val();
													
													if(custId == null || custId == ""){
														alert("客户ID为空");
														return;
													}
													
													
													$.post(
															"/cust/signrecord/add",
															{
																"custId" : custId,
																"applicant" : applicant,
																"dealNo" : deal_no,
																"country" : country,
																"projectId" : projectId,
																"partner" : partner,
																"serviceLawyer" : service_lawyer,
																"serviceFee" : service_fee,
																"fee" : fee,
																"signDate" : sign_date,
																"paycode" : paycode,
																"remark" : remark
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