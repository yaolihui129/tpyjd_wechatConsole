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
						<h3 class="page-title">荣誉资质</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/console">主页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>移民官网 <i class="icon-angle-right"></i> 关于我们<i class="icon-angle-right"></i> 荣誉资质</li>
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
									<a class="btn blue addnew" id="addBtn"><i class="icon-plus"></i> 新增</a>
									<a data-toggle="modal" href="#honorBox" aria-labelledby = "新增" id = "btnAdd" style="display: none;">honorBox</a>
									<a class="btn green" target="_blank" href="${OFFICIAL_URL}/about-us/honorsPreview"><i class="m-icon-swapright m-icon-white"></i> 预览</a>
								</div>
							</div>
					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" action="/official/about/honor">
                       	<div class="row-fluid">
                              <div class="span6">
                           	  </div>
                           	  <div class="span6">
	                           	  <div id="sample_2_filter" class="dataTables_filter">
		                           	  <label><input id="title" class="m-wrap medium" placeholder="输入荣誉标题关键词.." name="title" type="text" value="${title }">
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
                                      	  <c:when test="${field=='title' && way=='asc'}">
                                              <th  class="sorting_asc" data-field="title">标题</th>
                                          </c:when>
                                          <c:when test="${field=='title' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="title">标题</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th  class="sorting" data-field="title">标题</th>
                                          </c:otherwise>
                                      </c:choose>
                                      
                                      <th style="text-align:center">状态</th>
                                      <th style="text-align:center">图片列表</th>
                                      <th >快捷操作&nbsp;&nbsp;</th>
                                      
								  </tr>
							  </thead>
							  <tbody id="list">
								  <c:forEach items="${list}" var="item" varStatus="status">
									<tr>
										<td>${status.index + 1 }</td>
										<td data-title="标题">
                                            ${item.title}
                                        </td>
										<td style="text-align:center">${item.status}</td>
										<td style="text-align:center">
                                        	<a href="/official/about/honorimg/${item.oh_id}"> 查看 </a>
                                        </td>
                                        <td data-title="操作">
                                        	<div data-id="${item.oh_id}" data-title="${item.title} ">
                                        		<c:if test="${status.index != 0 }">
                                                	<!-- <a class="btn yellow-stripe mini"><i class="icon-upload">置顶</i></a> -->
                                                	<a class="btn blue-stripe mini"><i class="icon-long-arrow-up">上移</i></a>
                                                </c:if>
                                                <c:if test="${!status.last }">
                                                <a class="btn red-stripe mini"><i class="icon-long-arrow-down">下移</i></a>
                                                </c:if>
                                        		<a class="btn green-stripe mini"><i class="icon-pencil">编辑</i> </a>
                                        		<c:if test="${item.status == '未发布' }">
                                        			<a class="btn yellow-stripe mini"><i class="icon-ok">发布</i> </a>
                                        		</c:if>
                                        		<c:if test="${item.status == '已发布' }">
                                        			<a class="btn red-stripe mini"><i class="icon-remove-sign">下线</i> </a>
                                        		</c:if>
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
	<div id="honorBox" class="modal hide fade" data-focus-on="input:first" aria-labelledby="mySmallModalLabel" >
    <form>
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h3 id="boxTitle_add" style="display: none;">新增</h3>
				<h3 id="boxTitle_edit" style="display: none;">修改</h3>
			</div>

			<div class="modal-body">
				<table>
					<tr>
						<td width="100" align="right">标题：</td>
						<td>
							<input name="oh_id" id="oh_id" type="hidden" data-tabindex="1" value=""/>
							<input name="oh_title" id="oh_title" maxlength="20" placeholder="请输入荣誉资质标题，不超过20个字" class="m-wrap span4" type="text" data-tabindex="1" value=""/>
						</td>
					</tr>
				</table>
   			</div>

			<div class="modal-footer">
				<a id="saveBtn" class="btn red">保存</a>
				<a data-dismiss="modal" class="btn" id="btnClose">取消</a>
			</div>
		</form>
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
				
				//新增
				$("#addBtn").click(function(e){
						$("#oh_id").val("");
						$("#oh_title").val("");
						$("#boxTitle_add").show();
						$("#boxTitle_edit").hide();
						$("#honorBox").modal();
					});	
			//编辑
				$("i.icon-pencil").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						var title = $(this).parent().parent().attr("data-title");
						$("#oh_id").val(id);
						$("#oh_title").val(title);
						
						$("#boxTitle_edit").show();
						$("#boxTitle_add").hide();
						$("#honorBox").modal();
					});		
                });
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						var title = $(this).parent().parent().attr("data-title");
						if(confirm("确认要删除【"+title+"】吗？")){
							$.post("/official/about/honor/delete",{"ids":id},function(data){
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
				//绑定发布按钮
				$("i.icon-ok").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("确认要发布吗？")){
							$.post("/official/about/honor/publish/"+id,{},function(data){
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
				
				//绑定下线按钮
				$("i.icon-remove-sign").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						var title = $(this).parent().parent().attr("data-title");
						if(confirm("确认要下线【"+title+"】吗？")){
							$.post("/official/about/honor/downline/"+id,{},function(data){
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
						$.post("/official/about/honor/topsort",{"id":id},function(data){
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

						$.post("/official/about/honor/upsort",{"id":id},function(data){
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
						$.post("/official/about/honor/downsort",{"id":id},function(data){
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
			
			$("#saveBtn").click(function(e) {
				if($("#oh_title").val().trim() != ""){
					$.post("/official/about/honor/save",{"oh_id":$("#oh_id").val(),"title":$("#oh_title").val()},function(data){
						if(data.status==0){
							alert("保存成功");
			               	$("#btnClose").click();
							window.location.reload();
						}else if(data.status == 2){
							alert(data.msg);
						}
						else
							alert("保存失败");
					});
				}else{
					alert("标题不能为空");
				}
            });
			
		});
	</script>
	<!-- END JAVASCRIPTS -->
<!-- END BODY -->
</html>