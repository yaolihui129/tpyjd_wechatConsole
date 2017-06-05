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

						<h3 class="page-title">移民政策<i style="font-size: 12px;">（${coun.countryName}）</i></h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li><a href="/country">国家管理</a><i class="icon-angle-right"></i>
							</li>

							<li>移民政策</li>

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
								<li><a href="/country/city/hot/hotCityList?coun_id=${coun.countryId}">热门城市</a></li>
								<li class="active"><a href="javascript:;">移民政策</a></li>
                            </ul>
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet box grey">
							<div class="portlet-title" >
								移民政策
							</div>
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="get">
									<table border="0">
											<tr>
											<td align="right">
												<a href="/cms/articleinfo/add?pcode=0003&coun_id=${coun.countryId}" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
											</td>
											</tr>
									</table>
									 <table class="table table-striped table-bordered table-hover">
							  <thead>
								  <tr>
									  <th style="width:8px;" id="all"><input type="checkbox" /><input type="hidden" value="0" id="checkStatus"></th>
                                      <c:choose>
                                      	  <c:when test="${field=='title' && way=='asc'}">
                                              <th class="sorting_asc" data-field="title">标题</th>
                                          </c:when>
                                          <c:when test="${field=='title' && way=='desc'}">
                                              <th class="sorting_desc" data-field="title">标题</th>
                                         </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="title">标题</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <c:choose>
                                      	  <c:when test="${field=='publish_time' && way=='asc'}">
                                              <th class="sorting_asc" data-field="publish_time" style="text-align:center">发布时间</th>
                                          </c:when>
                                          <c:when test="${field=='publish_time' && way=='desc'}">
                                              <th class="sorting_desc" data-field="publish_time" style="text-align:center">发布时间</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="publish_time" style="text-align:center">发布时间</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th data-field="publish_user">发布人</th>
                                      <th >快捷操作&nbsp;&nbsp;</th>
								  </tr>
							  </thead>
							  <tbody id="list">
								  <c:forEach items="${list}" var="item">
									<tr>
										<td><input type="checkbox" class="checkboxes" value="${item.info_id}#${item.section_type }"/></td>
										<td data-title="标题">
                                            ${item.title}
                                        </td>
										<td style="text-align:center">
                                           	<c:if test="${item.status == '00140002' || item.status == '00140003'}">
                                        		<fmt:formatDate value="${item.publish_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        	</c:if>
                                        </td>
										<td>${item.publish_user}</td>
                                        <td data-title="操作">
                                           		<div data-id="${item.info_id}" data-type = "${item.section_type }" data-sid="${item.section_id }">
                                           		
                                           				<a class="btn green-stripe mini"><i class="icon-pencil">编辑</i></a>
	                                                    <a class="btn purple-stripe mini"><i class="icon-remove">删除</i></a>
                                                </div>
                                        </td>
								    </tr>
                                  </c:forEach>
							  </tbody>
						  </table>
                          		<input id="field" name="field" type="hidden" /> 
                                <input id="way" name="way" type="hidden" /> 
                                <div id="pageBar">
                                	<input type="hidden" name="page" id="page" value="1" />
                                    ${pageBar}
                                </div>
									<input type="hidden" id="coun_id" name="coun_id" value="${coun_id}" />
									<input type="hidden" id="coun_name" name="coun_name" value="${coun_name}" />
								</form>
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
		<!-- FOOTER -->
	</div>
</body>

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
																				.attr(
																						"data-id");
																		var coun_id = $("#coun_id").val();
																		location.href = "/country/city/hot/editHotCity?city_id="+ id +"&coun_id="+coun_id;
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
		//绑定内容编辑
		$("i.icon-pencil").each(function(index, element) {
			$(this).click(function(e){
				var id = $(this).parent().parent().attr("data-id");
				var type = $(this).parent().parent().attr("data-type");
				//if(type == "文章"){
					location.href="/cms/articleinfo/edit/"+id;
				//}else if(type == "图片"){
				//	location.href="/cms/imageinfo/edit/"+id;
				//}
			});		
        });
	//绑定删除按钮（废弃）
		$("i.icon-trash").each(function(index, element) {
			$(this).click(function(e){
				var url = "";
				var id = $(this).parent().parent().attr("data-id");
				var type = $(this).parent().parent().attr("data-type");
				if(confirm("提示：数据一旦删除不能恢复!确定要删除吗?")){
					if(type == "文章"){
						url = "/cms/articleinfo/delete";
					}else if(type == "图片"){
						url = "/cms/imageinfo/delete";
					}
					$.post(url,{"ids":id},function(data){
						if(data.status==0){
							$(element).parents("#list>tr").remove();
						}else if(data.status == 2){
							alert(data.msg);
						}
						else
							alert(data.msg);
					});
				}
			});		
        });
		//删除（即下线操作，下线后在国家移民政策中不可见，但是在资讯发布处可见，为下线状态）
		$("i.icon-remove").each(function(index, element) {
			$(this).click(function(e){
				var id = $(this).parent().parent().attr("data-id");
				var type = $(this).parent().parent().attr("data-type");
				if(confirm("确定要删除吗?")){
					//if(type == "文章"){
						url = "/cms/articleinfo/offline";
					//}else if(type == "图片"){
					//	url = "/cms/imageinfo/offline";
					//}
					$.post(url,{"ids":id},function(data){
						if(data.status==0){
							alert("删除成功!");
							location.reload();
						}else if(data.status == 2){
							alert(data.msg);
						}
						else
							alert(data.msg);
					});
				}
			});		
        });
		//删除移民政策(废弃)
		function deletePolicy(id){
			var coun_id = $("#coun_id").val();
			if(confirm("删除后该资讯移除移民政策，且状态修改为下线？")){
				$.post(
						"/country/immiPolicy/deletePolicy",
						{
							"id" : id,
							"coun_id" : coun_id 
						},
						function(data) {
							if (data.status == 0) {
								alert("删除成功！");
								location.reload();
							} else
								alert(data.msg);
						});
			}
		}
		</script>

		<!-- END JAVASCRIPTS -->
		<!-- END BODY -->
</html>