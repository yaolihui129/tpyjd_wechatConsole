<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
						<h3 class="pull-left">客户反馈</h3>
						<ul class="breadcrumb clear">
							<li>
								<i class="icon-home"></i>
								<a href="/console">首页</a> 
								<i class="icon-angle-right"></i>
							</li>
                            <li>客户反馈</li>
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
								<table class="table table-striped table-bordered table-hover" id="sample_2">
									<thead>
										<tr>
											<th>序号</th>
											<th>客户姓名</th>
											<th>手机号</th>
											<th>联系方式</th>
											<th>版本</th>
											<th>反馈效率</th>
											<th>问答专业度</th>
											<th>及时回访</th>
											<th>留言</th>
											<th>提交时间</th>
										 </tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${list}" varStatus="status">
											<tr class="odd gradeX">
												<td><c:out value="${status.count}"/></td>
												<td>${item.custinfo_name}</td>
												<td>${item.phone_num}</td>
												<td>${item.contact_way}</td>
												<td>${item.version}</td>
												<td>${item.feedback_name}</td>
												<td>${item.profession_degree_name}</td>
												<td>${item.call_back_name}</td>
												<td>
														<c:choose>
															<c:when test="${fn:length(item.message) > 18}">
																<span class="popovers" data-trigger="hover" data-placement="top" data-content="${item.message}">
																<c:out value="${fn:substring(item.message, 0, 20)}..." />
															</c:when>
															<c:otherwise>
																${item.message}
															</c:otherwise>
														</c:choose>
													</span>
												</td>
												<td><fmt:formatDate value="${item.create_time}" type="both"/></td>
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
	
	</script>
</body>
<!-- END BODY -->
</html>