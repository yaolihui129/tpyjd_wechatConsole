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
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />
 <!-- BEGIN GLOBAL MANDATORY STYLES -->
	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
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
						<h3 class="page-title">注册用户列表</h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li>用户管理 - 注册用户列表
							</li>
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
								<div class="caption"><i class="icon-list"></i></div>
								<!-- <div class="actions">
									<a href="/members/add" class="btn blue addnew"><i class="icon-pencil"></i> 新增</a>
									<div class="btn-group">
										<a class="btn green" href="#" data-toggle="dropdown">
										<i class="icon-cogs"></i> 批量操作
										<i class="icon-angle-down"></i>
										</a>
										<ul class="dropdown-menu pull-right">
											<li><a id="batchDel"><i class="icon-trash"></i> 批量删除</a></li>
										</ul>
									</div>
								</div> -->
							</div>
						
						
							<div class="portlet-body  no-more-tables">
								<form id="searchForm" method="post">
									
									<div class="span12">
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">客户姓名：</label>
                                            <div class="controls">
                                                <input type="text" class="m-wrap span6" placeholder="姓名" value="${name }" id="name" name="name">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">来源：</label>
                                            <div class="controls">
                                                <select id="source" class="span6 select2" name="source">
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
                                            </div>
                                        </div>
                                    </div>
                                    <%-- <div class="span4 ">
                                        <div class="control-group">
                                        	<label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">会员状态：</label>
                                        	<div class="controls">
                                                <select id="mstatus" class="span6 select2" name="mstatus">
	                                               <option value="">全部</option>
													<c:forEach items="${mstatusList}" var="mstatus">
														<c:if test="${memberStatus == mstatus.dictCode }">
															<option value="${mstatus.dictCode }" selected>${mstatus.name}</option>
														</c:if>
														<c:if test="${memberStatus != mstatus.dictCode }">
															<option value="${mstatus.dictCode }">${mstatus.name}</option>
														</c:if>
													</c:forEach>
												</select>
                                            </div>
                                            
                                        </div>
                                    </div> --%>
                                </div>

                                <div class="span12" style="clear:both; margin-left:0;">
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">手机号码：</label>
                                            <div class="controls">
                                                <input  class="m-wrap span6" placeholder="手机号" type="text" id="paras" name="paras" value="${paras }">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">所在城市：</label>
                                            <div class="controls">
                                                <select id="province" class="span4 " name="province">
	                                               <option value="">省份</option>
													<c:forEach items="${provinceList}" var="province">
														<c:if test="${sheng == province.dictCode }"> 
															<option value="${province.dictCode }" selected="selected">${province.name}</option> 
														</c:if>
														<c:if test="${sheng != province.dictCode }"> 
															<option value="${province.dictCode }" >${province.name}</option> 
														</c:if>
													</c:forEach>
												</select>
												
                                                <select id="city" class="span4 " name="city">
	                                               <option value="">城市</option>
													 <c:forEach items="${cityList}" var="city">
														<option value="${city.dictCode }" <c:if test="${shi == city.dictCode }">selected </c:if> >${city.name}</option>
													</c:forEach> 
												</select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <button class="btn black" id="searchBtn">查询 <i class="icon-search"></i></button>
                                        </div>
                                    </div>
                                </div>
                                    
									<table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th id="all" style="width:8px;"><input type="checkbox" /></th>
												<th>序号</th>
												<c:choose>
													<c:when test="${field=='cust.login_name' && way=='asc'}">
														<th class="sorting_asc" data-field="cust.login_name">登录名</th>
													</c:when>
													<c:when test="${field=='cust.login_name' && way=='desc'}">
														<th class="sorting_desc"
															data-field="cust.login_name">登录名</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" data-field="cust.login_name">登录名</th>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${field=='cust.nick_name' && way=='asc'}">
														<th class="sorting_asc" data-field="cust.nick_name">昵称</th>
													</c:when>
													<c:when test="${field=='cust.nick_name' && way=='desc'}">
														<th class="sorting_desc"
															data-field="cust.nick_name">昵称</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" data-field="cust.nick_name">昵称</th>
													</c:otherwise>
												</c:choose>
												<th>姓名</th>
												<c:choose>
													<c:when test="${field=='cust.gender' && way=='asc'}">
														<th class="sorting_asc"
															style="text-align: center" data-field="cust.gender">性别</th>
													</c:when>
													<c:when test="${field=='cust.gender' && way=='desc'}">
														<th class="sorting_desc"
															style="text-align: center" data-field="cust.gender">性别</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" style="text-align: center"
															data-field="cust.gender">性别</th>
													</c:otherwise>
												</c:choose>
												
												<th style="text-align: center" data-field="cust.stutus">状态</th>

												<c:choose>
													<c:when test="${field=='cust.cust_source' && way=='asc'}">
														<th class="sorting_asc"
															style="text-align: center" data-field="cust.cust_source">来源</th>
													</c:when>
													<c:when test="${field=='cust.cust_source' && way=='desc'}">
														<th class="sorting_desc"
															style="text-align: center" data-field="cust.cust_source">来源</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" style="text-align: center"
															data-field="cust.cust_source">来源</th>
													</c:otherwise>
												</c:choose>
												
												<c:choose>
													<c:when test="${field=='cust.phone_num' && way=='asc'}">
														<th class="sorting_asc"
															data-field="cust.phone_num">手机号</th>
													</c:when>
													<c:when test="${field=='cust.phone_num' && way=='desc'}">
														<th class="sorting_desc"
															data-field="cust.phone_num">手机号</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" data-field="cust.phone_num">手机号</th>
													</c:otherwise>
												</c:choose>
												<%-- 
												<c:choose>
													<c:when test="${field=='cust.email' && way=='asc'}">
														<th class="sorting_asc"
															data-field="cust.email">邮箱</th>
													</c:when>
													<c:when test="${field=='cust.email' && way=='desc'}">
														<th class="sorting_desc"
															data-field="cust.email">邮箱</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" data-field="cust.email">邮箱</th>
													</c:otherwise>
												</c:choose> --%>

												<c:choose>
													<c:when test="${field=='cust.create_time' && way=='asc'}">
														<th class="sorting_asc"
															style="text-align: center" data-field="cust.create_time">注册时间</th>
													</c:when>
													<c:when test="${field=='cust.create_time' && way=='desc'}">
														<th class="sorting_desc"
															style="text-align: center" data-field="cust.create_time">注册时间</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" style="text-align: center"
															data-field="cust.create_time">注册时间</th>
													</c:otherwise>
												</c:choose>
												
												<c:choose>
													<c:when test="${field=='cust.create_time' && way=='asc'}">
														<th class="sorting_asc"
															style="text-align: center" data-field="cust.create_time">最近登录</th>
													</c:when>
													<c:when test="${field=='cust.create_time' && way=='desc'}">
														<th class="sorting_desc"
															style="text-align: center" data-field="cust.create_time">最近登录</th>
													</c:when>
													<c:otherwise>
														<th class="sorting" style="text-align: center"
															data-field="cust.create_time">最近登录</th>
													</c:otherwise>
												</c:choose>
												<th >最后IP地址</th>
												<th >代理人</th>

												<th >快捷操作&nbsp;&nbsp;</th>
											</tr>

										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item" varStatus = "status">
												<tr style="height:40px;">
													<td ><input type="checkbox" class="checkboxes"
														value="${item.custinfo_id}" /></td>
													<th>${status.index + 1}</th>
													<td data-title="登录名"><%-- <a id="sd" data-toggle="modal"
														data-target="#cust_detail"
														href="/cust/detail/${item.custinfo_id}">${item.login_name}</a> --%>
														<c:if test="${empty item.login_name}">
															未设置
														</c:if>
														<c:if test="${not empty item.login_name}">
															${item.login_name}
														</c:if>
													</td>
													<td data-title="昵称">
														<c:if test="${empty item.nick_name}">
															未设置
														</c:if>
														<c:if test="${not empty item.nick_name}">
															${item.nick_name}
														</c:if>
													</td>
													<th>
														<c:if test="${empty item.name}">
															未设置
														</c:if>
														<c:if test="${not empty item.name}">
															${item.name}
														</c:if>
													</th>
												
													<td style="text-align: center" data-title="性别">
														<p>
															<c:if test="${empty item.gender}">
																未设置
															</c:if>
															<c:if test="${not empty item.gender}">
																<c:choose>
																	<c:when test="${item.gender == \"m\"}">
																		男
																	</c:when>
																	<c:otherwise>
																		女
																	</c:otherwise>
																</c:choose>
															</c:if>
															
														</p>
													</td>
													
													<th style="text-align: center" data-title="状态">${item.member_statusZN}</th>
													
													<td style="text-align: center" data-title="来源">
														<p>${item.cust_source}</p>
													</td>
													
													<td data-title="手机">${item.phone_num}</td>
													<%-- <td data-title="邮箱">${item.email}</td> --%>
													
													<td style="text-align: center" data-title="注册日期">
														<p>
														<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
														</p>
													</td>
													
													<td style="text-align: center" data-title="最近登录">
														<p>
														<fmt:formatDate value="${item.last_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
														</p>
													</td>
													<td style="text-align: center" data-title="最后IP地址">
														<p>
														${item.last_ip }
														</p>
													</td>
													
													<td style="text-align: center" data-title="代理人">
													<c:if test="${empty item.dlr}">无</c:if>
													<c:if test="${not empty item.dlr}">${item.dlr }</c:if>
													</td>
													
													<td data-title="操作">
														<div data-id="${item.custinfo_id}">
															<%-- <c:if test="${item.member_status == null || item.member_status == ''}">
																<a class="btn yellow-stripe mini"><i class="icon-lock">禁用</i></a>
																<a class="btn blue-stripe mini"><i class="icon-unlock">启用</i></a>
															</c:if>
															<c:if test="${item.member_status == mstatus_enabled}">
																<a class="btn yellow-stripe mini"><i class="icon-lock">禁用</i></a>
															</c:if>
															<c:if test="${item.member_status == mstatus_disabled}">
																<a class="btn blue-stripe mini"><i class="icon-unlock">启用</i></a>
															</c:if>
															<a class="btn green-stripe mini"><i class="icon-edit">编辑</i></a>
															<a class="btn red-stripe mini"><i class="icon-trash">删除</i></a> --%>
															<a class="btn red-stripe mini"><i class="icon-eye-open">查看</i></a>
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
</div>
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
		<script type="text/javascript" src="/views/media/js/select2.min.js"></script><!--下拉输入必须-->
		<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
		<script type="text/javascript" src="/views/media/js/bootstrap-datetimepicker.js"></script><!--下拉输入必须-->
		<script type="text/javascript" src="/views/media/js/jquery.inputmask.bundle.min.js"></script>  
		<script type="text/javascript" src="/views/media/js/jquery.input-ip-address-control-1.0.min.js"></script>
		<script type="text/javascript" src="/views/media/js/jquery.multi-select.js"></script>   
		<!--<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>-->

		<!-- END PAGE LEVEL PLUGINS -->
		
		<script src="/views/media/js/form-components.js"></script>  <!--下拉输入必须-->

		<!-- BEGIN PAGE LEVEL SCRIPTS -->

		<script src="/views/media/js/app.js"></script>
		<script src="/js/json/json2.js"></script>
		<script src="/views/media/js/form-validate.js"></script>

		<script>
			jQuery(document)
					.ready(
							function() {
								App.init(); // initlayout and core plugins
								FormComponents.init();//下拉输入必须
								
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
																		var id = $(this).parent().parent().attr("data-id");
																		location.href = "/members/edit/"+ id;
																	});
												});
								
								
								//绑定删除按钮
								$("i.icon-trash")
										.each(
												function(index, element) {
													$(this)
															.click(
																	function(e) {
																		var id = $(this).parent().parent().attr("data-id");
																		if(confirm("提示：删除后不可恢复！确定要删除该会员吗？")){
																			$.post(
																					"/members/delete",
																					{
																						"ids" : id
																					},
																					function(data) {
																						if (data.status == 0) {
																							alert("删除成功");
																							location.reload();
																						}else if(data.status == 2){
																							alert(data.msg);
																						} else
																							alert(data.msg);
																					});
																		}
																	});
												});
								
								
								
								
								//禁用
								$("i.icon-lock")
										.each(
												function(index, element) {
													$(this)
															.click(
																	function(e) {
																		var id = $(this).parent().parent().attr("data-id");
																		if(confirm("确定要禁用该会员吗？")){
																			$.post(
																					"/members/disabled",
																					{
																						"id" : id
																					},
																					function(data) {
																						if (data.status == 0) {
																							alert("禁用成功");
																							location.reload();
																						}else if(data.status == 2){
																							alert(data.msg);
																						} else
																							alert(data.msg);
																					});
																		}
																	});
												});
								
								//启用
								$("i.icon-unlock")
										.each(
												function(index, element) {
													$(this)
															.click(
																	function(e) {
																		var id = $(this).parent().parent().attr("data-id");
																		if(confirm("确定要启用该会员吗？")){
																			$.post(
																					"/members/enabled",
																					{
																						"id" : id
																					},
																					function(data) {
																						if (data.status == 0) {
																							alert("启用成功");
																							location.reload();
																						}else if(data.status == 2){
																							alert(data.msg);
																						} else
																							alert(data.msg);
																					});
																		}
																	});
												});
								
								//查看
								$("i.icon-eye-open")
										.each(
												function(index, element) {
													$(this)
															.click(
																	function(e) {
																		var id = $(this).parent().parent().attr("data-id");
																		location.href="/members/detail/"+id;
																	});
												});
								
								//批量删除
								$("#batchDel").click(function(e) {
				                   var checks = $("input.checkboxes:checked");
									if(checks.size()>0){
										var ids="";
										checks.each(function(index, element) {
				                            if(ids=="")
												ids=$(this).val();
											else{
												ids = ids+","+$(this).val();
											}
				                        });
										//dosomething
										if(confirm("提示：删除后无法恢复.确认要删除吗？")){
											$.post("/members/delete",{"ids":ids},function(data){
												if(data.status==0){
													alert("批量删除成功!");
													window.location.reload();
												}else if(data.status == 2){
													alert(data.msg);
												}
												else{
													alert(data.msg);
													window.location.reload();
												}
											});
										}
										
									}
									else{
										alert("请选择删除行");	
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
								
								//省份改变
								$('#province').change(function () {
									var sheng = $("#province").val();
									//先清除之前内容
									//$("#city").val("1");
									/* $("#city").find("option").each(function(){
										//if($(this).val() != "")
										$(this).remove();
								    }); */ 
								    //$("#city").empty();
									if(sheng != ""){
										$.post("/members/city",{"province":sheng},function(result){
											if (result.lists.length > 0) {
					                            data = result.lists,
					                            html = '<option value="1">城市</option>';
					                            $.each(data, function (i, obj) {
					                            	html += '<option value="'+obj.dict_code+'" >'+obj.name+
						                            '</option>';
					                            });
					                            
					                            //$("#city").find("option:last").after(html);
					                            $("#city").html(html);
					                        } 
										});
									}
						        });

							});
			
		</script>


<!-- END BODY -->
</html>