<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
</head>
<body class="page-header-fixed">
    <!-- BEGIN HEADER -->
    <%@ include  file="../../navi.jsp"%>
    <!-- END HEADER -->
    <!-- BEGIN CONTAINER -->
    <div class="page-container row-fluid">
        <!-- BEGIN SIDEBAR -->
        <%@ include  file="../../menus.jsp"%>
        <!-- END SIDEBAR -->
        <!-- BEGIN PAGE -->
        <div class="page-content">
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <!-- BEGIN STYLE CUSTOMIZER -->
						<a href="javascript:;" class="btn red" style="float:right; margin-right:20px;margin-top:20px;" onclick="release();"><i class=" icon-pencil" style="margin-right:5px;"></i>发布</a>
						<a href="${OFFICIAL_URL}" target="_blank" class="btn yellow" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-pencil" style="margin-right:5px;"></i>预览</a>
                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							项目详情
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">首页</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/project">项目管理</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>项目详情_办理流程</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li><a href="/project/details/${projectId}">基本信息</a></li>
                                <li><a href="/project/details/intro/${projectId}">项目介绍</a></li>
								<li><a href="/project/details/applyc/${projectId}">申请条件</a></li>
                                <li class="active"><a href="javascript:;">办理流程</a></li>
								<li><a href="/project/details/cost/${projectId}">费用详情</a></li>
								<li><a href="/project/details/material/${projectId}">材料清单</a></li>
								<li><a href="/project/details/resource/${projectId}">图片/视频</a></li>
								<c:if test="${subProject>0}">
									<li><a href="/project/details/subProject/${projectId}">二级项目</a></li>
								</c:if>
                            </ul>
                             <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                        
                                            <h3 class="form-section">办理流程</h3>
                                            <div class="span11 responsive" data-tablet="span12 fix-offset" data-desktop="span12">
                                                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                                                <div class="portlet box grey">
                                                    <div class="portlet-title">
                                                        <!-- <div class="actions">
                                                            <a href="#myModal3" role="button" class="btn blue addnew" data-toggle="modal" onclick="clearForm();"><i class="icon-pencil"></i> 新增</a>
                                                            <div class="btn-group">
                                                                <a class="btn green" href="#" data-toggle="dropdown">
                                                                    <i class="icon-cogs"></i>操作
                                                                    <i class="icon-angle-down"></i>
                                                                </a>
                                                                <ul class="dropdown-menu pull-right">
                                                                    <li><a href="javascript:;" id="batchDel"><i class="icon-trash"></i>批量删除</a></li>
                                                                    <li class="divider"></li>
                                                                    <li><a href="#"><i class="i"></i>Make admin</a></li>
                                                                </ul>
                                                            </div>
                                                        </div> -->
                                                    </div>
                                                    
                                                    <div class="portlet-body">
                                                    	<form id="searchForm" method="get" class="form-horizontal">
                                                        <table class="table table-striped table-bordered table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <!-- <th style="width:8px;">
                                                                        <input id="all" type="checkbox">
                                                                    </th> -->
                                                                    <th>序号</th>
                                                                    <th>流程</th>
                                                                    <th>周期</th>
                                                                    <th>办理内容</th>
                                                                    <!-- <th>顺序</th>
                                                                    <th>操作</th> -->
                                                                </tr>
                                                            </thead>
                                                            <tbody id="list">
                                                            	<c:forEach items="${list}" var="item" varStatus="status">
	                                                                <tr class="odd gradeX">
	                                                                    <%-- <td data-id="${item.project_apply_process_id}">
	                                                                        <input type="checkbox" class="checkboxes" value="${item.project_apply_process_id}" />
	                                                                    </td> --%>
	                                                                    <td>${status.count}</td>
	                                                                    <td data-name="${item.name}">${item.name}</td>
	                                                                    <td data-cycle="${item.cycle}">${item.cycle}</td>
	                                                                    <td data-cont="${item.content}">${item.content}</td>
	                                                                    <%-- <td>
	                                                                        <a href="/project/applyp/priority/${item.project_apply_process_id }?order=up">上移</a>
	                                                                        <a href="/project/applyp/priority/${item.project_apply_process_id }?order=down">下移</a>
	                                                                        <a href="/project/applyp/priority/${item.project_apply_process_id }?order=top">置顶</a>
	                                                                    </td>
	                                                                    <td>
	                                                                        <a class="updata" href="#myModal3" role="button" data-toggle="modal"><i class="icon-edit" style="margin-right:2px;"></i>编辑</a>
	                                                                        <a class="trash" data-id="${item.project_apply_process_id}" href="javascript:;" style="color:#555555;margin-left:10px;"><i class="icon-trash" style="margin-right:2px;"></i>删除</a>
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
                                </div>
                                
                                <!-- <div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
                                    <div class="modal-header">
                                        <button type="button" class="close" onclick="clearForm();" data-dismiss="modal" aria-hidden="true"></button>
                                        <h3 id="myModalLabel3" style="margin-top:5px;">编辑</h3>
                                    </div>
                                    
                                    <form class="form-horizontal" id="sform" method="post"  action="/project/applyp/add">
                                    	<input type="hidden" id="project_id" name="project_id" value="">
										<input type="hidden" id="project_apply_process_id" name="project_apply_process_id" />
	                                    <div class="modal-body">
	                                        <div class="portlet-body form">
	                                            BEGIN FORM
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label">流程名称:</label>
	                                                            <div class="controls">
	                                                                <input id="name"  type="text" class="m-wrap span10" name="name"/>
	                                                                <span style="color:red;margin-left:10px;">*</span>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label">流程周期:</label>
	                                                            <div class="controls">
	                                                                <input id="cycle"  type="text" class="m-wrap span10" name="cycle"/>
	                                                                <span style="color:red;margin-left:10px;">*</span>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label">办理内容:</label>
	                                                            <div class="controls">
	                                                            	<textarea id="content" class="span10 m-wrap" rows="6" name="content"></textarea>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                        </div>
	                                        <div class="modal-footer">
	                                            <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="clearForm();">取消</button>
	                                            <button id="subBtn" data-dismiss="modal" class="btn blue">保存</button>
	                                        </div>
	                                        </form>
	                                    </div> -->

                                </div>
                            </div>
                        </div>
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
            <div class="footer-inner">
                2013 &copy; Metronic by keenthemes.
            </div>
            <div class="footer-tools">
                <span class="go-top">
			<i class="icon-angle-up"></i>
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
        <script src="/views/media/js/table-managed.js"></script>
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
						$.post("/project/applyp/remove",{"ids":ids},function(data){
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
				$(".updata").each(function(index, element) {
            	 $(this).click(function(e){
            		    var tr = $(this).parent().parent();
						var td = $(tr).children("td");
						$("#project_apply_process_id").val($(td[0]).attr("data-id"));
						$("#name").val($(td[2]).attr("data-name"));
						$("#cycle").val($(td[3]).attr("data-cycle"));
						$("#content").val($(td[4]).attr("data-cont"));
				 });
             });
			
			//绑定删除按钮
				$("a.trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).attr("data-id");
						$.post("/project/applyp/remove",{"ids":id},function(data){
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
			
				//提交查询请求
				function doRequest(){
					//$("#searchForm").submit();
					$("#searchForm").formValidate();
				}
				
				//提交表单
				$("#subBtn").click(function(e) {
					$("#project_id").val("${projectId}");
					//调用验证插件，进行form表单的验证
					$("#sform").formValidate();
	            });
		});

		function clearForm() {
			$("#sform")[0].reset();
		}
		
		 function release() {
 			$.post("/project/details/release/${projectId}", function(data){
 				if(data.status==0) {
 					alert(data.msg);
 					window.location.reload();
 				} else {
 					alert(data.msg);
 				}
 			})
 		}
		
	</script>
        <!-- END JAVASCRIPTS -->

</body>
<!-- END BODY -->

</html>