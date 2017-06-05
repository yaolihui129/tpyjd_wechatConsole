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

							<li><a href="/cooperation">商务合作</a><i class="icon-angle-right"></i>
							</li>

							<li>商务合作进度</li>

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
						<div class="portlet box">
						
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
								<div><b>合作进度</b></div>
									<table>
										<tr bgcolor="grey"><td width="15%">申请资料</td><td></td><td></td></tr>
									</table>
									<table style="border-collapse:separate; border-spacing:10px;">
									<tr><td width="13%">申请人：</td><td width="20%">${cooperation.applicant_name}</td><td width="13%">联系电话：</td><td width="20%">${cooperation.applicant_phone}</td><td width="13%">合作方式：</td><td width="20%"><c:if test="${cooperation.cooperation_mode == 1}">地方子公司</c:if><c:if test="${cooperation.cooperation_mode == 2}">事业合伙人</c:if></td></tr>
									
									<tr><td width="13%">所在省份：</td><td width="20%">${cooperation.applicant_province}</td><td width="13%">所在城市：</td><td width="20%">${cooperation.applicant_city}</td><td width="13%">处理状态：</td><td width="20%"><c:if test="${cooperation.treatment_status == 0}">已提交</c:if><c:if test="${cooperation.treatment_status == 1}">洽谈中</c:if><c:if test="${cooperation.treatment_status == 2}">合作已达成</c:if><c:if test="${cooperation.treatment_status == 3}">合作未达成</c:if></td></tr>
									
									<tr><td width="13%">洽谈状态：</td><td width="20%"><c:if test="${cooperation.negotiation_status == 0}">等待洽谈</c:if><c:if test="${cooperation.negotiation_status == 1}">初步洽谈</c:if><c:if test="${cooperation.negotiation_status == 2}">深度沟通</c:if><c:if test="${cooperation.negotiation_status == 3}">确定合作意愿</c:if></td><td width="13%">提交时间：</td><td width="20%"><fmt:formatDate value="${cooperation.submit_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td><td width="13%">提交用户：</td><td width="20%"><script type="text/javascript">document.write(decodeURI("${cooperation.wx_name }"));</script></td></tr>
									</table>
									<table>
										<tr bgcolor="grey"><td width="15%">洽谈进度</td><td></td><td></td></tr>
									</table>
									<table style="border-collapse:separate; border-spacing:10px;" <c:if test="${cooperation.negotiation_status == 3}">hidden</c:if>>
										<tr><td width="13%">洽谈状态：</td>
										<td width="30%">
										<b style="color:red">*</b>
										<select id="negotiation_status">
											<option value=""></option>
											<c:if test="${cooperation.negotiation_status < 2}">
											<option value="1">初步洽谈</option>
											</c:if>
											<c:if test="${cooperation.negotiation_status < 3}">
											<option value="2">深度沟通</option>
											</c:if>
											<c:if test="${cooperation.negotiation_status < 3}">
											<option value="3">确定合作意愿</option>
											</c:if>
										</select>
										</td>
										<td width="10%">
										<c:if test="${cooperation.treatment_status == '0' || cooperation.treatment_status == '1'}">
											<c:if test="${cooperation.negotiation_status == '0' || cooperation.negotiation_status == '1' || cooperation.negotiation_status == '2'}"> 
											<a id="addNegotiation">添加</a>
											</c:if>
										</c:if>	
										</td>
										<td><input type="hidden" id="cooperation_id" value="${cooperation.id}"/></td>
										</tr>
										<tr>
										<td width="13%" height="50">说明：</td>
										<td width="30%"><b style="color:red">*</b><textarea id="negotiation_explain" rows="3" cols="3" onscroll="true"></textarea></td>
										<td></td>
										<td></td>
										</tr>
									</table>
									<br/>
									<table border="1" style="border-color:#E8E8E8;margin-left:120px;width:580px">
									<thead><tr><th width="5%">编号</th><th width="10%">洽谈状态</th><th width="15%">说明</th><th width="10%">洽谈时间</th><th width="5%">跟进人</th></tr></thead>
									<c:forEach items="${listpro}" var="progress">
										<tr><td>${progress.rownum}</td><td><c:if test="${progress.negotiation_status == 0}">等待洽谈</c:if><c:if test="${progress.negotiation_status == 1}">初步洽谈</c:if><c:if test="${progress.negotiation_status == 2}">深度沟通</c:if><c:if test="${progress.negotiation_status == 3}">确定合作意愿</c:if></td><td>${progress.negotiation_explain}</td><td><fmt:formatDate value="${progress.negotiation_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td><td>${progress.negotiation_user}</td></tr>
									</c:forEach>
									</table>
									<br/>
									<table>
										<tr bgcolor="grey"><td width="15%">处理结果</td><td></td><td></td></tr>
									</table>
									
									<table style="border-collapse:separate; border-spacing:10px;">
										<tr><td width="13%">处理结果：</td>
										<td>
										<div class="control-group">
											<div class="controls">
											<b style="color:red">*</b>
										<label class="radio">
											<input type="radio" name="treatment_status" value="2" <c:if test="${cooperation.treatment_status == '2'}">checked="checked"</c:if> <c:if test="${cooperation.treatment_status == '3'}">disabled</c:if>/>合作已达成 
										</label>
										<label class="radio">
											<input type="radio" name="treatment_status" value="3" <c:if test="${cooperation.treatment_status == '3'}">checked="checked"</c:if> <c:if test="${cooperation.treatment_status == '2'}">disabled</c:if>/>合作未达成
										</label>	
										</div>
										</div>
										</td>
										<td></td>
										<td></td>
										</tr>
										<tr>
										<td width="13%" height="50">备注说明：</td>
										<td width="50%"><b style="color:red">*</b><textarea id="treatment_explain" rows="3" cols="3" onscroll="true" <c:if test="${cooperation.treatment_status == '2'}">disabled</c:if><c:if test="${cooperation.treatment_status == '3'}">disabled</c:if>>${cooperation.treatment_explain}</textarea></td>
										<td></td>
										<td></td>
										</tr>
										<c:if test="${cooperation.treatment_status == '2' || cooperation.treatment_status == '3'}">
										<tr><td width="13%">时间：</td>
										<td width="30%">
										<input type="text" readonly="readonly" id="treatment_time" value="<fmt:formatDate value="${cooperation.treatment_time}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
										</td>
										<td width="13%">操作人：</td>
										<td width="30%">
										<input type="text" readonly="readonly" id="treatment_operator" value="${cooperation.treatment_operator}"/>
										</td>
										</c:if>
										<tr>
										<c:if test="${cooperation.treatment_status == '0' || cooperation.treatment_status == '1'}">
										<td width="13%"></td>
										<td width="30%">
										<input id="submitTreatment" type="button" style="color:blue" value="提交"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;										<input id="cancle" type="button" style="color:grey" value="取消"/>
										</td>
										</c:if>
										</tr>
									</table>
									
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
								//搜索触发
								$("#addNegotiation").click(function(e) {
									addNegotiation();
								});
								//提交处理结果
								$("#submitTreatment").click(function(e) {
									submitTreatment();
								});
								//取消
								$("#cancle").click(function(e) {
									cancle();
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
																location.href = "/cooperation/editProgress/"
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
																location.href = "/cooperation/viewProgress/"
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
								
								//添加洽谈进度
								function addNegotiation(){
									var negotiation_status = $("#negotiation_status").val();
									var negotiation_explain = $("#negotiation_explain").val();
									var cooperation_id = $("#cooperation_id").val();
									if(negotiation_explain == "" || negotiation_explain == null){
										alert("请填写洽谈说明后提交！");
										return;
									}
									var data = '{"negotiation_status":'+negotiation_status+',"negotiation_explain":'+negotiation_explain+'}';
									$.post(
										"/cooperation/addProgress",
										{
											"negotiation_status":negotiation_status,
											"negotiation_explain":negotiation_explain,
											"cooperation_id":cooperation_id
										},
										function (data) {
											if ( data.status == 0 ) {
												alert("添加成功！");
												location.href = "/cooperation/progress/"+cooperation_id;
											}else{
												alert(data.msg);
											}
											
										}
									);
								}
								
								//提交处理结果
								function submitTreatment(){
									var treatment_status = $("input[name='treatment_status']");
									 for (var i = 0; i < treatment_status.length; i++) {
							                if (treatment_status[i].checked == true) {
							                	treatment_status = treatment_status[i].value;
							                }
							            }
									var treatment_explain = $("#treatment_explain").val();
									var cooperation_id = $("#cooperation_id").val();
									if(treatment_status == '3'){
										 if(!treatment_explain){
											 alert("合作未成功时需添加备注！");
											 return;
										 }
									 }
									$.post(
										"/cooperation/addTreatment",
										{
											"treatment_status":treatment_status,
											"treatment_explain":treatment_explain,
											"cooperation_id":cooperation_id	
										},
										function (data) {
											if ( data.status == 0 ) {
												alert("添加成功！");
												location.href = "/cooperation/progress/"+cooperation_id;
											}else{
												alert(data.msg);
											}
											
										}
									);
									
								}
								
								function cancle(){
									location.href = "/cooperation"
								}

							});
				
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>