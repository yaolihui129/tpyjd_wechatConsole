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

	<!-- BEGIN PAGE LEVEL STYLES -->

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
	</style>

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

	<!-- BEGIN HEADER -->

	<%@ include  file="/views/navi.jsp"%>

	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->

	<div class="page-container">

		<!-- BEGIN SIDEBAR -->

		<%@ include  file="/views/menus.jsp"%>

		<!-- END SIDEBAR -->

		<!-- BEGIN PAGE -->

		<div class="page-content">

			<!-- BEGIN PAGE CONTAINER-->

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->

				<div class="row-fluid">

					<div class="span12"> 

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->

						<h3 class="page-title">活动管理</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>

								<a href="/">主页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>活动管理</li>
							
							<li class="pull-right no-text-shadow">

								<div id="dashboard-report-range" class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive" data-tablet="" data-desktop="tooltips" data-placement="top" data-original-title="Change dashboard date range">

									<i class="icon-calendar"></i>

									<span></span>

									<i class="icon-angle-down"></i>

								</div>

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

									<a href="/cms/activitys/activity/add" class="btn blue addnew"><i class="icon-pencil"></i> 新增</a>

									<div class="btn-group">

										<a class="btn green" href="#" data-toggle="dropdown">

										<i class="icon-cogs"></i> 批量操作

										<i class="icon-angle-down"></i>

										</a>

										<ul class="dropdown-menu pull-right">
											<li><a id="batchDel"><i class="icon-trash"></i> 批量删除</a></li>
										</ul>

									</div>

								</div>

							</div>

					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" method="get">
                       	<div class="row-fluid">
                              <div class="span6">
                              	<select id="status" name="status">
                                		<option value="">全部状态</option>
											<c:choose>
												<c:when test="${'未发布'==status_selected}">
													<option value="未发布" selected>未发布</option>
												</c:when>
												<c:otherwise>
													<option value="未发布">未发布</option>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${'已发布'==status_selected}">
													<option value="已发布" selected>已发布</option>
												</c:when>
												<c:otherwise>
													<option value="已发布">已发布</option>
												</c:otherwise>
											</c:choose>
								</select>      
                           	  </div>
                           	  <div class="span6"><div id="sample_2_filter" class="dataTables_filter"><label><input id="name" class="m-wrap medium" placeholder="输入活动名称.." name="name" type="text" value="${name}"><a id="searchBtn" class="btn blue"><i class="icon-search"></i></a></label></div></div></div>
								
                          <table class="table">
							  <thead>
								  <tr>
									  <th width="10%" id="all"><input type="checkbox" /><span>全选</span></th>
                                      <c:choose>
                                      	  <c:when test="${field=='activity_name' && way=='asc'}">
                                              <th width="" class="sorting_asc" data-field="activity_name">活动标题</th>
                                          </c:when>
                                          <c:when test="${field=='activity_name' && way=='desc'}">
                                              <th width="" class="sorting_desc" data-field="activity_name">活动标题</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting" data-field="activity_name">活动标题</th>
                                          </c:otherwise>
                                      </c:choose>
                                       <th width="10%"  >活动类型</th>
									  <c:choose>
                                      	  <c:when test="${field=='join_users' && way=='asc'}">
                                              <th width="10%" class="sorting_asc"  style="text-align:center" data-field="join_users">报名人数</th>
                                          </c:when>
                                          <c:when test="${field=='join_users' && way=='desc'}">
                                              <th width="10%" class="sorting_desc"  style="text-align:center" data-field="join_users">报名人数</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="10%" class="sorting"  style="text-align:center" data-field="join_users">报名人数</th>
                                          </c:otherwise>
                                      </c:choose>
									  <th width="10%"  style="text-align:center" >发布状态</th>
                                      <c:choose>
                                      	  <c:when test="${field=='create_time' && way=='asc'}">
                                              <th width="10%" class="sorting_asc"  style="text-align:center" data-field="create_time">发布时间</th>
                                          </c:when>
                                          <c:when test="${field=='create_time' && way=='desc'}">
                                              <th width="10%" class="sorting_desc"  style="text-align:center" data-field="create_time">发布时间</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="10%" class="sorting"  style="text-align:center" data-field="create_time">发布时间</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th width="15%">快捷操作&nbsp;&nbsp;</th>
								  </tr>

							  </thead>

							  <tbody id="list">
								  <c:forEach items="${list}" var="item">
									<tr>
										<td><input type="checkbox" class="checkboxes" value="${item.activityId}" /></td>
										<td>
                                            ${item.activityName}
                                        </td>
                                        <td>
                                        		<c:if test="${!empty item.activityType}">
                                        			${item.activityType}
                                        		</c:if>
                                        </td>
										<td style="text-align:center">
                                           	<p><a href="/cms/activitys/signs/${item.activityId}">${item.joinUsers}<span style="margin-left:5px">查看</span></a></p>
                                        </td>
                                        <td style="text-align:center">
                                           	<p>
                                              ${item.activityStatus}
                                            </p>
                                        </td>
                                        <td style="text-align:center">
                                           	<p>
                                           		<fmt:formatDate value="${item.createTime}" type="both"/>
                                            </p>
										<td data-title="操作">
                                           		<div data-id="${item.activityId}">
                                                    <!-- <a class="btn yellow-stripe mini"><i class="icon-upload">置顶</i></a>
                                                    <a class="btn blue-stripe mini"><i class="icon-long-arrow-up">上移</i></a>
                                                    <a class="btn red-stripe mini"><i class="icon-long-arrow-down">下移</i></a> -->
                                           		   <a class="btn green-stripe mini"><i class="icon-pencil">编辑</i></a>
                                                    <a class="btn purple-stripe mini"><i class="icon-trash">删除</i></a>
                                                    
                                                    	<c:choose>
				                                      	 <c:when test="${item.activityStatus=='未发布'}">
				                                              <a class="btn purple-stripe mini"><i class="icon-retweet">发布</i></a>
				                                          </c:when>
				                                          <c:when test="${item.activityStatus=='已发布'}">
				                                              <a class="btn purple-stripe mini"><i class="icon-retweet">下线</i></a>
				                                          </c:when>
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
                                	<input type="hidden" name="page" value="1" />
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
	<script>
		jQuery(document).ready(function() {    

		   App.init(); // initlayout and core plugins
		   //全选事件处理
				$("#all").click(function(e) {
                   if($(this).children(":last").text()=="全选"){
					   $(this).children(":last").text("反选");
					   $("input:checkbox").prop("checked",function(i,v){
							return true;   
						});
						$("div.checker>span").addClass("checked");
					}
					else{
						$(this).children(":last").text("全选");
						$("input:checkbox").prop("checked",function(i,v){
							return false;   
						});
						$("div.checker>span").removeClass("checked");
					}
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
				
				/**
				批量处理触发
				**/
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
						
						if(confirm("是否确定要删除当前所选择的活动?")){
							$.post("/cms/activitys/remove",{"ids":ids},function(data){
								if(data.status==0){
									checks.each(function(index, element) {
										$(this).parents("#list>tr").remove();
									});
								}
								else{
									alert(data.msg);
								}
							});
						}
					}
					else{
						alert("请选择其中一行");	
					}
                });
			
			//绑定内容编辑
				$("i.icon-pencil").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						location.href="/cms/activitys/activity/update/"+id;
					});		
                });
				
				//绑定发布、下线按钮
				$("i.icon-retweet").each(function(index, element) {
					$(this).click(function(e){
						var opt = $(this).text().trim();
						var opt_type=0;
						var opt_title="";
						if(opt=='发布'){
							opt_type=1;
						}
						else if(opt=='下线'){
							opt_type=2;
						}
						
						if(confirm("是否确定要"+opt+"当前活动?")){
							var id = $(this).parent().parent().attr("data-id");
							$.post("/cms/activitys/publish",{"ids":id,"opt":opt_type},function(data){
								if(data.status==0){
									doRequest();
								}
								else
									alert(data.msg);
							});
						}
					});		
                });
				
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						if(confirm("是否确定要删除当前活动?")){
							var id = $(this).parent().parent().attr("data-id");
							$.post("/cms/activitys/remove",{"ids":id},function(data){
								if(data.status==0){
									$(element).parents("#list>tr").remove();
								}
								else
									alert(data.msg);
							});
						}
					});		
                });
			
			//绑定置顶按钮
				$("i.icon-upload").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						$.post("/cms/activitys/topsort",{"id":id},function(data){
							if(data.status==0){
								//window.location.reload();
								doRequest();
							}
							else
								alert(data.msg);
						});
					});		
                });
			
			//绑定上移按钮
				$("i.icon-long-arrow-up").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						$.post("/cms/activitys/upsort",{"id":id},function(data){
							if(data.status==0){
								//window.location.reload();
								doRequest();
							}
							else
								alert(data.msg);
						});
					});		
                });
			//绑定下移按钮
				$("i.icon-long-arrow-down").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						
						$.post("/cms/activitys/downsort",{"id":id},function(data){
							if(data.status==0){
								//window.location.reload();
								doRequest();
							}
							else
								alert(data.msg);
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
			
			//提交查询请求
			function doRequest(){
				//$("#searchForm").submit();
				$("#searchForm").formValidate();
			}
			
			$("#status").change(function(e) {
                doRequest();
            });
		});

	</script>

</html>