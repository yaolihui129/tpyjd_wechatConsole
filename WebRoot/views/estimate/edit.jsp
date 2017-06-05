<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
<link rel="stylesheet" href="/views/media/css/multiple-select.css">

<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>

<style type="text/css">
.need{
	color:red;
}
</style>

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->
	<%@ include file="../navi.jsp"%>
	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->
	<div class="page-container row-fluid">
		<!-- BEGIN SIDEBAR -->
		<%@ include file="../menus.jsp"%>
		<!-- END SIDEBAR -->

		<!-- BEGIN PAGE -->
        <div class="page-content">
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
            	
            	<div class="row-fluid">
					<div class="span12">
						
						<h3 class="page-title">
							问题${operation }
							 <small></small>
						</h3>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>

							<li>
								<a href="/estimates">问卷管理</a>
								<span class="icon-angle-right"></span>
							</li>

							<li><a href="#">问题${operation }</a></li>
						</ul>
					</div>
				</div>
            
                <div class="portlet-body form">
                    <!-- BEGIN FORM-->
                    <form action="#" id="questionForm" class="form-horizontal" method="post">
                    	<div class="row-fluid">
                            <div class="span12">
                                <div class="control-group">
                                    <label class="control-label">问卷版本：</label>
                                    <div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
                                        ${qversion.versionNo}
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        
                        <div class="row-fluid">
                            <div class="span12">
                                <div class="control-group">
                                    <label class="control-label"><span class="need">*</span>问题名：</label>
                                    <div class="controls">
                                        <input type="text" class="m-wrap span5" id="title" name="title" data-label="问题名" must-be="true" maxlength="30" value="${question.title }">
                                        <select class="m-wrap span5" must-be="true" id="dict_code" name="dict_code" data-label="项目特性">
                                        	<option value="">请设置问题对应的项目特性</option>
                                        	<c:forEach items="${propertyList }" var="item">
                                        		<c:if test="${question.dictCode ==  item.dictCode}">
                                        			<option value="${item.dictCode }" selected="selected">${item.name }</option>
                                        		</c:if>
                                        		<c:if test="${question.dictCode !=  item.dictCode}">
                                        			<option value="${item.dictCode }" >${item.name }</option>
                                        		</c:if>
                                        	</c:forEach>
                                        </select>

                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>

                        <div class="row-fluid">
                            <div class="span12">
                                <div class="control-group">
                                    <label class="control-label">问题注解：</label>
                                    <div class="controls">
                                        <textarea class="span10 m-wrap" rows="6" maxlength="100" id="annotation"  name="annotation">${question.annotation}</textarea>
                                    </div>

                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <div class="row-fluid">
                            <div class="span12">
                                <div class="control-group">
                                    <label class="control-label"><span class="need">*</span>作答模式：</label>
                                    <div class="controls">
                                        <select class="m-wrap span10" must-be="true" id="answer" name="answer" data-label="作答模式" <c:if test="${!empty question.estimateQuestionId}">disabled="disabled"</c:if> >
                                        	<option value="">--请选择--</option>
                                        	<c:forEach items="${answerModeList }" var="item">
                                        		<c:if test="${question.answer ==  item.dictCode}">
                                        			<option value="${item.dictCode }" selected="selected">${item.name }</option>
                                        		</c:if>
                                        		<c:if test="${question.answer !=  item.dictCode}">
                                        			<option value="${item.dictCode }">${item.name }</option>
                                        		</c:if>
                                        	</c:forEach>

                                        </select>
                                    </div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <div class="row-fluid">
                            <div class="span12">
                                <div class="control-group">
                                    <label class="control-label"><span class="need">*</span>是否必填：</label>
                                    <div class="controls">                                                
										<label class="radio">
										<input type="radio" name="isrequired" value="1" checked="checked"/>
										是
										</label>
										<label class="radio">
										<input type="radio" name="isrequired" value="0" <c:if test="${question.isrequired ==  0}">checked="checked"</c:if> />
										否
										</label>  
									</div>
                                </div>
                            </div>
                            <!--/span-->
                        </div>
                        <div class=" row-fluid " >
                            <div class="span12 ">
                            	<c:if test="${question.estimateQuestionId == null }"><!-- 新增 -->
	                            	<div class="control-group answer-question" id="answerOptionDiv">
	                                    <label class="control-label "><span class="need" id="answerOption">*</span>答案选项：</label>
	                                    <div class="controls" id="test">
	                                        <input type="text" class="m-wrap span4" style="float:left;" placeholder="请填写用户可选答案">
	                                        <div class="span4">
	                                            <select class="ms" id="additional" multiple="multiple" name="additional" data-type="select" data-label="答案选项" must-be="true">
	   
	                                            </select>
	                                        </div>
	                                        <div class="add-btn span2" style="float:left;margin-bottom:20px;">
				                                
				                            </div>
	                                    </div>
	                                    
	                                </div>
                            	</c:if>
                            	
                            	
                            	
                            	<c:if test="${question.estimateQuestionId != null }"><!-- 编辑 -->
                            		<div class="control-group answer-question" id="answerOptionDiv">
	                                    <label class="control-label "><span class="need">*</span>答案选项：</label>
	                                    
	                                    <c:forEach items="${esList }" var="qselect" varStatus="status">
	                                    	<c:if test="${status.index != 0 }">
	                                    		<label class="control-label "></label>
	                                    	</c:if>
	                                    	<div class="controls">
		                                        <input type="text" class="m-wrap span4" style="float:left;" placeholder="请填写用户可选答案" value="${qselect.content }">
		                                        <div class="span4">
		                                            <select class="ms" id="additional" multiple="multiple" name="additional" data-type="select" data-label="答案选项" must-be="true">
		                                            	<c:forEach items="${qselect.dictList }" var="qsa">
		                                            		<option value="${qsa.dictCode }" <c:if test="${qsa.deleteFlag == 9 }">selected="selected"</c:if> >${qsa.name }</option>
		                                            	</c:forEach>
		                                            	
		                                            </select>
		                                        </div>
		                                        <div class="add-btn span2" style="float:left;margin-bottom:20px;">
		                                        	<a href="javascript:;" class="btn icn-only remove"><i class="icon-minus" style="color:#999;"></i></a>
		                                        	<c:if test="${status.last }">
		                                        		<a href="javascript:;" class="btn  icn-only add"><i class=" icon-plus" style="color:#999;"></i></a>
		                                        	</c:if>
					                            </div>
		                                    </div>
	                                    </c:forEach>
	                                    
	                                </div>
                            	</c:if>
                            </div>
                            <!--/span-->
                        </div>

                        <!--/row-->

                        <!--/row-->
                        <div class="form-actions " style="background-color:#ffffff;padding-left: 180px; ">
                        	<input type="hidden" id="jsonParam" name="jsonParam" value="">
                        	<input type="hidden" id="version_id" name="version_id" value="${qversion.versionId }">
                        	<input type="hidden" id="question_id" name="question_id" value="${question.estimateQuestionId }">
                            <button type="button" class="btn blue " id="subBtn"><i class="icon-ok "></i> 保存</button>
                            <button type="button" class="btn " id="back">取消</button>
                        </div>
                    </form>
                    <!-- END FORM-->
                </div>
            </div>
            <!-- END PAGE CONTAINER-->
        </div>
        <!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
	<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript"></script>
	<!-- END CORE PLUGINS -->

	<script type="text/javascript" src="/views/media/js/form-validate.js"></script>
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<script type="text/javascript" src="/js/json/json2.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/views/media/js/multiple-select.js"></script>

	<script src="/js/laydate/laydate.js"></script>
	<!-- 日期控件 -->
	<script>
		jQuery(document)
				.ready(
						function() {
							// initiate layout and plugins
							App.init();
							FormSamples.init();
							TableAdvanced.init();
							
							$(function () {
					            $('.ms').change(function () {
					                console.log($(this).val());
					            }).multipleSelect({
					                width: '100%',
					                placeholder: "请选择匹配关系"
					            });
					            

					        });
							
							
							//提交表单
							$("#subBtn")
									.click(
											function(e) {
												if($('#title').val() == ""){
													alert("问题名不能为空");
													$("#title").focus();
												}else{
													$.post("/estimates/valiTitle", 
															{ 
															"question_id": "${question.estimateQuestionId }", 
															"title": $('#title').val(),
															"version_id":$("#version_id").val()
															},
															function(data){
																if(data.status==0){
																	var flag = true;
																	//作答模式
																	var am = $("#answer").children('option:selected').val();  
																	//项目特性
																	var tx = $("#dict_code").children('option:selected').val(); 
																	if(tx == null || tx == ""){
																		alert("请选择项目特性");
																		flag = false;
																	}else{
																		
																		if(am == null || am == ""){
																			alert("请选择作答模式");
																			flag = false;
																		}else{
																			if(am == "${single}" || am == "${much}"){
																				$(".answer-question>.controls").each(function(){
																					if($(this).find("input").val() == "" || $(this).find("select").val() == ""
																							|| $(this).find("input").val() == null || $(this).find("select").val() == null){
																						alert("可选答案和匹配关系都不能为空");
																						flag = false;
																						return false;
																					}
																			    });
																			}
																		}
																	}
																	
																	
																	if(flag){
																		var data=[];
																		
																		if(am == "${single}" || am == "${much}"){
																			//获取答案选项、匹配关系
																			$(".answer-question>.controls").each(function(){
																				var tmp = {};
																				tmp.options = $(this).find("input").val();
																				tmp.selects = $(this).find("select").val();
																				data.push(tmp);
																		    });
																			
																		}
																		$("#jsonParam").val(JSON.stringify(data));
																		//调用验证插件，进行form表单的验证
																		$("#questionForm").formValidate();
																	}
																	
																}
																else {
																	alert(data.msg);
																	return false;
																}
														});
												}
												
											});
							
							
							
							var AddHtml = '<label class="control-label "></label>${answerOptions}';
	
				            $(document).on("click",".add", function () {
				                $(".answer-question>.controls:last").after(AddHtml);
				                $(".answer-question>.controls:last").find(".ms").change(function () {
				                    console.log($(this).val());
				                }).multipleSelect({
				                    width: '100%',
				                    placeholder: "请选择匹配关系"
				                });
				                
				                //最后一行显示增加按钮 
				                var tmp = 1;
				                $(".answer-question>.controls").each(function(){
									
									if(tmp != $(".answer-question>.controls").length){
										$(this).find(".add").hide();
										$(this).find(".remove").show();
									}
									tmp++;
							    });
				                
				            });
				            
							
				            $(document).on("click",".remove", function () {
				            	if($(".answer-question>.controls").length == 1){
				            		alert("最后一个不允许删除");
				            	}else{
				            		if($('.remove').index(this) == 0){
				            			$(this).parent().parent().next().remove();
				            			$(this).parent().parent().remove();
				            			
				            		}else{
				            			$(this).parent().parent().prev().remove();
						            	$(this).parent().parent().remove();
				            		}
				            		//只有一行时 隐藏删除按钮
				            		if($(".answer-question>.controls").length == 1){
				            			$(".answer-question>.controls>.span2>.remove").hide();
				            			$(".answer-question>.controls>.span2>.add").show();
				            		}else{
				            			$(".answer-question>.controls:last>.span2>.add").show();
				            		}
				            		
				            	}
				            	
				            });
							

							$("#back").click(function(e) {
								window.history.back();
							});

							//作答模式改变
							$("#answer").change(function () {  
					            var ss = $(this).children('option:selected').val();  
					            if(ss == "${single}" || ss == "${much}"){
					            	//$("#answerOption").show();
					            	$("#answerOptionDiv").show();
					            }else{
					            	//$("#answerOption").hide();
					            	$("#answerOptionDiv").hide();
					            }
					        }); 
							//问题关联项目特性改变
							$("#dict_code").change(function () {  
					            var code = $(this).children('option:selected').val(); 
					            if(code != ""){
					            	
					            	$.post("/estimates/selectChildenDict", 
											{ 
											"code": code
											},
											function(data){
												if(data.status==0){
													AddHtml = '<label class="control-label "></label>' + data.msg;
													
													// 编辑状态
													//if("${question.estimateQuestionId }" != ""){
														
														$(".answer-question>.controls").each(function(){
															$(this).remove();
													    });
														
														$(".answer-question>.control-label:first").after(data.msg);
														
														$(".answer-question>.controls:last").find(".ms").change(function () {
										                    //console.log($(this).val());
										                }).multipleSelect({
										                    width: '100%',
										                    placeholder: "请选择匹配关系"
										                });	
														
														
													/* }else{
														$(".answer-question>.controls:last").after(data.msg);
														
														$(".answer-question>.controls:first").remove();
														
														$(".answer-question>.controls:last").find(".ms").change(function () {
										                    //console.log($(this).val());
										                }).multipleSelect({
										                    width: '100%',
										                    placeholder: "请选择匹配关系"
										                });	
													} */
													
													
													//只有一行时 隐藏删除按钮
								            		if($(".answer-question>.controls").length == 1){
								            			$(".answer-question>.controls>.span2>.remove").hide();
								            		}
												}
												else {
													alert(data.msg);
													return false;
												}
										});		
					            }
					            
					        }); 

			});
		
		window.onload=function(){
			if("${question.answer}" == "${single}" || "${question.answer}" == "${much}"){
				$("#answerOptionDiv").show();
			}else{
				$("#answerOptionDiv").hide();
			}
			
			//只有一行时 隐藏删除按钮
    		if($(".answer-question>.controls").length == 1){
    			$(".answer-question>.controls>.span2>.remove").hide();
    		}
		}

	</script>
	<!-- END JAVASCRIPTS -->
	<!-- 
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>
 -->
	<!-- END BODY -->
</html>