<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
						<h3 class="page-title">问卷管理</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">主页</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>评估管理 - 问卷管理</li>
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
									<c:if test="${list != null && fn:length(list) > 0}">
										<a id="btnCopy" class="btn yellow"><i class="icon-copy"></i> 复制问卷</a>
									</c:if>
									<a id="addVersion" class="btn purple"><i class="icon-plus"></i> 新增问卷</a>
									<c:if test="${versionInfo.status == wfb }">
										<a id="btnAdd" class="btn green"><i class="icon-plus"></i> 新增问题</a>
                                    	<a id="btnSave" class="btn blue"><i class="icon-ok"></i> 保存</a>
                                    	<a id="btnPublish" class="btn red"><i class="icon-ok-sign"></i> 发布</a>
                                    </c:if>
                                    
								</div>
							</div>
					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" action="">
                      		<input type="hidden" id="sversion" name="sversion" value="${sversion }">
                      		<div class="span12">
                                    <div class="span4 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">问卷版本:</label>
                                            <div class="controls">
                                                <select class="m-wrap span9" style="float:left;" id="versionSelect">
                                                	<c:forEach items="${versionList }" var="item">
                                                		<c:if test="${sversion == item.version_id }">
                                                			<option value="${item.version_id }" selected="selected">${item.version_no }</option>
                                                		</c:if>
                                                		<c:if test="${sversion != item.version_id }">
                                                			<option value="${item.version_id }">${item.version_no }</option>
                                                		</c:if>
                                                	</c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span2 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">发布状态:</label>
                                            <div class="controls" id="statusDiv" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
                                                ${versionInfo.name }
                                            </div>
                                        </div>
                                    </div>
                                    <div class="span6 ">
                                        <div class="control-group">
                                            <label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">发布时间:</label>
                                            <div class="controls" id="publishDiv" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
                                            	<c:if test="${versionInfo.status != wfb }">
                                            		<fmt:formatDate value="${versionInfo.publish_time}" pattern="yyyy-MM-dd HH:mm"/>
                                            	</c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                          <table class="table table-striped table-bordered table-hover">
							  <thead>
								  <tr>
									  <th style="width:30px;">编号</th>
                                      <th style="text-align:center;width:20%;">问题名</th>
                                      <th style="text-align:center;width:20%;">注解</th>
                                      <th style="text-align:center">作答模式</th>
                                      <th style="text-align:center">是否必填</th>
                                      <th style="text-align:center;width:10%;">匹配权重</th>
                                      <c:if test="${versionInfo.status == wfb}">
                                      <th >快捷操作&nbsp;&nbsp;</th>
                                      </c:if>
								  </tr>
							  </thead>
							  <tbody id="list">
								  <c:forEach items="${list}" var="item" varStatus="status">
									<tr>
										<td style="text-align:center">${status.index + 1}</td>
										<td style="text-align:left">
                                            ${item.title}
                                        </td>
										<td>${item.annotation}</td>
                                        <td style="text-align:center">
                                        	${item.answerZN}
                                        </td>
                                        <td style="text-align:center">
                                        	${item.isrequiredZN}
                                        </td>
										<td style="text-align:center">
											<c:if test="${versionInfo.status != wfb}">
												${item.weight}<span style="font-size:14px;margin-left:5px;">%</span>
											</c:if>
											<c:if test="${versionInfo.status == wfb}">
                                        		<input type="text" class="span6" id="${item.estimate_question_id}" name="weights" value="${item.weight}" ><span style="font-size:14px;margin-left:5px;">%</span>
                                        	</c:if>
                                        </td>
                                        <c:if test="${versionInfo.status == wfb}">
                                        <td data-title="操作">
                                        	<div data-id="${item.estimate_question_id}">
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
                                       </c:if>
								    </tr>
                                  </c:forEach>
							  </tbody>
						  </table>
						  	<!-- 
                          		<input id="field" name="field" type="hidden" /> 
                                <input id="way" name="way" type="hidden" /> 
                                <div id="pageBar">
                                	<input type="hidden" name="page" value="1" />
                                    ${pageBar}
                                </div>
                                 -->
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
				
		
			//绑定内容编辑
				$("i.icon-pencil").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						location.href="/estimates/edit/"+id;
					});		
                });
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						if(confirm("提示：删除后无法恢复.确认要删除吗？")){
							$.post("/estimates/delete",{"ids":id},function(data){
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
						$.post("/estimates/topsort",{"id":id},function(data){
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
						$.post("/estimates/upsort",{"id":id},function(data){
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
						$.post("/estimates/downsort",{"id":id},function(data){
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
			
			//问卷版本改变
				$("#versionSelect").change(function () {  
		            var ss = $(this).children('option:selected').val();  
		            
		            $("#sversion").val(ss);
		            //alert($("#sversion").val());
		            $("#searchForm").attr("action","/estimates");
		            $("#searchForm").formValidate();
		        }); 
			
			
			var ids = "";//问题ID
			var wvs = "";//问题权重值
			//验证权重值是否达到100
			function valiWeight(){
				var reg = /^(0|[1-9]\d?|100)$/;
				var wt = 0;
				var flag = true;
				ids = "";
				wvs = "";
				
				$("input[name='weights']").each( 
						function(){ 
							ids += $(this).attr("id") + ",";
							wvs += $(this).val() + ",";
							if(reg.test($(this).val())){
								wt += parseInt($(this).val());  
							}else{
								$(this).val("");
								$(this).focus();
								flag = false;
							}
						}  
				)  
				if(!flag){
					return -1;
				}else{
					if(wt==100){
						return 1;
					}
					return 0;
				}
				
			}
			//新增问题
			$("#btnAdd").click(function(e) {
				location.href = "/estimates/add?vid="+$("#sversion").val();
            });
			
			//复制新增
				$("#btnCopy").click(function(e) {
					if(confirm("是否复制当前版本["+$("#versionSelect").find("option:selected").text()+"]并创建新问卷?")){
						$.post("/estimates/copyAndCreate",{"vid":$("#sversion").val()},function(data){
							if(data.status==0){
								alert("复制问卷成功");
								$("#sversion").val(data.msg);
					            $("#searchForm").formValidate();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert(data.msg);
						});
					}
                });
			
			//新增问卷
				$("#addVersion").click(function(e) {
					if(confirm("是否为您创建新的空白问卷?")){
						$.post("/estimates/newVersion",{},function(data){
							if(data.status==0){
								alert("问卷新增成功");
								$("#sversion").val(data.msg);
					            $("#searchForm").formValidate();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert(data.msg);
						});
					}
                });
			
			//保存权重
				$("#btnSave").click(function(e) {
					var v = valiWeight();
					if(v == -1){
						alert("权重值为0-100的整数");
					}else{
						$.post("/estimates/saveWeight",{"ids":ids,wvs:wvs},function(data){
							if(data.status==0){
								alert("保存成功");
								window.location.reload();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert(data.msg);
						});
					}
                });
			
			//发布
				$("#btnPublish").click(function(e) {
					var v = valiWeight();
					if(v == 1){
						$.post("/estimates/publishVersion",{"ids":ids,wvs:wvs,vid:$("#sversion").val()},function(data){
							if(data.status==0){
								alert("发布成功");
								window.location.reload();
							}else if(data.status == 2){
								alert(data.msg);
							}
							else
								alert(data.msg);
						});
					}else if(v == 0){
						alert("保存权重设置失败：所有问题匹配权重值之和必须为100%.请确认");
					}else if(v == -1){
						alert("权重值为0-100的整数");
					}
                });
			
		});
		
	</script>
	<!-- END JAVASCRIPTS -->
<!-- END BODY -->
</html>