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
						<h3 class="page-title">内容管理</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/console">主页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>内容管理 - 资讯发布</li>
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
					<div class="span2 portlet box" style="border:#efefef 1px solid;">
							<div class="portlet-title">
								<div class="caption"><i class="icon-sitemap"><span style="font-size:16px;">&nbsp;栏目结构</span> </i></div>
								<!-- <div class="actions">
									<a href="javascript:;" id="tree_collapse" class="btn green"> 收缩</a>
									<a href="javascript:;" id="tree_expand" class="btn yellow"> 展开</a>
								</div> -->
							</div>
							<div class="portlet-body fuelux">${sectionTree}</div>
					</div>
                    <div class="span10">
                    <div class="portlet box grey">
							<div class="portlet-title">
								<div class="caption"><i class="icon-list"></i></div>
								<div class="actions">
									<a href="/cms/articleinfo/add?pcode=${secId }" class="btn blue addnew"><i class="icon-pencil"></i> 新增</a>
									<div class="btn-group">
										<a class="btn green" href="#" data-toggle="dropdown">
										<i class="icon-cogs"></i> 批量操作
										<i class="icon-angle-down"></i>
										</a>
										<ul class="dropdown-menu pull-right">
											<li><a id="batchDel"><i class="icon-trash"></i> 批量删除</a></li>
											<li><a id="batchPub"><i class="icon-ok-sign"></i> 批量发布</a></li>
											<li><a id="batchOffline"><i class="icon-remove-sign"></i> 批量下线</a></li>
										</ul>
									</div>
								</div>
							</div>
					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" method="get">
                        <div class="span12">
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">标题:</label>
                                            <div class="controls">
                                                <input id="title" class="m-wrap medium" placeholder="输入标题名称.." name="title" type="text" value="${title }">
                                                <input id="secId" name="secId" type="hidden" value="${secId }">
                                                <input id="ifParent" name="ifParent" type="hidden" value="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">发布状态:</label>
                                            <div class="controls">
                                                <select class="m-wrap span6" style="float:left;" id="pub_status" name="pub_status">
                                                	<option value="">全部</option>
                                                	<c:forEach items="${statusList }" var="item">
                                                		<c:if test="${item.dictCode == publish_status }">
															<option value="${item.dictCode }" selected>${item.name }</option>
														</c:if>
                                                		<c:if test="${item.dictCode != publish_status }">
															<option value="${item.dictCode }">${item.name }</option>
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
                          <table class="table table-striped table-bordered table-hover">
							  <thead>
								  <tr>
									  <th style="width:8px;" id="all"><input type="checkbox" /><input type="hidden" value="0" id="checkStatus"></th>
                                      <c:choose>
                                      	  <c:when test="${field=='title' && way=='asc'}">
                                              <th class="sorting_asc" data-field="title">标题</th>
                                          </c:when>
                                          <c:when test="${field=='title' && way=='desc'}">
                                              <th class="sorting_desc" data-field="title">标题</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="title">标题</th>
                                          </c:otherwise>
                                      </c:choose>
                                       <th  data-field="status">状态</th>
                                       <th data-field="section_name">栏目</th>
                                       <c:choose>
                                      	  <c:when test="${field=='click_count' && way=='asc'}">
                                              <th class="sorting_asc" data-field="click_count">点击量</th>
                                          </c:when>
                                          <c:when test="${field=='click_count' && way=='desc'}">
                                              <th class="sorting_desc" data-field="click_count">点击量</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="click_count">点击量</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th data-field="section_name">资讯类型</th>
                                      <c:choose>
                                      	  <c:when test="${field=='publish_time' && way=='asc'}">
                                              <th class="sorting_asc" data-field="publish_time">发布时间</th>
                                          </c:when>
                                          <c:when test="${field=='publish_time' && way=='desc'}">
                                              <th class="sorting_desc" data-field="publish_time">发布时间</th>
                                          </c:when>
                                          <c:otherwise>
                                         	 <th class="sorting" data-field="publish_time">发布时间</th>
                                          </c:otherwise>
                                      </c:choose>
                                      <th data-field="publish_user">发布人</th>
                                      <th >快捷操作&nbsp;&nbsp;</th>
								  </tr>
							  </thead>
							  <tbody id="list">
								  <c:forEach items="${list}" var="item">
									<tr>
										<td><input type="checkbox" class="checkboxes" value="${item.info_id}#${item.section_type }" /></td>
										<td data-title="标题">
                                            ${item.title}
                                        </td>
										<td>${item.statusZN}</td>
										<td>${item.section_name}</td>
										<td>${item.click_count}</td>
										<td data-field="section_name">${item.section_type }</td>
										<td style="text-align:center">
                                           	<c:if test="${item.status == '00140002' || item.status == '00140003'}">
                                        		<fmt:formatDate value="${item.publish_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        	</c:if>
                                        </td>
										<td>${item.publish_user}</td>
                                        <td data-title="操作">
                                           		<div data-id="${item.info_id}" data-type = "${item.section_type }" data-sid="${item.section_id }">
                                           		
                                           			<c:if test="${item.section_type == '文章'}">
                                           				<a class="btn green-stripe mini"><i class="icon-pencil">编辑</i></a>
	                                           			<c:if test="${item.status == '00140002'}">
	                                           				<a class="btn yellow-stripe mini"><i class="icon-remove">下线</i></a>
	                                           			</c:if>
	                                           			<c:if test="${item.status == '00140001' || item.status == '00140003'}">
	                                                    	<a class="btn purple-stripe mini"><i class="icon-trash">删除</i></a>
	                                           			</c:if>
	                                           			
	                                           			<c:if test="${item.sort < 999999 && item.status == '00140002'}">
	                                           				<a class="btn blue-stripe mini"><i class="icon-upload">置顶</i></a>
	                                           			</c:if>
                                           			</c:if>
                                           		
                                           			<c:if test="${item.section_type == '图片'}">
                                           				<c:if test="${item.status == '00140001' || item.status == '00140003'}">
	                                           				<a class="btn green-stripe mini"><i class="icon-pencil">编辑</i></a>
	                                                    	<a class="btn purple-stripe mini"><i class="icon-trash">删除</i></a>
	                                           			</c:if>
	                                           			<c:if test="${item.status == '00140002'}">
	                                           				<a class="btn yellow-stripe mini"><i class="icon-remove">下线</i></a>
	                                           			</c:if>
                                           			</c:if>
                                                    
                                           			<a class="btn blue-stripe mini"><i class="icon-eye-open">查看</i></a>
                                                </div>
                                        </td>
								    </tr>
                                  </c:forEach>
							  </tbody>
						  </table>
                          		<input id="field" name="field" type="hidden" /> 
                                <input id="way" name="way" type="hidden" /> 
                                <div id="pageBar">
                                	<input type="hidden" name="page" id="page" value="1" />
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
						if(confirm("删除后数据无法恢复，确定是否删除？")){
							 $.post("/cms/information/delete",{"ids":ids},function(data){
								if(data.status==0){
									checks.each(function(index, element) {
										$(this).parents("#list>tr").remove();
									});
								}else if(data.status == 2){
									alert(data.msg);
								}
								else{
									alert(data.msg);
									location.reload();
								}
							}); 
						}
					}
					else{
						alert("请选择删除行");	
					}
                });
				//批量发布
				$("#batchPub").click(function(e) {
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
						if(confirm("确定要发布选中的资讯信息吗?")){
							$.post("/cms/information/publish",{"ids":ids},function(data){
								if(data.status==0){
									//checks.each(function(index, element) {
										alert(data.msg);
										location.reload();
									//});
								}else if(data.status == 2){
									alert(data.msg);
								}
								else{
									alert(data.msg);
									location.reload();
								}
							});
						}
					}
					else{
						alert("请选择发布数据");	
					}
                });
				//批量下线
				$("#batchOffline").click(function(e) {
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
						if(confirm("确定要下线吗？")){
							$.post("/cms/information/offline",{"ids":ids},function(data){
								if(data.status==0){
									//checks.each(function(index, element) {
										alert(data.msg);
										location.reload();
									//});
								}else if(data.status == 2){
									alert(data.msg);
								}
								else{
									alert(data.msg);
									location.reload();
								}
							});
						}
					}
					else{
						alert("请选择要下线的资讯");	
					}
                });
				
			//查看
			$("i.icon-eye-open").each(function(index, element) {
				$(this).click(function(e){
					var id = $(this).parent().parent().attr("data-id");
					var type = $(this).parent().parent().attr("data-type");
					if(type == "文章"){
						location.href="/cms/articleinfo/detail/"+id;
					}else if(type == "图片"){
						location.href="/cms/imageinfo/detail/"+id;
					}
				});		
            });
			
			//置顶
			$("i.icon-upload").each(function(index, element) {
				$(this).click(function(e){
					var id = $(this).parent().parent().attr("data-id");
					var sid = $(this).parent().parent().attr("data-sid");
					if(confirm("置顶后将优先展示资讯列表中，暂时支持置顶3篇文章，确定要置顶吗？")){
						$.post("/cms/articleinfo/setTop",{"id":id,"sid":sid},function(data){
							if(data.status==0){
								alert(data.msg);
								location.reload();
							}else if(data.status == 2){
								alert(data.msg);
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
						var type = $(this).parent().parent().attr("data-type");
						if(type == "文章"){
							location.href="/cms/articleinfo/edit/"+id;
						}else if(type == "图片"){
							location.href="/cms/imageinfo/edit/"+id;
						}
					});		
                });
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var url = "";
						var id = $(this).parent().parent().attr("data-id");
						var type = $(this).parent().parent().attr("data-type");
						if(confirm("提示：数据一旦删除不能恢复!确定要删除吗?")){
							if(type == "文章"){
								url = "/cms/articleinfo/delete";
							}else if(type == "图片"){
								url = "/cms/imageinfo/delete";
							}
							$.post(url,{"ids":id},function(data){
								if(data.status==0){
									$(element).parents("#list>tr").remove();
								}else if(data.status == 2){
									alert(data.msg);
								}
								else
									alert(data.msg);
							});
						}
					});		
                });
				//下线
				$("i.icon-remove").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						var type = $(this).parent().parent().attr("data-type");
						if(confirm("确定要下线吗?")){
							if(type == "文章"){
								url = "/cms/articleinfo/offline";
							}else if(type == "图片"){
								url = "/cms/imageinfo/offline";
							}
							$.post(url,{"ids":id},function(data){
								if(data.status==0){
									alert("下线成功!");
									location.reload();
								}else if(data.status == 2){
									alert(data.msg);
								}
								else
									alert(data.msg);
							});
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
			
			//节点折叠
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
</body>
</html>