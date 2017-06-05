<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
    <meta charset="utf-8" />
    <title>太平洋加达出国－后台管理系统 v1.0</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="description" />
    <meta content="" name="author" />
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
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
							直播间
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
                            <li>直播间</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">
                    	<%@ include  file="live_room_common.jsp"%>
						
						<form id="searchForm" method="post">
						
                        <div class="tabbable tabbable-custom">	
                            <ul class="nav nav-tabs">
                                <li ><a href="/live/list/room/${liveId }">在线用户</a></li>
                                <li><a href="/live/list/room/application/${liveId }">临时申请</a></li>
                                <li class="active"><a href="javascript:;">留言板</a></li>
                            </ul>
                             <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                        	<!-- table start -->
                                        	<button class="btn mini green" id="searchBtn" style="float: right;margin-bottom: 10px;"><i class="icon-refresh"></i> 刷新 </button>
                                            <table class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>评论时间</th>
												<th>姓名</th>
												<th>昵称</th>
												<th>手机号</th>
												<th>评论内容</th>
												<th>操作</th>
											</tr>
										</thead>

										<tbody id="list">
											<c:forEach items="${list}" var="item" varStatus = "status">
												<tr style="height:40px;">
													<td data-title="评论时间">
														<fmt:formatDate value="${item.create_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
													</td>
													<td data-title="姓名">
														<c:if test="${empty item.name}">
															未设置
														</c:if>
														<c:if test="${not empty item.name}">
															${item.name}
														</c:if>
													</td>
													<td data-title="昵称">
														<c:if test="${empty item.wx_name}">
															未设置
														</c:if>
														<c:if test="${not empty item.wx_name}">
															<script type="text/javascript">document.write(decodeURI("${item.wx_name }"));</script>
														</c:if>
													</td>
													<td data-title="手机号">
														${item.phone_num }
													</td>
													<td data-title="评论内容">
														${item.contents }
													</td>
													<td>
														<div data-id="${item.message_id}">
															<a class="btn red-stripe mini"><i class="icon-remove">删除</i></a>
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
                                            <!-- table end -->
                                        </div>
                                    </div>
                                </div>
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
	  	   //全选事件处理                
	      $("#all").toggle(
	           function() {
	           		$("input:checkbox").prop("checked",function(i,v){
						return true;   
					});
					$("div.checker>span").addClass("checked");
					$(this).attr("checked","checked");
	            },
	            function() {
	            	$("input:checkbox").prop("checked",function(i,v){
						return false;   
					});
					$("div.checker>span").removeClass("checked");
					$(this).attr("checked","");
	            }
	        );
	    //结束直播
		   $("#btnEndLive").click(function(e) {
			   if(confirm("确定要结束该直播吗?")){
					$.post(
							"/live/list/room/endLive/${live.liveId}",
							function(data) {
								if (data.status == 0) {
									alert("直播已结束");
									location.href="/live/list";
								}else if(data.status == 2){
									alert(data.msg);
								} else
									alert(data.msg);
							});
				}
          }); 
		   //刷新
	      $("i.icon-refresh").click(function(e) {
              location.reload();
          });
		   
	    //删除
			$("i.icon-remove")
					.each(
							function(index, element) {
								$(this)
										.click(
												function(e) {
													var id = $(this).parent().parent().attr("data-id");
													if(confirm("确定要删除该评论吗？")){
														$.post(
																"/live/list/room/delMessage/"+id,
																{
																	"id" : id
																},
																function(data) {
																	if (data.status == 0) {
																		alert("删除成功");
																		location.reload();
																	}else if(data.status == 2){
																		alert(data.msg);
																	} else
																		alert(data.msg);
																});
													}
												});
							});
	   
			
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
		
			//提交表单
			$("#subBtn").click(function(e) {
				$("#project_id").val("${projectId}");
				//调用验证插件，进行form表单的验证
				$("#sform").formValidate();
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