<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
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
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
    <link rel="stylesheet" href="/views/media/css/DT_bootstrap.css" />
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
	<!-- 图片上传 -->
	<link rel="stylesheet" type="text/css" href="/views/media/css/multiple-select.css">
    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	<script>
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
	</script>
</head>
<body class="page-header-fixed">
    <!-- BEGIN HEADER -->
    <%@ include  file="../navi.jsp"%>
    <!-- END HEADER -->
    <!-- BEGIN CONTAINER -->
    <div class="page-container row-fluid">
        <!-- BEGIN SIDEBAR -->
        <%@ include  file="../menus.jsp"%>
        <!-- END SIDEBAR -->
        <!-- BEGIN PAGE -->
        <div class="page-content">
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <!-- BEGIN STYLE CUSTOMIZER -->
                        <!-- <a href="#" class="btn red" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-pencil" style="margin-right:5px;"></i>发布</a> -->

                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							就业环境<i style="font-size: 12px;">（${coun.countryName}）</i>
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">首页</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/country">国家管理</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>${operation}就业环境</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                 <li><a href="/country/add?coun_id=${coun.id}&operation=${operation}">基本信息</a></li>
                                 <li><a href="/country/countrySurvey?coun_id=${coun.countryId}">国家概况</a></li>
                                <li><a href="/country/livingEnvironment?coun_id=${coun.countryId}">居住环境</a></li>
                                 <li><a href="/country/socialWelfare?coun_id=${coun.countryId}">社会福利</a></li>
								<li><a href="/country/educationalLevel?coun_id=${coun.countryId}">教育水准</a></li>
								<li><a href="/country/investHome?coun_id=${coun.countryId}">投资置业</a></li>
								<li class="active"><a href="javascript:;">就业环境</a></li>
								<li><a href="/country/passportNationality?coun_id=${coun.countryId}">护照国籍</a></li>
								<li><a href="/country/city/hot/hotCityList?coun_id=${coun.countryId}">热门城市</a></li>
								<li><a href="/country/immiPolicy/listPolicy?coun_id=${coun.countryId}">移民政策</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                         <form id="sform"  class="form-horizontal" method="post">
                                            <h3 class="form-section">就业环境</h3>
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <div class="controls" style="margin-left: 100px;">
                                                            <textarea class="span10 m-wrap" style="height:360px;width:760px;visibility:hidden;"  rows="6" name="employment_environment">${coun.employmentEnvironment}</textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            <!--/row-->
											<input  name="operation" type="hidden" value="${operation}" />
											<input  name="coun_id" type="hidden" value="${coun.countryId}" />
                                            <!--/row-->
                                            <div class="form-actions" style="background-color:#ffffff;padding-left: 100px;">
                                                <button id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</button>
                                                <button type="button" class="btn" id="back">取消</button>
                                            </div>
                                        </form>
                                        <!-- END FORM-->
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
		<script src="media/js/excanvas.min.js"></script>
		<script src="media/js/respond.min.js"></script>  
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
        jQuery(document).ready(function() {    

 		   App.init(); // initlayout and core plugin

 			$("#back").click(function(e) {
 				location.href="/country";
             });
 			
 			//提交表单
 			$("#subBtn").click(function(e) {
 				//调用验证插件，进行form表单的验证
 				$("#sform").formValidate();
             });
 		});
        </script>
        <!-- END JAVASCRIPTS -->

</body>
<!-- END BODY -->

</html>