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
		var editor1 = K.create('textarea[name="country_brief"]', {
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
			allowFileManager : true,
			readonlyMode : true,
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
			allowFileManager : true,
			readonlyMode : true,
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
			allowFileManager : true,
			readonlyMode : true,
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
			allowFileManager : true,
			readonlyMode : true,
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
			allowFileManager : true,
			readonlyMode : true,
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
			allowFileManager : true,
			readonlyMode : true,
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
			allowFileManager : true,
			readonlyMode : true,
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
	K('input[name=country_brief]').click(function() {
		editor1.readonly();
	});
	K('input[name=living_environment]').click(function() {
		editor1.readonly();
	});
	K('input[name=educational_level]').click(function() {
		editor1.readonly();
	});
	K('input[name=invest_home]').click(function() {
		editor1.readonly();
	});
	K('input[name=employment_environment]').click(function() {
		editor1.readonly();
	});
	K('input[name=passport_nationality]').click(function() {
		editor1.readonly();
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
						<!-- BEGIN PAGE TITLE & BREADCRUMB-->
						<h3 class="page-title">国家详情<i style="font-size: 12px;">（${coun.countryName}）</i></h3>
						<ul class="breadcrumb">
							<li><i class="icon-home"></i> <a href="/">主页</a> <i
								class="icon-angle-right"></i></li>
							<li><a href="/country">国家管理</a><i class="icon-angle-right"></i>
							</li>
							<li>国家详情</li>
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
                                <li class="active"><a href="#tab_1" data-toggle="tab">国家信息</a></li>
                                <li><a href="#tab_8" data-toggle="tab">国家概况</a></li>
                                <li><a href="#tab_2" data-toggle="tab">居住环境</a></li>
                                <li><a href="#tab_3" data-toggle="tab">社会福利</a></li>
								<li><a href="#tab_4" data-toggle="tab">教育水准</a></li>
								<li><a href="#tab_5" data-toggle="tab">投资置业</a></li>
								<li><a href="#tab_6" data-toggle="tab">就业环境</a></li>
								<li><a href="#tab_7" data-toggle="tab">护照国籍</a></li>
								<%-- <li><a href="/country/city/hot/hotCityList?coun_id=${coun.countryId}">热门城市</a></li>
								<li><a href="/country/immiPolicy/listPolicy?coun_id=${coun.countryId}">移民政策</a></li> --%>
                            </ul>
               <div class="tab-content">
               <!-- 基本信息开始 -->
                  <div class="tab-pane active" id="tab_1">
					<%-- <div class="portlet-title">
						<div class="caption">
							<b>基本信息</b>
						</div>
						<c:if test="${coun.releaseStatus != 1}">
						<div align="right"><a href="#"><input type="button" id="release" style="background-color:#FF8C00;color:#ffffff;width:100px;border:0;" value="发布"/></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</c:if>
						<c:if test="${coun.releaseStatus == 1}">
						<div align="right"><a href="#"><input type="button" id="offline" style="background-color:#cccccc;color:#ffffff;width:100px;border:0;" value="下线"/></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</c:if>
					</div> --%>
					<!-- 添加表单 -->
					<div class="portlet-body form">
						<!-- BEGIN FORM-->
						<div class="form-horizontal form-bordered">
							<form id="sform" method="post">
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>国家名：</span> 
											<input type="text" class="m-wrap span3" data-label="国家名"
											must-be="true" name="country_name" value="${coun.countryName}" readonly="readonly"/>
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
											<input type="checkbox" name="hot_spot" value="${hotspot.dictCode}" <c:if test="${fn:contains(coun.hotspotsId, hotspot.dictCode)}">checked="checked"</c:if> disabled="disabled">${hotspot.name}<c:if test="${hotspot.name == '出行便利'}"><br/></c:if>
										</c:forEach>
									</div>
								</div>

								<div class="control-group"> 
								 	<div class="controls">
								 		<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>代表icon：</span>   
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.standPic}">
												<img  id="standImg" src="${coun.standPic}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty coun.standPic}">
												<img  id="standImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:78px;height:78px;" src="/images/addImg.png">
											</c:if>
										 </div>   
									</div>
									
									<div class="controls">
										<div style="float: right;width:250px;height:250px;overflow:hidden;position:absolute;left:650px;top:-220px;z-index:5">
											<c:if test="${!empty coun.standPic}">
												<img  id="styleImg" src="${coun.stylePic}" style="position:absolute;left:-1px;top:-1px;width:250px;height:250px;">
											</c:if>
											<c:if test="${empty coun.standPic}">
												<img  id="styleImg" style="position:relative;z-index:5;width:250px;height:250px;" src="/images/addImg.png">
											</c:if>
										 </div>
										<span style="margin-top:25px;margin-left:385px;float:left;color:#000000;font-weight:9px;">&nbsp;&nbsp;&nbsp;&nbsp;国家风貌图片</span>
									</div>
								</div>
								
								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;"><b
											style="color: #FF003B;">*</b>封面图片：</span> 
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty coun.coverPic}">
												<img  id="coverImg" src="${coun.coverPic}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty coun.coverPic}">
												<img  id="coverImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:78px;height:78px;" src="/images/addImg.png">
											</c:if>
										 </div>   
									</div>
								</div>



								<div class="control-group">
									<div class="controls">
										<span class="m-wrap span2" style="margin-top: 10px;">国家简介：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="国家简介" data-length="50" name="country_brief"
											id="country_brief"  readonly="readonly">${coun.countryBrief }</textarea>
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
								</form>
								</div>
								</div>
								</div>
								
								<div class="tab-pane" id="tab_8">
									<div class="portlet-body form">	
										<span class="m-wrap span2" style="margin-top: 10px;">国家概况：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;"
											data-label="国家概况" data-length="50" name="country_survey"
											id="country_survey" readonly="readonly">${coun.countrySurvey }</textarea>
									</div>
								</div>
								<div class="tab-pane" id="tab_2">
									<div class="portlet-body form">	
										<span class="m-wrap span2" style="margin-top: 10px;">居住环境：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="居住环境" data-length="50" name="living_environment"
											id="living_environment" readonly="readonly">${coun.livingEnvironment }</textarea>
									</div>
								</div>
								
								<div class="tab-pane" id="tab_3">
									<div class="portlet-body form">
										<span class="m-wrap span2" style="margin-top: 10px;">社会福利：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="社会福利" data-length="50" name="social_welfare"
											id="social_welfare" readonly="readonly">${coun.socialWelfare }</textarea>
									</div>
								</div>
								
								<div class="tab-pane" id="tab_4">
									<div class="portlet-body form">
										<span class="m-wrap span2" style="margin-top: 10px;">教育水准：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="教育水准" data-length="50" name="educational_level"
											id="educational_level" readonly="readonly">${coun.educationalLevel }</textarea>
									</div>
								</div>
								
								<div class="tab-pane" id="tab_5">
									<div class="portlet-body form">
										<span class="m-wrap span2" style="margin-top: 10px;">投资置业：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="投资置业" data-length="50" name="invest_home"
											id="invest_home" readonly="readonly">${coun.investHome }</textarea>
									</div>
								</div>
								
								<div class="tab-pane" id="tab_6">
									<div class="portlet-body form">
										<span class="m-wrap span2" style="margin-top: 10px;">就业环境：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="就业环境" data-length="50" name="employment_environment"
											id="employment_environment" readonly="readonly">${coun.employmentEnvironment }</textarea>
									</div>
								</div>
								
								<div class="tab-pane" id="tab_7">
									<div class="portlet-body form">
										<span class="m-wrap span2" style="margin-top: 10px;">护照国籍：</span>
										<textarea class="span10 m-wrap" style="height:200px;width:680px;visibility:hidden;"
											data-label="护照国籍" data-length="50" name="passport_nationality"
											id="passport_nationality" readonly="readonly">${coun.passportNationality }</textarea>
									</div>
								</div>
								
								<input id="coun_id" name="coun_id" type="hidden" value="${coun.id}"/>
								<input id="operation" name="operation" type="hidden" value="${operation}"/>
							
						<!-- END FORM-->
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
	<!-- END PAGE LEVEL SCRIPTS -->
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
        <script src="/views/media/js/jquery.uniform.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script type="text/javascript" src="/views/media/js/bootstrap-fileupload.js"></script>

        <script type="text/javascript" src="/views/media/js/select2.min.js"></script>

        <script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>

        <script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>

        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="/views/media/js/app.js"></script>
        <script src="/views/media/js/form-samples.js"></script>
        <script src="/views/media/js/form-components.js"></script>
        <script src="/views/media/js/table-managed.js"></script>
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
												//验证移民目的是否为空
												var hot_spot = $("input[name='hot_spot']:checked").val();
												if(!hot_spot){
													alert("移民目的不能为空！");
													return;
												}
												//调用验证插件，进行form表单的验证
												$("#sform").formValidate();
											});
							//发布
							$("#release").click(function(e) {
								var id = $("#coun_id").val();
								if(confirm("确定要发布该国家吗？")){
									$.post(
										"/country/release",
										{"coun_id":id},
										function(data){
											if(data.status == 0){
												alert("发布成功！");
												location.reload();
											}else if(data.status == 1){
												alert(data.msg);
											}else if(data.status == 2){
												alert(data.msg);
											}
										}
									);
								}
							});
							//下线
							$("#offline").click(function(e) {
								var id = $("#coun_id").val();
								if(confirm("确定要下线该国家吗？")){
									$.post(
										"/country/offline",
										{"coun_id":id},
										function(data){
											if(data.status == 0){
												alert("下线成功！");
												location.reload();
											}else if(data.status == 1){
												alert(data.msg);
											}else if(data.status == 2){
												alert(data.msg);
											}
										}
									);
								}
							});
						});
		  
		  
		//代表icon
		$('#standPic').change(function() {
			var files = $('#standPic').prop('files');
			console.log(files);
			var imgUrl = $("#stand_pic").val();
			for(var m=0;m<files.length;m++){
			lrz(files[m],{quality :0.3})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#standImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 $('#stand_pic').val(data.picUrl);
						}
						else {
							 $('#stand_pic').val('');
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#standImg').click(function(){ 
			$('#standPic').click(); 
		});
		//封面图片
		$('#coverPic').change(function() {
			var files = $('#coverPic').prop('files');
			console.log(files);
			var imgUrl = $("#cover_pic").val();
			for(var m=0;m<files.length;m++){
			lrz(files[m],{quality :0.3})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#coverImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 $('#cover_pic').val(data.picUrl);
						}
						else {
							 $('#cover_pic').val('');
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#coverImg').click(function(){ 
			$('#coverPic').click(); 
		});
		//国家风貌图片
		$('#stylePic').change(function() {
			var files = $('#stylePic').prop('files');
			console.log(files);
			var imgUrl = $("#style_pic").val();
			for(var m=0;m<files.length;m++){
			lrz(files[m],{quality :0.3})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#styleImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 $('#style_pic').val(data.picUrl);
						}
						else {
							 $('#style_pic').val('');
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#styleImg').click(function(){ 
			$('#stylePic').click(); 
		});
		
		
		$('#country_id').change(function(){
			var countryId = $('#country_id').val();
			var countryName = $('#country_id').find("option:selected").text();
			if(!countryId){
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
	</script>
	 <script>
            jQuery(document).ready(function () {
                // initiate layout and plugins
                App.init();
                FormSamples.init();
                /*FormComponents.init();*/
                TableManaged.init();
            });
        </script>

	<!-- END JAVASCRIPTS -->
	<!-- END BODY -->
</html>