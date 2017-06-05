<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %> 
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

	<meta content="" name="author" />

	<!-- BEGIN GLOBAL MANDATORY STYLES -->

	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>

	<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    
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

						<h3 class="page-title">${operation}</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>
								<a href="/">主页</a> 
								<i class="icon-angle-right"></i>
							</li>

							<li><a href="/live/list">直播内容</a><i class="icon-angle-right"></i>
                            </li>
							
                            <li>
                                ${operation}
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
                	<div class="portlet-title">
                    	<div class="caption"><i class="icon-list"></i>${operation}</div>
					</div>
              
                    <!-- 添加表单 -->
                    <div class="portlet-body form">

								<!-- BEGIN FORM-->

								<div class="form-horizontal form-bordered form-row-stripped">
								<form id="sform" method="post">
												<div class="control-group">
                                                    <label class="control-label"><font color="#FF0000">*</font>直播标题：</label>
                                                    <div class="controls">
                                                        <input name="live_title" type="text" class="span6 m-wrap" must-be="true" data-length="100" data-label="直播标题" value="${live.liveTitle}"/>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">类型：</label>
                                                    <div class="controls">
                                                    	<c:choose>
                                                    	<c:when test="${empty live.liveType}">
                                                       <c:forEach items="${live_typies}" var="livetype">
                                                       <c:choose>
                                                       		<c:when test="${live.liveType==livetype.name}">
                                                            <label class="radio">
                                                            	<input data-name="${livetype.name}" name="live_type" type="radio" value="${livetype.name}" checked="checked" />${livetype.name}</label>
                                                            </c:when>
                                                            <c:otherwise>
                                                            <label class="radio">
                                                            	<input data-name="${livetype.name}" name="live_type" type="radio" value="${livetype.name}" />${livetype.name}</label>
                                                            </c:otherwise>
                                                       </c:choose>
                                                       
                                                       </c:forEach>
                                                       </c:when>
                                                       <c:otherwise>
                                                       	${live.liveType}
                                                       </c:otherwise>
                                                       </c:choose>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label"><font color="#FF0000">*</font>介绍图：</label>
                                                    <div class="controls">
                                                    		<input id="livePoster" multiple accept="image/*" type="file" style="display: none;">
															<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
                                                                <c:if test="${!empty live.livePoster}">
                                                                    <img  id="showImg" src="${live.livePoster}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;">
                                                                </c:if>
                                                                <c:if test="${empty live.livePoster}">
                                                                    <img  id="showImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
                                                                </c:if>
                                                                <input type="hidden" must-be="true" data-label="介绍图" id="live_poster" name="live_poster" value="${live.livePoster}" />
														 	</div>
                                                   	</div>
                                                </div>
                                                
												<div class="control-group">
													<label class="control-label"></label>
												 	<div class="controls" >
												 		<input type="button" id="selectInfoImg" value="更换介绍图">
												 	</div>
			                                              
												</div>
												<div class="control-group">
													<label class="control-label"></label>
												 	<div style="margin-left: 100px;">
												 		<span class="label label-important">图片格式</span>
                                                        <span> 支持<font color="#FF0000">jpg,png</font>格式图片，,大小不超过<font color="#FF0000">300kb</font></span>
												 	</div>
			                 
												</div>
                                                
                                                <div class="control-group">
                                                    <label class="control-label">直播介绍：</label>
                                                    <div class="controls">
                                                        <input name="live_introduce" type="text" data-length="200" data-label="直播介绍" class="span6 m-wrap" value="${live.liveIntroduce}" />
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">人数限制：</label>
                                                    <div class="controls">
                                                        <input id="live_limit" name="live_limit" must-be="true" data-type="plus_number" type="text" data-label="人数限制" class="span6 m-wrap" value="${live.liveLimit}" />
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">报名时间：</label>
                                                    <div class="controls">
                                                        <input type="text" must-be="true" data-label="报名开始时间" class="m-wrap span3" id="signup_start_time" name="signup_start_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value='<fmt:formatDate value="${live.signupStartTime}" type="date" dateStyle="default" />'>
                                                        <span style="line-height:35px;">--</span>
                                                        <input type="text" must-be="true" data-label="报名结束时间" class="m-wrap span3"  id="signup_end_time" name="signup_end_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value='<fmt:formatDate value="${live.signupEndTime}" type="date" dateStyle="default"/>'>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">开始时间：</label>
                                                    <div class="controls">
                                                        <input type="text" must-be="true" data-label="开始时间" class="m-wrap span4" id="live_start_time" name="live_start_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" value='<fmt:formatDate value="${live.liveStartTime}" type="both"/>'>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">主播：</label>
                                                    <div class="controls">
                                                    <select name="live_steward_id" must-be="true" data-label="主播" class="m-wrap span4">
                                                            <c:forEach items="${stewards}" var="steward">
                                                            <c:choose>
                                                            	<c:when test="${steward.stewardId==live.liveStewardId}">
                                                            	<option value="${steward.stewardId}" selected>${steward.stewardName}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                <option value="${steward.stewardId}">${steward.stewardName}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            </c:forEach>
                                                    </select>
                                                    </div>
                                                </div>
                                                
                                                
												<div class="form-actions">
													<a id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</a>
													<button type="button" class="btn" id="back">取消</button>
												
                                                <input id="fromurl" name="fromurl" type="hidden" value="" />
                                                <input id="operation" name="operation" type="hidden" value="${operation}" />
                                                
											</form>
											</div>

											<!-- END FORM-->  

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

			2016 &copy; copyright pacificimmi.

		</div>

		<div class="footer-tools">

			<span class="go-top">

			<i class="icon-angle-up"></i>

			</span>

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

	<script src="/views/media/js/excanvas.min.js"></script>

	<script src="/views/media/js/respond.min.js"></script>  

	<![endif]-->   

	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="/views/media/js/jquery.vmap.js" type="text/javascript"></script>   

	<script src="/views/media/js/jquery.vmap.russia.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.world.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.europe.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.germany.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.usa.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.sampledata.js" type="text/javascript"></script>  

	<script src="/views/media/js/jquery.flot.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.flot.resize.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.pulsate.min.js" type="text/javascript"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    <script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>
    <script src="/js/laydate/laydate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script>

		jQuery(document).ready(function() {    

		   App.init(); // initlayout and core plugin

			$("#back").click(function(e) {
                /* window.history.back(); */
                window.location.href="/live/list";
            });
			
			/**
			当无默认选项时，默认选中私密
			***/
			if($("input[name='live_type']:checked").size()==0){
				$("input[name='live_type']:last").parent().addClass("checked");
				$("input[name='live_type']:last").prop("checked", true);
			}
			
			/**
			当选中公开时，取消报名时间的填写
			**/
			$("label.radio").click(function(e) {
				var radio = $(this).find("input:radio");
                if(radio.attr("checked")=='checked'){
					if(radio.attr("data-name")=='公开'){
						$("#live_limit").prop("disabled", true);
						$("#signup_start_time").prop("disabled", true);
						$("#signup_end_time").prop("disabled", true);
						
						$("#live_limit").attr("must-be", "false");
						$("#signup_start_time").attr("must-be", "false");
						$("#signup_end_time").attr("must-be", "false");
					}
					else{
						$("#live_limit").prop("disabled", false);
						$("#signup_start_time").prop("disabled", false);
						$("#signup_end_time").prop("disabled", false);
						
						$("#live_limit").attr("must-be", "true");
						$("#signup_start_time").attr("must-be", "true");
						$("#signup_end_time").attr("must-be", "true");
					}
				}
            });
			
			//提交表单
			$("#subBtn").click(function(e) {
				if($("#signup_end_time").val()!=''){
					var d0 = new Date($("#signup_start_time").val());
					var d1 = new Date($("#signup_end_time").val());
					var d2 = new Date($("#live_start_time").val());
					if(d2.getTime()<=d1.getTime()){
						alert("开始时间不能早于报名结束时间！");
						return false;
					}
					
					if(d0.getTime()>d1.getTime()){
						alert("报名开始时间要早于报名结束时间！");
						return false;
					}
				}
				
				var fromurl = document.referrer;
				$("#fromurl").val(fromurl);
				//调用验证插件，进行form表单的验证
				document.getElementById("subBtn").disabled = true;
				$("#sform").formValidate();
            });
			
			
			///图片上传
			$('#livePoster').change(function() {
			var files = $('#livePoster').prop('files');
			console.log(files);
			var imgUrl = $("#live_poster").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");  
		            document.getElementById("selectInfoImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>300*1024){
					alert("图片大小要小于300kb");
					document.getElementById("selectInfoImg").disabled = false;
					return false;
				}
				lrz(files[m],{quality :0.3})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("selectInfoImg").disabled = false;
									 $('#live_poster').val(data.picUrl);
								}
								else {
									 $('#live_poster').val('');
									 document.getElementById("selectInfoImg").disabled = false;
									alert(data.msg);
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
				}
			});
			
			$('#showImg').click(function(){ 
				$('#livePoster').click(); 
			});
			
			$('#selectInfoImg').click(function(){ 
				document.getElementById("selectInfoImg").disabled = true;
				$('#showImg').click(); 
			});
		});
	
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>