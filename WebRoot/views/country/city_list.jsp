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
<!-- 上传图片用到的js -->
<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
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

						<h3 class="page-title">热门城市<i style="font-size: 12px;">（${coun.countryName}）</i></h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li><a href="/country">国家管理</a><i class="icon-angle-right"></i>
							</li>

							<li>热门城市</li>

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
			<div class="row-fluid">
				<!-- END PAGE HEADER-->
				<div class="span12">
				<div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li><a href="/country/add?coun_id=${coun.id}&operation=编辑">基本信息</a></li>
                                <li><a href="/country/countrySurvey?coun_id=${coun.countryId}">国家概况</a></li>
                                <li><a href="/country/livingEnvironment?coun_id=${coun.countryId}">居住环境</a></li>
                                <li><a href="/country/socialWelfare?coun_id=${coun.countryId}">社会福利</a></li>
								<li><a href="/country/educationalLevel?coun_id=${coun.countryId}">教育水准</a></li>
								<li><a href="/country/investHome?coun_id=${coun.countryId}">投资置业</a></li>
								<li><a href="/country/employmentEnvironment?coun_id=${coun.countryId}">就业环境</a></li>
								<li><a href="/country/passportNationality?coun_id=${coun.countryId}">护照国籍</a></li>
								<li class="active"><a href="javascript:;">热门城市</a></li>
								<li><a href="/country/immiPolicy/listPolicy?coun_id=${coun.countryId}">移民政策</a></li>
                            </ul>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box grey">
							<div class="portlet-title" >
								城市列表
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
									<table border="0">
											<tr>
											<td align="right">
												<a href="/country/city/hot/addHotCity?coun_id=${coun_id}" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
											</td>
											</tr>
									</table>

									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th id="all" style="text-align: center"><span>编号</span></th>
													<th style="text-align: center" data-field="city.name">城市名</th>
													<th style="text-align: center"; data-field="city.city_egname">英文名</th>
													<th style="text-align: center"
															data-field="city.description">描述</th>
													<th class="" style="text-align: center"
													data-field="city.thumb_img">图片</th>

												<th style="text-align: left;">快捷操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${citys}" var="item" varStatus="status">
												<tr style="height:40px;">
													<td style="text-align: center" data-title="编号">${status.count}</td>
													<td style="text-align: center" data-title="城市名">${item.city_name}</td>
													<td style="text-align: center" data-title="英文名">${item.city_egname}</td>
													<td style="text-align: center" data-title="描述">${item.description}</td>
													<td style="text-align: center" data-title="图片">
														<div align="center">
															<c:if test="${!empty item.thumb_img}">
																<img src="${item.thumb_img}" style="width:60px;height:30px;">
															</c:if>
															<c:if test="${empty item.thumb_img}">
																<input class="${item.id}" name="standPic" multiple accept="image/*" type="file" style="display: none;">
																<a href="#"  onclick="upload(${item.id})"><u style="color:blue">上传图片</u></a>
															</c:if>
														 </div> 
													</td>
													<td style="text-align: left" data-title="操作">
														<div data-id="${item.id}">
															<a class="btn green-stripe mini"><i class="icon-edit">编辑</i></a>
															<a class="btn purple-stripe mini"><i class="icon-trash m-icon-black">删除</i></a>
															<input type="hidden" id="coun_id" name="coun_id" value="${coun_id}" />
														<input type="hidden" id="coun_name" name="coun_name" value="${coun_name}" />
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
																				.parent()
																				.attr(
																						"data-id");
																		var coun_id = $("#coun_id").val();
																		location.href = "/country/city/hot/editHotCity?city_id="+ id +"&coun_id="+coun_id;
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
																		var id = $(this)
																				.parent()
																				.parent()
																				.attr("data-id");
																		var coun_id = $("#coun_id").val();
																		if(confirm("确定要删除该城市吗？")){
																			$.post(
																					"/country/city/hot/delete",
																					{
																						"city_id" : id,
																						"coun_id" : coun_id 
																					},
																					function(data) {
																						if (data.status == 0) {
																							alert("删除成功！");
																							location.reload();
																						} else{
																							alert(data.msg);
																						}	
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
		var isUpload = true;
		function upload(city_id){
			if(isUpload){
				isUpload = false;
				$("."+city_id).click();
				//缩略图
				$('.'+city_id).change(function() {
					var files = $('.'+city_id).prop('files');
					console.log(files);
					for(var m=0;m<files.length;m++){
						if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
				            alert("图片类型必须是.jpg,png中的一种");
				            isUpload = true;
							location.reload();  
				        }
						if(files[m].size>100*1024){
							alert("图片大小要小于100k");
							isUpload = true;
							location.reload();
						}
					lrz(files[m],{quality :0.3})
					  .then(function (rst) {
						var filename = rst.origin.name;
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":''},
							function(data){
								if(data.status==0){
									$.post("/country/city/hot/uploadPic", {"city_id":city_id,"thumb_img":data.picUrl},
											function(data){
												if(data.status==0){
													alert('上传成功!');
													isUpload = true;
													 location.reload();
													}else{
													isUpload = true;
													alert(data.msg);
													location.reload();
													}
												});
								}
								else {
									isUpload = true;
									alert(data.msg);
									location.reload();
								}
							});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
					}
				});
			}else{
				alert("请勿重复点击！若您取消了文件选择框请刷新页面后再上传！");
			}
		}
		
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>