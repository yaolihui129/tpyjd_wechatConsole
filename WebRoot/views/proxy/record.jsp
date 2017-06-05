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
						<h3 class="pull-left">变更记录</h3>
						<ul class="breadcrumb clear">
							<li>
								<i class="icon-home"></i>
								<a href="/console">首页</a> 
								<i class="icon-angle-right"></i>
							</li>
                            <li>
								<a href="/proxy/proxy">渠道分销</a>
								<i class="icon-angle-right"></i>
							</li>
                            <li>
								<a href="/proxy/proxy/details/${custinfo.custinfoId}">分销商查看</a>
								<i class="icon-angle-right"></i>
							</li>
                            <li>变更记录</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				
				
				<div class="row-fluid">
					<div class="span12">
						<div class="portlet-body form">
							<div class="form-horizontal form-view">
							
								<h4 class="form-section">${custinfo.name}的权限变更记录</h4>
								<div class="row-fluid">
									<div class="span12">
										<ul class="timeline">
										
											<c:forEach var="item" items="${statusRecordList}">
												<li class="timeline-grey">
													<div class="timeline-time">
														<span class="date"><fmt:formatDate value="${item.update_time}" pattern="yyyy.MM.dd" /></span>
														<span class="time"><fmt:formatDate value="${item.update_time}" type="time"  pattern=" HH:mm"/></span>
													</div>
													<div class="timeline-icon"></div>
													<div class="timeline-body">
														<h4>状态变更：${item.status_name}</h4>
														<div class="timeline-footer">理由：${item.reason}</div>
													</div>
												</li>
											</c:forEach>
											
										</ul>
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
	
</body>
<!-- END BODY -->
</html>