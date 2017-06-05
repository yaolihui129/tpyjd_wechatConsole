<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
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
						<h3 class="page-title">栏目管理</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/console">主页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>内容管理 - 栏目管理</li>
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
					<div class="span3 portlet box" style="border:#efefef 1px solid;">
							<div class="portlet-title">
								<div class="caption"><i class="icon-sitemap"><span style="font-size:16px;">&nbsp;栏目结构</span> </i></div>
								<div class="actions">
									<a href="javascript:;" id="tree_collapse" class="btn green"> 收缩</a>
									<a href="javascript:;" id="tree_expand" class="btn yellow"> 展开</a>
								</div>
							</div>
							<div class="portlet-body fuelux">${sectionTree}</div>
					</div>
                    <div class="span9">
                    <div class="portlet box grey">
							<div class="portlet-title">
								<div class="caption"><i class="icon-list"></i></div>
								<div class="actions">
									<a href="/cms/section/add?pcode=${secId }" class="btn blue addnew"><i class="icon-plus"></i> 新增</a>
									<!-- <a class="btn yellow addnew" id="saveSort"><i class="icon-save"></i> 保存排序</a> -->
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
                      <form method="post" id="searchForm" action="/cms/section">
                       	<div class="row-fluid">
                              <div class="span6">
                              	<input id="secId" name="secId" type="hidden" value="${secId }">
                              	<input id="ifParent" name="ifParent" type="hidden" value="">
                           	  </div>
                           	  <div class="span6">
	                           	  <div id="sample_2_filter" class="dataTables_filter">
		                           	  <label><input id="name" class="m-wrap medium" placeholder="输入栏目名称.." name="name" type="text" value="${name }">
		                           	  <a id="searchBtn" class="btn blue"><i class="icon-search"></i></a>
		                           	  </label>
	                           	  </div>
                           	  </div>
                           	  </div>
                          <table class="table table-striped table-bordered table-hover">
							  <thead>
								  <tr>
									  <th style="width:8px;" id="all"><input type="checkbox" /><input type="hidden" value="0" id="checkStatus"></th>
                                      <c:choose>
                                      	  <c:when test="${field=='name' && way=='asc'}">
                                              <th  class="sorting_asc" data-field="name">栏目名称</th>
                                          </c:when>
                                          <c:when test="${field=='name' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="name">栏目名称</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th  class="sorting" data-field="name">栏目名称</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <c:choose>
                                      	  <c:when test="${field=='pname' && way=='asc'}">
                                              <th  class="sorting_asc" data-field="pname">上级栏目</th>
                                          </c:when>
                                          <c:when test="${field=='pname' && way=='desc'}">
                                              <th  class="sorting_desc" data-field="pname">上级栏目</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="pname">上级栏目</th>
                                          </c:otherwise>
                                      </c:choose>
                                       <th style="text-align:center" data-field="section_img">预览图片</th>
                                      <th >快捷操作&nbsp;&nbsp;</th>
                                      
								  </tr>
							  </thead>
							  <tbody id="list">
								  <c:forEach items="${list}" var="item" varStatus="status">
									<tr>
										<td><input type="checkbox" class="checkboxes" value="${item.section_id}" /></td>
										<td data-title="栏目名称">
                                            ${item.name}
                                        </td>
										<td>${item.pname}</td>
                                        <td style="text-align:center">
                                        	<c:if test="${item.section_img != '' &&  item.section_img != null}">
                                           		<img alt="" src="${item.section_img }" style="width:100px;height:60px;">
                                           	</c:if>
                                        </td>

                                        <td data-title="操作">
                                        	<div data-id="${item.section_id}">
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
						//dosomething
						if(confirm("提示：删除后无法恢复,还可能影响其他显示.确认要删除吗？")){
							$.post("/cms/section/delete",{"ids":ids},function(data){
								if(data.status==0){
									checks.each(function(index, element) {
										$(this).parents("#list>tr").remove();
									});
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
						
					}
					else{
						alert("请选择删除行");	
					}
                });
			//绑定内容编辑
				$("i.icon-pencil").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						location.href="/cms/section/edit/"+id;
					});		
                });
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("提示：删除后无法恢复,还可能影响其他显示.确认要删除吗？")){
							$.post("/cms/section/delete",{"ids":id},function(data){
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
						$.post("/cms/section/topsort",{"id":id},function(data){
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

						$.post("/cms/section/upsort",{"id":id},function(data){
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
						$.post("/cms/section/downsort",{"id":id},function(data){
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
				//$("#searchForm").submit();
				$("#searchForm").formValidate();
			}
			
			//树形节点选中
			$("#sectionTree").find("li>a").each(function(index, element) {
				   $(this).click(function(e) {
	                 var id =$(this).attr("data-value");
	                 	if(id == "0000"){
	                 		$("#secId").val("0");
	                 	}else{
	                 		 $("#secId").val(id);
	                 	}
						
						 if($(this).attr("data-toggle") == null){
							 $("#ifParent").val("0");//子节点
						 }else{
							 $("#ifParent").val("1");//父节点
						 }
						//doRequest();
					});
				});
			
			//收缩
           $('#tree_collapse').click(function () {
               $('.tree-toggle', $('#sectionTree > li')).addClass("closed");
               $('.branch', $('#sectionTree > li')).removeClass("in");
           });
		   
			//展开
           $('#tree_expand').click(function () {
               $('.tree-toggle', $('#sectionTree > li')).removeClass("closed");
               $('.branch', $('#sectionTree > li')).addClass("in");
           });
			
           $(".nodetitle").each(function(i,element){
				 $(this).click(function(){
					 //在此处可以添加节点文字点击时出发的操作代码
	                 var id =$(this).parent().parent().attr("data-value");
	                 	if(id == "0000"){
	                 		$("#secId").val("0");
	                 	}else{
	                 		 $("#secId").val(id);
	                 	}
						
						 if($(this).attr("data-toggle") == null){
							 $("#ifParent").val("0");//子节点
						 }else{
							 $("#ifParent").val("1");//父节点
						 }
						doRequest();
					 
					 return false;
				 });
			});

           $('.tree-toggle').each(function(i, element) {
               $(this).click(function(){
					if($(this).hasClass("closed")){
						$(this).removeClass("closed");
						$(this).parent().children(".branch").addClass("in");
					}
					else{
						$(this).addClass("closed");
						$(this).parent().children(".branch").removeClass("in");
					}
				});
           });
		});
	</script>
	<!-- END JAVASCRIPTS -->
<!-- END BODY -->
</html>