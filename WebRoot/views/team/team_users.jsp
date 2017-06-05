<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->

<html lang="en" class="no-js"> <!--<![endif]-->
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

						<h3 class="page-title">专业团队管理</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>

								<a href="/">主页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>
                                <a href="/official/about/team/list/">专业团队管理</a>
                            </li>
							
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
								<a href="/official/about/team/list/add" class="btn yellow addnew"><i class="icon-pencil"></i>新增</a>
							</div>
						</div>

					  <div class="portlet-body  no-more-tables">
                      <form id="searchForm" method="post">
                       	<div class="row-fluid">
                         <div class="span12">
                          		<div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">关键字:</label>
                                            <div class="controls">
                                                <input id="name" class="m-wrap medium" placeholder="输入姓名或手机号" name="name" type="text" value="${name}">
                                            </div>
                                        </div>
                                   </div>
                                    <div class="span3 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">发布状态:</label>
                                            <div class="controls">
                                                <select class="m-wrap span6" style="float:left;" id="pub_status" name="pub_status">
                                                	<option value="">全部</option>
                                                	<c:forEach items="${statusList }" var="item">
                                                		<c:if test="${item.name == publish_status }">
															<option value="${item.name }" selected>${item.name }</option>
													</c:if>
                                                		<c:if test="${item.name != publish_status }">
															<option value="${item.name }">${item.name }</option>
													</c:if>
                                                	</c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span3 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">团队类型:</label>
                                            <div class="controls">
                                                <select class="m-wrap span6" style="float:left;" id="team_type" name="team_type">
                                                	<option value="">全部</option>
                                                	<c:forEach items="${teamTypeList }" var="item">
                                                		<c:if test="${item.name == team_type }">
															<option value="${item.name }" selected>${item.name }</option>
													</c:if>
                                                		<c:if test="${item.name != team_type }">
															<option value="${item.name }">${item.name }</option>
													</c:if>
                                                	</c:forEach>
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
									  <th width="50" id="all"><input type="checkbox" /><span>全选</span></th>
                                      <c:choose>
                                      	  <c:when test="${field=='user_name' && way=='asc'}">
                                              <th width="45" class="sorting_asc" data-field="user_name">姓名</th>
                                          </c:when>
                                          <c:when test="${field=='user_name' && way=='desc'}">
                                              <th width="45" class="sorting_desc" data-field="user_name">姓名</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="45" class="sorting" data-field="user_name">姓名</th>
                                          </c:otherwise>
                                      </c:choose>
                                
                                      <c:choose>
                                      	  <c:when test="${field=='english_name' && way=='asc'}">
                                              <th width="45" class="sorting_asc" data-field="english_name">英文名</th>
                                          </c:when>
                                          <c:when test="${field=='english_name' && way=='desc'}">
                                              <th width="45" class="sorting_desc" data-field="english_name">英文名</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="45" class="sorting" data-field="english_name">英文名</th>
                                          </c:otherwise>
                                      </c:choose>
                                 
                                      <c:choose>
                                      	  <c:when test="${field=='job_title' && way=='asc'}">
                                              <th width="" class="sorting_asc" data-field="job_title">头衔</th>
                                          </c:when>
                                          <c:when test="${field=='job_title' && way=='desc'}">
                                              <th width="" class="sorting_desc" data-field="job_title">头衔</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting" data-field="job_title">头衔</th>
                                          </c:otherwise>
                                      </c:choose>
                                      
                                       <th width="60">首页推荐</th>
                                       
                                       <c:choose>
                                      	 <c:when test="${field=='release_mark' && way=='asc'}">
                                              <th width="" class="sorting_asc" data-field="release_mark">发布状态</th>
                                          </c:when>
                                          <c:when test="${field=='release_mark' && way=='desc'}">
                                              <th width="" class="sorting_desc" data-field="release_mark">发布状态</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting" data-field="release_mark">发布状态</th>
                                          </c:otherwise>
                                      </c:choose>
                                      
                                      <c:choose>
                                      	 <c:when test="${field=='team_type' && way=='asc'}">
                                              <th width="" class="sorting_asc" data-field="team_type">团队类型</th>
                                          </c:when>
                                          <c:when test="${field=='team_type' && way=='desc'}">
                                              <th width="" class="sorting_desc" data-field="team_type">团队类型</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th width="" class="sorting" data-field="team_type">团队类型</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th width="200">快捷操作</th>
								  </tr>

							  </thead>

							  <tbody id="list">
								  <c:forEach items="${list}" var="item">
									<tr>
										<td width=""><input type="checkbox" class="checkboxes" value="${item.team_id}" /></td>
										<td width="">${item.user_name}</td>
                                        <td width="">${item.english_name}</td>
										<td width="">${item.job_title}</td>
									 	
									 	<c:choose>
									 		<c:when test="${item.index_show==1}">
									 			<td width="10%">推荐</td> 
									 		</c:when>
									 		<c:otherwise>
									 			<td width="10%">未推荐</td> 
									 		</c:otherwise>
									 	</c:choose>
									 	<c:choose>
									 		<c:when test="${item.release_mark=='未发布'}">
									 			<td width="10%">未发布</td> 
									 		</c:when>
									 		<c:when test="${item.release_mark=='已发布'}">
									 			<td width="10%">已发布</td> 
									 		</c:when>
									 		<c:otherwise>
									 			<td width="10%">已下线</td> 
									 		</c:otherwise>
									 	</c:choose>
									 	<td width="">${item.team_type}</td>
										<td  data-title="操作"> 
                                        		<div data-id="${item.team_id}">
                                        		 
                                              <a class="btn blue-stripe mini"><i class="icon-long-arrow-up">上移</i></a>
                                              <a class="btn red-stripe mini"><i class="icon-long-arrow-down">下移</i></a>
                                        		 <a class="btn green-stripe mini"><i class="icon-pencil">编辑</i></a>
                                                 <a class="btn purple-stripe mini"><i class="icon-trash">删除</i></a>
                                                 <c:choose>
		                                      	 <c:when test="${item.release_mark=='未发布'}">
		                                              <a class="btn purple-stripe mini"><i class="icon-share-alt">发布</i></a>
		                                          </c:when>
		                                          <c:when test="${item.release_mark=='已发布'}">
		                                              <a class="btn purple-stripe mini"><i class="icon-download">下线</i></a>
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
                                <input id="org_id" name="org_id" type="hidden" value="${org_id}"/>
                                <input id="org_name" name="org_name" type="hidden" value="${org_name}"/>
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
		   $("#orgTree").find("li>a").each(function(index, element) {
			   $(this).click(function(e) {
                 var id =$(this).attr("data-info");
					 $("#org_id").val(id);
					 $("#org_name").val($(this).text());
					 $(this).parents("div.btn-group").find("a>span").text($(this).text());
					 doRequest();
				});
			});
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
				
				//发布
				$("i.icon-share-alt,i.icon-download").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("是否确定"+$(this).text()+"?")){
							$.post("/official/about/team/list/pub",{"ids":id},function(data){
								if(data.status==0){
									location.reload();
								}
								else
									alert(data.msg);
							});
						} 
					});		
	            });
			//绑定内容编辑
			$("i.icon-pencil").each(function(index, element) {
				$(this).click(function(e){
					var id = $(this).parent().parent().attr("data-id");
					location.href="/official/about/team/list/update/"+id;
				});		
            });
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						 
						if(confirm("警告!删除之后数据数据将无法恢复!您确认要删除?")){
							$.post("/official/about/team/list/remove",{"ids":id},function(data){
								if(data.status==0){
									//$(element).parent().parents("#list>tr").remove();
									location.reload();
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
						$.post("/official/about/team/list/topsort",{"id":id},function(data){
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
						$.post("/official/about/team/list/upsort",{"id":id},function(data){
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
						
						$.post("/official/about/team/list/downsort",{"id":id},function(data){
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
			
		});

	</script>
	<!-- END JAVASCRIPTS -->

</html>