<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <script src="/js/laydate/laydate.js"></script>
    
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

							<li><a href="/cms/activitys">专题管理</a><i class="icon-angle-right"></i>
                            </li>
							
                            <li>
                                <a href="">${operation}</a>
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

						<div class="form-horizontal">
								<form id="sform" method="post">
												<div class="control-group">
                                                    <label class="control-label">活动名称<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                        <input id="activity_name" name="activity_name" data-label="活动名称" must-be="true" data-length="30" type="text" class="span6 m-wrap" value="${activity.activityName}"/>
                                                    </div>
                                                </div>
												
                                                <div class="control-group">
                                                    <label class="control-label">活动描述：</label>
                                                    <div class="controls"> 
                                                        <input name="activity_mark" type="text" data-label="活动描述" data-length="100" class="span6 m-wrap" value="${activity.activityMark}" />
                                                    </div>
                                                </div>
                                               
                                               <!--   
                                                <div class="control-group">
                                                    <label class="control-label">顺序号：</label>
                                                    <div class="controls">
                                                        <input name="activity_sort" type="text" class="span2 m-wrap" value="${activity.activitySort}" />
                                                    </div>
                                                </div>
                                                 -->
                                                
                                                <div class="control-group">
                                                    <label class="control-label">缩略图<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                    		<input id="topThumbPic" multiple accept="image/*" type="file" style="display: none;">
															<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
                                                                <c:if test="${!empty activity.activityThumbImage}">
                                                                    <img  id="showThumbImg" src="${activity.activityThumbImage}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;">
                                                                </c:if>
                                                                <c:if test="${empty activity.activityThumbImage}">
                                                                    <img  id="showThumbImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
                                                                </c:if>
                                                                
                                                                <input type="hidden" must-be="true" data-label="缩略图" id="activity_thumb_image" name="activity_thumb_image" value="${activity.activityThumbImage}" />
														 	</div> 
                                                   	</div>
                                                </div>
                                                <div class="control-group">
													<label class="control-label"></label>
												 	<div class="controls" >
												 		<input type="button" id="selectInfoImg1" value="选择图片">
												 	</div>
			                                              
												</div>
												<div class="control-group">
													<label class="control-label"></label>
												 	<div style="margin-left: 100px;">
												 		<span class="label label-important">图片格式</span>
                                                        <span> 支持jpg,png格式图片，尺寸为140*130px，大小不超过100kb</span>
												 	</div>
			                 
												</div>
												
                                                <div class="control-group">
                                                    <label class="control-label">微站图片<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                    		
															<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
                                                                <c:if test="${!empty activity.activityImage}">
                                                                    <img  id="showImg" src="${activity.activityImage}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;">
                                                                </c:if>
                                                                <c:if test="${empty activity.activityImage}">
                                                                    <img  id="showImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
                                                                </c:if>
                                                                <font color="#FF0000">*</font>
                                                                <input id="topPic" multiple accept="image/*" type="file">
                                                                <input must-be="true" data-label="微站图片" type="hidden" id="activity_image" name="activity_image" value="${activity.activityImage}" />
														 	</div> 
                                                        
                                                   	</div>
                                                </div>
                                                <div class="control-group">
													<label class="control-label"></label>
												 	<div class="controls" >
												 		<input type="button" id="selectInfoImg" value="选择图片">
												 	</div>
			                                              
												</div>
												<div class="control-group">
													<label class="control-label"></label>
												 	<div style="margin-left: 100px;">
												 		<span class="label label-important">图片格式</span>
                                                        <span> 支持jpg,png格式图片，建议高度240px，大小不超过100kb</span>
												 	</div>
												</div>
                                               
                                               
                                                <div class="control-group">
                                                    <label class="control-label">官网图片<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                    		
															<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
                                                                <c:if test="${!empty activity.activityImage1}">
                                                                    <img  id="showImg1" src="${activity.activityImage1}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;">
                                                                </c:if>
                                                                <c:if test="${empty activity.activityImage1}">
                                                                    <img  id="showImg1" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
                                                                </c:if>
                                                                <font color="#FF0000">*</font>
                                                                <input id="topPic1" multiple accept="image/*" type="file">
                                                                <input must-be="true" data-label="官网图片" type="hidden" id="activity_image1" name="activity_image1" value="${activity.activityImage1}" />
														 	</div> 
                                                        
                                                   	</div>
                                                </div>
                                                <div class="control-group">
													<label class="control-label"></label>
												 	<div class="controls" >
												 		<input type="button" id="selectInfoImg2" value="选择图片">
												 	</div>
			                                              
												</div>
												<div class="control-group">
													<label class="control-label"></label>
												 	<div style="margin-left: 100px;">
												 		<span class="label label-important">图片格式</span>
                                                        <span> 建议图片尺寸为 170px*170px, 大小在500K以内</span>
												 	</div>
												</div>
												
                                               <div class="control-group">
                                                    <label class="control-label">活动类型：</label>
                                                    <div class="controls">
                                                        <select name="activity_type">
                                                         <c:forEach items="${activityType.subDictionaries}" var="item">
                                                            <c:choose>
                                                                <c:when test="${item.value==activity.activityType}">
                                                                    <option value="${item.value}" selected>${item.name}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${item.value}">${item.name}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                          </c:forEach>
                                                        </select>
                                                    </div>
                                                </div> 
                                                <div class="control-group">
                                                    <label class="control-label">活动开始时间<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                        <input data-label="活动开始时间" must-be="true" data-type="datetime" class="m-wrap span3" name="start_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" value='<fmt:formatDate value="${activity.startTime}" type="both"/>' type="text">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">活动结束时间 ：</label>
                                                    <div class="controls">
                                                        <input data-label="活动结束时间" data-type="datetime" class="m-wrap span3" name="end_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" value='<fmt:formatDate value="${activity.endTime}" type="both"/>' type="text">  注：公司说明会不需填写结束时间
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">活动地址<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                        <input name="activity_address" must-be="true" data-label="活动地址" data-length="30" type="text" class="span6 m-wrap" value="${activity.activityAddress}" />
                                                    </div>
                                                </div> 
                                               <div class="control-group">
                                                    <label class="control-label">文章链接：</label>
                                                    <div class="controls">
                                                        <input name="url" data-label="文章链接" data-length="200" type="text" class="span6 m-wrap" value="${activity.url}" /> 注：输入http://开头的相关链接地址
                                                    </div>
                                                </div> 
                                               <div class="control-group ">
													<label class="control-label">推送位置 <span style="color:red;">*</span>：</label>
													<div class="controls">
														<c:forEach items="${positions}" var="item">
			                                              	<label class="checkbox">
			                                              		<c:if test="${empty activity.position  }">
																	<input type="checkbox" name="position" value="${item.dictCode }" checked="checked"/> ${item.name }
																</c:if>
																<c:if test="${!empty activity.position }">
																	<input type="checkbox" name="position" value="${item.dictCode }" <c:if test="${fn:contains(activity.position, item.dictCode)}">checked="checked"</c:if>/> ${item.name }
																</c:if>
															</label>
			                                            </c:forEach>
													</div>
												</div>
												<div class="form-actions">
													<c:choose>
													<c:when test="${empty activity}">
														<a id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</a>
														<a id="pubBtn" class="yellow btn"><i class="icon-ok-sign"></i> 发布</a>
														<button id="back" type="button" class="btn">取消</button>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${activity.activityStatus=='未发布'}">
																<button id="subBtn" type="button" class="btn blue"><i class="icon-ok"></i> 保存</button>
																<button id="pubBtn" type="button" class="yellow btn"><i class="icon-ok-sign"></i> 发布</button>
																<button id="back" type="button" class="btn" >取消</button>
															</c:when>
															<c:when test="${activity.activityStatus=='已发布'}">
																<button id="offBtn" type="button" class="btn blue"><i class="icon-ok"></i> 下线</button>
																<button id="pubBtn" type="button" class="yellow btn"><i class="icon-ok-sign"></i> 重新发布</button>
																<button id="back" type="button" class="btn">取消</button>
															</c:when>
															<c:otherwise>
																<button id="back" type="button" class="btn">取消</button>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
													</c:choose>
												</div>
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
    
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script>

		jQuery(document).ready(function() {    

		   App.init(); // initlayout and core plugin

			$("#back").click(function(e) {
                window.history.back();
            });
			
			//提交表单
			$("#subBtn").click(function(e) {
				
				var fromurl = document.referrer;
				$("#fromurl").val(fromurl);
				if($("#activity_name").val()=='')
					return false;
				var send_position = $("input[name='position']:checked").size();
				if(send_position==0){alert("请选择推送位置");return false;}
				//调用验证插件，进行form表单的验证
				document.getElementById("subBtn").disabled = true;
				$("#sform").formValidate();
            });
			
			//提交表单
			$("#pubBtn").click(function(e) {
				var fromurl = document.referrer;
				$("#fromurl").val(fromurl);
				if($("#activity_name").val()=='')
					return false;
				var send_position = $("input[name='position']:checked").size();
				if(send_position==0){alert("请选择推送位置");return false;}
				//调用验证插件，进行form表单的验证
				$("#sform").attr("action","/cms/activitys/activity/publish/${id}");
				document.getElementById("pubBtn").disabled = true;
				$("#sform").formValidate();
            });
			
			//提交表单
			$("#offBtn").click(function(e) {
				
				var fromurl = document.referrer;
				$("#fromurl").val(fromurl);
				
				//调用验证插件，进行form表单的验证
				$("#sform").attr("action","/cms/activitys/activity/offline/${id}");
				document.getElementById("offBtn").disabled = true;
				$("#sform").formValidate();
            });
			///图片上传
			$('#topPic').change(function() {
			var files = $('#topPic').prop('files');
			$('#showImg').attr("src","/images/loading.gif");
			var imgUrl = $("#activity_image").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            document.getElementById("selectInfoImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					document.getElementById("selectInfoImg").disabled = false;
					return false;
				}
				lrz(files[m],{quality :1.0})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("selectInfoImg").disabled = false;
									 $('#activity_image').val(data.picUrl);
								}
								else {
									 $('#activity_image').val('');
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
				$('#topPic').click(); 
			});
			
			$('#selectInfoImg').click(function(){ 
				document.getElementById("selectInfoImg").disabled = true;
				$('#showImg').click(); 
			});
			
			///官网活动图片上传
			$('#topPic1').change(function() {
			var files = $('#topPic1').prop('files');
			$('#showImg1').attr("src","/images/loading.gif");
			var imgUrl = $("#activity_image1").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            document.getElementById("selectInfoImg2").disabled = false;
		            return false;  
		        }
				if(files[m].size>500*1024){
					alert("图片大小要小于500k");
					document.getElementById("selectInfoImg2").disabled = false;
					return false;
				}
				lrz(files[m],{quality :1.0})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showImg1').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("selectInfoImg2").disabled = false;
									 $('#activity_image1').val(data.picUrl);
								}
								else {
									 $('#activity_image1').val('');
									 document.getElementById("selectInfoImg2").disabled = false;
									alert(data.msg);
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
				}
			});
			
			$('#showImg1').click(function(){ 
				$('#topPic1').click(); 
			});
			
			$('#selectInfoImg2').click(function(){ 
				document.getElementById("selectInfoImg2").disabled = true;
				$('#showImg1').click(); 
			});
			
			///缩略图片上传
			$('#topThumbPic').change(function() {
			var files = $('#topThumbPic').prop('files');
			
			$('#showThumbImg').attr("src","/images/loading.gif");
			var imgUrl = $("#activity_thumb_image").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种"); 
		            document.getElementById("selectInfoImg1").disabled = false;
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					document.getElementById("selectInfoImg1").disabled = false;
					return false;
				}
				lrz(files[m],{quality :1.0})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showThumbImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("selectInfoImg1").disabled = false;
									 $('#activity_thumb_image').val(data.picUrl);
								}
								else {
									 $('#activity_thumb_image').val('');
									 document.getElementById("selectInfoImg1").disabled = false;
									alert(data.msg);
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
				}
			});
			
			$('#showThumbImg').click(function(){ 
				$('#topThumbPic').click(); 
			});
			
			$('#selectInfoImg1').click(function(){ 
				document.getElementById("selectInfoImg1").disabled = true;
				$('#showThumbImg').click(); 
			});
			
			$("#activity_name").blur(function(e){
		    		if($(this).val()!=''){
			    		$.post("/cms/activitys/activity/chkActivity",{"activity_name":$(this).val()},function(data){
			    			if(data.status>0){
			    				alert("当前活动已存在");
			    				$("#activity_name").val("");
			    				$("#activity_name").focus();
			    				return false;
			    			}
			    		});
		    		}
		    });
		});
	
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>