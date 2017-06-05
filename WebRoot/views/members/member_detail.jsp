<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
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
	
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
	<!-- END PAGE LEVEL SCRIPTS -->

	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
	<style type="text/css">
		.show_detail{
			font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;
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
	<div class="page-container row-fluid">
		<!-- BEGIN SIDEBAR -->

		<%@ include file="../menus.jsp"%>

		<!-- END SIDEBAR -->
	

		<!-- BEGIN PAGE -->  
		<div class="page-content">

			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<div id="portlet-config" class="modal hide">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"></button>
					<h3>portlet Settings</h3>
				</div>

				<div class="modal-body">
					<p>Here will be a configuration form</p>
				</div>
			</div>

			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->   
				<div class="row-fluid">
					<div class="span12">
						
						<h3 class="page-title">
							用户详情
							 <small></small>
						</h3>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>
							
							<li>
								<a href="/members">注册用户列表</a> 
								<span class="icon-angle-right"></span>
							</li>
							
							<li> 用户详情
							</li>
						</ul>
					</div>
				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">
					<!--  --><div class="span12">
						<div class="tabbable tabbable-custom boxless">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab_1" data-toggle="tab">基本信息</a></li>
								<li><a class="" href="#tab_2" data-toggle="tab">评估结果</a></li>
							</ul>

							<div class="tab-content">
								<!-- 会员基本信息 开始 -->
								<div class="tab-pane active" id="tab_1">
									<div class="portlet box green">
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>基本信息</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>

										<div class="portlet-body form">

											<!-- BEGIN FORM-->

											<form action="#" class="form-horizontal" id="memberForm" method="get">
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">头像：</label>
															<div class="controls show_detail" >
																<c:if test="${not empty cust.headImg }"><img alt="" src="${cust.headImg }" width="97" height="97"> </c:if>
																<c:if test="${empty cust.headImg }">未设置</c:if>
															</div>
														</div>
													</div>
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">登录名：</label>
															<div class="controls show_detail" >
																<c:if test="${not empty cust.loginName }">${cust.loginName }</c:if>
																<c:if test="${empty cust.loginName }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">城市：</label>
															<div class="controls show_detail" >
																<c:if test="${not empty ss }">${ss }</c:if>
																<c:if test="${empty ss }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">手机号：</label>
															<div class="controls show_detail" >
																<c:if test="${not empty cust.phoneNum }">${cust.phoneNum }</c:if>
																<c:if test="${empty cust.phoneNum }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">真实姓名：</label>
															<div class="controls show_detail" >
																<c:if test="${not empty cust.name }">${cust.name }</c:if>
																<c:if test="${empty cust.name }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">会员来源：</label>
															<div class="controls show_detail" >
																<c:if test="${empty memberSource }">
																	未知
																</c:if>
																<c:if test="${not empty memberSource }">
																	${memberSource }
																</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">性别：</label>
															<div class="controls show_detail" >                                                
																<c:if test="${cust.gender == 'm' }"> 男</c:if>
																<c:if test="${cust.gender == 'f' }"> 女</c:if>
																<c:if test="${empty cust.gender }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">是否做过评估：</label>
															<div class="controls show_detail" >                                                
																${ifEstimate }
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">出生日期：</label>
															<div class="controls show_detail" >                                                
																
																<c:if test="${not empty cust.birthday }"><fmt:formatDate value="${cust.birthday }" pattern="yyyy-MM-dd"/></c:if>
																<c:if test="${empty cust.birthday }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">注册时间：</label>
															<div class="controls show_detail" >                                                
																<fmt:formatDate value="${cust.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">微信昵称：</label>
															<div class="controls show_detail" >
																<c:if test="${not empty cust.wxName }"><script type="text/javascript">document.write(decodeURI("${cust.wxName }"));</script></c:if>
																<c:if test="${empty cust.wxName }">未设置</c:if>                                                
																
															</div>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">代理人：</label>
															<div class="controls show_detail" >                                                
																${dlr }
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">用户昵称：</label>
															<div class="controls show_detail" >                                                
																<c:if test="${not empty cust.nickName }">${cust.nickName }</c:if>
																<c:if test="${empty cust.nickName }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div>

												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">最后登录时间：</label>
															<div class="controls show_detail" >                                                
																<c:if test="${not empty cust.lastTime }"><fmt:formatDate value="${cust.lastTime }" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>
																
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">邮箱地址：</label>
															<div class="controls show_detail" >                                                
																<c:if test="${not empty cust.email }">${cust.email }</c:if>
																<c:if test="${empty cust.email }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div> 
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">最后登录IP：</label>
															<div class="controls show_detail" >      
																<c:if test="${empty cust.lastIp }">
																	未知
																</c:if>                                          
																<c:if test="${not empty cust.lastIp }">
																	${cust.lastIp }
																</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">备用手机：</label>
															<div class="controls show_detail" >                                                
																<!-- 联系电话 -->
																<c:if test="${not empty cust.contact }">${cust.contact }</c:if>
																<c:if test="${empty cust.contact }">未设置</c:if>
															</div>
														</div>
													</div>
													<!--/span-->
												</div>
												
												<div class="row-fluid">
													<div class="span6 ">
														<div class="control-group">
															<label class="control-label">会员状态：</label>
															<div class="controls show_detail" >                                                
																<c:if test="${empty memberStatus }">
																	启用
																</c:if>                                          
																<c:if test="${not empty memberStatus }">
																	${memberStatus }
																</c:if>
															</div>
														</div>
													</div>
												</div>           
												
												
											</form>
											<!-- END FORM-->                
										</div>
									</div>
								</div>
								<!-- 会员基本信息 结束 -->
							
								<!-- 评估结果 开始 -->
								<div class="tab-pane " id="tab_2">
									<div class="portlet box blue">
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>评估结果</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>

										<div class="portlet-body form">
											<!-- BEGIN FORM-->
											<form action="#" class="form-horizontal" id="estimateForm" method="get">
												<c:if test="${notEmpty == 0 }">
													<span style="font-size: 22px;">此会员尚未进行评估</span>
												</c:if>
												<c:if test="${notEmpty != 0 }">
													<h3 class="form-section">评估问卷</h3>
													<div class="row-fluid">
														<div class="span6 ">
															<div class="control-group">
																<label class="control-label" style="width: 230px;">评估时间：</label>
																<div class="controls show_detail" >
																	<c:if test="${not empty estimateTime }">
																		<fmt:formatDate value="${estimateTime }" pattern="yyyy-MM-dd"/>	
																	</c:if>
																</div>
															</div>
														</div>
													</div>
													
													<c:forEach items="${estimateRecord }" var="item" varStatus="status">
															<c:if test="${status.index%2 == 0 }">
																<div class="row-fluid">
															</c:if>
															
																<div class="span6 ">
																	<div class="control-group">
																		<label class="control-label" style="width: 230px;">
																		<c:if test="${not empty item.title }">
																			<script type="text/javascript">document.write("${item.title }".replace("？", "").replace("?", ""));</script>：
																		</c:if>
																		</label>
																		<div class="controls show_detail" >
																			<c:if test="${not empty item.content }">
																				${item.content }
																			</c:if>
																			<c:if test="${empty item.content }">
																				${item.int_value }
																			</c:if>
																		</div>
																	</div>
																</div>
															
															<c:if test="${status.index%2 == 1  || status.last}">
																</div>
															</c:if>
														</c:forEach>
													 
													<h3 class="form-section">评估结果</h3>
													
													<c:if test="${!empty resultList}">
														<c:forEach var="item" items="${resultList}"  varStatus="status">
															<%-- <c:if test="${status.count <=3}"> --%>
																<div class="row-fluid">
																	<div class="span6 ">
																		<div class="control-group">
																			<label class="control-label" style="width: 230px;">
																			方案${status.count}：
																			</label>
																			<div class="controls show_detail" >
																				${item.projectName}
																			</div>
																		</div>
																	</div>
																	<div class="span6 ">
																		<div class="control-group">
																			<label class="control-label" style="width: 230px;">匹配度：</label>
																			<div class="controls show_detail" >
																				<c:if test="${item.matching != null}">${item.matching}%</c:if>
																			</div>
																		</div>
																	</div>
																</div>
															<%-- </c:if> --%>
															
														</c:forEach>
													</c:if>
												</c:if>
												
												
											</form>
											<!-- END FORM-->                
										</div>
									</div>
								</div>
								<!-- 评估结果 结束 -->
								<div class="form-actions">
									<button type="button" class="btn" id="back"><i class="icon-undo"></i> 返回 </button>
									<button class="btn green" id="callBtn"><i class="icon-headphones"></i> 外呼 </button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- END PAGE CONTENT-->         
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->  
	</div>
	<!-- END CONTAINER -->


	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>	
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	<script>
		jQuery(document).ready(function() {    
		   // initiate layout and plugins
		   App.init();
		   FormSamples.init();
		   TableAdvanced.init();
		   
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		   
		 //提交表单
			$("#subBtn")
					.click(
							function(e) {

								var fromurl = document.referrer;
								$("#fromurl").val(fromurl);
								//调用验证插件，进行form表单的验证
								$("#memberForm").formValidate();
							});
		   
		});
		
		//外呼
		$("#callBtn").on("click",function(){
		$("#callBtn").prop("disabled", true);
    	$.ajax({
            url: '/callcenter',
            data:{
            	Called:"${cust.custinfoId }",//指定被叫号码
            	Caller:"${userId}"//主叫号码
            },
            type: "get",
            dataType: "json",
            success: function (result) {
            	$("#callBtn").prop("disabled", false);
            	if(result.code == 100){
            		alert(result.msg);
            	}else{
            		
            	}
            }
    	}) 
	});
	</script>
	<!-- END JAVASCRIPTS -->   
<!-- 
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>
 -->
<!-- END BODY -->
</html>