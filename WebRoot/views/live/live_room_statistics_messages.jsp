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
                    <div class="span12" style="margin-top:10px;">
                        <!-- BEGIN STYLE CUSTOMIZER -->
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">用户评论</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/live/list/statistics/${live_id}">返回</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                	<div class="span12" style="font-size:14px">
                	  <form id="searchForm" method="post">
                                    <div class="row-fluid">
                                      <table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th width="20%">评论时间</th>
												<th>评论内容</th>
											</tr>
										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item" varStatus = "status">
												<tr style="height:40px;">
													<td data-title="评论时间">
														<fmt:formatDate value="${item.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													
													<td data-title="评论内容">
														<script>document.write(decodeURI("${item.contents }"));</script>
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