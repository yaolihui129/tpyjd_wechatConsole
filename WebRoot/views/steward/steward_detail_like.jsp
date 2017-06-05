<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

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
								点赞人数
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

								<li><a href="/steward/list/detail/${stewardId}">基本信息</a></li>

								<li><a href="/steward/list/detail/evalute/${stewardId}">评价信息</a></li>

								<li><a href="/steward/list/detail/sign/${stewardId}">聘用纪录</a></li>

								<li><a href="/steward/list/detail/customer/${stewardId}">服务用户</a></li>

								<li class="active"><a href="/steward/list/detail/like/${stewardId}">点赞人数</a></li>

							</ul>

							<div class="tab-content">
								<div class="tab-pane active">
                                	<form id="searchForm" method="post">
                                    <div class="row-fluid">
                                    <table width="100%" border="0" cellspacing="2" cellpadding="0" height="80">
                                      <tr>
                                        <td width="25%">管家姓名:${stewardName}</td>
                                        <td width="75%">英文名:${englishName}</td>
                                      </tr>
                                      <tr>
                                        <td>共获得客户<font color="red">${totle}</font>个赞</td>
                                        <td>&nbsp;</td>
                                      </tr>
                                    </table>
                                      <table class="table">
                                          <thead>
                                              <tr>
                                                 <th>用户昵称</th>
                                                 <th>手机号</th>
                                                 <th>处理状态</th>
                                                 
                                                 <th>来源</th>
                                                 <c:choose>
                                                      <c:when test="${field=='csl.create_time' && way=='asc'}">
                                                          <th class="sorting_asc" data-field="csl.create_time">时间</th>
                                                      </c:when>
                                                      <c:when test="${field=='csl.create_time' && way=='desc'}">
                                                          <th  class="sorting_desc" data-field="csl.create_time">时间</th>
                                                      </c:when>
                                                      <c:otherwise>
                                                         <th class="sorting" data-field="csl.create_time">时间</th>
                                                      </c:otherwise>
                                                  </c:choose>
                                              </tr>
            
                                          </thead>
            
                                          <tbody id="list">
                                              <c:forEach items="${list}" var="item">
                                                <tr>
                                                    <td><c:choose>
                                             	<c:when test="${empty item.nickName}">
                                             		未设置
                                             	</c:when>
                                             	<c:otherwise>
                                             		<script type="text/javascript">document.write(decodeURI("${item.nickName}"));</script>
                                             	</c:otherwise>
                                             </c:choose></td>
                                                    <td>${item.phoneNum}</td>
                                                    <td>${item.custStatus}</td>
                                                    <td>${item.custSource}</td>
                                                    <td><fmt:formatDate value="${item.time}" type="both"/></td>
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
                </div>
			</div>
			<div id="hideBox" class="modal hide fade" tabindex="-1" role="dialog"  aria-hidden="true" style="display: none;">

                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>

                    <h3>隐藏后用户不可看到该评价，是否继续隐藏？</h3>

                </div>
				<form id="hideForm" action="/steward/list/detail/evaluateHide" method="post">
                <div class="modal-body">

                    <table width="100%" border="0" cellspacing="10" cellpadding="10">
                      <tr>
                        <td><font color="#FF0000">*</font>隐藏原因：</td>
                      </tr>
                      <tr>
                        <td><textarea id="reason" name="reason" rows="5" must-be="true" style="width:495px;"></textarea></td>
                      </tr>
                    </table>

                </div>

                <div class="modal-footer">

                    
                    <input type="hidden" name="vid" id="vid" value="" />
					<input type="hidden" name="from" id="from" value="" />
                    <a id="hideBtn" class="btn yellow">隐藏</a>
                    <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>

                </div>
				</form>
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
    <script src="/views/media/js/form-validate.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script> 
		jQuery(document).ready(function() {     
		    App.init(); // initlayout and core plugin 
		  
			//搜索触发
			$("#searchBtn").click(function(e) {
				doRequest();
			});
			
			//排序事件处理
			$(".sorting,.sorting_asc,.sorting_desc").each(function(index, element) {
				$(this).click(function(e) {
					var field = $(this).attr("data-field");
					$("#field").val(field);
					
					$(this).siblings(".sorting,.sorting_asc,.sorting_desc").attr("class","sorting");
					if($(this).attr("class")=="sorting"){
						$(this).attr("class","sorting_asc");
						$("#way").val("asc");
						//do something
						doRequest();
					}
					else if($(this).attr("class")=="sorting_asc"){
						$(this).attr("class","sorting_desc");
						$("#way").val("desc");
						//do something
						doRequest();
					}
					else{
						$(this).attr("class","sorting_asc");
						$("#way").val("asc");
						//do something
						doRequest();
					}
				});
			});
		
			
		//绑定翻页
			$('li.pages').each(function(index, element) {
				if($(element).attr("data-page")!=undefined){
					$(this).click(function(e) {
						$("#page").val($(element).attr("data-page"));
						doRequest();
					});
				}
			});
			
			//提交查询请求
			function doRequest(){
				//$("#searchForm").submit();
				$("#searchForm").formValidate();
			}
		});
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>