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

						<h3 class="page-title">专题管理</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>

								<a href="/console">主页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li><a href="/cms/topics">专题管理</a></li>
							
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
									<a href="/cms/topics/setting" class="btn blue setting"><i class="icon-cog"></i> 设置</a>
									<a href="/cms/topics/topic/add" class="btn blue addnew"><i class="icon-pencil"></i> 新增</a>

									<!-- <div class="btn-group">

										<a class="btn green" href="#" data-toggle="dropdown">

										<i class="icon-cogs"></i> 批量操作

										<i class="icon-angle-down"></i>

										</a>

										<ul class="dropdown-menu pull-right">
											<li><a id="batchDel"><i class="icon-trash"></i>批量删除</a></li>
										</ul>

									</div> -->

								</div>

							</div>

					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" method="get">
                      
                      	<table border="0">
										<tr>
											<td width="120">标题：</td>
											<td width="250">
											<input type="text" id="name" placeholder="输入专题名称" name="name" value="${name}">
											</td>
											<td width="120">发布状态：</td>
											<td width="250">
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
													<c:choose>
															<c:when test="${'已下线'==status_selected}">
																<option value="已下线" selected>已下线</option>
															</c:when>
															<c:otherwise>
																<option value="已下线">已下线</option>
															</c:otherwise>
													</c:choose>		
												</select>
											</td>
											<td valign="top">
												<button class="btn blue" id="searchBtn">查询 <i class="icon-search"></i></button>
											</td>	
										</tr>
						</table>				
                       
                          <table class="table">
							  <thead>
								  <tr>
									  <th width="" id="all"><span>编号</span></th>
                                         <th width="" data-field="topic_name">专题名称</th>
                                         <c:choose>
                                      	  <c:when test="${field=='dianjiliang' && way=='asc'}">
                                              <th width="" class="sorting_asc"  style="text-align:center" data-field="dianjiliang">点击量</th>
                                          </c:when>
                                          <c:when test="${field=='dianjiliang' && way=='desc'}">
                                              <th width="" class="sorting_desc"  style="text-align:center" data-field="dianjiliang">点击量</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting"  style="text-align:center" data-field="dianjiliang">点击量</th>
                                          </c:otherwise>
                                      </c:choose>
                                         <th width="" style="text-align:center" data-field="update_time">发布用户</th>
									  <c:choose>
                                      	  <c:when test="${field=='update_time' && way=='asc'}">
                                              <th width="" class="sorting_asc"  style="text-align:center" data-field="update_time">发布时间</th>
                                          </c:when>
                                          <c:when test="${field=='update_time' && way=='desc'}">
                                              <th width="" class="sorting_desc"  style="text-align:center" data-field="update_time">发布时间</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting"  style="text-align:center" data-field="update_time">发布时间</th>
                                          </c:otherwise>
                                      </c:choose>
                                     <c:choose>
                                      	  <c:when test="${field=='topic_status' && way=='asc'}">
                                              <th width="" class="sorting_asc" style="text-align:center" data-field="topic_status">状态</th>
                                          </c:when>
									  	  <c:when test="${field=='topic_status' && way=='desc'}">
                                              <th width="" class="sorting_desc" style="text-align:center" data-field="topic_status">状态</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting" style="text-align:center" data-field="topic_status">状态</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th width="" style="text-align:center">操作&nbsp;&nbsp;</th>
								  </tr>

							  </thead>

							  <tbody id="list">
								  <c:forEach items="${list}" var="item" varStatus="status">
									<tr>
										<td><span>${status.count}</span></td>
										<td data-title="专题名称">
										<div style="width:150px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;" title="${item.topicName}">
											<a href="${item.topicUrl}"  target="_blank" style="color: blue">${item.topicName}</a>
										</div>
                                        </td>
										<td style="text-align:center">
											${item.hits}
										</td>
                                        <td style="text-align:center">
                                        	<c:if test="${item.topicStatus != '未发布'}">
                                           		<p>${item.releaseUser}</p>
                                           	</c:if>
                                        </td>
										<td style="text-align:center">
											<c:if test="${item.topicStatus != '未发布'}">
	                                           	<p>
	                                           	<fmt:formatDate value="${item.releaseTime}" type="both"/>
	                                           	</p>
	                                        </c:if>   	
                                        </td>
                                        
                                        <td style="text-align:center">
                                           	<p>${item.topicStatus}</p>
                                        </td>
										<td data-title="操作" style="text-align:left">
                                           		<div data-id="${item.topicId}">
                                           			<c:if test="${status.index != 0}">
                                           			<a href="#" class="btn green-stripe mini"><i class="icon-upload">置顶</i>&nbsp;&nbsp;</a>
                                                    <a href="#" class="btn green-stripe mini"><i class="icon-long-arrow-up">上移</i>&nbsp;&nbsp;</a>
                                           			</c:if>
                                           			<%-- <c:if test="${status.index == 0}">
                                           			 	<a href="#" class="btn green-stripe mini" style="visibility: hidden;"><i class="icon-upload">置顶</i>&nbsp;&nbsp;</a>
                                                    	<a href="#" class="btn green-stripe mini" style="visibility: hidden;"><i class="icon-long-arrow-up">上移</i>&nbsp;&nbsp;</a>
                                           			</c:if> --%>
                                           			<%-- <c:if test="${status.last }">
                                                   		<a href="#" class="btn green-stripe mini" style="visibility: hidden;"><i class="icon-long-arrow-down">下移</i>&nbsp;&nbsp;</a>
                                           			</c:if> --%>
                                                    <c:if test="${!status.last }">
                                                    	<a href="#" class="btn green-stripe mini"><i class="icon-long-arrow-down">下移</i>&nbsp;&nbsp;</a>
                                           			</c:if>
                                           			<a href="#" class="btn red-stripe mini"><i class="icon-pencil">编辑</i>&nbsp;&nbsp;</a>
                                                    <!-- <a href="#" class="btn red-stripe mini"><i class="icon-trash">删除</i></a> -->
                                                    <c:if test="${item.topicStatus == '已发布'}">
                                                    	<a href="#" class="btn yellow-stripe mini"><i class="icon-download-alt">下线</i></a>
                                                    </c:if>
                                                    <c:if test="${item.topicStatus != '已发布'}">
                                                    <a href="#" class="btn blue-stripe mini"><i class="icon-upload-alt">发布</i></a>
                                                    </c:if>
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
						if(confirm("是否确定要删除当前所选的专题?")){
							$.post("/cms/topics/remove",{"ids":ids},function(data){
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
						location.href="/cms/topics/topic/update/"+id;
					});		
                });
				
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						if(confirm("是否确定要删除当前专题?")){
							var id = $(this).parent().parent().attr("data-id");
							$.post("/cms/topics/remove",{"ids":id},function(data){
								if(data.status==0){
									alert("删除成功！");
									doRequest();
									/* $(element).parents("#list>tr").remove(); */
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
						$.post("/cms/topics/topsort",{"id":id},function(data){
							if(data.status==0){
								window.location.reload();
								//doRequest();
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
						$.post("/cms/topics/upsort",{"id":id},function(data){
							if(data.status==0){
								window.location.reload();
								//doRequest();
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
						$.post("/cms/topics/downsort",{"id":id},function(data){
							if(data.status==0){
								window.location.reload();
								//doRequest();
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
				//绑定发布
				$("i.icon-upload-alt").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("是否确定要发布本专题?")){
							/* $.post("/cms/topics/topic/checkReleaseNum",function(data){
								if(data.code==0){
									$.post("/cms/topics/topic/publish",{"id":id},function(data){
										if(data.status==0){
											alert("发布成功！");
											doRequest();
										}
										else
											alert(data.msg);
									});
								}else{
									if(confirm("当前已发布专题已满5条，确认后将自动下线最早的专题。")){ */
										$.post("/cms/topics/topic/publish",{"id":id},function(data){
											if(data.status==0){
												alert("发布成功！");
												doRequest();
											}
											else
												alert(data.msg);
										});
								/* 	}
								} 
							});*/
						}
					});
                });
				//绑定下线
				$("i.icon-download-alt").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("是否确定要下线本专题?")){
						$.post("/cms/topics/topic/offline",{"id":id},function(data){
							if(data.status==0){
								alert("下线成功！");
								doRequest();
							}
							else
								alert(data.msg);
						});
						}
					});		
                });
			
			//提交查询请求
			function doRequest(){
				//$("#searchForm").submit();
				$("#searchForm").formValidate();
			}
			
			/* $("#status").change(function(e) {
                doRequest();
            }); */
		});

	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>