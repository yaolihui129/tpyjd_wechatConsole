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
				allowFileManager : true,
				items : [
							'source',  'cut', 'paste', 'plainpaste', 'selectall', 'justifyleft',
							'justifycenter', 'justifyright', 'justifyfull', 'indent', 'outdent',
							'subscript', 'superscript', 'formatblock', 'fontname', 'fontsize', 'forecolor', 
							'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough', 'removeformat', 'table',
							'hr', 'link', 'unlink', 'lineheight', 'clearhtml','image'],
				afterBlur:function() {this.sync();},
				allowUpload : true, //允许上传图片
				allowImageUpload : true,
				allowImageRemote : false,
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
			editor1.readonly(true);	
			prettyPrint();
		});
	</script>
    
    <!-- 富文本结束 -->
	<style type="text/css">
		.detail_style {
			font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;
		}
	</style>
	
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
								<c:if test="${op_code != 'edit' }">
									<li ><a href="/cms/imageinfo/${op_code }">图片资讯</a></li>
								</c:if>
								<li class="active"><a href="javascript:;">文章资讯</a></li>
							</ul>
							<div class="tab-content">
								
								<div class="tab-pane active" id="tab_2" >
									<div class="portlet box green">
										<div class="portlet-title">
											<div class="caption"><i class="icon-reorder"></i>文章资讯</div>
											<div class="tools">
												<a href="javascript:;" class="collapse"></a>
											</div>
										</div>
										<div class="portlet-body form">
											<!-- BEGIN FORM-->
								<form action="#" class="form-horizontal" id="articleForm" method="get">
									<div class="control-group">
										<label class="control-label">标题：</label>
										<div class="controls">
											<input type="text" value="${info.title }" id="title" name="title" class="span6 m-wrap" placeholder="标题" must-be="true" data-label="标题" disabled="disabled">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">所属栏目：</label>
										<div class="controls">
	                                        <div class="span6 m-wrap">
	                                            <select class="ms" id="section" name="section" multiple="multiple" must-be="true" data-label="所属栏目" data-type="select" disabled="disabled">
	                                                <c:forEach items="${slist}" var="item">
	                                                	<c:if test="${9 == item.deleteFlag }">
															<option value="${item.sectionId }" selected="selected"> ${item.name }</option>
														</c:if>
														<c:if test="${9 != item.deleteFlag }">
															<option value="${item.sectionId }"> ${item.name }</option>
														</c:if>
	                                                </c:forEach>
	                                            </select>
	                                        </div>
	                                    </div>
									</div>
									
									<div class="control-group">
										<label class="control-label">关联国家：</label>
										<div class="controls">        
											<select id="country" name="country" data-placeholder="国家" class="span6" tabindex="6" disabled="disabled">
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
									
									<div class="control-group" >
										<label class="control-label">缩略图：</label>
										<input id="thumbImg" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:140px;height:130px;overflow:hidden;position:relative;">
                                                           <c:if test="${!empty info.thumbImg}">
                                                               <img  id="showThumbImg" src="${info.thumbImg}" style="position:absolute;left:-1px;top:-1px;width:140px;height:130px;" >
                                                           </c:if>
                                                           <c:if test="${empty info.thumbImg}">
                                                               <img  id="showThumbImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:140px;height:130px;" src="/images/nopic.jpg">
                                                           </c:if>
                                                           <input type="hidden" id="thumb_img" name="thumb_img" value="${info.thumbImg}" />
									 	</div> 
                                              <span class="help-inline"></span>
									</div>
									
									<div class="control-group" >
										<label class="control-label">列表图：</label>
										<input id="listImg" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:140px;height:130px;overflow:hidden;position:relative;">
                                                           <c:if test="${!empty info.listImg}">
                                                               <img  id="showListImg" src="${info.listImg}" style="position:absolute;left:-1px;top:-1px;width:140px;height:130px;" >
                                                           </c:if>
                                                           <c:if test="${empty info.listImg}">
                                                               <img  id="showListImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:140px;height:130px;" src="/images/nopic.jpg">
                                                           </c:if>
                                                           <input type="hidden" id="list_img" name="list_img" value="${info.listImg}" />
									 	</div> 
                                              <span class="help-inline"></span>
									</div>
									
									<div class="control-group">
										<label class="control-label">来源：</label>
										<div class="controls">
											<input type="text" value="${info.source }" id="source" name="source" class="span6 m-wrap" placeholder="来源" disabled="disabled">
											
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">作者：</label>
										<div class="controls">
											<input type="text" value="${info.author }" id="author" name="author" class="span6 m-wrap" placeholder="作者" disabled="disabled">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">标签：</label>
										<div class="controls">
											<input type="hidden" id="tag_v" name="tag_v" class="span6 " value="${info.tags }" placeholder="添加标签" disabled="disabled">
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
											<textarea class="span6 m-wrap" rows="3" id="summary" name="summary" disabled="disabled">${info.summary}</textarea>
										</div>
									</div>
							
									<div class="control-group ">
										<label class="control-label">内容：</label>
										<div class="controls">
											<textarea class="span9 m-wrap" style="height:300px;visibility:hidden;" id="contents" name="contents" must-be="true" data-label="内容">${info.contents}</textarea>
										</div>
									</div>
									
									<div class="control-group ">
										<label class="control-label">推送位置：</label>
										<div class="controls">
											<c:forEach items="${pushList}" var="item">
											
											
                                              	<label class="checkbox">
                                              	${item.name }
                                              	<!-- 
                                              		<c:if test="${empty info.infoId  }">
													<input type="checkbox" name="push_location" value="${item.dictCode }" checked="checked"/> ${item.name }
													</c:if>
													<c:if test="${!empty info.infoId }">
													<input type="checkbox" name="push_location" value="${item.dictCode }" <c:if test="${fn:contains(info.pushLocation, item.dictCode)}">checked="checked"</c:if>/> ${item.name }
													</c:if>
													 -->
													
												</label>
                                            </c:forEach>
										</div>
									</div>
									
									<div class="form-actions">
										<input type="hidden" id="section_id" name="section_id" value="${info.sectionId }">
										<input type="hidden" id="section_name" name="section_name" value="${info.sectionName }">
										<input type="hidden" id="pname" name="pname" value="">
										<input type="hidden" id="status" name="status" value="${info.status }">
										<input type="hidden" id="info_id" name="info_id" value="${info.infoId }">
										<button type="button" class="btn" id="back">取消</button>
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
	
	
	<!-- 以下为文章资讯js -->
	<!-- 标签开始 -->
	<script type="text/javascript" src="/views/media/js/jquery.tagsinput.min.js"></script>
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/ckeditor.js"></script>  
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<!-- 标签结束 -->
	
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
               placeholder: "请选择匹配关系"
           });
		   
		   FormComponents.init();//分层级下拉框  (在下拉复选后初始化 否则下拉复选样式混乱)
		   
		   $("#tag_v").select2({
	            tags: null
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

								//调用验证插件，进行form表单的验证
								$("#articleForm").formValidate();
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
						//调用验证插件，进行form表单的验证
						$("#articleForm").formValidate();
					});
		});
		
	</script>
	<!-- END JAVASCRIPTS -->   
<!-- END BODY -->

</body>
</html>