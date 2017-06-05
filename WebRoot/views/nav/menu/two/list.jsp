<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<%@ include  file="../../../navi.jsp"%>
	<!-- END HEADER -->
	<!-- BEGIN CONTAINER -->
	<div class="page-container">
		<!-- BEGIN SIDEBAR -->
		<%@ include  file="../../../menus.jsp"%>
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
						<h3 class="pull-left">二级菜单</h3>
						<ul class="breadcrumb clear">
							<li>
								<i class="icon-home"></i>
								<a href="/console">首页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a href="/official/nav/menu">导航菜单</a> 
								<i class="icon-angle-right">
							</i>
                            <li>二级菜单</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->
				<h4 class="form-section">一级菜单：${one.menuName}</h3>
				<div class="portlet box grey">
							<div class="portlet-title">
								<div class="actions">
                                    <a href="/official/nav/menu/two/add/${one.navMenuId}" class="btn blue"><i class="icon-pencil"></i>新增</a>
                                </div>
							</div>
							<div class="portlet-body">
								<form id="searchForm" method="post">
								<table class="table table-striped table-bordered table-hover" id="sample_2">
									<thead>
										<tr>
											<th>序号</th>
											<th>二级菜单</th>
											<c:if test="${menu_type_cdl==one.menuType}">
												<th>链接</th>
											</c:if>
											<th>新窗口打开</th>
                                            <th>快捷操作</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${list != null}">
											<c:forEach var="item" items="${list}" varStatus="status">
												<tr>
													<td><c:out value="${status.count}" /></td>
													<td>${item.menu_name}</td>
													<c:if test="${menu_type_cdl==one.menuType}">
														<td>${item.menu_url}</td>
													</c:if>
													<td>${item.open_mode_name}</td>
													<td>
														<c:choose>
		                                            		<c:when test="${now == 1 and status.count == 1}"></c:when>
		                                            		<c:otherwise>
																<a href="javascript:;" onclick="orderUpdata('${item.nav_menu_id}', 'up');" class="btn black-stripe mini"><i class="icon-arrow-up"></i> 上移</a>
		                                            		</c:otherwise>
		                                            	</c:choose>
		                                            	<c:choose>
		                                            		<c:when test="${now==page and status.count==fn:length(list)}"></c:when>
		                                            		<c:otherwise>
		                                            			<a href="javascript:;" onclick="orderUpdata('${item.nav_menu_id}', 'down');" class="btn black-stripe mini"><i class="icon-arrow-down"></i> 下移</a>
		                                            		</c:otherwise>
		                                            	</c:choose>
														<%-- <a href="javascript:void(0);" class="btn red-stripe mini" onclick="updataStatus('${item.nav_menu_id}');"><i class="icon-trash"></i>发布</a> --%>
														<a href="javascript:void(0);" class="btn red-stripe mini" onclick="del('${item.nav_menu_id}');"><i class="icon-trash"></i> 删除</a>
														<a  href="/official/nav/menu/two/updata/${item.nav_menu_id}" class="btn green-stripe mini edit"><i class="icon-edit"></i> 编辑</a>
														<c:if test="${menu_type_cdl != one.menuType}">
															<a href="/official/nav/menu/three/${item.nav_menu_id}" class="btn blue-stripe mini" ><i class="icon-sitemap"></i>子菜单</a>
														</c:if>
													</td>
												</tr>
											</c:forEach>
										</c:if>
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
		
		//删除
		function del(id) {
			if(confirm("确定要删除吗？")){
				$.post("/official/nav/menu/two/delete/"+id, function(data){
					if(data.status==0) {
						alert(data.msg);
						window.location.reload();
					} else {
						alert(data.msg);
					}
				})
			}
		}
		
		//排序
		function orderUpdata(id, order) {
			$.post("/official/nav/menu/two/order", {'id':id, 'order':order}, function(data){
				if(data.status==0) {
					/* alert(data.msg); */
					window.location.reload();
				} else {
					alert(data.msg);
				}
			})
		}
		
		
		/* //状态修改
		function updataStatus(id) {
			$.post("/official/nav/menu/release",{'id':id}, function(data){
				if(data.status==0) {
					alert(data.msg);
					window.location.reload();
				} else {
					alert(data.msg);
				}
			})
		} */
	</script>
</body>
<!-- END BODY -->
</html>