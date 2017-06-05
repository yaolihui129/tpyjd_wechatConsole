<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES --> 
	
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
    
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    
   
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

			<!-- BEGIN PAGE CONTAINER-->

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->

				<div class="row-fluid">

					<div class="span12">  

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->

						<h3 class="page-title">${operation}</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>
								<a href="/">主页</a> 
								<i class="icon-angle-right"></i>
							</li>

							<li>
								<a href="/steward/list">移民管家管理<i class="icon-angle-right"></i></a>
                            </li>
	
							<li>
                                管家详情
                                <i class="icon-angle-right"></i>
                            </li>
							<li>
								基本信息
							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<div class="row-fluid">
                    <div class="portlet-body">
                    	 <div class="tabbable tabbable-custom tabbable-full-width">

							<ul class="nav nav-tabs">

								<li class="active"><a href="/steward/list/detail/${stewardId}">基本信息</a></li>

								<li><a href="/steward/list/detail/evalute/${stewardId}">评价信息</a></li>

								<li><a href="/steward/list/detail/sign/${stewardId}">聘用纪录</a></li>

								<li><a href="/steward/list/detail/customer/${stewardId}">服务用户</a></li>

								<li><a href="/steward/list/detail/like/${stewardId}">点赞人数</a></li>

							</ul>

							<div class="tab-content">

								<div class="tab-pane row-fluid active">
                                <table width="70%" border="0" cellspacing="10" cellpadding="5">
                                  <tr>
                                    <td width="16%">管家姓名：</td>
                                    <td width="84%">${cu.userName}</td>
                                  </tr>
                                  <tr>
                                    <td>英文名：</td>
                                    <td>${cu.englishName}</td>
                                  </tr>
                                  <tr>
                                    <td>照片：</td>
                                    <td>
                                    	<c:if test="${empty cu.headImg}">
                                        	<img src="/images/default.jpg" width="80" style="border:#ccc 1px solid;padding:3px;"/>
                                        </c:if>
                                        <c:if test="${!empty cu.headImg}">
                                        	<img src="${cu.headImg}" width="80"/>
                                        </c:if>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td>微信：</td>
                                    <td>
                                   		<c:if test="${empty cu.wechat}">
                                        	<img src="/images/default.jpg" width="80" style="border:#ccc 1px solid;padding:3px;"/>
                                        </c:if>
                                        <c:if test="${!empty cu.wechat}">
                                        	<img src="${cu.wechat}" width="80"/>
                                        </c:if>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td>性别：</td>
                                    <td>
                                    ${gender}
                                    </td>
                                  </tr>
                                  <tr>
                                    <td>头衔：</td>
                                    <td>${cu.jobTitle}</td>
                                  </tr>
                                  <tr>
                                    <td>手机号：</td>
                                    <td>${cu.phone}</td>
                                  </tr>
                                  <tr>
                                    <td>QQ：</td>
                                    <td>${cu.qq}</td>
                                  </tr>
                                  <tr>
                                    <td>Email：</td>
                                    <td>${cu.email}</td>
                                  </tr>
                                  <tr>
                                    <td>所在地区：</td>
                                    <td>${province}-${city}</td>
                                  </tr>
                                  <tr>
                                    <td>状态：</td>
                                    <td>${su.releaseMark}</td>
                                  </tr>
                                  <tr>
                                    <td>启用名片：</td>
                                    <td>
                                    	<c:choose>
                                        	<c:when test="${su.cardStatus==1}">
                                            可用
                                            </c:when>
                                            <c:otherwise>
                                            不可用
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td>已服务：</td>
                                    <td>${num}</td>
                                  </tr>
                                  <tr>
                                    <td>点赞：</td>
                                    <td>${su.likeCount}次</td>
                                  </tr>
                                  <tr>
                                    <td>个人简介：</td>
                                    <td>${cu.introduce}</td>
                                  </tr>
                                </table>
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

			2016 &copy; copyright pacificimmi.

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

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script> 
		jQuery(document).ready(function() {     
		    App.init(); // initlayout and core plugin 
			
		});
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>