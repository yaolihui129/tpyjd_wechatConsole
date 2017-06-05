<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->

<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

<meta charset="utf-8" />

<title>太平洋加达出国－后台管理系统 v1.0</title>

<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<meta content="" name="description" />

<meta content="" name="author" />

<!-- BEGIN GLOBAL MANDATORY STYLES -->

<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css" />
<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />

<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />

<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL STYLES -->
<!-- 多出来的 -->
<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
<!-- 这个css为移民目的引用的样式 -->
<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css" />
<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>


    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	
	
    <style type="text/css">
	th{
		cursor:pointer;
	}
	th div{
		float:left;
	}
	.tree a.tree-toggle{
		padding-left:20px;
	}
	</style>
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
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="page-title">${operation}城市<i style="font-size: 12px;">（${coun.countryName}）</i></h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li><a href="/country/city/hot/hotCityList?coun_id=${coun_id}">热门城市</a><i class="icon-angle-right"></i>
							</li>
							<li>${operation}城市</li>
							<li class="pull-right no-text-shadow">
								<div id="dashboard-report-range"
									class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive"
									data-tablet="" data-desktop="tooltips" data-placement="top"
									data-original-title="Change dashboard date range">
									<i class="icon-calendar"></i> <span></span> <i
										class="icon-angle-down"></i>
								</div>
							</li>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->
				<div class="row-fluid">
				<div class="span12">
				<div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li><a href="/country/add?coun_id=${coun.id}&operation=编辑">基本信息</a></li>
                                <li><a href="/country/countrySurvey?coun_id=${coun.countryId}">国家概况</a></li>
                                <li><a href="/country/livingEnvironment?coun_id=${coun.countryId}">居住环境</a></li>
                                <li><a href="/country/socialWelfare?coun_id=${coun.countryId}">社会福利</a></li>
								<li><a href="/country/educationalLevel?coun_id=${coun.countryId}">教育水准</a></li>
								<li><a href="/country/investHome?coun_id=${coun.countryId}">投资置业</a></li>
								<li><a href="/country/employmentEnvironment?coun_id=${coun.countryId}">就业环境</a></li>
								<li><a href="/country/passportNationality?coun_id=${coun.countryId}">护照国籍</a></li>
								<li class="active"><a href="javascript:;">热门城市</a></li>
								<li><a href="/country/immiPolicy/listPolicy?coun_id=${coun.countryId}">移民政策</a></li>
                            </ul>
               <div class="tab-content">
               <!-- 基本信息开始 -->
                  <div class="tab-pane active" id="tab_1">
					<div class="portlet-title">
						<div class="caption">
							<b>${operation}城市</b>
						</div>
					</div>
					<!-- 添加表单 -->
					<div class="portlet-body form">
						<!-- BEGIN FORM-->
						<div class="form-horizontal form-bordered">
							<form id="sform" method="post">
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>城市名：</span> 
											<select class="m-wrap span3" id="city_id" name="city_id" <c:if test="${!empty city.cityName}">disabled="disabled"</c:if>>
											<option value=""></option>
											<c:forEach var="item" items="${citys}">
												<option value="${item.dictCode}" data-id="${item.shortName}" <c:if test="${item.dictCode == city.cityId}">selected="selected"</c:if>>${item.name}</option>
											</c:forEach>
											</select>
											<input type="hidden" class="m-wrap span3" data-label="城市名需要在字典表中维护！"
											must-be="true" id="city_name" name="city_name" value="${city.cityName}"/>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>英文名：</span> 
											<input  placeholder="英文名" class="m-wrap span3" type="text" data-label="英文名需要在字典表中维护，"
											must-be="true" name="city_egname" id="city_egname" value="${city.cityEgname}" readonly="readonly"/>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>描述：</span> 
											<textarea placeholder="描述" data-label="描述"
											must-be="true" name="description" id="description">${city.description}</textarea>
									</div>
								</div>
								

								<div class="control-group"> 
								 	<div class="controls">
								 		<span class="m-wrap span2" style="margin-top: 10px;">缩略图：</span>   
										<input id="thumbPic" name="thumbPic" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:60px;height:60px;overflow:hidden;position:relative;">
											<c:if test="${!empty city.thumbImg}">
												<img  id="thumbImg" src="${city.thumbImg}" style="position:absolute;left:-1px;top:-1px;width:60px;height:60px;">
											</c:if>
											<c:if test="${empty city.thumbImg}">
												<img  id="thumbImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:60px;height:60px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="thumb_img" name="thumb_img" value="${city.thumbImg}" />
										 </div>
										  <input type="button" id="thumbUpImg" value="选择图片" style="margin-top: 62px;margin-left: -61px;float:left;">   
										 <span style="margin-top: 89px;margin-left: -70px;float:left;color:#A1A1A1;font-size: xx-small;">图片格式:支持<b style="color:#FF3B00;">jpg,png</b>格式图片，建议尺寸<b style="color:#FF3B00;">280*280px</b>，若较大系统会自动截取，大小在<b style="color:#FF3B00;">100k</b>以内.</span>
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;">大图：</span> 
											<input id="bigPic" name="bigPic" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:120px;height:120px;overflow:hidden;position:relative;">
											<c:if test="${!empty city.bigImg}">
												<img  id="bigImg" src="${city.bigImg}" style="position:absolute;left:-1px;top:-1px;width:120px;height:120px;">
											</c:if>
											<c:if test="${empty city.bigImg}">
												<img  id="bigImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:120px;height:120px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="big_img" name="big_img" value="${city.bigImg}" />
										 </div>
										  <input type="button" id="bigUpImg" value="选择图片" style="margin-top: 123px;margin-left: -118px;float:left;">  
										 <span style="margin-top: 147px;margin-left: -116px;float:left;color:#A1A1A1;font-size: xx-small;">图片格式:支持<b style="color:#FF3B00;">jpg,png</b>格式图片，建议高度<b style="color:#FF3B00;">700px</b>，大小在<b style="color:#FF3B00;">150k</b>以内.</span>
									</div>
								</div>
								<input id="coun_id" name="coun_id" type="hidden" value="${coun_id}"/>
								<input id="coun_name" name="coun_name" type="hidden" value="${coun_name}"/>
								<%-- <input id="city_id" name="city_id" type="hidden" value="${city.id}"/> --%>
								<input id="operation" name="operation" type="hidden" value="${operation}"/>
								<div class="form-actions">
									<a class="subBtn btn blue" style="width:80px;"><i class="icon-ok"></i> 保存</a>
									<a class="btn back"><i class="icon-remove"></i>取消</a>
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
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->
	</div>
	<!-- END CONTAINER -->

	<!-- BEGIN FOOTER -->
				</div>
				 <!-- 基本信息开结束-->
				 
	<div class="footer">
		<div class="footer-inner">2016 &copy; copyright pacificimmi.</div>
		<div class="footer-tools">
			<a href="#tab_1"><span class="go-top"> <i class="icon-angle-up"></i>
			</span></a>
		</div>
	</div>
	<!-- END FOOTER -->
	</body>
	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>

	<!-- 编辑密码引用的js -->     
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/form-validate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->

	<script>
		jQuery(document)
				.ready(
						function() {
							//取消、返回
							$(".back").click(function(e) {
								window.history.back();
							});

							

							//提交表单
							$(".subBtn")
									.click(
											function(e) {
												var description = $("#description").val();
												if(!description){
													alert('描述不能为空！');
													return;
												}
												//调用验证插件，进行form表单的验证
												$("#sform").formValidate();
											});
						});
		  
		  
		//缩略图
		$('#thumbPic').change(function() {
			var files = $('#thumbPic').prop('files');
			console.log(files);
			var imgUrl = $("#thumb_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpg,png中的一种");
		            document.getElementById("thumbUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					document.getElementById("thumbUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :0.3})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#thumbImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("thumbUpImg").disabled = false;
							 $('#thumb_img').val(data.picUrl);
						}
						else {
							 $('#thumb_img').val('');
							 document.getElementById("thumbUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#thumbUpImg').click(function(){ 
			document.getElementById("thumbUpImg").disabled = true;
			$('#thumbPic').click(); 
		});
		//大图
		$('#bigPic').change(function() {
			var files = $('#bigPic').prop('files');
			console.log(files);
			var imgUrl = $("#big_img").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是.jpg,png中的一种");
		            document.getElementById("bigUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>150*1024){
					alert("图片大小要小于150k");
					document.getElementById("bigUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :0.3})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#bigImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("bigUpImg").disabled = false;
							 $('#big_img').val(data.picUrl);
						}
						else {
							 $('#big_img').val('');
							 document.getElementById("bigUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#bigUpImg').click(function(){ 
			document.getElementById("bigUpImg").disabled = true;
			$('#bigPic').click(); 
		});
		
		$('#city_id').change(function(){
			var cityId = $('#city_id').val();
			var english_name = $('#city_id').find("option:selected").attr("data-id");
			var cityName = $('#city_id').find("option:selected").text();
			/* var cityId = $('#city_id').find("option:selected").text(); */
			if(!cityId){
				$("#city_name").val('');
			}else{
				$("#city_name").val(cityName);
			}
			if(!english_name){
				$("#city_egname").val('');
			}else{
				$("#city_egname").val(english_name);
			}
		});
	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>