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
    <link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
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
						<a href="javascript:;" class="btn red" style="float:right; margin-right:20px;margin-top:20px;" onclick="release();"><i class=" icon-pencil" style="margin-right:5px;"></i>发布</a>
						<a href="${OFFICIAL_URL}" target="_blank" class="btn yellow" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-pencil" style="margin-right:5px;"></i>预览</a>
                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							项目管理
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
                            <li>费用详情</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li><a href="/project/base/update/${projectId}">基本信息</a></li>
                                <li><a href="/project/intro/${projectId}">项目介绍</a></li>
                                <li><a href="/project/applyc/${projectId}">申请条件</a></li>
                                <li><a href="/project/applyp/${projectId}">办理流程</a></li>
								<li class="active"><a href="javascript:;">费用详情</a></li>
								<li><a href="/project/material/${projectId}">材料清单</a></li>
								<li><a href="/project/resource/${projectId}">图片/视频</a></li>
								<c:if test="${subProject>0}">
									<li><a href="/project/subProject/${projectId}">二级项目</a></li>
								</c:if>
                            </ul>
                             <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                        
                                            <h3 class="form-section">费用详情</h3>
                                            <div class="span11 responsive" data-tablet="span12 fix-offset" data-desktop="span12">
                                                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                                                <div class="portlet box grey">
                                                    <div class="portlet-title">
                                                        <div class="actions">
                                                            <a href="#myModal3" role="button" class="btn blue addnew" data-toggle="modal" onclick="initAdd();"><i class="icon-pencil"></i> 新增</a>
                                                            <div class="btn-group">
                                                                <a class="btn green" href="#" data-toggle="dropdown">
                                                                    <i class="icon-cogs"></i>操作
                                                                    <i class="icon-angle-down"></i>
                                                                </a>
                                                                <ul class="dropdown-menu pull-right">
                                                                    <li><a id="batchDel" href="javascript:;"><i class="icon-trash"></i>批量删除</a></li>
                                                                    <!-- <li class="divider"></li>
                                                                    <li><a href="#"><i class="i"></i> Make admin</a></li> -->
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="portlet-body">
                                                    	<form id="searchForm" method="post" class="form-horizontal">
                                                        <table class="table table-striped table-bordered " >
                                                            <thead>
                                                                <tr>
                                                                    <th style="width:8px;">
                                                                        <input id="all" type="checkbox">
                                                                    </th>
                                                                    <th>序号</th>
                                                                    <th>费用项</th>
                                                                    <th>收费机构</th>
                                                                    <th>金额</th>
                                                                    <th>收费阶段</th>
                                                                    <th>退款标准</th>
                                                                    <th>快捷操作</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="list">
                                                            	<c:forEach items="${list}" var="item" varStatus="status">
	                                                                <tr class="odd gradeX">
	                                                                    <td data-cid="${item.project_cost_id}">
	                                                                        <input type="checkbox" class="checkboxes" value="${item.project_cost_id}" />
	                                                                    </td>
	                                                                    <td>${status.count}</td>
	                                                                    <td data-cname="${item.name}">${item.name}</td>
	                                                                    <td data-inst="${item.institution}">${item.institution}</td>
	                                                                    <td data-cost="${item.cost}">${item.cost}</td>
	                                                                    <td data-cs="${item.charge_stage}">${item.charge_stage}</td>
	                                                                    <td data-rs="${item.refund_standard}">${item.refund_standard}</td>
	                                                                    <td>
	                                                                        <a href="javascript:;" onclick="orderUpdata('${item.project_cost_id}', 'top');" class="btn black-stripe mini"><i class="icon-circle-arrow-up"></i> 置顶</a>
																			<a href="javascript:;" onclick="orderUpdata('${item.project_cost_id}', 'up');" class="btn black-stripe mini"><i class="icon-arrow-up"></i> 上移</a>
																			<a href="javascript:;" onclick="orderUpdata('${item.project_cost_id}', 'down');" class="btn black-stripe mini"><i class="icon-arrow-down"></i> 下移</a>
																			<a href="#myModal3" class="btn green-stripe mini updata" role="button" data-toggle="modal"><i class="icon-edit"></i> 编辑</a>
																			<a href="javascript:;" data-id="${item.project_cost_id}" class="btn red-stripe mini trash"><i class="icon-trash"></i> 删除</a>
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
                                                <!-- END EXAMPLE TABLE PORTLET-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true">
                                    <div class="modal-header">
                                        <button type="button" class="close"  onclick="clearForm();" data-dismiss="modal" aria-hidden="true"></button>
                                        <h3 id="myModalLabel3" style="margin-top:5px;">编辑</h3>
                                    </div>
                                    
                                    <form class="form-horizontal" id="sform" method="post"  action="/project/cost/add">
                                    	<input type="hidden" id="project_id" name="project_id" value="">
										<input type="hidden" id="project_cost_id" name="project_cost_id" />
	                                    <div class="modal-body">
	                                        <div class="portlet-body form">
	                                            <!-- BEGIN FORM-->
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label span3">费用项:</label>
	                                                            <div class="controls span9">
	                                                                <input id="name" must-be="true" data-label="费用项"  data-length="20"  type="text" class="m-wrap span10" name="name"/>
	                                                                <span style="color:red;margin-left:10px;">*</span>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label span3">收费机构:</label>
	                                                            <div class="controls span9">
	                                                                <input id="institution" must-be="true" data-label="收费机构"  data-length="30"  type="text" class="m-wrap span10" name="institution"/>
	                                                                <span style="color:red;margin-left:10px;">*</span>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label span3">金额:</label>
	                                                            <div class="controls span9">
	                                                                <input id="cost" must-be="true" data-label="金额"  data-length="20"  type="text" class="m-wrap span10" name="cost"/>
	                                                                <span style="color:red;margin-left:10px;">*</span>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label span3">收费时间/阶段:</label>
	                                                            <div class="controls span9">
	                                                                <input id="charge_stage"  data-length="20"   type="text" class="m-wrap span10" name="charge_stage"/>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <div class="row-fluid">
	                                                    <div class="span12 ">
	                                                        <div class="control-group">
	                                                            <label class="control-label span3">退款标准:</label>
	                                                            <div class="controls span9">
	                                                                <input id="refund_standard" data-length="20"  type="text" class="m-wrap span10" name="refund_standard"/>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                        </div>
	                                        <div class="modal-footer">
	                                            <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="clearForm();">取消</button>
	                                             <button type="button"  id="subBtn"  class="btn blue">保存</button>
	                                        </div>
	                                        </form>
	                                    </div>

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
					if(confirm('确定删除吗?')) {
						var ids="";
						checks.each(function(index, element) {
							if(ids=="")
								ids=$(this).val();
							else{
								ids = ids+","+$(this).val();
							}
						});
						//dosomething
						$.post("/project/cost/remove",{"ids":ids},function(data){
							if(data.status==0){
								checks.each(function(index, element) {
									$(this).parents("#list>tr").remove();
								});
								alert(data.msg);
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
			$(".updata").each(function(index, element) {
           	 $(this).click(function(e){
           			$("#myModalLabel3").text("修改");
           			clearForm();
           		    var tr = $(this).parent().parent();
					var td = $(tr).children("td");
					$("#project_cost_id").val($(td[0]).attr("data-cid"));
					$("#name").val($(td[2]).attr("data-cname"));
					$("#institution").val($(td[3]).attr("data-inst"));
					$("#cost").val($(td[4]).attr("data-cost"));
					$("#charge_stage").val($(td[5]).attr("data-cs"));
					$("#refund_standard").val($(td[6]).attr("data-rs"));
			 });
            });
		
			//绑定删除按钮
			$("a.trash").each(function(index, element) {
				$(this).click(function(e){
					if(confirm('确定删除吗?')) {
						var id = $(this).attr("data-id");
						$.post("/project/cost/remove",{"ids":id},function(data){
							if(data.status==0){
								$(element).parents("#list>tr").remove();
								alert(data.msg);
								doRequest();
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
		
			//提交表单
			$("#subBtn").click(function(e) {
				$("#project_id").val("${projectId}");
				//调用验证插件，进行form表单的验证
				$("#sform").formValidate();
            });
		});

		function initAdd() {
			$("#myModalLabel3").text("新增");
			clearForm();
		}
		
		function clearForm() {
			$("#sform :input").not(":button, :submit, :reset").val("").removeAttr("checked").remove("selected");
		}
		
		//排序
		function orderUpdata(id, order) {
			$.post("/project/cost/priority",{"id":id, "order":order},function(data){
				if(data.status==0) {
					alert(data.msg);
					doRequest();
				} else {
					alert(data.msg);
				}
			});
		}
		
		
		//提交查询请求
		function doRequest(){
			//$("#searchForm").submit();
			$("#searchForm").formValidate();
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