<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
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
	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.gritter.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/chosen.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.tagsinput.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/clockface.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-wysihtml5.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/datepicker.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/timepicker.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/colorpicker.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-toggle-buttons.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/daterangepicker.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/datetimepicker.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/multi-select-metro.css" />
	<link href="/views/media/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
	
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/multiple-select.css">
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

	<!-- BEGIN HEADER -->
	<%@ include file="../../navi.jsp"%>
	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->
	<div class="page-container row-fluid">

		<!-- BEGIN SIDEBAR -->
		<%@ include file="../../menus.jsp"%>
		<!-- END SIDEBAR -->
		<!-- BEGIN PAGE -->  
		<div class="page-content">

			

			<!-- BEGIN PAGE CONTAINER-->

			<div class="container-fluid">

				<!-- BEGIN PAGE HEADER-->   

				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN STYLE CUSTOMIZER -->
						<div class="color-panel hidden-phone">
							<!-- END BEGIN STYLE CUSTOMIZER -->  
							<h3 class="page-title">
								${operation }图片
							</h3>
							<ul class="breadcrumb">
								<li>
									<i class="icon-home"></i>
									<a href="/">首页</a> 
									<span class="icon-angle-right"></span>
								</li>
								<li>
									移民官网
									<span class="icon-angle-right"></span>
									荣誉资质
									<span class="icon-angle-right"></span>
									${operation }图片
								</li>
							</ul>
						</div>
				</div>
				
				
				<!-- END PAGE HEADER-->		
				
				

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN PORTLET-->   
						<div class="portlet box purple">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>${operation }图片</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>
							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<form action="#" class="form-horizontal" id="imgForm" method="post">
									<div class="control-group">
										<label class="control-label">图片名称：</label>
										<div class="controls">
											<input type="text" value="${img.name }" id="name" name="name" maxlength="10" class="span6 m-wrap" placeholder="请输入图片名称,不超过10个字" data-label="图片名称">
										</div>
									</div>
									
									<div class="control-group">
										<label class="control-label"><span style="color:red;">*</span>上传图片：</label>
										<input id="imgUrl" multiple accept="image/*" type="file" style="display: none;">
										<div style="width:140px;height:130px;overflow:hidden;position:relative;">
                                                        <c:if test="${!empty img.imgUrl}">
                                                            <img  id="showImgUrl" src="${img.imgUrl}" style="position:absolute;left:-1px;top:-1px;width:140px;height:130px;">
                                                        </c:if>
                                                        <c:if test="${empty img.imgUrl}">
                                                            <img  id="showImgUrl" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:140px;height:130px;" src="/images/nopic.jpg">
                                                        </c:if>
                                                        <input type="hidden" id="img_url" name="img_url" value="${img.imgUrl}" must-be="true" data-label="上传图片"/>
									 	</div> 
                                              
									</div>
									<div class="control-group">
										<label class="control-label"></label>
									 	<div class="controls" >
									 		<input type="button" id="selectImgUrl" value="选择图片">
									 	</div>
                                              
									</div>
									<div class="control-group">
										<label class="control-label"></label>
									 	<div style="margin-left: 100px;">
									 		<span class="label label-important">图片格式</span>
                                                     <span> 支持jpg,png格式图片，建议尺寸220x148 px,大小不超过500kb</span>
									 	</div>
                                              
									</div>
									
									<div class="form-actions">
										<input type="hidden" id="oh_id" name="oh_id" value="${oh_id }">
										<input type="hidden" id="ohi_id" name="ohi_id" value="${img.ohiId }">
										<button type="button" class="btn blue" id="saveBtn"><i class="icon-ok"></i> 保存</button>
										<button type="button" class="btn" id="back">返回</button>
									</div>
								</form>
								<!-- END FORM-->  
							</div>
						</div>
						<!-- END PORTLET-->
					</div>
				</div>
				<!-- END PAGE CONTENT-->         
			</div>
			<!-- END PAGE CONTAINER-->
		</div>

		<!-- END PAGE -->  

	</div>
	</div>
	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->
	<%@ include  file="/views/footer.jsp"%>

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
	<script type="text/javascript" src="/views/media/js/ckeditor.js"></script>  
	<script type="text/javascript" src="/views/media/js/bootstrap-fileupload.js"></script>
	<script type="text/javascript" src="/views/media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/wysihtml5-0.3.0.js"></script> 
	<script type="text/javascript" src="/views/media/js/bootstrap-wysihtml5.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.tagsinput.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.toggle.buttons.js"></script>
	<script type="text/javascript" src="/views/media/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/views/media/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="/views/media/js/clockface.js"></script>
	<script type="text/javascript" src="/views/media/js/date.js"></script>
	<script type="text/javascript" src="/views/media/js/daterangepicker.js"></script> 
	<script type="text/javascript" src="/views/media/js/bootstrap-colorpicker.js"></script>  
	<script type="text/javascript" src="/views/media/js/bootstrap-timepicker.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.inputmask.bundle.min.js"></script>   
	<script type="text/javascript" src="/views/media/js/jquery.input-ip-address-control-1.0.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.multi-select.js"></script>   
	<script src="/views/media/js/bootstrap-modal.js" type="text/javascript" ></script>
	<script src="/views/media/js/bootstrap-modalmanager.js" type="text/javascript" ></script> 
	
	<script type="text/javascript" src="/views/media/js/form-validate.js"></script>
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-components.js"></script>     

	<!-- END PAGE LEVEL SCRIPTS -->
	
	<!-- 层级下拉 -->
	
	<script src="/views/media/js/multiple-select.js"></script>

	<script>

		jQuery(document).ready(function() {       
		   // initiate layout and plugins
		   App.init();
		   //FormComponents.init();
		
		   $("#back").click(function(e) {
				window.history.back();
			});

			//提交表单
			$("#saveBtn")
					.click(
							function(e) {
								$("#imgForm").formValidate();
								
							});
		 
			///缩略图上传
			$('#imgUrl').change(function() {
			var files = $('#imgUrl').prop('files');
			//console.log(files);
			var imgUrl = $("#img_url").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            document.getElementById("selectImgUrl").disabled = false;
		            return false;  
		        }
				if(files[m].size>500*1024){
					alert("图片大小要小于500k");
					document.getElementById("selectImgUrl").disabled = false;
					return false;
				}
				lrz(files[m],{quality :1})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showImgUrl').attr("src",data.picUrl);
									 alert('上传成功!');
									 $('#img_url').val(data.picUrl);
									 document.getElementById("selectImgUrl").disabled = false;
								}
								else {
									 $('#img_url').val('');
									alert(data.msg);
									document.getElementById("selectImgUrl").disabled = false;
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
						  
					  });
				}
			});
			$('#selectImgUrl').click(function(){ 
				document.getElementById("selectImgUrl").disabled = true;
				$('#imgUrl').click(); 
			});
			
			
		});

	</script>

	<!-- END JAVASCRIPTS -->   
<!-- END BODY -->
</body>
</html>