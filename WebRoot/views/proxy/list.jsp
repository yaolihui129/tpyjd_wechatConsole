<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
	<meta charset="utf-8" />
	<title>太平洋加达出国－后台管理系统 v1.0</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
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
    <link href="/views/media/css/timeline.css" rel="stylesheet" type="text/css"/>
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link href="/views/media/css/jquery.gritter.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/daterangepicker.css" rel="stylesheet" type="text/css" />
	<link href="/views/media/css/fullcalendar.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/jqvmap.css" rel="stylesheet" type="text/css" media="screen"/>
	<link href="/views/media/css/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
    <link href="/views/media/css/add.css" rel="stylesheet" type="text/css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
	<!-- END PAGE LEVEL STYLES -->
	<link rel="shortcut icon" href="/views/media/image/logo3232.ico" /> 
	<script src="/js/laydate/laydate.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@ include  file="../navi.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@ include  file="../menus.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->
		<div class="page-content">
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="pull-left">分销商管理</h3>
						<ul class="breadcrumb clear">
							<li>
								<i class="icon-home"></i>
								<a href="/console">首页</a> 
								<i class="icon-angle-right"></i>
							</li>
                            <li>渠道分销</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->
				<div class="portlet box grey">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i></div>
							</div>
							<div class="portlet-body">
								<form id="searchForm" method="post">
								<div class="span12">
									<div class="span4">
										<div class="control-group">
											<label style="float:left; line-height: 30px; margin-right:10px;">快速查找</label>
											<div class="controls">
												<input type="text" placeholder="输入姓名或电话" class="m-wrap medium" name="fast_query" value="${sel_fast_query}" />
											</div>
										</div>
									</div>
									<div class="span7">
										<div class="control-group">
											<label style="float:left; line-height: 30px; margin-right:10px;">所在城市:</label>
											<div class="controls">
												<select  id="provinceCode" class="m-wrap span4" style="float:left;" name="province">
													<option value="">省份</option>
													<c:if test="${provinceList != null}">
														<c:forEach var="province" items="${provinceList}">
															<option value="${province.dictCode}" <c:if test="${province.dictCode==sel_province}">selected=selected</c:if>>${province.name}</option>
														</c:forEach>
													</c:if>
                                                </select>
                                                
                                                <select id="cityCode" class="m-wrap span4" style="float:left;margin-left:20px;" name="city">
													<option value="">城市</option>
													<c:if test="${cityList != null}" >
														<c:forEach var="city" items="${cityList}">
															<option value="${city.dictCode}" <c:if test="${city.dictCode==sel_city}">selected=selected</c:if>>${city.name}</option>
														</c:forEach>
													 </c:if>
                                                </select>
											</div>
										</div>
									</div>
								</div>
								<div class="span12">
									<div class="span5">
										<div class="control-group">
											<label style="float:left; line-height: 30px; margin-right:10px;">审核通过时间</label>
											<div class="controls">
												<input type="text" placeholder="开始时间" class="m-wrap small" name="start_online_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${sel_start_online_time}"/>
												 -- 
												 <input type="text" placeholder="结束时间" class="m-wrap small" name="end_online_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${sel_end_online_time}"/>
											</div>
										</div>
									</div>
									<div class="span2">
										<a href="javascript:;" class="btn blue" id="searchBtn" >
											<i class="icon-search"></i> 搜索
										</a>
									</div>
								</div>
								
                                <div class="tabbable tabbable-custom bodr-bm1 clear">
                                    <ul class="nav nav-tabs">
                                        <li <c:if test="${selectTab=='all'}">class="active"</c:if>><a href="#tab_1_1" data-toggle="tab" onclick="selectTab('','all');">全部（${all_count}）</a></li>
                                        <li <c:if test="${selectTab=='one'}">class="active"</c:if>><a href="javascript:;" data-toggle="tab" onclick="selectTab('${proxy_level_one}', 'one');">合伙人（${one_count}）</a></li>
                                        <li <c:if test="${selectTab=='two'}">class="active"</c:if>><a href="javascript:;" data-toggle="tab" onclick="selectTab('${proxy_level_two}', 'two');">代理人（${two_count}）</a></li>
                                    </ul>
                                    <input id="selectTab"  type="hidden" name="selectTab" value="${selectTab}">
                                    <input id="proxy_level"  type="hidden" name="proxy_level" value="${proxy_level}">
                                    
                                </div>
								<table class="table table-striped table-bordered table-hover" id="sample_2">
									<thead>
										<tr>
											<th>序号</th>
											<th>姓名</th>
											<th>联系电话</th>
											<th>备用电话</th>
                                            <th>合作方式</th>
											<th>审核状态</th>
											<th>代理状态</th>
                                            <th>下级代理人</th>
											<th>直属客户</th>
											<th>所在城市</th>
											<th>审核通过时间</th>
											<th>上级合伙人</th>
                                            <th>快捷操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${list}" varStatus="status">
											<tr class="odd gradeX">
												<td><c:out value="${status.count}"/></td>
												<td>${item.name}</td>
												<td>${item.phone_num}</td>
												<td>${item.contact}</td>
	                                            <td>${item.proxy_level_name}</td>
												<td>${item.audit_status_name}</td>
												<td>${item.proxy_status_name}</td>
	                                            <td><c:if test="${item.sub_proxy_count != 0}">${item.sub_proxy_count}</c:if></td>
												<td><c:if test="${item.sub_custinfo_count != 0}">${item.sub_custinfo_count}</c:if></td>
												<td>${item.city_name}</td>
												<td><fmt:formatDate value="${item.passed_time}" type="date" dateStyle="default"/></td>
												<td>
													<c:choose>
														<c:when test="${item.proxy_pname!=null}">
															${item.proxy_pname}
														</c:when>
														<c:otherwise>--</c:otherwise>
													</c:choose>
												</td>
	                                            <td>
	                                            	<c:choose>
	                                            		<c:when test="${item.audit_status==audit_status_passed}">
	                                            			<a  href="/proxy/proxy/details/${item.custinfo_id}"  class="btn yellow-stripe mini"><i class="icon-eye-open"></i>查看</a>
	                                            			<c:choose>
			                                            		<c:when test="${item.proxy_status==proxy_status_enabled}">
			                                            			<a  href="#updataStatus"  class="btn red-stripe mini" onclick="updateStatus('${item.custinfo_id}', '${proxy_status_disabled}', '${proxy_status}', this);" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-lock"></i>禁用</a>
			                                            		</c:when>
			                                            		<c:otherwise>
			                                            			<a  href="#updataStatus"  class="btn green-stripe mini" onclick="updateStatus('${item.custinfo_id}', '${proxy_status_enabled}', '${proxy_status}', this);" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-unlock"></i>启用</a>
			                                            		</c:otherwise>
			                                            	</c:choose>
	                                            		</c:when>
	                                            		<c:when test="${item.audit_status==audit_status_new}">
	                                            			<c:choose>
	                                            				<c:when test="${item.proxy_level==proxy_level_other}">
	                                            					<a  href="#updateProxyLevelOther"  class="btn green-stripe mini" onclick="updateProxyLevel('${item.custinfo_id}', 'first')" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-ok"></i>通过</a>
	                                            				</c:when>
	                                            				<c:otherwise>
	                                            					<a  href="#updateProxyLevel"  class="btn green-stripe mini" onclick="updateStatus('${item.custinfo_id}', '${audit_status_passed}', '${audit_status}', this),updatePassedStatusTitle('${item.proxy_level_name}');" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-ok"></i>通过</a>
	                                            				</c:otherwise>
	                                            			</c:choose>
															<a  href="#updataStatus"  class="btn black-stripe mini" onclick="updateStatus('${item.custinfo_id}', '${audit_status_refused}', '${audit_status}', this);" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-remove"></i>拒绝</a>
	                                            		</c:when>
	                                            		<c:otherwise>
	                                            			<c:choose>
	                                            				<c:when test="${item.proxy_level==proxy_level_other}">
	                                            					<a  href="#updateProxyLevelOther"  class="btn green-stripe mini" onclick="updateProxyLevel('${item.custinfo_id}', 'again')" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-ok"></i>再审通过</a>
	                                            				</c:when>
	                                            				<c:otherwise>
	                                            					<a  href="#updataStatus"  class="btn purple-stripe mini" onclick="updateStatus('${item.custinfo_id}', '${audit_status_passed}', '${audit_status}', this);" role="button" class="btn blue addnew" data-toggle="modal" ><i class="icon-refresh"></i>再审通过</a>
	                                            				</c:otherwise>
	                                            			</c:choose>
	                                            		</c:otherwise>
	                                            	</c:choose>
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
						
						<div id="updataStatus" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updataStatus" aria-hidden="true" >
			                <div class="modal-header">
			                    <button type="button" class="close" onclick="clearInput();" data-dismiss="modal" aria-hidden="true"></button>
			                   <h3  style="margin-top:5px;" id="statusTitle"></h3>
			                 </div>
			                 <div class="modal-body">
			                 	<div class="portlet-body form">
									<div class="row-fluid">
											<div class="span12 "></div>
									  		<div class="span12 ">
                                                <div class="control-group">
                                            		<label id="intpuTitle" >请输入原因:</label>
                                            	</div>
                                            </div>
                                            <div class="span12 ">
                                                <div class="control-group">
                                                    <div class="controls">
                                                    	<textarea id="reason" must-be="true"  data-length="50" data-label="输入原因" class="span10 m-wrap"   rows="4" name="reason"></textarea>
                                                    	<!-- <span style="color:red;margin-left:10px;">*</span> -->
                                                    	<input id="us_custinfo_id"  name="custinfo_id" type="hidden" value=""/>
														<input id="us_column" name="column" type="hidden" value=""/>
														<input id="us_status_code" name="status_code" type="hidden" value="" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
		                        </div>
	                        </div>
							<div class="modal-footer">
							    <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="clearInput();">取消</button>
							     <button type="button"  onclick="valiStatusDate();"  class="btn blue">确定</button>
							</div>
		              </div>
		              
		              <div id="updateProxyLevelOther" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateProxyLevelOther" aria-hidden="true" >
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
			                   <h3  style="margin-top:5px;" id="statusTitle">选择合作方式</h3>
			                 </div>
			                 <div class="modal-body">
			                 	<div class="portlet-body form">
									<div class="row-fluid">
											<div class="span12">
												<label class="radio span3" >
													<input type="radio"  name="pl_proxy_level" value="${proxy_level_one}" checked="checked"/>合伙人
												</label>
												<label class="radio span3" >
													<input type="radio"  name="pl_proxy_level" value="${proxy_level_two}" />代理人
												</label>
											</div>
											<div class="span12 ">
                                                <div class="control-group">
                                            		<label id="pl_intpuTitle" >请输入再审通过原因:</label>
                                            	</div>
                                            </div>
                                            <div class="span12 ">
                                                <div class="control-group">
                                                    <div class="controls">
                                                    	<textarea id="pl_reason" must-be="true"  data-length="50" data-label="输入原因" class="span10 m-wrap"   rows="4" ></textarea>
                                                    	<input id="pl_custinfo_id" type="hidden" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>
		                        </div>
	                        </div>
	                        
							<div class="modal-footer">
							    <button class="btn" data-dismiss="modal" aria-hidden="true" >取消</button>
							     <button id="pl_sumit" type="button" class="btn blue">确定</button>
							</div>
		              </div>
              		
              		
              		<div id="updateProxyLevel" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updateProxyLevel" aria-hidden="true" >
		                <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                   <h3  style="margin-top:5px;" id="statusTitle"></h3>
		                 </div>
		                 <div class="modal-body">
		                 	<div class="portlet-body form">
								<div class="row-fluid">
										<div class="span12 "><label id="passedStatusTitle" style="text-align:center;margin:30px 0;">是否确认此用户成为一级代理</label></div>
                                   </div>
	                        </div>
                        </div>
						<div class="modal-footer">
						    <button class="btn" data-dismiss="modal" aria-hidden="true" >取消</button>
						     <button type="button"  onclick="submitStatus();"  class="btn blue">确定</button>
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
		<div class="footer-inner">
			2013 &copy; 北京太平洋加达出国顾问股份有限公司
		</div>
		<div class="footer-tools">
			<span class="go-top">
			<i class="icon-angle-up"></i>
			</span>
		</div>
	</div>
	<!-- END FOOTER -->
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
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
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script src="/views/media/js/jquery.vmap.js" type="text/javascript"></script>   
	<script src="/views/media/js/jquery.vmap.russia.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.world.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.europe.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.germany.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.usa.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.sampledata.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.flot.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.flot.resize.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.pulsate.min.js" type="text/javascript"></script>
	<script src="/views/media/js/date.js" type="text/javascript"></script>
	<script src="/views/media/js/daterangepicker.js" type="text/javascript"></script>     
	<script src="/views/media/js/jquery.gritter.js" type="text/javascript"></script>
	<script src="/views/media/js/fullcalendar.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.easy-pie-chart.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.sparkline.min.js" type="text/javascript"></script>  
	<!-- END PAGE LEVEL PLUGINS -->
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<script src="/views/media/js/index.js" type="text/javascript"></script>     
	<script src="/views/media/js/form-validate.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->  
	<script>
		jQuery(document).ready(function() {    
		   App.init(); // initlayout and core plugins
		   
		 //绑定翻页
			$('li.pages').each(function(index, element) {
				if($(element).attr("data-page")!=undefined){
					$(this).click(function(e) {
						$("#page").val($(element).attr("data-page"));
						doRequest();
					});
				}
           });
		});
		
		//搜索触发
		$("#searchBtn").click(function(e) {
	        doRequest();
	    });
		
		//提交查询请求
		function doRequest(){
			$("#searchForm").formValidate();
		}
	
		 //根据省份查询城市
		 $("#provinceCode").change(function(){
	      	$("#cityCode").empty();
	      	$("#cityCode").append("<option value=''>城市列表</option>");
	      	if($(this).val()) {
		            	$.post("/utils/getCity", {"country_code":$(this).val()}, function(data){
		             		if(data.status==0) {
		             			var obj = data.citys;
		             			var html="";
		             			if(obj.length) {
		             				for(var i=0; i<obj.length; i++) {
		             					html+='<option value="'+obj[i].dict_code+'">'+obj[i].name+'</option>';
		             				}
		             				$("#cityCode").empty();
		             				$("#cityCode").append("<option value=''>城市列表</option>"+html);
		             			}
		            		} else {
		            			alert(data.msg);
		            		}
		            	});
	      	}
	      });
		 
		 //修改状态
		 function updateStatus(custinfo_id, status_code, column, obj) {
			$("#intpuTitle").text("请输入"+$(obj).text()+"原因");
			if(custinfo_id && status_code && column) {
				clearInput();
				$("#us_custinfo_id").val(custinfo_id);
				 $("#us_column").val(column);
				 $("#us_status_code").val(status_code);
			}
		 }
		 
		 function clearInput() {
			 $("#us_custinfo_id").val("");
			 $("#us_column").val("");
			 $("#us_status_code").val("");
			 $("#reason").val("");
		 }
		 
		 function valiStatusDate() {
			 var $reason = $("#reason");
			var reason=$reason.val();
			var dataLen = $reason.attr("data-length");
			var label = $reason.attr("data-label");
			var be = $reason.attr("must-be");
			//字数验证
			if(dataLen!=undefined && reason.length>dataLen){
				alert(label+"字数不能超过"+dataLen+"!");
				flag=false;
				return false;
			} else if(be && !reason) {
				alert(label+"不能为空!");
				flag=false;
				return false;
			}
			submitStatus(reason);
		 }
		 
		 //提交修改状态
		function submitStatus(reason) {
			var custinfo_id=$("#us_custinfo_id").val();
			var column=$("#us_column").val();
			var status_code=$("#us_status_code").val();
			
			if(custinfo_id && status_code && column) {
				 $.post("/proxy/proxy/status",{'custinfo_id':custinfo_id, 'status_code':status_code, 'column':column, 'reason':reason}, function(data) {
					 if(data.status==0) {
						 alert(data.msg);
						 doRequest();
					 } else {
						 alert(data.msg);
					 }
				 });
			 }
		 }
		 
		 
		 //修改代理级别
		 function updateProxyLevel(custinfo_id, code) {
			if(custinfo_id) {
				clearProxyLevel();
				if(code=='first') {
					$('#pl_sumit').unbind().bind('click', function(){submitProxyLevel('null')}); 
					$("#pl_reason").hide();
					$("#pl_intpuTitle").hide();
				} else {
					$('#pl_sumit').unbind().bind('click', function(){valiProxyLevel()}); 
					$("#pl_reason").show();
					$("#pl_intpuTitle").show();
				}
				$("#pl_custinfo_id").val(custinfo_id);
			}
		 }
		 
		 function clearProxyLevel() {
			 $("#pl_custinfo_id").val("");
			 $("#pl_reason").val("");
		 }
		 
		 function valiProxyLevel() {
			var $pl_reason = $("#pl_reason");
			var pl_reason=$pl_reason.val();
			var pl_dataLen = $pl_reason.attr("data-length");
			var pl_label = $pl_reason.attr("data-label");
			var pl_be = $pl_reason.attr("must-be");
			//字数验证
			if(pl_dataLen!=undefined && pl_reason.length>pl_dataLen){
				alert(pl_label+"字数不能超过"+pl_dataLen+"!");
				flag=false;
				return false;
			} else if(pl_be && !pl_reason) {
				alert(pl_label+"不能为空!");
				flag=false;
				return false;
			}
			submitProxyLevel(pl_reason);
		 }
		 
		 //提交代理级别
		 function submitProxyLevel(reason) {
			 var custinfo_id = $("#pl_custinfo_id").val(),
			 		code = $("input[name='pl_proxy_level']:checked").val();
			 if(custinfo_id && code) {
				 $.post("/proxy/proxy/status",{'custinfo_id':custinfo_id, 'status_code':code, 'column':'${proxy_level_}', 'reason':reason}, function(data) {
					 if(data.status==0) {
						 alert(data.msg);
						 doRequest();
					 } else {
						 alert(data.msg);
					 }
				 });
			 }
		 }
		 
		//修改提示语
		 function updatePassedStatusTitle(title) {
			 $("#passedStatusTitle").text("是否确认此用户成为"+title+"？");
		 }
		
		 //选择级别数据
		 function selectTab(code, tab) {
			 $("#selectTab").val(tab);
			 $("#proxy_level").val(code);
			 doRequest();
		 }
	</script>
</body>
<!-- END BODY -->
</html>