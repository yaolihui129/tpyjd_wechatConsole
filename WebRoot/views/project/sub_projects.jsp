<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
                                <li><a href="/project/applyp/${project.projectId}">办理流程</a></li>
								<li><a href="/project/cost/${projectId}">费用详情</a></li>
								<li><a href="/project/material/${projectId}">材料清单</a></li>
								<li><a href="/project/resource/${projectId}">图片/视频</a></li>
								<li class="active"><a href="javascript:;">二级项目</a></li>
                            </ul>
                             <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="container-fluid">
                                        <div class="row-fluid">
                                        
                                            <h3 class="form-section">二级项目</h3>
                                            <div class="responsive">
                                                <!-- BEGIN EXAMPLE TABLE PORTLET-->
                                                <div class="portlet box grey">
                                                    <div class="portlet-title" style="height: 26px;">
                                                        <div class="actions">
                                                            <!-- <a href="#myModal3" role="button" class="btn blue addnew" data-toggle="modal" onclick="initAdd();"><i class="icon-pencil"></i> 新增</a>
                                                            <div class="btn-group">
                                                                <a class="btn green" href="#" data-toggle="dropdown">
                                                                    <i class="icon-cogs"></i>操作
                                                                    <i class="icon-angle-down"></i>
                                                                </a>
                                                                <ul class="dropdown-menu pull-right">
                                                                    <li><a id="batchDel" href="javascript:;"><i class="icon-trash"></i>批量删除</a></li>
                                                                    <li class="divider"></li>
                                                                    <li><a href="#"><i class="i"></i> Make admin</a></li>
                                                                </ul>
                                                            </div> -->
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="portlet-body">
                                                    	<form id="searchForm" method="post" class="form-horizontal">
                                                       <table class="table table-striped table-bordered table-hover">
						                                    <thead>
						                                        <tr>
						                                            <th style="width:8px;" id="all">
						                                                <input type="checkbox" class="group-checkable" />
						                                            </th>
						                                            <c:choose>
																		<c:when test="${field=='project_code' && way=='asc'}">
																			<th width="" class="sorting_asc" data-field="project_code">项目编号</th>
																		</c:when>
																		<c:when test="${field=='project_code' && way=='desc'}">
																			  <th width="" class="sorting_desc" data-field="project_code">项目编号</th>
																		</c:when>
																		<c:otherwise>
																			<th width="" class="sorting" data-field="project_code">项目编号</th>
																		</c:otherwise>
																	  </c:choose>
																		
																	  <c:choose>
																		<c:when test="${field=='project_name' && way=='asc'}">
																			<th width="" class="sorting_asc" data-field="project_name">项目名称</th>
																		</c:when>
																		<c:when test="${field=='project_name' && way=='desc'}">
																			  <th width="" class="sorting_desc" data-field="project_name">项目名称</th>
																		</c:when>
																		<c:otherwise>
																			<th width="" class="sorting" data-field="project_name">项目名称</th>
																		</c:otherwise>
																	  </c:choose>
																	  
																	  <th width="" class="" >项目级别</th>
																	  <th width="" class="" >国家地区</th>
																	  <th width="" class="" data-field="">项目分类</th>
																	  
																	  <c:choose>
																		<c:when test="${field=='project_status' && way=='asc'}">
																			<th width="" class="sorting_asc" data-field="project_status">项目状态</th>
																		</c:when>
																		<c:when test="${field=='project_status' && way=='desc'}">
																			  <th width="" class="sorting_desc" data-field="project_status">项目状态</th>
																		</c:when>
																		<c:otherwise>
																			<th width="" class="sorting" data-field="project_status">项目状态</th>
																		</c:otherwise>
																	  </c:choose>
																	  <th>扩展推荐</th>
																	  <th width="" class="" data-field="">上线日期</th>
																	  <th width="" class="" data-field="">操作人</th>
						                                               <th>操作</th>
						                                        </tr>
						                                    </thead>
						                                    <tbody  id="list">
																<c:forEach items="${list}" var="item" varStatus="status">
						                                        <tr class="odd gradeX">
						                                            <td><input  type="checkbox" class="checkboxes"  value="${item.project_id}" /></td>
						                                            <td>${item.project_code}</td>
																	<td>
																		<a href="/project/details/${item.project_id}" style="color:#4d90fe;text-decoration:underline;">${item.project_name}</a>
																	</td>
																	<td>${item.project_level_name}</td>
																	<td>
																		${item.country_name}
																		<c:if test="${item.city_name != null}">
																			>${item.city_name}
																		</c:if>
																	</td>
																	<td>${item.project_type_name}</td>
																	<td>${item.project_status_name}</td>
																	<td>
																		<c:if test="${item.project_expands_name != null}">
																			${item.project_expands_name}
																		</c:if>
																	</td>
																	<td><fmt:formatDate value="${item.online_time}" type="date" dateStyle="default"/></td>
																	<td>${item.create_user_name}</td>
						                                            <td style="min-width:130px;">
						                                            	<a  href="javascript:void(0);" class="btn green-stripe mini edit" role="button" data-id="${item.project_id}"><i class="icon-edit"></i> 编辑</a>
						                                                <a href="#updataStatus" class="btn yellow-stripe mini" role="button" class="btn blue addnew" data-toggle="modal" onclick="initStatus('${item.project_id}');"><i class="icon-minus"></i> 暂停</a>
						                                            	<%-- <c:choose>
						                                            		<c:when test="${now == 1 and status.count == 1}"></c:when>
						                                            		<c:otherwise>
						                                            			<a href="javascript:;" onclick="orderUpdata('${item.project_id}', 'top');" class="btn black-stripe mini"><i class="icon-circle-arrow-up"></i> 置顶</a>
																				<a href="javascript:;" onclick="orderUpdata('${item.project_id}', 'up');" class="btn black-stripe mini"><i class="icon-arrow-up"></i> 上移</a>
						                                            		</c:otherwise>
						                                            	</c:choose>
						                                            	<c:choose>
						                                            		<c:when test="${now==page and status.count==fn:length(list)}"></c:when>
						                                            		<c:otherwise>
						                                            			<a href="javascript:;" onclick="orderUpdata('${item.project_id}', 'down');" class="btn black-stripe mini"><i class="icon-arrow-down"></i> 下移</a>
						                                            		</c:otherwise>
						                                            	</c:choose> --%>
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
                                
                                
                                <div class="modal hide fade addMyModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3" aria-hidden="true" >
					                <div class="modal-header">
					                    <button type="button" class="close" onclick="clearForm();" data-dismiss="modal" aria-hidden="true"></button>
					                    <h3  style="margin-top:5px;">扩展推荐</h3>
					                 </div>
					                          
				                     <form class="form-horizontal" id="sform" method="post" >
				                     	<div class="control-group" style="padding-top:20px;">
				                        	<label class="control-label">扩展推荐:</label>
											<div class="controls"  style="padding-left:20px;min-height:160px;">
												<c:if test="${expandsList != null}">
													<c:forEach var="item" items="${expandsList}">
														<label class="checkbox span3">
															<input type="checkbox" name="project_expands" value="${item.dictCode}" /> ${item.name}
														</label>
													</c:forEach>
												</c:if>
											</div>
				                        </div>
				                        
										<div class="modal-footer">
										    <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="clearForm();">取消</button>
										     <button type="button"  id="subBtn"  class="btn blue">保存</button>
										</div>
					                 </form>
				              </div>
				              
				              <div id="updataStatus" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="updataStatus" aria-hidden="true" >
					                <div class="modal-header">
					                    <button type="button" class="close" onclick="clearStatusForm();" data-dismiss="modal" aria-hidden="true"></button>
					                    <h3  style="margin-top:5px;">项目状态</h3>
					                 </div>
					                          
				                     <form class="form-horizontal" id="statusform" method="post" >
				                     	<input type="hidden"  id="project_id"  />
				                     	<div class="control-group" style="padding-top:20px;">
				                        	<label class="control-label">项目状态:</label>
											<div class="controls"  style="padding-left:20px;min-height:160px;">
												<select id="project_status" class="m-wrap" style="float:left;">
													<option value="00070003">暂停</option>
													<option value="00070004">售罄</option>
												</select>
											</div>
				                        </div>
				                        
										<div class="modal-footer">
										    <button class="btn" data-dismiss="modal" aria-hidden="true" onclick="clearStatusForm();">取消</button>
										     <button type="button"  id="statusBtn"  class="btn blue">保存</button>
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
	                   console.log(checks);
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
							$.post("/project/remove",{"ids":ids},function(data){
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
							$.post("/project/remove",{"ids":id},function(data){
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
			
			//排序
			function orderUpdata(id, order) {
				$.post("/project/priority",{"id":id, "order":order},function(data){
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
				$("#searchForm").formValidate();
			}
			
	        
	      //提交表单
			$("#subBtn").click(function(e) {
				 var checks = $("input.checkboxes:checked");
				 var projectIds=new Array();
					if(checks.size()>0){
						checks.each(function(index, element) {
	                     var id=$(this).val();
	                     if(id) {
	                    	 projectIds.push(id);
	                     }
	                 });
						
					var cks = $("input[name='project_expands']:checked");
					if(cks.size()>0) {
						var expandsIds = new Array();
						if(cks.size()>0) {
							cks.each(function(index, element) {
								var ck = $(this).val();
								if(ck) {
									expandsIds.push(ck);
								}
							})
						}
	
						$.ajax({
						    type:'post',
						    url:'/project/expands',
						    data:{projectIds:projectIds,expandsIds:expandsIds},
						    traditional:true,
						    async:false,
						    success:function(data) {
						    	if(data.status==0) {
						    		alert(data.msg);
									$("#myModal3").removeClass("in");
									$(".modal-backdrop").removeClass("in");
									doRequest();
								} else {
									alert(data.msg);
								}
						    }
						});
					} else {
						alert("扩展推荐没有选中项！");
					}
				} else {
					alert("请选择其中一行项目");	
				}
	        });
	
			
			//扩展选项
			function projectExpands() {
				$("input[name='project_expands']").removeAttr("checked").parent().removeClass("checked");
				 var checks = $("input.checkboxes:checked");
				 if(checks.size()<=0) {
						alert("请选择其中一行项目");	
				} else {
					if(checks.size()==1) {
						var projectId="";
						checks.each(function(index, element) {
							var ck = $(this).val();
							if(ck) {
								projectId=ck;
							}
						})
						
						$.ajax({
						    type:'post',
						    url:'/project/getProjectExpands',
						    data:{projectId:projectId},
						    async:false,
						    success:function(data) {
						    	if(data.status==0) {
									var i=0;
									var obj = data.list;
									for(i; i<obj.length; i++) {
										$("input[name='project_expands']:checkbox[value='"+obj[i].dict_code+"']").attr('checked','true').parent().addClass("checked");
									}
								}  else {
									alert(data.msg);
								}
						    }
						});
					}
					$(".addMyModal3").attr("id","myModal3");
				}
			}
			
			function clearForm() {
				$("input[name='project_expands']").removeAttr("checked").parent().removeClass("checked");
				$("input.checkboxes").removeAttr("checked").parent().removeClass("checked");
				$(".addMyModal3").removeAttr("id");
			}
			
			/* //暂停操作
			function stop(id) {
				$.post("/project/stop/"+id, function(data){
					if(data.status==0) {
						doRequest();
					} else {
						alert("暂停操作失败！");
					}
				});
			} */
			
			//保存项目状态
			$("#statusBtn").click(function(e) {
				var projectId=$("#project_id").val(),
					projectStatus=$("#project_status").val();
				
				if(projectId && projectStatus) {
					$.post("/project/stop/"+projectId,{'status':projectStatus}, function(data){
						if(data.status==0) {
							alert(data.msg);
							doRequest();
						} else {
							alert(data.msg);
						}
					});
				} else {
					alert("没有选择！");
				}
				
			});
			
			//项目状态
			function initStatus(id) {
				clearStatusForm();
				$("#project_id").val(id);
			}
			function clearStatusForm() {
				$("#project_id").val('');
				$("#project_status option:first").prop("selected", 'selected');
			}
			
			 $("#countryCode").change(function(){
	         	$("#cityCode").empty();
	         	$("#cityCode").append("<option value=''>城市列表</option>");
	         	if($(this).val()) {
		            	$.post("/utils/getCity", {"country_code":$(this).val()}, function(data){
		             		if(data.status==0) {
		             			var obj = data.citys;
		             			var html="";
		             			if(obj.length) {
		             				for(var i=0; i<obj.length; i++) {
		             					html+='<option value="'+obj[i].dict_code+'">'+obj[i].name+'</option>';
		             				}
		             				$("#cityCode").empty();
		             				$("#cityCode").append("<option value=''>城市列表</option>"+html);
		             			}
		            		} else {
		            			alert(data.msg);
		            		}
		            	});
	         	}
	         });
			
			 
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