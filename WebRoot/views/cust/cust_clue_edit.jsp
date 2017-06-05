<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<link rel="stylesheet" type="text/css"
	href="/views/media/css/DT_bootstrap.css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->

<link rel="stylesheet" type="text/css"
	href="/views/media/css/bootstrap-tree.css" />

<script src="/bower_components/lrz/dist/lrz.bundle.js"
	type="text/javascript"></script>


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

						<h3 class="page-title">${operation}</h3>

						<ul class="breadcrumb">

							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>

							<li>线索管理<i class="icon-angle-right"></i>
							</li>

							<li>线索录入/编辑</li>
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
					<!--  --><div class="span12">
						<div class="tabbable tabbable-custom boxless">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab_1" data-toggle="tab">线索信息</a></li>
								<li <c:if test="${active == '1' }">class="active"</c:if>><a class="" href="#tab_2" data-toggle="tab">意向信息</a></li>
								<li id="li_tab3" <c:if test="${active == '2' }">class="active"</c:if>><a href="#tab_3" data-toggle="tab">跟进记录</a></li>
							</ul>

							<div class="tab-content">
								<!-- 线索信息 开始 -->
								<div class="tab-pane active" id="tab_1">
									<div class="portlet box green">
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>线索信息</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>

										<div class="portlet-body form">

											<!-- BEGIN FORM-->

											<form action="#" class="form-horizontal" id="memberForm" method="get">
												<h3 class="form-section">基本信息</h3>
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">姓名：</label>
															<input type="text" value="${cust.name }" id="name" name="name" class="m-wrap span6" placeholder="姓名">
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">所属部门：</label>
															<input type="text" value="${cust.nickName }" id="nick_name" name = "nick_name" class="m-wrap span6" placeholder="所属部门">
														</div>
													</div>
													<!--/span-->
												</div>
												
												<!--/row-->
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">性别：</label>
															<div class="controls">                                                
																<label class="radio">
																<input type="radio" id="gender" name="gender" value="m" <c:if test="${cust.gender == 'm' }"> checked</c:if>/>
																男
																</label>
																<label class="radio">
																<input type="radio" id="gender" name="gender" value="f"  <c:if test="${cust.gender == 'f' }"> checked</c:if>/>
																女
																</label>  
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label" >所在地区：</label>
															<select class="span6 select2_category"  data-placeholder="所在地区" tabindex="1" name="cust_source" id="cust_source">
																<option value=""></option>
																<c:forEach items="${provinceList}" var="province">
																	<c:if test="${cust.area ==  province.dictCode}">
																		<option value="${province.dictCode }" selected>${province.name}</option>
																	</c:if>
																	<c:if test="${cust.area !=  province.dictCode}">
																		<option value="${province.dictCode }">${province.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
												</div>

												<!--/row-->        
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">线索来源：</label>
															<select class="span6 select2_category"  data-placeholder="线索来源" tabindex="1" name="cust_source" id="cust_source">
																<option value=""></option>
																<c:forEach items="${csourceList}" var="csource">
																	<c:if test="${cust.custSource ==  csource.dictCode}">
																		<option value="${csource.dictCode }" selected>${csource.name}</option>
																	</c:if>
																	<c:if test="${cust.custSource !=  csource.dictCode}">
																		<option value="${csource.dictCode }">${csource.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>

													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">线索状态：</label>
															<select class="span6 select2_category"  data-placeholder="线索状态" tabindex="1" name="cust_source" id="cust_source">
																<option value=""></option>
																<c:forEach items="${csourceList}" var="csource">
																	<c:if test="${cust.custSource ==  csource.dictCode}">
																		<option value="${csource.dictCode }" selected>${csource.name}</option>
																	</c:if>
																	<c:if test="${cust.custSource !=  csource.dictCode}">
																		<option value="${csource.dictCode }">${csource.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->

												</div>
												<!--/row-->  
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">推荐人：</label>
															<input type="text" value="${cust.name }" id="name" name="name" class="m-wrap span6" placeholder="推荐人">
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">负责人：</label>
															<input type="text" value="${cust.nickName }" id="nick_name" name = "nick_name" class="m-wrap span6" placeholder="负责人">
														</div>
													</div>
													<!--/span-->
												</div>   
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">电话：</label>
															<input type="text" value="${cust.name }" id="name" name="name" class="m-wrap span6" placeholder="电话">
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">常用电话：</label>
															<input type="text" value="${cust.nickName }" id="nick_name" name = "nick_name" class="m-wrap span6" placeholder="常用电话">
														</div>
													</div>
													<!--/span-->
												</div>    
												
												<div class="row-fluid" style="display:none;">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">最后修改时间：</label>
															<input type="text" value="${cust.name }" id="name" name="name" class="m-wrap span6" placeholder="电话">
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">最后跟进时间：</label>
															<input type="text" value="${cust.nickName }" id="nick_name" name = "nick_name" class="m-wrap span6" placeholder="常用电话">
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="form-actions">
													<input type="hidden" id="custinfo_id" name="custinfo_id" value="${cust.custinfoId }">
													<button type="submit" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存</button>
													<button type="button" class="btn" id="back">取消</button>
												</div>
											</form>
											<!-- END FORM-->                
										</div>
									</div>
								</div>
								<!-- 线索信息 结束 -->
								
								<!-- 意向信息 开始 -->
								<div class="tab-pane " id="tab_2">
									<!-- BEGIN EXAMPLE TABLE PORTLET-->
									<div class="portlet box blue">
										<div class="portlet-title">
											<div class="caption"><i class="icon-globe"></i>意向信息</div>
											<div class="actions">
												
											</div>
										</div>
										<div class="portlet-body form">

											<!-- BEGIN FORM-->

											<form action="/cust/clue/saveCustIntention" class="form-horizontal" id="intentionForm" method="post">
												<h3 class="form-section">意向信息</h3>
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">移民目的：</label>
															<input type="text" value="${intention.intention }" id="intention" name="intention" class="m-wrap span6" placeholder="移民目的">
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">预算资金：</label>
															<input type="text" value="${intention.calculation_min }" id="calculation_min" name = "calculation_min" class="m-wrap span6" placeholder="预算资金">
														</div>
													</div>
													<!--/span-->
												</div>
												
												<!--/row-->
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">意向国家：</label>
															<select id="country" name="country">
															<c:forEach items="${countryList}" var="country">
																	<c:if test="${intention.country ==  country.dictCode}">
																		<option value="${intention.dictCode }" selected>${country.name}</option>
																	</c:if>
																	<c:if test="${intention.country !=  country.dictCode}">
																		<option value="${intention.dictCode }">${country.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">家庭净资产：</label>
															<input type="text" value="${intention.family_assets }" id="family_assets" name = "family_assets" class="m-wrap span6" placeholder="家庭净资产">
														</div>
													</div>
													<!--/span-->
												</div>

												<!--/row-->
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">最高学历：</label>
															<select id="education" name="education">
															<c:forEach items="${eduList}" var="edu">
																	<c:if test="${intention.education ==  edu.dictCode}">
																		<option value="${intention.dictCode }" selected>${edu.name}</option>
																	</c:if>
																	<c:if test="${intention.education !=  edu.dictCode}">
																		<option value="${intention.dictCode }">${edu.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
															
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">希望获得身份：</label>
															<select id="identity_type" name="identity_type">
															<c:forEach items="${visaTypeList}" var="visaType">
																	<c:if test="${intention.identity_type ==  visaType.dictCode}">
																		<option value="${intention.dictCode }" selected>${visaType.name}</option>
																	</c:if>
																	<c:if test="${intention.identity_type !=  visaType.dictCode}">
																		<option value="${intention.dictCode }">${visaType.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<!--/row-->  
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">英文水平：</label>
															<select id="language" name="language">
															<c:forEach items="${languageList}" var="lan">
																	<c:if test="${intention.language ==  lan.dictCode}">
																		<option value="${intention.dictCode }" selected>${lan.name}</option>
																	</c:if>
																	<c:if test="${intention.language !=  lan.dictCode}">
																		<option value="${intention.dictCode }">${lan.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">可接受海外居住时间：</label>
															<select id="live_require" name="live_require">
															<c:forEach items="${liveList}" var="live">
																	<c:if test="${intention.live_require ==  live.dictCode}">
																		<option value="${intention.dictCode }" selected>${live.name}</option>
																	</c:if>
																	<c:if test="${intention.live_require !=  live.dictCode}">
																		<option value="${intention.dictCode }">${live.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
												</div>   
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">年龄：</label>
															<select id="age" name="age">
															<c:forEach items="${ageList}" var="age">
																	<c:if test="${intention.custSource ==  age.dictCode}">
																		<option value="${intention.dictCode }" selected>${age.name}</option>
																	</c:if>
																	<c:if test="${intention.custSource !=  age.dictCode}">
																		<option value="${intention.dictCode }">${age.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
													
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">管理经验：</label>
															<select id="manage_exp" name="manage_exp">
															<c:forEach items="${manageList}" var="manage">
																	<c:if test="${intention.custSource ==  manage.dictCode}">
																		<option value="${intention.dictCode }" selected>${manage.name}</option>
																	</c:if>
																	<c:if test="${intention.custSource !=  manage.dictCode}">
																		<option value="${intention.dictCode }">${manage.name}</option>
																	</c:if>
																	
																</c:forEach>
															</select>
														</div>
													</div>
													<!--/span-->
												</div>    
												
												<div class="form-actions">
													<input type="hidden" id="intention_id" name="intention_id" value="${intention.intention_id }">
													<input type="hidden" id="custinfo_id" name="custinfo_id" value="${cust.custinfoId }">
													<button type="submit" class="btn blue" id="intentionBtn"><i class="icon-ok"></i> 保存</button>
													<button type="button" class="btn" id="back">取消</button>
												</div>
											</form>
											<!-- END FORM-->                
										</div>
									</div>
									<!-- END EXAMPLE TABLE PORTLET-->
								</div>
								<!-- 意向信息 结束 -->
							
								<!-- 跟进记录 开始 -->
								<div class="tab-pane " id="tab_3">
									<!-- BEGIN EXAMPLE TABLE PORTLET-->
									
									
									<div class="portlet box yellow">
										<div class="portlet-title">
											<div class="caption"><i class="icon-globe"></i>跟进记录</div>
											<div class="actions">
												<a data-toggle="modal" href="#" data-target="#add_follow_record" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
											</div>
										</div>
										
										<!-- 记录列表 -->
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
																	<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
																	
																	</p>
																</td>
																<td style="text-align: center" data-title="记录人">
																	<p>
																	<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
																	
																	</p>
																</td>
																<td data-title="操作">
																	<div data-id="${item.follow_record_id}">
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
										<!-- 记录列表 -->
										
									</div>
									<!-- END EXAMPLE TABLE PORTLET-->
								</div>
								<!-- 跟进记录 结束 -->
								
								
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
							<td><input type="text" id="title" name="title"/></td>
						</tr>
						<tr>
							<td>描述</td>
							<td><textarea name="remark" id="remark" cols="50" rows="2"></textarea></td>
						</tr>
						<tr>
							<td>开始时间</td>
							<td>
							<div class="input-append date form_datetime">
								<input id="start_time" name = "start_time" size="16" type="text" value="" readonly class="m-wrap">
								<span class="add-on"><i class="icon-calendar"></i></span>
							</div>
							</td>
						</tr>
						<tr>
							<td>结束时间</td>
							<td><input type="text" id="end_time" name="end_time"/><span class="add-on"><i class="icon-calendar"></i></span></td>
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
	<!-- 模态弹出窗内容 -->

	<!-- BEGIN FOOTER -->

	<div class="footer">

		<div class="footer-inner">2016 &copy; copyright pacificimmi.</div>

		<div class="footer-tools">

			<span class="go-top"> <i class="icon-angle-up"></i>

			</span>

		</div>

	</div>

	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

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

	<script src="/views/media/js/jquery.vmap.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.russia.js"
		type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.world.js"
		type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.europe.js"
		type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.germany.js"
		type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.usa.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.sampledata.js"
		type="text/javascript"></script>
	<script src="/views/media/js/jquery.flot.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.flot.resize.js"
		type="text/javascript"></script>
	<script src="/views/media/js/jquery.pulsate.min.js"
		type="text/javascript"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script type="text/javascript"
		src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<script src="/bower_components/lrz/dist/lrz.bundle.js"
		type="text/javascript"></script>
	<script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->

	<script>
		jQuery(document)
				.ready(
						function() {
							App.init(); // initlayout and core plugin 
							$("#back").click(function(e) {
								window.history.back();
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
							

							//提交表单
							$("#subBtn")
									.click(
											function(e) {

												var fromurl = document.referrer;
												$("#fromurl").val(fromurl);
												//调用验证插件，进行form表单的验证
												$("#sform").formValidate();
											});
							
							//提交意向信息表单
							$("#intentionBtn")
									.click(
											function(e) {

												$("#intentionForm").formValidate();
											});
							
							
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
												document.getElementById("tab_2").setAttribute("class", "tab-pane active");
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