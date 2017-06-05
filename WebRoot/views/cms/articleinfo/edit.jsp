<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<title>Metronic | Form Stuff - Advance Form Samples</title>
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
	
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    
    <link rel="stylesheet" type="text/css" href="/views/media/css/multiple-select.css">
    
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
				afterBlur:function() {this.sync();},
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

			<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<div id="portlet-config" class="modal hide">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button"></button>
					<h3>portlet Settings</h3>
				</div>

				<div class="modal-body">
					<p>Here will be a configuration form</p>
				</div>
			</div>

			<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->

			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->   
				<div class="row-fluid">
					<div class="span12">
						
						<h3 class="page-title">
							文章资讯${operation }
							 <small></small>
						</h3>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>

							<li>
								<a href="#">资讯管理</a>
								<span class="icon-angle-right"></span>
							</li>

							<li><a href="#">文章资讯${operation }</a></li>
						</ul>
					</div>
				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->
				
				<div class="tab-content">
					<!-- 资讯信息 开始 -->
					<div class="tab-pane active" id="tab_1">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>资讯信息</div>
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
											<input type="text" value="${info.title }" id="title" name="title" class="span6 m-wrap" placeholder="标题">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">所属栏目：</label>
										<div class="controls">
	                                        <div class="span6 m-wrap">
	                                            <select class="ms" id="section_id" name="section_id" multiple="multiple">
	                                                <c:forEach items="${slist}" var="item">
	                                                	<c:if test="${info.sectionId == item.sectionId }">
															<option value="${item.sectionId }" selected="selected">${item.name }</option>
														</c:if>
														<c:if test="${info.sectionId != item.sectionId }">
															<option value="${item.sectionId }">${item.name }</option>
														</c:if>
	                                                	
	                                                </c:forEach>
	                                            </select>
	                                        </div>
	                                    </div>
									</div>
							
									<div class="control-group">
										<label class="control-label">作者：</label>
										<div class="controls">
											<input type="text" value="${info.author }" id="author" name="author" class="span6 m-wrap" placeholder="作者">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">来源：</label>
										<div class="controls">
											<input type="text" value="${info.source }" id="source" name="source" class="span6 m-wrap" placeholder="来源">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">标签：</label>
										<div class="controls">        
											<input type="hidden" id="select2_sample5" class="span6 select2" value="red, blue">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">排序：</label>
										<div class="controls">
											<input type="text" value="${info.sort }" id="sort" name="sort" class="span6 m-wrap" placeholder="排序">
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">摘要：</label>
										<div class="controls">
											<textarea class="span6 m-wrap" rows="3" id="summary" name="summary">${info.summary}</textarea>
										</div>
									</div>
							
									<div class="control-group">
										<label class="control-label">内容：</label>
										<div class="controls">
											<textarea class="span12 m-wrap" style="height:300px;visibility:hidden;" id="contents" name="contents">${info.summary}</textarea>
										</div>
									</div>
									
									<div class="form-actions">
										<input type="hidden" id="pname" name="pname" value="">
										<input type="hidden" id="status" name="status" value="${info.status }">
										<input type="hidden" id="info_id" name="info_id" value="${info.infoId }">
										<button type="submit" class="btn blue" id="saveBtn"><i class="icon-ok"></i> 保存</button>
										<button type="submit" class="btn yellow" id="pubBtn"><i class="icon-ok-sign"></i> 保存并发布</button>
										<button type="button" class="btn" id="back">取消</button>
									</div>
								</form>
								<!-- END FORM-->                
							</div>
						</div>
					</div>
					<!-- 资讯信息 结束 -->
								
				</div>
						
				<!-- END PAGE CONTENT-->         
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
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>	
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- 标签开始 -->
	<script type="text/javascript" src="/views/media/js/jquery.tagsinput.min.js"></script>
	<script type="text/javascript" src="/views/media/js/form-components.js"></script>
	<script type="text/javascript" src="/views/media/js/multiple-select.js"></script>
	<script type="text/javascript" src="/views/media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="/views/media/js/bootstrap-datetimepicker.js"></script><!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.input-ip-address-control-1.0.min.js"></script><!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.inputmask.bundle.min.js"></script> <!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.multi-select.js"></script><!-- 不引用会有js错误 -->
	<!-- 标签结束 -->


	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	<script>
		jQuery(document).ready(function() {    
		   // initiate layout and plugins
		   App.init();
		   FormSamples.init();
		   TableAdvanced.init();
		   
		   //下拉复选
		   $('.ms').change(function () {
               console.log($(this).val());
           }).multipleSelect({
               width: '100%',
               placeholder: "请选择匹配关系"
           });
		   
		   FormComponents.init();//分层级下拉框  (在下拉复选后初始化 否则下拉复选样式混乱)
		   
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		 //提交表单
			$("#saveBtn")
					.click(
							function(e) {
								$("#status").val("00140001");//未发布
								//调用验证插件，进行form表单的验证
								$("#articleForm").formValidate();
							});
		 //保存并发布
			$("#pubBtn")
			.click(
					function(e) {
						$("#status").val("00140002");//发布
						//调用验证插件，进行form表单的验证
						$("#articleForm").formValidate();
					});
		   
		});
		
		function schange(){
			var obj = document.getElementById("pid"); //selectid
			var index = obj.selectedIndex; // 选中索引
			var text = obj.options[index].text; // 选中文本
			
			document.getElementById("pname").value=text;
		}
	</script>
	<!-- END JAVASCRIPTS -->   
<!-- 
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>
 -->
<!-- END BODY -->
</html>