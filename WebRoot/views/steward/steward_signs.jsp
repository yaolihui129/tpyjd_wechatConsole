<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

	<link href="/views/media/css/uniform.default.css" rel="styles
	<meta content="" name="author" />

	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
heet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->
 <!--  <link rel="icon" type="image/png" href="/views/assets/i/favicon.png">
  <link rel="apple-touch-icon-precomposed" href="/views/assets/i/app-icon72x72@2x.png">
  <link rel="stylesheet" href="/views/assets/css/amazeui.min.css"/> -->
<!--   <link rel="stylesheet" href="/views/assets/css/admin.css"> -->
	<!-- BEGIN PAGE LEVEL STYLES -->


<!--  <link rel="stylesheet" href="/views/lib/css/public.min.css">  -->
 <link rel="stylesheet" href="/views/lib/css/mpublic.min.css"> 
	<!-- BEGIN PAGE LEVEL STYLES -->
<meta charset="utf-8">
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta content="width=device-width; initial-scale=1; maximum-scale=1" name="viewport">
<script type="text/javascript" src="/views/lib/stewardstar/js/jquery.min.js"></script>


	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />
    <style type="text/css">
	th{
		cursor:pointer;
	}
	th div{
		float:left;
	}
	.tree a.tree-toggle{
		padding-left:20px;
	}
	.rating span{
	font-size:16px;
	}
	</style>

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

						<h3 class="page-title">移民管家管理</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>

								<a href="/console">主页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>
                                <a href="/steward/list/">移民管家管理</a>
                                <i class="icon-angle-right"></i>
                            </li>
                            <li>
								聘用纪录
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

								<div class="actions">
									
								</div>
							</div>

					  <div class="portlet-body  no-more-tables">
                      <form id="searchForm" method="post">
                       	<div class="row-fluid">
                         <div class="span12">
                          			<div class="span3 ">
                                  		<div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">管家姓名:</label>
                                            <div class="controls">
                                                <input id="user_name" class="m-wrap small" placeholder="输入管家姓名" name="user_name" type="text" value="${user_name}">
                                            </div>
                                  		</div>
                                   	</div>
                                    <div class="span3 ">
                                  		<div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">发起用户:</label>
                                            <div class="controls">
                                                <input id="nick_name" class="m-wrap small" placeholder="输入用户昵称" name="nick_name" type="text" value="${nick_name}">
                                            </div>
                                  		</div>
                                   	</div>
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">发布状态:</label>
                                            <div class="controls">
                                                <select class="m-wrap span6" style="float:left;" id="sign_status" name="sign_status">
                                                	<option value="">全部</option>
                                                    <c:choose>
                                                    	<c:when test="${sign_status == '聘用'}">
                                                        <option value="聘用" selected>聘用</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <option value="聘用">聘用</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <c:choose>
                                                    	<c:when test="${sign_status == '解聘'}">
                                                        <option value="解聘" selected>解聘</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                        <option value="解聘">解聘</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span2 ">
                                        <div class="control-group">
                                            <button id="searchBtn" data-dismiss="modal" class="btn  green" style="float:right; margin-right:10px;">查询</button>
                                        </div>
                                    </div>
                                </div>
                          </div>
                          
                          <table class="table">
							  <thead>
								  <tr>
									 <th>发起用户</th>
                                     <th>手机号</th>
                                     <th>聘用/解聘</th>
                                     <th>管家姓名</th>
                                     <th>英文名</th>
                                     <th>解聘原因</th>
                                     <c:choose>
                                      	  <c:when test="${field=='css.update_time' && way=='asc'}">
                                              <th class="sorting_asc" data-field="css.update_time">聘用/解聘时间</th>
                                          </c:when>
                                          <c:when test="${field=='css.update_time' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="css.update_time">聘用/解聘时间</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="css.update_time">聘用/解聘时间</th>
                                          </c:otherwise>
                                      </c:choose>
								  </tr>

							  </thead>

							  <tbody id="list">
								  <c:forEach items="${list}" var="item">
									<tr>
										<td>
											<c:choose>
                                             	<c:when test="${empty item.customNickName}">
                                             		未设置
                                             	</c:when>
                                             	<c:otherwise>
                                             		<script type="text/javascript">document.write(decodeURI("${item.customNickName}"));</script>
                                             	</c:otherwise>
                                             </c:choose>
                                         </td>
                                        <td>${item.customMobile}</td>
                                        <td>${item.signStatus}</td>
                                        <td>${item.stewardName}</td>
                                        <td>${item.englishName}</td>
                                        <td><a href="" title="${item.unsignReasonTitle}">${item.unsignReason}</a></td>
                                        <td><fmt:formatDate value="${item.optTime}" type="both"/></td>
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

		<div class="footer-inner">

			2016 &copy; copyright xiuhexuan.

		</div>

		<div class="footer-tools">

			<span class="go-top">

			<i class="icon-angle-up"></i>

			</span>

		</div>

	</div>

	<!-- FOOTER -->

	<!-- BEGIN J2.1.1RIPTS(Lll reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

<!-- 	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script> -->

	<!-- <script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script> -->

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

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js"></script>
	<script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>     
	<script>
		jQuery(document).ready(function() {    

		   	App.init(); // initlayout and core plugins
		  
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

</html>