<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <meta charset="utf-8" />
    <title>太平洋加达出国－后台管理系统 v1.0</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
    <link rel="stylesheet" href="/views/media/css/DT_bootstrap.css" />
    <link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
		.show_detail{
			font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;
		}
	</style>
</head>
<body class="page-header-fixed">
    <!-- BEGIN HEADER -->
    <%@ include  file="../navi.jsp"%>
    <!-- END HEADER -->
    <!-- BEGIN CONTAINER -->
    <div class="page-container row-fluid">
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
                        <!-- BEGIN STYLE CUSTOMIZER -->
                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							直播间《${live_title}》
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">首页</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/live/list">直播内容</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>报名详情</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">
						
						<form id="searchForm" method="post">
                                        <div class="row-fluid">
                                            <table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>用户姓名</th>
												<th>手机号</th>
												<th>城市</th>
												<th>报名结果</th>
												<th>报名时间</th>
												<th>操作</th>
											</tr>
										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item" varStatus = "status">
												<tr style="height:40px;">
													<td data-title="用户姓名">
														<c:if test="${empty item.name}">
															未设置
														</c:if>
														<c:if test="${not empty item.name}">
															${item.name}
														</c:if>
													</td>
													<td data-title="手机号">
														${item.phone_num }
													</td>
													<td data-title="城市">
														<c:if test="${empty item.city}">
															未设置
														</c:if>
														<c:if test="${not empty item.city}">
															${item.city}
														</c:if>
													</td>
													<td data-title="报名结果">
														<c:choose>
															<c:when test="${item.status=='002700020002'}">驳回</c:when>
															<c:when test="${item.status=='002700020001'}">通过</c:when>
															<c:otherwise>
																取消参与资格
															</c:otherwise>
														</c:choose>
													</td>
													<td data-title="报名时间">
														<fmt:formatDate value="${item.create_time }" pattern="yyyy年MM月dd日 HH:mm:ss"/>
													</td>
													<td>
														<div data-id="${item.application_id}">
														<c:choose>
															<c:when test="${item.status=='002700020002'}">
																<a class="btn red-stripe mini"><i class="icon-ok-sign">开通资格</i></a>
															</c:when>
															<c:when test="${item.status=='002700020001'}">
																<a class="btn red-stripe mini"><i class="icon-remove-sign">驳回资格</i></a>
															</c:when>
															<c:otherwise>
															
															</c:otherwise>
														</c:choose>
															
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
                                    
                        </div>
                        </form>
                    </div>

                    <!-- END PAGE CONTENT-->
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
		<script src="media/js/excanvas.min.js"></script>
		<script src="media/js/respond.min.js"></script>  
		<![endif]-->
        <script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
        <script src="/views/media/js/jquery.uniform.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script type="text/javascript" src="/views/media/js/bootstrap-fileupload.js"></script>
        <script type="text/javascript" src="/views/media/js/select2.min.js"></script>
        <script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="/views/media/js/app.js"></script>
        <script src="/views/media/js/form-samples.js"></script>
        <script src="/views/media/js/form-components.js"></script>

        <!-- END PAGE LEVEL SCRIPTS -->
		<script src="/views/media/js/form-validate.js"></script>     
		
        <script>
		jQuery(document).ready(function() {

		   App.init(); // initlayout and core plugins
	  	  
		   //开通参与资格
		   $("i.icon-ok-sign").each(function(index, element) {
				$(this).click(
					function(e) {
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("确定开通用户参与资格?")){
							$.post("/live/list/signupCheck/"+id,
									{
										"type" : 0
									},
									function(data) {
										if (data.status == 0) {
											alert("参与资格已开通");
											location.reload();
										} else
											alert(data.msg);
							});
						}
						
					});
			});
			
			//驳回参与资格
		   $("i.icon-remove-sign").each(function(index, element) {
				$(this).click(
					function(e) {
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("确定驳回用户参与资格?")){
							$.post("/live/list/signupCheck/"+id,
									{
										"type" : 1
									},
									function(data) {
										if (data.status == 0) {
											alert("参与资格已驳回");
											location.reload();
										} else
											alert(data.msg);
							});
						}
						
					});
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
		
		});

		//提交查询请求
		function doRequest(){
			//$("#searchForm").submit();
			$("#searchForm").formValidate();
		}
	</script>
        <!-- END JAVASCRIPTS -->

</body>
<!-- END BODY -->

</html>