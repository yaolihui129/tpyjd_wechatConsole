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
				
				
				
				<div class="row-fluid">
					<div class="span12">
						<div class="tabbable tabbable-custom boxless">
							<ul class="nav nav-tabs">
								<li class="active"><a href="javascript:;">文章资讯</a></li>
								<c:if test="${op_code != 'edit' }">
									<li ><a href="/cms/imageinfo/${op_code }?pcode=${secId}">图片资讯</a></li>
								</c:if>
								
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="tab_2" >
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				
				
				

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">
					<div class="span12">
						<!-- BEGIN PORTLET-->   
						<div class="portlet box purple">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>文章资讯</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>
							<div class="portlet-body form">
								<!-- BEGIN FORM-->
								<form action="#" class="form-horizontal" id="articleForm" method="post">
									<div class="control-group">
										<label class="control-label"><span style="color:red;">*</span>标题：</label>
										<div class="controls">
											<input type="text" value="${info.title }" id="title" name="title" maxlength="30" class="span6 m-wrap" placeholder="标题" must-be="true" data-label="标题">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label"><span style="color:red;">*</span>所属栏目：</label>
										<div class="controls">
	                                        <select id="section" name="section"  must-be="true" data-label="所属栏目" data-type="select" data-placeholder="所属栏目" class="chosen span6" tabindex="6">
                                            	<c:if test="${empty info.title}">
                                            		<option value="">选择所属栏目</option>
                                            	</c:if>
                                            	
                                                <c:forEach items="${slist}" var="item">
                                                	<c:if test="${9 == item.deleteFlag }">
														<option value="${item.sectionId }" data-id="${item.imgSizeGw }" index-enable = "${item.indexEnable }" selected="selected"> ${item.name }</option>
													</c:if>
													<c:if test="${9 != item.deleteFlag }">
														<option value="${item.sectionId }" data-id="${item.imgSizeGw }" index-enable = "${item.indexEnable }"> ${item.name }</option>
													</c:if>
                                                </c:forEach>
                                            </select>
	                                    </div>
									</div>
									
									<div class="control-group">
										<label class="control-label">关联国家：</label>
										<div class="controls">        
											<select id="country" name="country" data-placeholder="国家" class="chosen span6" tabindex="6">
												<option value="">无</option>
												<c:forEach items="${countryList}" var="cou">
													<c:if test="${info.country == cou.country_code}">
														<option value="${cou.country_code }" selected="selected">${cou.name }</option>
													</c:if>
													<c:if test="${info.country != cou.country_code}">
														<option value="${cou.country_code }" >${cou.name }</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
									</div>
									
									<div class="control-group">
										<label class="control-label"><span style="color:red;">*</span>缩略图：</label>
										<input id="thumbImg" multiple accept="image/*" type="file" style="display: none;">
										<div style="width:140px;height:130px;overflow:hidden;position:relative;">
                                                        <c:if test="${!empty info.thumbImg}">
                                                            <img  id="showThumbImg" src="${info.thumbImg}" style="position:absolute;left:-1px;top:-1px;width:140px;height:130px;">
                                                        </c:if>
                                                        <c:if test="${empty info.thumbImg}">
                                                            <img  id="showThumbImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:140px;height:130px;" src="/images/nopic.jpg">
                                                        </c:if>
                                                        <input type="hidden" id="thumb_img" name="thumb_img" value="${info.thumbImg}" must-be="true" data-label="缩略图"/>
									 	</div> 
                                              
									</div>
									<div class="control-group">
										<label class="control-label"></label>
									 	<div class="controls" >
									 		<input type="button" id="selectThumbImg" value="选择图片">
									 	</div>
                                              
									</div>
									<div class="control-group">
										<label class="control-label"></label>
									 	<div style="margin-left: 100px;">
									 		<span class="label label-important">图片格式</span>
                                                     <span> 支持jpg,png格式图片，建议尺寸140x130 px,大小不超过100kb</span>
									 	</div>
                                              
									</div>
									
									<!-- 官网图片 start -->
									<div class="control-group">
										<label class="control-label"><span style="color:red;"></span>列表图片：</label>
										<input id="listImg" multiple accept="image/*" type="file" style="display: none;">
										<div style="width:140px;height:130px;overflow:hidden;position:relative;">
                                                        <c:if test="${!empty info.listImg}">
                                                            <img  id="showListImg" src="${info.listImg}" style="position:absolute;left:-1px;top:-1px;width:140px;height:130px;">
                                                        </c:if>
                                                        <c:if test="${empty info.listImg}">
                                                            <img  id="showListImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:140px;height:130px;" src="/images/nopic.jpg">
                                                        </c:if>
                                                        <input type="hidden" id="list_img" name="list_img" value="${info.thumbImg}" data-label="列表图片"/>
									 	</div> 
                                              
									</div>
									<div class="control-group">
										<label class="control-label"></label>
									 	<div class="controls" >
									 		<input type="button" id="selectListImg" value="选择图片">
									 	</div>
                                              
									</div>
									<div class="control-group">
										<label class="control-label"></label>
									 	<div style="margin-left: 100px;">
									 		<span class="label label-important">图片格式</span>
                                                     <span id="gwSizeDesc"> 支持jpg,png格式图片，建议尺寸 <c:if test="${not empty listImgSize }">${listImgSize }</c:if><c:if test="${empty listImgSize }">140x130</c:if> px,大小不超过200kb</span>
									 	</div>
                                              
									</div>
									<!-- 官网图片 end -->
									
									<div class="control-group">
										<label class="control-label">来源：</label>
										<div class="controls">
											<c:if test="${empty info.infoId  }">
											<input type="text" value="太平洋出国集团" id="source" name="source" class="span6 m-wrap" placeholder="来源">
											</c:if>
											<c:if test="${!empty info.infoId }">
											<input type="text" value="${info.source }" id="source" name="source" class="span6 m-wrap" placeholder="来源">
											</c:if>
											
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">作者：</label>
										<div class="controls">
											<input type="text" value="${info.author }" id="author" name="author" class="span6 m-wrap" placeholder="作者">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">标签：</label>
										<div class="controls">
											<input type="hidden" id="tag_v" name="tag_v" class="span6 " value="${info.tags }" placeholder="添加标签">
										</div>
									</div>
							
									<%-- <div class="control-group">
										<label class="control-label">排序：</label>
										<div class="controls">
											<input type="text" value="${info.sort }" id="sort" name="sort" class="span6 m-wrap" placeholder="排序">
										</div>
									</div> --%>
							
									<div class="control-group">
										<label class="control-label">摘要：</label>
										<div class="controls">
											<textarea class="span6 m-wrap" rows="3" id="summary" name="summary">${info.summary}</textarea>
										</div>
									</div>
							
									<div class="control-group ">
										<label class="control-label"><span style="color:red;">*</span>内容：</label>
										<div class="controls">
											<textarea class="span9 m-wrap" style="height:300px;visibility:hidden;" id="contents" name="contents" must-be="true" data-label="内容">${info.contents}</textarea>
										</div>
									</div>
									
									<div class="control-group ">
										<label class="control-label"><span style="color:red;">*</span>推送位置：</label>
										<div class="controls">
											<c:forEach items="${pushList}" var="item">
                                              	<label class="checkbox">
                                              		<c:if test="${empty info.infoId  }">
													<input type="checkbox" name="tswz" value="${item.dictCode }" checked="checked"/> ${item.name }
													</c:if>
													<c:if test="${!empty info.infoId }">
													<input type="checkbox" name="tswz" value="${item.dictCode }" <c:if test="${fn:contains(info.pushLocation, item.dictCode)}">checked="checked"</c:if>/> ${item.name }
													</c:if>
													
													
												</label>
                                            </c:forEach>
										</div>
									</div>
									
									<div class="control-group " id="d_index_show" style="display:none;">
										<label class="control-label">首页推荐：</label>
										<div class="controls">
											<label class="radio">
											<input type="radio" id="index_show" name="index_show" value="1" <c:if test="${info.indexShow != '0' }"> checked</c:if>/>是</label>
											<label class="radio">
											<input type="radio" id="index_show" name="index_show" value="0"  <c:if test="${info.indexShow == '0' }"> checked</c:if>/>否</label> 
										</div>
									</div>
									
									<div class="form-actions">
										<input type="hidden" id="section_id" name="section_id" value="${info.sectionId }">
										<input type="hidden" id="section_name" name="section_name" value="${info.sectionName }">
										<input type="hidden" id="pname" name="pname" value="">
										<input type="hidden" id="status" name="status" value="${info.status }">
										<input type="hidden" id="info_id" name="info_id" value="${info.infoId }">
										<input type="hidden" id="index_enable" name="index_enable" value="">
										<input type="hidden" id="push_location" name="push_location" value="${info.pushLocation }">
										
										<button type="button" class="btn purple" id="previewBtn"><i class="m-icon-swapright m-icon-white"></i> 预览</button>	
										<c:if test="${info.status == '00140002'}">
											<button type="button" class="btn green" id="pubBtn2"><i class="icon-ok-sign"></i> 重新发布</button>
											<button type="button" class="btn yellow" id="pubOffline"><i class="icon-remove"></i> 下线</button>
										</c:if>
										<c:if test="${info.status != '00140002'}">
											<button type="button" class="btn blue" id="saveBtn"><i class="icon-ok"></i> 保存</button>
											<button type="button" class="btn yellow" id="pubBtn"><i class="icon-ok-sign"></i> 保存并发布</button>
										</c:if>
										<button type="button" class="btn" id="back">取消</button>
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
		 //下拉复选
		   $('.ms').change(function () {
               //console.log($(this).val());
           }).multipleSelect({
               width: '100%',
               placeholder: ""
           });
		   
		   FormComponents.init();//分层级下拉框  (在下拉复选后初始化 否则下拉复选样式混乱)
		   
		   $("#tag_v").select2({
	            tags:[] 
	        });
		   
		   $("#back").click(function(e) {
				window.history.back();
			});

			//提交表单
			$("#saveBtn")
					.click(
							function(e) {
								var a = "";
								$("#section option:selected").each(function () {
									a += $(this).text() + ",";
								});
								//alert(a.substring(0, a.length - 1));
								$("#section_name").val(a.substring(0, a.length - 1)); // 选中文本
								$("#section_id").val($("#section").val()); // 选中值
								$("#status").val("${no_publish}");//未发布
								if($("#section").val() == null || $("#section").val() == ""){
									alert("请选择所属栏目");
									return ;
								}
								if($("#contents").val().replace(new RegExp("&nbsp;",'gm'),'') == ""){
									alert("内容不能为空");
									return;
								}
								/* var postData = {info_id:"${info.infoId }", "title": $('#title').val()};
								if($('#section').children('option:selected').attr('index-enable') == 1){
									postData.indexShow = $("input[name='index_show']:checked").val();
								} */
								
								$.post("/cms/articleinfo/valiName", { "info_id": "${info.infoId }", "title": $('#title').val()},
										function(data){
											if(data.status==0){
												//$("#articleForm").attr("action", "/cms/articleinfo/add");
												var chk_value = ""; 
												$('input[name="tswz"]:checked').each(function(){ 
													chk_value += $(this).val() + ","; 
												}); 
												
												if(chk_value == ""){
													alert("推送位置不能为空！");
													return;
												}
												
												$("#push_location").val(chk_value);
												
												//调用验证插件，进行form表单的验证
												$("#articleForm").formValidate();
											}
											else {
												alert(data.msg);
												return false;
											}
									});
								
							});
		 //保存并发布
			$("#pubBtn")
			.click(
					function(e) {
						var a = "";
						$("#section option:selected").each(function () {
							a += $(this).text() + ",";
						});
						//alert(a.substring(0, a.length - 1));
						$("#section_name").val(a.substring(0, a.length - 1)); // 选中文本
						$("#section_id").val($("#section").val()); // 选中值
						$("#status").val("${published}");//发布
						if($("#section").val() == null || $("#section").val() == ""){
							alert("请选择所属栏目");
							return ;
						}
						if($("#contents").val().replace(new RegExp("&nbsp;",'gm'),'') == ""){
							alert("内容不能为空");
							return;
						}
						$.post("/cms/articleinfo/valiName", { "info_id": "${info.infoId }", "title": $('#title').val()},
								function(data){
									if(data.status==0){
										$("#articleForm").attr("action", "/cms/articleinfo/saveAndPublish");
										var chk_value = ""; 
										$('input[name="tswz"]:checked').each(function(){ 
											chk_value += $(this).val() + ","; 
										}); 
										
										if(chk_value == ""){
											alert("推送位置不能为空！");
											return;
										}
										$("#push_location").val(chk_value);
										if(confirm("发布后网站端将会实时同步！确定要发布吗？")){
											//调用验证插件，进行form表单的验证
											$("#articleForm").formValidate();
										}
										
									}
									else {
										alert(data.msg);
										return false;
									}
							});
					});
			 //重新发布
			$("#pubBtn2")
			.click(
					function(e) {
						var a = "";
						$("#section option:selected").each(function () {
							a += $(this).text() + ",";
						});
						//alert(a.substring(0, a.length - 1));
						$("#section_name").val(a.substring(0, a.length - 1)); // 选中文本
						$("#section_id").val($("#section").val()); // 选中值
						$("#status").val("${published}");//发布
						if($("#section").val() == null || $("#section").val() == ""){
							alert("请选择所属栏目");
							return ;
						}
						if($("#contents").val().replace(new RegExp("&nbsp;",'gm'),'') == ""){
							alert("内容不能为空");
							return;
						}
						$.post("/cms/articleinfo/valiName", { "info_id": "${info.infoId }", "title": $('#title').val()},
								function(data){
									if(data.status==0){
										$("#articleForm").attr("action", "/cms/articleinfo/saveAndPublish");
										var chk_value = ""; 
										$('input[name="tswz"]:checked').each(function(){ 
											chk_value += $(this).val() + ","; 
										}); 
										
										if(chk_value == ""){
											alert("推送位置不能为空！");
											return;
										}
										
										$("#push_location").val(chk_value);
										if(confirm("发布后网站端将会实时同步！确定要发布吗？")){
											//调用验证插件，进行form表单的验证
											$("#articleForm").formValidate();	
										}
										
									}
									else {
										alert(data.msg);
										return false;
									}
							});
					});
			 
			 //下线
			$("#pubOffline").click(function(e) {
				if(confirm("确定要下线吗？")){
					$.post("/cms/information/offline",{"ids":"${info.infoId }"+"#文章"},function(data){
						if(data.status==0){
							//checks.each(function(index, element) {
								alert(data.msg);
								location.href="/cms/information";
							//});
						}else if(data.status == 2){
							alert(data.msg);
						}
						else{
							alert(data.msg);
							location.href="/cms/information";
						}
					});
				}
            });
			 
			 //预览
			 $("#previewBtn").click(function(e) {
				window.open("${OFFICIAL_URL}"+"/information/preview/${info.infoId}");
            });
			 
			 
			///缩略图上传
			$('#thumbImg').change(function() {
			var files = $('#thumbImg').prop('files');
			//console.log(files);
			var imgUrl = $("#thumb_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            document.getElementById("selectThumbImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					document.getElementById("selectThumbImg").disabled = false;
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
									 document.getElementById("selectThumbImg").disabled = false;
								}
								else {
									 $('#thumb_img').val('');
									alert(data.msg);
									document.getElementById("selectThumbImg").disabled = false;
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
						  
					  });
				}
			});
			$('#selectThumbImg').click(function(){ 
				document.getElementById("selectThumbImg").disabled = true;
				$('#thumbImg').click(); 
			});
			
			
			///列表图片上传
			$('#listImg').change(function() {
			var files = $('#listImg').prop('files');
			//console.log(files);
			var imgUrl = $("#list_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            document.getElementById("selectListImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>200*1024){
					alert("图片大小要小于200k");
					document.getElementById("selectListImg").disabled = false;
					return false;
				}
				lrz(files[m],{quality :1})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showListImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 $('#list_img').val(data.picUrl);
									 document.getElementById("selectListImg").disabled = false;
								}
								else {
									 $('#list_img').val('');
									alert(data.msg);
									document.getElementById("selectListImg").disabled = false;
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
						  
					  });
				}
			});
			$('#selectListImg').click(function(){ 
				document.getElementById("selectListImg").disabled = true;
				$('#listImg').click(); 
			});
			
			
			//栏目改变事件
			$('#section').change(function(){
				$("#gwSizeDesc").html("支持jpg,png格式图片，建议尺寸"+$(this).children('option:selected').attr('data-id')+"px,大小不超过200kb");
				$("#d_index_show")[0].style.display = $(this).children('option:selected').attr('index-enable') == 1?'':'none';
				$("#index_enable").val($(this).children('option:selected').attr('index-enable'));
			})
		});
		
		window.onload = function(){
			$("#d_index_show")[0].style.display = $('#section').children('option:selected').attr('index-enable') == 1?'':'none';
			$("#index_enable").val($('#section').children('option:selected').attr('index-enable'));
		}

	</script>

	<!-- END JAVASCRIPTS -->   
<!-- END BODY -->
</body>
</html>