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
	
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>

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
							栏目${operation }
							 <small></small>
						</h3>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>

							<li>
								<a href="/cms/section">栏目管理</a>
								<span class="icon-angle-right"></span>
							</li>

							<li><a href="#">栏目${operation }</a></li>
						</ul>
					</div>
				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->
				
				<div class="tab-content">
					<!-- 会员信息 开始 -->
					<div class="tab-pane active" id="tab_1">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>栏目信息</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<form action="#" class="form-horizontal" id="sectionForm" method="get">
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">栏目名称：</label>
												<input type="text" value="${section.name }" maxlength="15"  id="section_name" name="section_name" class="m-wrap span6" placeholder="栏目名称" data-label="栏目名称" must-be="true">
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">上级栏目：</label>
												<select class="large m-wrap" name="pcode" id="pcode" onchange="schange()">
													<option value="0">无</option>
													<c:forEach items="${slist}" var="item">
														<c:if test="${section.pcode == item.code }">
															<option value="${item.code }" selected>${item.name}</option>
														</c:if>
														<c:if test="${section.pcode != item.code }">
															<option value="${item.code }">${item.name}</option>
														</c:if>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">栏目类型：</label>
												<div class="controls">  
													<!-- 
													<c:forEach items="${typeList}" var="item">
														<label class="radio">
														<input type="radio" data-type="radio" data-label="栏目类型" radio-name="section_type" id="section_type" name="section_type" value="${item.dictCode }" <c:if test="${section.sectionType == item.dictCode }"> checked</c:if>/>
														${item.name }
														</label>
													</c:forEach>
													 --> 
													 
													<select class="large m-wrap" name="section_type" id="section_type" must-be="true" data-label="栏目类型">
													<option value="">--请选择栏目类型--</option>
													<c:forEach items="${typeList}" var="item">
														<c:if test="${section.sectionType == item.dictCode }">
															<option value="${item.dictCode }" selected>${item.name}</option>
														</c:if>
														<c:if test="${section.sectionType != item.dictCode }">
															<option value="${item.dictCode }">${item.name}</option>
														</c:if>
													</c:forEach>
												</select>     
												</div>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">静态目录：</label>
												<input type="text" value="${section.staticDir }" id="static_dir" name="static_dir" class="m-wrap span6" placeholder="静态目录">
											</div>
										</div>
									</div>
									
									<!-- 
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">同级排序：</label>
												<input type="text" value="${section.sort }" id="sort" name="sort" class="m-wrap span6" placeholder="排序" must-be="true" data-label="排序" data-type="number+">
											</div>
										</div>
									</div>
									 -->
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">栏目图片：</label>
												<input id="sectionImg" multiple accept="image/*" type="file" style="display: none;">
												<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
                                                     <c:if test="${!empty section.sectionImg}">
                                                         <img  id="showImg" src="${section.sectionImg}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;">
                                                     </c:if>
                                                     <c:if test="${empty section.sectionImg}">
                                                         <img  id="showImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
                                                     </c:if>
                                                     <input type="hidden" id="section_img" name="section_img" value="${section.sectionImg}" />
											 	</div> 
											</div>
										</div>
									</div>
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label"></label>
											 	<div class="controls" >
											 		<input type="button" id="selectImg" value="选择图片">
											 	</div>
											</div>
										</div>
									</div>
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label"></label>
											 	<div style="margin-left: 100px;">
											 		<span class="label label-important">图片格式</span>
                                                       <span> 支持jpg,png格式图片，建议尺寸200x145 px,大小不超过50kb</span>
											 	</div>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">栏目资讯官网图片尺寸：</label>
												<input type="text" value="${section.imgSizeGw }" id="img_size_gw" name="img_size_gw" class="m-wrap span6" placeholder="栏目资讯官网图片尺寸">
												像素&nbsp;&nbsp;<span style="color: red;">例：200X145</span>
											</div>
										</div>
									</div>
									
									<div class="control-group ">
										<label class="control-label">是否显示首页推荐：</label>
										<div class="controls">
											<label class="radio">
											<input type="radio" id="index_enable" name="index_enable" value="1" <c:if test="${section.indexEnable == '1' }"> checked</c:if>/>是</label>
											<label class="radio">
											<input type="radio" id="index_enable" name="index_enable" value="0"  <c:if test="${section.indexEnable == '0' }"> checked</c:if>/>否</label> 
										</div>
									</div>
									     
									
									<div class="form-actions">
										<input type="hidden" id="pname" name="pname" value="${section.pname }">
										<input type="hidden" id="section_id" name="section_id" value="${section.sectionId }">
										<button type="button" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存</button>
										<button type="button" class="btn" id="back">取消</button>
									</div>
								</form>
								<!-- END FORM-->                
							</div>
						</div>
					</div>
					<!-- 会员信息 结束 -->
								
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
	
	<script type="text/javascript" src="/views/media/js/form-validate.js"></script>

	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>	
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

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
		   
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		 //提交表单
			$("#subBtn")
					.click(
							function(e) {
								$.post("/cms/section/valiName", { "section_id": "${section.sectionId }", "section_name": $('#section_name').val()},
										function(data){
											if(data.status==0){
												
												$("#pname").val($("#pcode option:selected").text());
												//调用验证插件，进行form表单的验证
												$("#sectionForm").formValidate();
											}
											else {
												alert(data.msg);
												return false;
											}
									});
								
							});
		 
		 
			///图片上传
			$('#sectionImg').change(function() {
			var files = $('#sectionImg').prop('files');
			console.log(files);
			var imgUrl = $("#section_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpeg,jpg,png中的一种");  
		            document.getElementById("selectImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>50*1024){
					alert("图片大小要小于50k");
					document.getElementById("selectImg").disabled = false;
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
									 $('#section_img').val(data.picUrl);
									 document.getElementById("selectImg").disabled = false;
								}
								else {
									 $('#section_img').val('');
									alert(data.msg);
									document.getElementById("selectImg").disabled = false;
								}
						});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
						  
					  });
				}
			});
			
			$('#selectImg').click(function(){ 
				document.getElementById("selectImg").disabled = true;
				$('#sectionImg').click(); 
			});
			
			
			
		   
		});
		
		//校验栏目名称
		//$('#section_name').blur(function(){ 
		function valiname(){
			$.post("/cms/section/valiName", { "section_id": "${section.sectionId }", "section_name": $('#section_name').val()},
					function(data){
						if(data.status==0){
							return true;
						}
						else {
							alert(data.msg);
							return false;
						}
				});
		}
			
		//});
		
		
		function schange(){
			var obj = document.getElementById("pcode"); //selectid
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