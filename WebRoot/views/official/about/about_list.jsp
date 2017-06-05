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
<meta content="" name="author" />
<link rel="stylesheet" type="text/css"
	href="/views/media/css/bootstrap-tree.css" />
<link rel="stylesheet" type="text/css"
	href="/views/media/css/DT_bootstrap.css" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="/views/media/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="/views/media/css/bootstrap-responsive.min.css"
	rel="stylesheet" type="text/css" />
<link href="/views/media/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="/views/media/css/style-metro.css" rel="stylesheet"
	type="text/css" />
<link href="/views/media/css/style.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style-responsive.css" rel="stylesheet"
	type="text/css" />
<link href="/views/media/css/default.css" rel="stylesheet"
	type="text/css" id="style_color" />
<link href="/views/media/css/uniform.default.css" rel="stylesheet"
	type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css"
	href="/views/media/css/select2_metro.css" />
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@ include file="/views/navi.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@ include file="/views/menus.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="page-title">关于我们</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li>移民官网 - 关于我们</li>
							<li class="pull-right no-text-shadow">
								<div class="portlet-body form">
									<div id="dashboard-report-range"
										class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
										data-tablet="" data-desktop="tooltips" data-placement="top"
										data-original-title="Change dashboard date range">
										<i class="icon-calendar"></i> <span></span> <i
											class="icon-angle-down"></i>
									</div>
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
							<div class="portlet-title">
								<div class="caption">
									<i class="icon-list"></i>
								</div>
							</div>


							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="post">

									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th style="width: 30px;">编号</th>
												<th>导航名称</th>
												<th>URL地址</th>
												<th>操作</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${aboutlist}" var="item" varStatus="status">
												<tr style="height: 40px;">
													<th>${status.index + 1}</th>
													<td data-title="导航名称">${item.navName}</td>
													<td data-title="URL地址">${item.navUrl}</td>
													<td data-title="操作">
														<div data-id="${item.oanId}" data-navName="${item.navName}" data-navUrl="${item.navUrl}">
															<c:if test="${status.index != 0 }">
																<a class="btn blue-stripe mini"><i
																	class="icon-long-arrow-up">上移</i></a>
															</c:if>
															<c:if test="${!status.last }">
																<a class="btn red-stripe mini"><i
																	class="icon-long-arrow-down">下移</i></a>
															</c:if>
															<c:if test="${item.editEnable == 1}">
																<a class="btn green-stripe mini"><i
																	class="icon-edit">编辑</i> </a>
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
		<%@ include  file="/views/footer.jsp"%>
		<!-- END FOOTER -->

		<!-- 模态弹出窗内容 -->

		<div id="aboutNavBox" class="modal hide fade" data-focus-on="input:first" aria-labelledby="mySmallModalLabel" >
	    	<form>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
					<h3 id="boxTitle_add">关于我们导航设置</h3>
				</div>
	
				<div class="modal-body">
					<table>
						<tr>
							<td width="100" align="right">导航名称：</td>
							<td>
								<input name="oan_id" id="oan_id" type="hidden" data-tabindex="1" value=""/>
								<input name="nav_name" id="nav_name" maxlength="20" placeholder="导航名称" class="m-wrap span4" type="text" data-tabindex="1" value=""/>
							</td>
						</tr>
						<tr>
							<td width="100" align="right">URL地址：</td>
							<td>
								<input name="nav_url" id="nav_url" maxlength="200" placeholder="URL链接地址" class="m-wrap span4" type="text" data-tabindex="1" value=""/>
							</td>
						</tr>
					</table>
	   			</div>
	
				<div class="modal-footer">
					<a id="saveBtn" class="btn red">保存</a>
					<a data-dismiss="modal" class="btn" id="btnClose">取消</a>
				</div>
			</form>
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
	<!--下拉输入必须-->
	<script type="text/javascript"
		src="/views/media/js/jquery.dataTables.js"></script>
	<script type="text/javascript"
		src="/views/media/js/bootstrap-datetimepicker.js"></script>
	<!--下拉输入必须-->
	<script type="text/javascript"
		src="/views/media/js/jquery.inputmask.bundle.min.js"></script>
	<script type="text/javascript"
		src="/views/media/js/jquery.input-ip-address-control-1.0.min.js"></script>
	<script type="text/javascript"
		src="/views/media/js/jquery.multi-select.js"></script>
	<!--<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>-->

	<!-- END PAGE LEVEL PLUGINS -->

	<script src="/views/media/js/form-components.js"></script>
	<!--下拉输入必须-->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js"></script>
	<script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>

	<script>
		jQuery(document).ready(function() {
			App.init(); // initlayout and core plugins

			//绑定内容编辑
			$("i.icon-edit").each(function(index, element) {
				$(this).click(function(e) {
					var id = $(this).parent().parent().attr("data-id");
					var navName = $(this).parent().parent().attr("data-navName");
					var navUrl = $(this).parent().parent().attr("data-navUrl");
					
					$("#oan_id").val(id);
					$("#nav_name").val(navName);
					$("#nav_url").val(navUrl);
					$("#aboutNavBox").modal();
				});
			});
			
			//绑定上移按钮
			$("i.icon-long-arrow-up").each(function(index, element) {
				$(this).click(function(e){
					var id = $(this).parent().parent().attr("data-id");

					$.post("/official/about/upsort",{"id":id},function(data){
						if(data.status==0){
							window.location.reload();
						}else if(data.status == 2){
							alert(data.msg);
						}
						else
							alert("上移失败");
					});
				});		
            });
		//绑定下移按钮
			$("i.icon-long-arrow-down").each(function(index, element) {
				$(this).click(function(e){
					var id = $(this).parent().parent().attr("data-id");
					$.post("/official/about/downsort",{"id":id},function(data){
						if(data.status==0){
							window.location.reload();
						}else if(data.status == 2){
							alert(data.msg);
						}
						else
							alert("下移失败");
					});
				});		
            });	
		
			//保存编辑
			$("#saveBtn").click(function(e) {
				if($("#nav_name").val().trim() == ""){
					alert("导航名称不能为空")
				}else if($("#nav_url").val().trim() == ""){
					alert("导航URL不能为空")
				}else{
					$.post("/official/about/edit",{"oan_id":$("#oan_id").val(),"nav_name":$("#nav_name").val(),"nav_url":$("#nav_url").val()},function(data){
						if(data.status==0){
							alert("保存成功");
			               	$("#btnClose").click();
							window.location.reload();
						}else if(data.status == 2){
							alert(data.msg);
						}
						else
							alert("保存失败");
					});
				}
            });

		});
	</script>


	<!-- END BODY -->
</html>