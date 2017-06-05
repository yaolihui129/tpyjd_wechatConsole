<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />
	<!-- END GLOBAL MANDATORY STYLES -->
	
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<!-- 标签选择 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/chosen.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.tagsinput.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-toggle-buttons.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/multi-select-metro.css" />
	<link href="/views/media/css/bootstrap-modal.css" rel="stylesheet" type="text/css"/>
	<!-- 标签选择 -->
	
	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
	
	
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
				<!-- BEGIN PAGE HEADER-->   
				<div class="row-fluid">
					<div class="span12">
						
						<h3 class="page-title">
							站内信
							 <small></small>
						</h3>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>

							<li>
								<a href="#">站内信</a>
								<span class="icon-angle-right"></span>
							</li>

							<li><a href="#">写信</a></li>
						</ul>
					</div>
				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->

				<div class="row-fluid">
					<div class="span8">
						<!-- BEGIN BUTTONS PORTLET-->
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>写信</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>
							<div class="portlet-body">
								<!-- BEGIN FORM-->
								<form id="letterForm" name="letterForm" class="form-horizontal" method="get" action="/letters/add">
									<div class="control-group">
										<label class="control-label">收件人：</label>
										<div class="controls">

											<select id="receiver" name="receiver" data-placeholder="收件人" class="chosen span9" multiple="multiple" tabindex="6">

												<option value=""></option>
												<c:forEach items="${gl}" var="g">
													<optgroup label="${g }">
													<c:forEach items="${list}" var="l">
														<c:if test="${g == l.name}">
															<c:if test="${sender == l.user_id}">
																<option value="${l.user_id }" selected>${l.user_name }</option>
															</c:if>
															<c:if test="${sender != l.user_id}">
																<option value="${l.user_id }">${l.user_name }</option>
															</c:if>
														</c:if>
														
													</c:forEach>
												</optgroup>
												</c:forEach>
											</select>

										</div>

									</div>

									<div class="control-group">
										<label class="control-label">主题：</label>
										<div class="controls">
											<input type="text" id="title" name="title" placeholder="" class="m-wrap span9" />
										</div>
									</div>

									<div class="control-group">
										<label class="control-label">内容：</label>
										<div class="controls">
											<textarea class="m-wrap span9 " id="contents"  style="height:300px;visibility:hidden;" name="contents"></textarea>
										</div>
									</div>
									
									<div class="form-actions">
										<button type="submit" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存</button>
										<button type="button" class="btn" id="back">取消</button>
									</div>
								</form>
								<!-- END FORM-->
							</div>
						</div>
						<!-- END BUTTONS PORTLET-->      
						
					</div>
					<div class="span4">
						<!-- BEGIN BLOCK BUTTONS PORTLET-->
						<!-- <div class="portlet box purple">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>联系人</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>
							<div class="portlet-body">
								${tree}
							</div>
						</div> -->
						<!-- BEGIN BLOCK BUTTONS PORTLET-->
						
					</div>
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
	<!-- END PAGE LEVEL PLUGINS -->
	
	<!-- 标签选择 -->
	<script type="text/javascript" src="/views/media/js/chosen.jquery.min.js"></script>
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.tagsinput.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.inputmask.bundle.min.js"></script>   
	<script type="text/javascript" src="/views/media/js/jquery.multi-select.js"></script>
	<script type="text/javascript" src="/views/media/js/bootstrap-datetimepicker.js"></script><!-- 不引用会有js错误 -->
	<script type="text/javascript" src="/views/media/js/jquery.input-ip-address-control-1.0.min.js"></script><!-- 不引用会有js错误 -->
	<script src="/views/media/js/form-components.js"></script>  
	<!-- 标签选择 -->
	

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	<script>
		jQuery(document).ready(function() {    
		   // initiate layout and plugins
		   App.init();
		   FormComponents.init();
		   
		   //组织机构树
		   $("#orgTree").find("li>a").each(function(index, element) {
			   $(this).click(function(e) {
                 var id =$(this).attr("data-info");
					 $("#org_id").val(id);
					 $("#org_name").val($(this).text());
					 $(this).parents("div.btn-group").find("a>span").text($(this).text());
					 doRequest();
				});
			});
		   
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		 //提交表单
			$("#subBtn")
					.click(
							function(e) {
								
								//调用验证插件，进行form表单的验证
								$("#letterForm").formValidate();
							});
		   
		});
	</script>
	<!-- END JAVASCRIPTS -->   
<!-- 
<script type="text/javascript">  var _gaq = _gaq || [];  _gaq.push(['_setAccount', 'UA-37564768-1']);  _gaq.push(['_setDomainName', 'keenthemes.com']);  _gaq.push(['_setAllowLinker', true]);  _gaq.push(['_trackPageview']);  (function() {    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;    ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script></body>
 -->
<!-- END BODY -->
</html>