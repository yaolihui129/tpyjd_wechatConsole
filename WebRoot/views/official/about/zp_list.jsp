<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<meta content="" name="author" />
	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

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
						<h3 class="page-title">诚聘英才</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/console">主页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>移民官网 <i class="icon-angle-right"></i> 关于我们<i class="icon-angle-right"></i> 诚聘英才</li>
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
									<a href="/official/about/zp/add" class="btn blue addnew"><i class="icon-plus"></i> 新增</a>
									<a class="btn green" href="/official/about/zp/set"><i class="icon-cogs"></i> 设置</a>
								</div>
							</div>
					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" action="/official/about/zp">
                       	<div class="row-fluid">
                              <div class="span6">
                           	  </div>
                           	  <div class="span6">
	                           	  <div id="sample_2_filter" class="dataTables_filter">
		                           	  <label><input id="position" class="m-wrap medium" placeholder="输入职位关键词.." name="position" type="text" value="${position }">
		                           	  <a id="searchBtn" class="btn blue"><i class="icon-search"></i></a>
		                           	  </label>
	                           	  </div>
                           	  </div>
                           	  </div>
                          <table class="table table-striped table-bordered table-hover">
							  <thead>
								  <tr>
									  <th style="width:30px;">编号</th>
                                      <c:choose>
                                      	  <c:when test="${field=='position' && way=='asc'}">
                                              <th  class="sorting_asc" data-field="position">职位</th>
                                          </c:when>
                                          <c:when test="${field=='position' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="position">职位</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th  class="sorting" data-field="position">职位</th>
                                          </c:otherwise>
                                      </c:choose>
                                      
                                      <c:choose>
                                      	  <c:when test="${field=='nums' && way=='asc'}">
                                              <th  class="sorting_asc" data-field="nums" align="center">招聘人数</th>
                                          </c:when>
                                          <c:when test="${field=='nums' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="nums" align="center">招聘人数</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th  class="sorting" data-field="nums" align="center">招聘人数</th>
                                          </c:otherwise>
                                      </c:choose>
                                      
                                      <th style="text-align:center">工作地点</th>
                                      
                                      <c:choose>
                                      	  <c:when test="${field=='edit_time' && way=='asc'}">
                                              <th  class="sorting_asc" data-field="edit_time" style="text-align:center">发布时间</th>
                                          </c:when>
                                          <c:when test="${field=='edit_time' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="edit_time" style="text-align:center">发布时间</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="edit_time" style="text-align:center">发布时间</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th >快捷操作&nbsp;&nbsp;</th>
                                      
								  </tr>
							  </thead>
							  <tbody id="list">
								  <c:forEach items="${list}" var="item" varStatus="status">
									<tr>
										<td>${status.index + 1 }</td>
										<td data-title="职位">
                                            ${item.position}
                                        </td>
										<td>${item.nums}</td>
										<td style="text-align:center">
                                        	<%-- ${item.provinceZH} --%>${item.cityZH}
                                        </td>
                                        <td style="text-align:center">
                                        	<fmt:formatDate value="${item.edit_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </td>

                                        <td data-title="操作">
                                        	<div data-id="${item.or_id}">
                                        		<c:if test="${status.index != 0 }">
                                                	<a class="btn yellow-stripe mini"><i class="icon-upload">置顶</i></a>
                                                	<a class="btn blue-stripe mini"><i class="icon-long-arrow-up">上移</i></a>
                                                </c:if>
                                                <c:if test="${!status.last }">
                                                <a class="btn red-stripe mini"><i class="icon-long-arrow-down">下移</i></a>
                                                </c:if>
                                        		<a class="btn green-stripe mini"><i class="icon-pencil">编辑</i> </a>
                                       			<a class="btn purple-stripe mini"><i class="icon-trash">删除</i> </a>
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
	<%@ include  file="/views/footer.jsp"%>
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
                   if($("#checkStatus").val()=="0"){
					   $("#checkStatus").val("1");
					   $("input:checkbox").prop("checked",function(i,v){
							return true;   
						});
						$("div.checker>span").addClass("checked");
					}
					else{
						$("#checkStatus").val("0");
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
				
			//绑定内容编辑
				$("i.icon-pencil").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						location.href="/official/about/zp/edit/"+id;
					});		
                });
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("提示：删除后无法恢复,还可能影响其他显示.确认要删除吗？")){
							$.post("/official/about/zp/delete",{"ids":id},function(data){
								if(data.status==0){
									//$(element).parents("#list>tr").remove();
									window.location.reload();
								}else if(data.status == 2){
									alert(data.msg);
								}
								else{
									alert(data.msg);
									window.location.reload();
								}
									
							});
						}
					});		
                });
				//绑定置顶按钮
				$("i.icon-upload").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						$.post("/official/about/zp/topsort",{"id":id},function(data){
							if(data.status==0){
								window.location.reload();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert("置顶失败");
						});
					});		
                });
			//绑定上移按钮
				$("i.icon-long-arrow-up").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");

						$.post("/official/about/zp/upsort",{"id":id},function(data){
							if(data.status==0){
								window.location.reload();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert("上移失败");
						});
					});		
                });
			//绑定下移按钮
				$("i.icon-long-arrow-down").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						$.post("/official/about/zp/downsort",{"id":id},function(data){
							if(data.status==0){
								window.location.reload();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert("下移失败");
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
				$("#searchForm").formValidate();
			}
			
		});
	</script>
	<!-- END JAVASCRIPTS -->
<!-- END BODY -->
</html>