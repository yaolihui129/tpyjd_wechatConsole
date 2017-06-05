<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css" />
    <link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
    <link rel="stylesheet" href="/views/media/css/DT_bootstrap.css" />

    <!-- END PAGE LEVEL SCRIPTS -->
    <link rel="shortcut icon" href="/views/media/image/favicon.ico" />
	<script src="/js/laydate/laydate.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

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
                <div class="span12">
                    <ul class="breadcrumb" style="margin-top:10px; background-color: #fff;">
                        <li>
                            <i class="icon-home"></i>
                            <a href="/console">首页</a>
                            <span class="icon-angle-right"></span>
                        </li>
                    </ul>
                </div>
                <div class="row-fluid">
                    <h3 class="form-section">名片流量管理</h3>
                    <div class="span11 responsive" data-tablet="span12 fix-offset" data-desktop="span12">
                        <!-- BEGIN EXAMPLE TABLE PORTLET-->
                        <div class="portlet box grey">
                            <div class="portlet-title">

                                <div class="actions">
                                    <!-- <a href="/project/base/add" class="btn blue"><i class="icon-pencil"></i> 添加</a>
                                    <div class="btn-group">
                                        <a class="btn green" href="#" data-toggle="dropdown">
                                            <i class="icon-cogs"></i> 工具
                                            <i class="icon-angle-down"></i>
                                        </a>
                                        <ul class="dropdown-menu pull-right">
                                            <li><a id="batchDel"><i class="icon-trash"></i> 删除</a></li>
                                            <li><a href="#"><i class="icon-signin"></i> 导入数据</a></li>
                                            <li><a href="#"><i class="icon-signout"></i> 导出模版</a></li>
                                            <li class="divider"></li>
                                            <li><a href="#"><i class="i"></i> Make admin</a></li>
                                        </ul>
                                    </div> -->
                                </div>
                            </div>
                            <div class="portlet-body">
							<form id="searchForm" method="get"> <!-- class="form-horizontal"> -->
                                <%-- <div class="span12">
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">项目状态:</label>
                                            <div class="controls">
												<select class="m-wrap span9" style="float:left;" name="project_status">
													<option></option>
													<c:if test="${projectStatusList != null}" >
														<c:forEach var="item" items="${projectStatusList}">
															<option value="${item.dictCode}" <c:if test="${project_status != null and project_status == item.dictCode}">selected="selected"</c:if>>${item.name}</option>
														</c:forEach>
													</c:if>
												</select>
											</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="span12" style="clear:both; margin-left:0;margin-bottom:20px;">
                                    <a href="/projects" class="btn"  style="float:right; margin-right:10px;">取消</a>
                                    <button id="searchBtn" data-dismiss="modal" class="btn  green" style="float:right; margin-right:10px;">查询</button>
                                </div> --%>
                                
                                <table class="table table-striped table-bordered table-hover" >
                                    <thead>
                                        <tr>
                                            <th>序号</th>
											  <th width="" class="" data-field="">名片归属人</th>
											  <th width="" class="" data-field="">浏览量</th>
											  <th width="" class="" data-field="">已报名人数</th>
											  <th width="" class="" data-field="">转化率</th>
											  <!-- <th width="" class="" data-field="">访问源（url）</th>
											  <th width="" class="" data-field="">转发时间</th>
											  <th width="" class="" data-field="">转发人</th> -->
                                        </tr>
                                    </thead>
                                    <tbody  id="list">
										<c:forEach items="${list}" var="item" varStatus="status">
                                        <tr class="odd gradeX">
                                        	<td>${status.count}</td>
											<td>
												<c:choose>
													<c:when test="${item.user_id == -1}">公司名片</c:when>
													<c:otherwise>${item.user_name}</c:otherwise>
												</c:choose>
											</td>
											<td>${item.browse_num}</td>
											<td><c:if test="${item.enrol_num>0}">${item.enrol_num}</c:if></td>
											<td><c:if test="${item.percent != null}">${item.percent}‰</c:if></td>
											<%-- <td>${item.url}</td>
											<td><fmt:formatDate value="${item.create_time}" type="date"/></td>
											<td>
												<c:choose>
													<c:when test="${item.send_user_name != null}">
														${item.send_user_name}
													</c:when>
													<c:otherwise>
														${item.send_wx_name}
													</c:otherwise>
												</c:choose>
											</td> --%>
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
                        <!-- END EXAMPLE TABLE PORTLET-->
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
            2013 &copy; Metronic by keenthemes.
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

	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>

	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>

	<!--<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>-->

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js"></script>
	<script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>     
    <!-- END PAGE LEVEL SCRIPTS -->
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
				
				//批量删除
				$("#batchDel").click(function(e) {
                   var checks = $("input.checkboxes:checked");
					if(checks.size()>0){
						var ids="";
						checks.each(function(index, element) {
                            if(ids=="")
								ids=$(this).val();
							else{
								ids = ids+","+$(this).val();
							}
                        });
						//dosomething
						$.post("/projects/remove",{"ids":ids},function(data){
							if(data.status==0){
								checks.each(function(index, element) {
									$(this).parents("#list>tr").remove();
								});
							}
							else{
								alert("删除失败");
							}
						});
					}
					else{
						alert("请选择其中一行");	
					}
                });
			
			//绑定内容编辑
				$("a.edit").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).attr("data-id");
						location.href="/project/base/update/"+id;
					});		
                });
			
			//绑定删除按钮
				$("a.trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).attr("data-id");
						$.post("/projects/remove",{"ids":id},function(data){
							if(data.status==0){
								$(element).parents("#list>tr").remove();
							}
							else
								alert("删除失败");
						});
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
		
		//暂停操作
		function stop(id) {
			$.post("/projects/stop/"+id, function(data){
				if(data.status==0) {
					doRequest();
				} else {
					alert("暂停操作失败！");
				}
			});
		}
		
		//提交查询请求
		function doRequest(){
			$("#searchForm").formValidate();
		}
	</script>
    <!--END JAVASCRIPTS-->
</body>
<!--END BODY-->
</html>