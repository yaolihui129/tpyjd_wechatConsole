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
<!-- 图片上传 -->
<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
<!-- 图片上传 -->
<link rel="stylesheet" type="text/css" href="/views/media/css/multiple-select.css">
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
	<script>
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="living_environment"]', {
			cssPath : '/kindeditor/plugins/code/prettify.css',
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
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="social_welfare"]', {
			cssPath : '/kindeditor/plugins/code/prettify.css',
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
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="educational_level"]', {
			cssPath : '/kindeditor/plugins/code/prettify.css',
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
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="invest_home"]', {
			cssPath : '/kindeditor/plugins/code/prettify.css',
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
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="employment_environment"]', {
			cssPath : '/kindeditor/plugins/code/prettify.css',
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
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="passport_nationality"]', {
			cssPath : '/kindeditor/plugins/code/prettify.css',
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
						<!-- BEGIN STYLE CUSTOMIZER -->
						<c:if test="${operation=='编辑' && coun.releaseStatus == 0}">
							<a href="#" class="btn red" id="release" style="float:right; margin-right:20px;margin-top:20px;"><i class="  icon-upload" style="margin-right:5px;"></i>发布</a>
						<a id="previewBtn" href="#" class="btn red" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-youtube-play" style="margin-right:5px;"></i>预览</a>
						</c:if>
						<c:if test="${operation=='编辑' && coun.releaseStatus == 1}">
							<a href="#" class="btn red" id="rerelease" style="float:right; margin-right:20px;margin-top:20px;"><i class="  icon-upload" style="margin-right:5px;"></i>重新发布</a>
						<a id="previewBtn" href="#" class="btn red" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-youtube-play" style="margin-right:5px;"></i>预览</a>
						</c:if>
						<c:if test="${operation=='编辑' && coun.releaseStatus == 2}">
							<a href="#" class="btn red" id="rerelease" style="float:right; margin-right:20px;margin-top:20px;"><i class="  icon-upload" style="margin-right:5px;"></i>重新发布</a>
						<a id="previewBtn" href="#" class="btn red" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-youtube-play" style="margin-right:5px;"></i>预览</a>
						</c:if>
						
                        <!-- END BEGIN STYLE CUSTOMIZER -->
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="page-title">${operation}国家<i style="font-size: 12px;"><c:if test="${operation != '添加' }">（${coun.countryName}）</c:if></i></h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li><a href="/country">国家管理</a><i class="icon-angle-right"></i>
							</li>
							<li>${operation}国家</li>
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
                                <li class="active"><a href="#tab_1" data-toggle="tab">基本信息</a></li>
                                <c:if test="${!empty coun.countryId}">
                                <li><a href="/country/countrySurvey?coun_id=${coun.countryId}">国家概况</a></li>
                                <li><a href="/country/livingEnvironment?coun_id=${coun.countryId}">居住环境</a></li>
                                <li><a href="/country/socialWelfare?coun_id=${coun.countryId}">社会福利</a></li>
								<li><a href="/country/educationalLevel?coun_id=${coun.countryId}">教育水准</a></li>
								<li><a href="/country/investHome?coun_id=${coun.countryId}">投资置业</a></li>
								<li><a href="/country/employmentEnvironment?coun_id=${coun.countryId}">就业环境</a></li>
								<li><a href="/country/passportNationality?coun_id=${coun.countryId}">护照国籍</a></li>
								<li><a href="/country/city/hot/hotCityList?coun_id=${coun.countryId}">热门城市</a></li>
								<li><a href="/country/immiPolicy/listPolicy?coun_id=${coun.countryId}">移民政策</a></li>
								</c:if>
                                <c:if test="${empty coun.countryId}">
                                <li><a href="#" onclick="jiben()">国家概况</a></li>
                                <li><a href="#" onclick="jiben()">居住环境</a></li>
                                <li><a href="#" onclick="jiben()">社会福利</a></li>
								<li><a href="#" onclick="jiben()">教育水准</a></li>
								<li><a href="#" onclick="jiben()">投资置业</a></li>
								<li><a href="#" onclick="jiben()">就业环境</a></li>
								<li><a href="#" onclick="jiben()">护照国籍</a></li>
								<li><a href="#" onclick="jiben()">热门城市</a></li>
								<li><a href="#" onclick="jiben()">移民政策</a></li>
								</c:if>
								<%-- <li style="background-color:orange;"><a href="/country/city/hot/hotCityList?coun_id=${coun.countryId}" data-toggle="tab">热门城市</a></li>
								<li style="background-color:orange;"><a href="/country/immiPolicy/listPolicy?coun_id=${coun.countryId}" data-toggle="tab">移民政策</a></li> --%>
                            </ul>
               <div class="tab-content">
               <!-- 基本信息开始 -->
                  <div class="tab-pane active" id="tab_1">
					<div class="portlet-title">
						<div class="caption">
							<b>基本信息</b>
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
											style="color: #FF003B;">*</b>国家名：</span> 
											<select class="m-wrap span3" id="country_id" name="country_id" <c:if test="${!empty coun.countryName}">disabled="disabled"</c:if>>
											<option value=""></option>
											<c:forEach var="country" items="${countryList}">
												<option value="${country.dictCode}" <c:if test="${coun.countryId == country.dictCode}">selected="selected"</c:if>>${country.name}</option>
											</c:forEach>
											</select>
											<input type="hidden" class="m-wrap span3" data-label="国家名"
											must-be="true" id="country_name" name="country_name" value="${coun.countryName}"/>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>英文名：</span> 
											<input  placeholder="英文名" class="m-wrap span3" type="text" data-label="英文名"
											must-be="true" name="english_name" id="english_name" value="${coun.englishName}" readonly="readonly"/>
									</div>
								</div>

								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>地理分类：</span> 
											<input placeholder="地理分类"
											class="m-wrap span3" type="text" data-label="地理分类"
											must-be="true" name="continent" id="continent" value="${coun.continentName}"  readonly="readonly">
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>移民目的：</span> 
										<c:forEach var="hotspot" items="${hotspots}">
											<input type="checkbox" name="hot_spot" value="${hotspot.dictCode}" <c:if test="${fn:contains(coun.hotspotsId, hotspot.dictCode)}">checked="checked"</c:if>>${hotspot.name}<c:if test="${hotspot.name == '出行便利'}"><br/></c:if>
										</c:forEach>
									</div>
								</div>

								<div class="control-group" style="border:none;"> 
								 		<div class="controls">
								 		<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>代表icon：</span>   
										<input id="standPic" name="standPic" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.standPic}">
												<img  id="standImg" src="${coun.standPic}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty coun.standPic}">
												<img  id="standImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:102px;height:102px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="stand_pic" name="stand_pic" data-label="代表icon"
											must-be="true" value="${coun.standPic}" style="display: none;" />
										 </div>   
										 <!-- <input type="button" id="standUpImg" value="选择图片" style="margin-top:50px;margin-left:12px;float:left;">
										 <span style="margin-top: 75px;margin-left:-67px;float:left;color:#A1A1A1;font-size: xx-small;">图片格式:支持<b style="color:#FF3B00;">jpg,png</b>格式图片，尺寸为<b style="color:#FF3B00;">156px*156px</b>以下,大小不超过<b style="color:#FF3B00;">50kb</b>.</span> -->
										</div>
									
									<%-- <div class="controls">
											<input id="stylePic" name="stylePic" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: right;width:250px;height:250px;overflow:hidden;position:absolute;left:650px;top:-220px;z-index:5;">
											<c:if test="${!empty coun.stylePic}">
												<img id="styleImg" src="${coun.stylePic}" style="position:relative;z-index:5;width:250px;height:250px;">
											</c:if>
											<c:if test="${empty coun.stylePic}">
												<img id="styleImg" style="position:relative;z-index:5;width:250px;height:250px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="style_pic" name="style_pic" value="${coun.stylePic}" />
										 </div>
										 <!-- <span style="margin-top:25px;margin-left:55px;float:left;color:#000000;font-weight:9px;">&nbsp;&nbsp;&nbsp;&nbsp;国家风貌图片</span> -->
									</div> --%>
									<!-- <div class="controls" >
										<div style="float: right;width:250px;height:250px;overflow:hidden;position:absolute;left:650px;z-index:5;">
											<span class="m-wrap span3" style="margin-top: 10px;"></span> 
								 			<input type="button" id="styleUpImg" value="选择图片"><b>&nbsp;&nbsp;国际风貌图片</b>
								 		</div>	
								 	</div> -->
									<!-- <div class="controls">
									<div style="float: right;width:350px;height:250px;overflow:hidden;position:absolute;left:630px;top:25px;z-index:5;">
									<div style="float: right;width:350px;height:250px;overflow:hidden;position:absolute;left:630px;top:25px;z-index:5;">
										<span class="m-wrap span3" style="margin-top: 10px;"></span>
								 		<span class="label label-important">图片格式</span>
                                        <span>支持jpg,png格式图片，建议图片尺寸为694*360px，大小不超过100k</span>
                                    </div>    
								 	</div> -->
								</div>
								<div class="control-group" style="border:none;">
									<div class="controls" >
										<span class="m-wrap span2" style="margin-top: 10px;"></span> 
								 		<input type="button" id="standUpImg" value="选择图片">
								 	</div>
								</div>
								<div class="control-group" style="border:none;">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"></span>
								 		<span class="label label-important">图片格式</span>
                                        <span>建议上传国旗图标,尺寸为120*120px,支持jpg,png格式图片, 大小不超过50k</span>
								 	</div>
								</div>
								<div class="control-group" style="border:none;">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"></span> 
											<input id="standPicOfficial" name="standPicOfficial" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.standPicOfficial}">
												<img  id="standPicOfficialImg" src="${coun.standPicOfficial}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty coun.standPicOfficial}">
												<img  id="standPicOfficialImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:102px;height:102px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="stand_pic_official" name="stand_pic_official" data-label="代表图片(官网)"
											must-be="true" value="${coun.standPicOfficial}" />
										 </div> 
										 </div>
									</div> 
									<div class="control-group" style="border:none;">
										<div class="controls" >
											<span class="m-wrap span2" style="margin-top: 10px;"></span> 
									 		<input type="button" id="standPicOfficialUpImg" value="选择图片">
									 	</div>
									</div>
									<div class="control-group" >
									<span style="margin-left: 550px;margin-top: -20px;"><b style="font-size: 20px;">国家列表页使用</b></span>
										<div class="controls">
											<span class="m-wrap span2" style="margin-top: 10px;"></span>
								 			<span class="label label-important">图片格式</span>
                                            <span>建议上传国旗图标,尺寸为112*112px,支持jpg,png格式图片, 大小不超过200k</span>
								 		</div>
									</div>
								<div class="control-group" style="border:none;">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>封面图片：</span> 
											<input id="coverPic" name="coverPic" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.coverPic}">
												<img  id="coverImg" src="${coun.coverPic}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty coun.coverPic}">
												<img  id="coverImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:102px;height:102px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="cover_pic" name="cover_pic" data-label="封面图片"
											must-be="true" value="${coun.coverPic}" />
										 </div> 
										 </div>
									</div> 
									<div class="control-group" style="border:none;">
										<div class="controls" >
											<span class="m-wrap span2" style="margin-top: 10px;"></span> 
									 		<input type="button" id="coverUpImg" value="选择图片">
									 	</div>
									</div>
									<div class="control-group" >
										<div class="controls">
											<span class="m-wrap span2" style="margin-top: 10px;"></span>
								 			<span class="label label-important">图片格式</span>
                                            <span> 支持jpg,png格式图片，建议尺寸280*280px,若较大系统会自动截取,大小不超过100K</span>
								 		</div>
									</div>
									<div class="control-group" style="border:none;">
										<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;">国际风貌图片：</span> 
											<input id="stylePic" name="stylePic" multiple accept="image/*" type="file" style="display: none;">
											<div style="float: left;   width:250px;height:250px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.stylePic}">
												<img id="styleImg" src="${coun.stylePic}" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px;width:250px;height:250px;">
											</c:if>
											<c:if test="${empty coun.stylePic}">
												<img id="styleImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px;width:250px;height:250px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="style_pic" name="style_pic" value="${coun.stylePic}" />
										 <!-- <span style="margin-top:25px;margin-left:55px;float:left;color:#000000;font-weight:9px;">&nbsp;&nbsp;&nbsp;&nbsp;国家风貌图片</span> -->
										 </div>
									</div>
									</div>
									<div class="control-group" style="border:none;">
									<span class="m-wrap span2" style="margin-top:-67px;margin-left:50px;"><i>(微站图片)</i></span> 
									<div class="controls" >
											<span class="m-wrap span2" style="margin-top:10px;"></span> 
								 			<input type="button" id="styleUpImg" value="选择图片">
								 	</div>
								 	</div>
								 	<div class="control-group" style="border:none;">
										<div class="controls">
											<span class="m-wrap span2" style="margin-top: 10px;"></span>
									 		<span class="label label-important">图片格式</span>
	                                        <span>支持jpg,png格式图片，建议图片尺寸为694*360px，大小不超过100k</span>
									 	</div>
								 	</div>
								 	<div class="control-group" style="border:none;">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"></span> 
											<input id="stylePicOfficial" name="stylePicOfficial" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:250px;height:250px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.stylePicOfficial}">
												<img  id="stylePicOfficialImg" src="${coun.stylePicOfficial}" style="position:absolute;left:-1px;top:-1px;width:250px;height:250px;">
											</c:if>
											<c:if test="${empty coun.stylePicOfficial}">
												<img  id="stylePicOfficialImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:250px;height:250px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="style_pic_official" name="style_pic_official" value="${coun.stylePicOfficial}" />
										 </div> 
										 </div>
									</div> 
									<div class="control-group" style="border:none;">
									<span class="m-wrap span2" style="margin-top:-67px;margin-left:50px;"><i>(官网图片)</i></span> 
										<div class="controls" >
											<span class="m-wrap span2" style="margin-top: 10px;"></span> 
									 		<input type="button" id="stylePicOfficialUpImg" value="选择图片">
									 	</div>
									</div>
									<div class="control-group" >
									<span style="margin-left: 550px;margin-top: -20px;"><b style="font-size: 20px;">国家列表页使用</b></span>
										<div class="controls">
											<span class="m-wrap span2" style="margin-top: 10px;"></span>
								 			<span class="label label-important">图片格式</span>
                                            <span>支持jpg,png格式图片，建议尺寸为320px*240px，大小不超过500k</span>
								 		</div>
									</div>
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>国家简介：</span>
										<textarea class="span10 m-wrap" style="height:100px;width:480px;"
											data-label="国家简介" data-length="1000" name="country_brief"
											id="country_brief">${coun.countryBrief }</textarea>
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;">发布状态：</span>
										<c:if test="${coun.releaseStatus == 0 }"><b><i style="color:red">未发布</i></b></c:if>
										<c:if test="${coun.releaseStatus == 1 }"><b><i style="color:red">已发布</i></b></c:if>
										<c:if test="${coun.releaseStatus == 2 }"><b><i style="color:red">已下线</i></b></c:if>
									</div>
								</div>
								<c:if test="${operation=='添加'}">
								<div class="form-actions">
									<a class="btn blue" id="subBtn" ><i class="icon-ok"></i> 保存</a>
									<a class="btn back"><i class="icon-remove"></i>取消</a>
								</div>
								</c:if>
								<c:if test="${operation=='编辑' && coun.releaseStatus == 0}">
								<div class="form-actions">
									<a class="btn blue" id="subBtn" ><i class="icon-ok"></i> 保存</a>
									<!-- <a class="btn blue" id="release"><i class="icon-share"></i> 发布</a> -->
									<a class="btn back"><i class="icon-remove"></i>取消</a>
								</div>
								</c:if>
								<c:if test="${operation=='编辑' && coun.releaseStatus == 1}">
								<div class="form-actions">
									<!-- <a class="btn blue" id="rerelease"><i class="icon-share"></i> 重新发布</a> -->
									<a class="btn blue" href="#" onclick="offline(${coun.id})"><i class=" icon-download"></i> 下线</a>
									<a class="btn back"><i class="icon-remove"></i>取消</a>
								</div>
								</c:if>
								<c:if test="${operation=='编辑' && coun.releaseStatus == 2}">
								<div class="form-actions">
									<!-- <a class="btn blue" id="rerelease"><i class="icon-share"></i> 重新发布</a> -->
									<a class="btn back"><i class="icon-remove"></i>取消</a>
								</div>
								</c:if>
								<input id="coun_id" name="coun_id" type="hidden" value="${coun.id}"/>
								<input id="operation" name="operation" type="hidden" value="${operation}"/>
								<input id="releaseSuccess" name=releaseSuccess type="hidden" value="${releaseSuccess}"/>
								<input id="saveSuccess" name=saveSuccess type="hidden" value="${saveSuccess}"/>
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


	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/form-validate.js"></script>
	<script src="/js/json/json2.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script> 
	<!-- 编辑密码引用的js -->     
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>	
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>
	<!-- bug号556
		将权限管理-资源管理的国家列表下的   保存并发布修改为 国家重新发布；国家新增 修改为 国家保存
		 微站-国家管理修改如下：
		 点击编辑页各按钮提示信息如下：
		 点击保存后提示 保存成功。
		 点击下线时提示 是否要将发布的内容进行下线？  
		 点击重新发布时提示：确定要发布该国家吗？ 
		 点击发布时提示：请先保存再进行发布，发布后网站端将会实时同步！确定要发布吗？
	 -->
	<script>
		jQuery(document)
				.ready(
						function() {
							App.init(); // initlayout and core plugins
							//取消、返回
							$(".back").click(function(e) {
								//window.history.back();
								location.href="/country";
							});

							first = true;
							var releaseSuccess = $("#releaseSuccess").val();
							if("1" == releaseSuccess){
								if(first){
									first = false;
									alert("发布成功！");
								}
								$("#releaseSuccess").val(0);
							}
							var saveSuccess = $("#saveSuccess").val();
							
							if("1" == saveSuccess){
								$("#saveSuccess").val("0");
								if(first){
									first = false;
									alert("保存成功！");
								}
							}
							reclick = true;
							validate = true;
							//提交表单
							$("#subBtn").click(function(e) {
												Verification();
												if(reclick&&validate){
													reclick = false;
													//调用验证插件，进行form表单的验证
													$("#sform").attr("action","/country/add");
													$("#sform").formValidate();
												}
											});
							//重新发布
							$("#rerelease").click(function(e) {
												Verification();
												if(reclick&&validate){
													if(confirm("确定要发布该国家吗？")){
														reclick = false;
														$.post(
															"/country/checkRelease",//检查已经发布的数量
															{
																"coun_id":"${coun.id}"
															},
															function(data){
																if(data.code == 0){
																	$("#sform").attr("action", "/country/addAndRelease");
																	//调用验证插件，进行form表单的验证
																	$("#sform").formValidate();
																}else{
																	alert(data.msg);
																	reclick = true;
																}
															}
														);
														
													}
												}
											});
							//发布
							$("#release").click(function(e) {
												Verification();
												if(reclick&&validate){
													if(confirm("请先保存再进行发布，发布后网站端将会实时同步！确定要发布吗？")){
														reclick = false;
														$.post(
																"/country/release",
																{"coun_id":"${coun.id}"},
																function(data){
																	if(data.status == 0){
																		alert("发布成功！");
																		window.location.href = "/country";
																	}else if(data.code == 1){
																		alert(data.msg);
																		reclick = true;
																	}else if(data.status == 2){
																		alert(data.msg);
																		reclick = true;
																	}
																}
														);
														
													}
												}
											});
						});
		function Verification(){
			if(reclick){
				var country_name = $("#country_name").val();
				if(!country_name){
					alert("国家名不能为空！");
					validate = false;
					return false;
				}
				var english_name = $("#english_name").val();
				if(!english_name){
					alert("英文名不能为空！");
					validate = false;
					return false;
				}
				var continent = $("#continent").val();
				if(!continent){
					alert("地理分类不能为空！");
					validate = false;
					return false;
				}
				var hot_spot = $("input[name='hot_spot']:checked").val();
				if(!hot_spot){
					alert("移民目的不能为空！");
					validate = false;
					return false;
				}
				var stand_pic = $("#stand_pic").val();
				if(!stand_pic){
					alert("代表icon不能为空！");
					validate = false;
					return false;
				}
				var stand_pic_official = $("#stand_pic_official").val();
				if(!stand_pic_official){
					alert("代表icon(官网)不能为空！");
					validate = false;
					return false;
				}
				var cover_pic = $("#cover_pic").val();
				if(!cover_pic){
					alert("封面图片不能为空！");
					validate = false;
					return false;
				}
				var country_brief = $("#country_brief").val();
				if(!country_brief){
					alert("国家简介不能为空！");
					validate = false;
					return false;
				}
				var dataLen = $("#country_brief").attr("data-length");
				if(dataLen!=undefined && $("#country_brief").val().length>dataLen){
					alert("国家简介字数不能超过"+dataLen+"!");
					validate = false;
					return false;
				}
				validate = true;
			}
		}
		  
		//代表icon
		$('#standPic').change(function() {
			var files = $('#standPic').prop('files');
			console.log(files);
			var imgUrl = $("#stand_pic").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("standUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>50*1024){
					alert("图片大小要小于50k");
					document.getElementById("standUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#standImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("standUpImg").disabled = false;
							 $('#stand_pic').val(data.picUrl);
						}
						else {
							 $('#stand_pic').val('');
							 document.getElementById("standUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#standUpImg').click(function(){ 
			document.getElementById("standUpImg").disabled = true;
			$('#standPic').click(); 
		});
		//代表icon（官网）
		$('#standPicOfficial').change(function() {
			var files = $('#standPicOfficial').prop('files');
			console.log(files);
			var imgUrl = $("#stand_pic_official").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("standPicOfficialUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>200*1024){
					alert("图片大小要小于200k");
					document.getElementById("standPicOfficialUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#standPicOfficialImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("standPicOfficialUpImg").disabled = false;
							 $('#stand_pic_official').val(data.picUrl);
						}
						else {
							 $('#stand_pic_official').val('');
							 document.getElementById("standPicOfficialUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#standPicOfficialUpImg').click(function(){ 
			document.getElementById("standPicOfficialUpImg").disabled = true;
			$('#standPicOfficial').click(); 
		});
		//封面图片
		$('#coverPic').change(function() {
			var files = $('#coverPic').prop('files');
			console.log(files);
			var imgUrl = $("#cover_pic").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("coverUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					document.getElementById("coverUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#coverImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("coverUpImg").disabled = false;
							 $('#cover_pic').val(data.picUrl);
						}
						else {
							 $('#cover_pic').val('');
							 document.getElementById("coverUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#coverUpImg').click(function(){ 
			document.getElementById("coverUpImg").disabled = true;
			$('#coverPic').click(); 
		});
		//国家风貌图片
		$('#stylePic').change(function() {
			var files = $('#stylePic').prop('files');
			console.log(files);
			var imgUrl = $("#style_pic").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("styleUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>100*1024){
					alert("图片大小要小于100k");
					document.getElementById("styleUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#styleImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("styleUpImg").disabled = false;
							 $('#style_pic').val(data.picUrl);
						}
						else {
							 $('#style_pic').val('');
							 document.getElementById("styleUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#styleUpImg').click(function(){ 
			document.getElementById("styleUpImg").disabled = true;
			$('#stylePic').click(); 
		});
		//国家风貌（官网）
		$('#stylePicOfficial').change(function() {
			var files = $('#stylePicOfficial').prop('files');
			console.log(files);
			var imgUrl = $("#style_pic_official").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("stylePicOfficialUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>500*1024){
					alert("图片大小要小于500k");
					document.getElementById("stylePicOfficialUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#stylePicOfficialImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("stylePicOfficialUpImg").disabled = false;
							 $('#style_pic_official').val(data.picUrl);
						}
						else {
							 $('#style_pic_official').val('');
							 document.getElementById("stylePicOfficialUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#stylePicOfficialUpImg').click(function(){ 
			document.getElementById("stylePicOfficialUpImg").disabled = true;
			$('#stylePicOfficial').click(); 
		});
		
		$('#country_id').change(function(){
			var countryId = $('#country_id').val();
			var countryName = $('#country_id').find("option:selected").text();
			if(!countryId){
				$(":input[name='country_name']").val("");
				$(":input[name='english_name']").val("");
				$(":input[name='continent']").val("");
				return;
			}else{
				$(":input[name='country_name']").val(countryName);
				$.post(
					"/country/selectContinent",
					{
					  "countryId":countryId
					},
					function(data){
						if(data.code == 0){
							$(":input[name='english_name']").val(data.enName);
							$(":input[name='continent']").val(data.continent);
						}else if (data.code == 1){
							alert("查询异常！");
						}else{
							alert("查询失败！");
						}
					
				});	
			}
		});
		function jiben(){
			alert("请先填写基本信息！");
		}
		//下线
		function offline(id){
		if(!id){return false;}
		if(confirm(" 是否要将发布的内容进行下线？")){
			$.post(
				"/country/offline",
				{"coun_id":id},
				function(data){
					if(data.status == 0){
						alert("下线成功！");
						window.location.href="/country/add?coun_id="+id+"&operation=编辑";
					}else if(data.status == 1){
						alert(data.msg);
					}else if(data.status == 2){
						alert(data.msg);
					}
				}
		)}
		}
		
		 //预览
		 $("#previewBtn").click(function(e) {
			window.open("${OFFICIAL_URL}"+"/country/survey/${coun.countryId}");
       });
	</script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>