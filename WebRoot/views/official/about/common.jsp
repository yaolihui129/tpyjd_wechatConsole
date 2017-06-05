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
	
	<!-- 层级选择 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/chosen.css" />
	<!-- 层级选择 -->
	
	<!-- 以下为文章资讯样式 -->
	<!-- 标签开始 -->
    <link rel="stylesheet" type="text/css" href="/views/media/css/jquery.tagsinput.css" /> 
    <!-- 标签结束 -->
	<!-- 富文本开始 -->
    
    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	 <script>
		KindEditor.ready(function(K) {
			var editor1 = K.create('textarea[name="contents"]', {
				cssPath : '/kindeditor/plugins/code/prettify.css',
				
				items : [
							'source',  'cut', 'paste', 'plainpaste', 'selectall', 'justifyleft',
							'justifycenter', 'justifyright', 'justifyfull', 'indent', 'outdent',
							'subscript', 'superscript', 'formatblock', 'fontname',  'forecolor', //'fontsize',
							'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough', 'removeformat', 'table',
							'hr', 'link', 'unlink', 'lineheight', 'clearhtml','image'],
				afterBlur:function() {this.sync();},
				allowUpload : true, //允许上传图片
				allowImageUpload : true,
				allowImageRemote : false,
				allowFileManager : false,
				uploadJson : '/imageupload',//上传路径
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						document.forms['example'].submit();
					});
				}
			});
			
			prettyPrint();
		});
	</script>
    
    <!-- 富文本结束 -->

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
								${config.code }
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
								</li>
								<li>
									关于我们
									<span class="icon-angle-right"></span>
								</li>
								<li>${config.code }</li>
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
								<div class="caption"><i class="icon-reorder"></i>${config.code }</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>
							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<form action="#" class="form-horizontal" id="articleForm" method="post">
									
									<div class="control-group ">
										<label class="control-label"><span style="color:red;"></span></label>
										<div class="controls">
											<textarea class="span9 m-wrap" style="height:300px;visibility:hidden;" id="contents" name="contents" must-be="true" data-label="内容">${config.value}</textarea>
										</div>
									</div>
									
									
									<div class="form-actions">
										<input type="hidden" id="oc_id" name="oc_id" value="${config.ocId }">
										
										<button type="button" class="btn blue" id="saveBtn"><i class="icon-ok"></i> 保存</button>
										<button type="button" class="btn purple" id="previewBtn"><i class="m-icon-swapright m-icon-white"></i> 预览</button>	
										<c:if test="${config.status == '未发布' }">
											<button type="button" class="btn yellow" id="pubBtn"><i class="icon-ok-sign"></i> 发布</button>
										</c:if>
										<button type="button" class="btn" id="back" style="display:none;">返回</button>
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

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/ckeditor.js"></script>  
	<script type="text/javascript" src="/views/media/js/bootstrap-fileupload.js"></script>
	
	<script type="text/javascript" src="/views/media/js/form-validate.js"></script>
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-components.js"></script>     

	<!-- END PAGE LEVEL SCRIPTS -->

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
								var tmp = $("#contents").val();
								/* if(tmp.replace(new RegExp("&nbsp;",'gm'),'') == ""){
									alert("${config.code}不能为空");
									return;
								}
								
								if(tmp == "${config.value}"){
									alert("内容没有改变，无需保存");
									return;
								}  */
								
								$.post("/official/about/saveConfig/${config.ocId}", { "contents": $('#contents').val()},
										function(data){
											if(data.status==0){
												alert(data.msg);
												location.reload();
											}
											else {
												alert(data.msg);
												return false;
											}
									}); 
								
							});
		 //发布
			$("#pubBtn")
			.click(
					function(e) {
				
						$.post("/official/about/pubConfig/${config.ocId}",
								function(data){
									if(data.status==0){
										alert(data.msg);
										location.reload();
									}
									else {
										alert(data.msg);
										return false;
									}
							});
					});
			
		 //预览
			$("#previewBtn")
			.click(
					function(e) {
						window.open("${PREVIEW_URL}");
					});
			 
		});

	</script>

	<!-- END JAVASCRIPTS -->   
<!-- END BODY -->
</body>
</html>