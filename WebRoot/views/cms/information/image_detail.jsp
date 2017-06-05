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
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
	<!-- END PAGE LEVEL SCRIPTS -->
	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
	
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/multiple-select.css">
	
	<!-- 层级选择 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/chosen.css" />
	<!-- 层级选择 -->
	
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
			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->   
				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN STYLE CUSTOMIZER -->
						<div class="color-panel hidden-phone">
						<!-- END BEGIN STYLE CUSTOMIZER -->  
						<h3 class="page-title">
							资讯${operation }
						</h3>
						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>
							<li>
								<a href="/cms/information">资讯发布</a>
								<span class="icon-angle-right"></span>
							</li>
							<li>资讯${operation }</li>
						</ul>
					</div>
				</div>
				<!-- END PAGE HEADER-->
				<!-- BEGIN PAGE CONTENT-->
				<div class="row-fluid">
					<div class="span12">
						<div class="tabbable tabbable-custom boxless">
							<ul class="nav nav-tabs">
								<li class="active"><a href="javascript:;">图片资讯</a></li>
								<c:if test="${op_code != 'edit' }">
									<li><a href="/cms/articleinfo/${op_code }">文章资讯</a></li>
								</c:if>
								
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="tab_1">
									<div class="portlet box blue">
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>图片资讯</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>
										<div class="portlet-body form">
											<!-- BEGIN FORM-->
											<form action="#" class="form-horizontal" id="imageForm" method="get">
												<div class="control-group">
													<label class="control-label">标题：</label>
													<div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
														${info.title }
													</div>
													
												</div>
												
												<div class="control-group">
													<label class="control-label">所属栏目：</label>
													<div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
														${sectionName }
				                                    </div>
												</div>
												
												
												<div class="control-group">
													<label class="control-label">关联城市：</label>
													<div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">       
													${countryName }${cityName }
													</div>
												</div>
												
												
												<div class="control-group">
													<label class="control-label">排序：</label>
													<div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
														${info.sort }
													</div>
												</div>
												
												
												<div class="control-group" >
													<label class="control-label">缩略图：</label>
													<input id="thumbImg" multiple accept="image/*" type="file" style="display: none;">
													<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
			                                                           <c:if test="${!empty info.thumbImg}">
			                                                               <img  id="showThumbImg" src="${info.thumbImg}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;" >
			                                                           </c:if>
			                                                           <c:if test="${empty info.thumbImg}">
			                                                               <img  id="showThumbImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
			                                                           </c:if>
			                                                           <input type="hidden" id="thumb_img" name="thumb_img" value="${info.thumbImg}" />
												 	</div> 
			                                              <span class="help-inline"></span>
												</div>
												
												
												<div class="control-group">
													<label class="control-label">资讯图片：</label>
													<input id="infoImg" multiple accept="image/*" type="file" style="display: none;">
													<div style="float: left;   width:320px;height:152px;overflow:hidden;position:relative;">
			                                                           <c:if test="${!empty info.infoImg}">
			                                                               <img  id="showInfoImg" src="${info.infoImg}" style="position:absolute;left:-1px;top:-1px;width:320px;height:152px;">
			                                                           </c:if>
			                                                           <c:if test="${empty info.infoImg}">
			                                                               <img  id="showInfoImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:320px;height:152px;" src="/images/nopic.jpg">
			                                                           </c:if>
			                                                           <input type="hidden" id="info_img" name="info_img" value="${info.infoImg}" />
			                                                           
												 	</div> 
			                                              <span ></span>
												</div>
												
												
												<div class="control-group">
													<label class="control-label">视频地址：</label>
													<div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
														${info.vedioUrl }
													</div>
												</div> 
												
												
												<div class="control-group">
													<label class="control-label">描述：</label>
													<div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">
														<textarea class="span6 m-wrap" rows="3" id="remark" name="remark" disabled="disabled">${info.remark }</textarea>
													</div>
												</div>
												
												<div class="form-actions">
												<!-- 
													<input type="hidden" id="section_id" name="section_id" value="${info.sectionId }">
													<input type="hidden" id="section_name" name="section_name" value="${info.sectionName }">
													<input type="hidden" id="pname" name="pname" value="">
													<input type="hidden" id="status" name="status" value="${info.status }">
													<input type="hidden" id="info_id" name="info_id" value="${info.infoId }">
													<button type="submit" class="btn blue" id="saveBtn"><i class="icon-ok"></i> 保存</button>
													<button type="submit" class="btn yellow" id="pubBtn"><i class="icon-ok-sign"></i> 保存并发布</button>
													 --><button type="button" class="btn" id="back">返回</button>
												</div>
											</form>
											<!-- END FORM--> 
										</div>
									</div>
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
	<script src="/views/media/js/excanvas.min.js"></script>
	<script src="/views/media/js/respond.min.js"></script>  
	<![endif]-->   
	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
	
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	
	<!-- 层级下拉 -->
	<script src="/views/media/js/form-components.js"></script>
	<script src="/views/media/js/multiple-select.js"></script>
	<script type="text/javascript" src="/views/media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="/views/media/js/bootstrap-datetimepicker.js"></script><!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.input-ip-address-control-1.0.min.js"></script><!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.inputmask.bundle.min.js"></script> <!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.multi-select.js"></script><!-- 不引用会有js错误 -->
	
	<!-- 日期控件 -->
	<!-- <script src="/js/laydate/laydate.js"></script> -->
	
	
	<script>
		jQuery(document).ready(function() {    
		   // initiate layout and plugins
		    App.init();
		   FormSamples.init();
		   TableAdvanced.init();
		   
		   //下拉复选
		   $('.ms').change(function () {
               //console.log($(this).val());
           }).multipleSelect({
               width: '100%',
               placeholder: ""
           });
		   
		   FormComponents.init();//分层级下拉框  (在下拉复选后初始化 否则下拉复选样式混乱)
		   
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		 //保存
			$("#saveBtn")
					.click(
							function(e) {
								$("#status").val("${no_publish}");//未发布
								var a = "";
								$("#section option:selected").each(function () {
									a += $(this).text() + ",";
								});
								//alert(a.substring(0, a.length - 1));
								$("#section_name").val(a.substring(0, a.length - 1)); // 选中文本
								$("#section_id").val($("#section").val()); // 选中值
								//调用验证插件，进行form表单的验证
								$("#imageForm").formValidate();
							});
		 //保存并发布
			$("#pubBtn")
			.click(
					function(e) {
						$("#status").val("${published}");//发布
						var a = "";
						$("#section option:selected").each(function () {
							a += $(this).text() + ",";
						});
						//alert(a.substring(0, a.length - 1));
						$("#section_name").val(a.substring(0, a.length - 1)); // 选中文本
						$("#section_id").val($("#section").val()); // 选中值
						//调用验证插件，进行form表单的验证
						$("#imageForm").formValidate();
					});
		 
			///缩略图上传
			$('#thumbImg').change(function() {
			var files = $('#thumbImg').prop('files');
			//console.log(files);
			var imgUrl = $("#thumb_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            return false;  
		        }
				if(files[m].size>50*1024){
					alert("图片大小要小于50k");
					return false;
				}
				lrz(files[m],{quality :0.3})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showThumbImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 $('#thumb_img').val(data.picUrl);
								}
								else {
									 $('#thumb_img').val('');
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
				//$('#thumbImg').click(); 
			});
		 
			///图片上传
			$('#infoImg').change(function() {
			var files = $('#infoImg').prop('files');
			//console.log(files);
			var imgUrl = $("#info_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					return false;
				}
				lrz(files[m],{quality :0.3})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showInfoImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 $('#info_img').val(data.picUrl);
								}
								else {
									 $('#info_img').val('');
									alert(data.msg);
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
				}
			});
			
			$('#showInfoImg').click(function(){ 
				//$('#infoImg').click(); 
			});
		   
		});
		

	</script>
	<!-- END JAVASCRIPTS -->   
<!-- END BODY -->

</body>
</html>