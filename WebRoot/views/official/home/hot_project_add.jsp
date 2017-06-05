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
    <!-- 下拉框搜索开始 -->
	<script type="text/javascript" src="http://www.daimajiayuan.com/download/jquery/jquery-1.10.2.min.js"></script>  
    <script type="text/javascript" src="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.js"></script>    
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.css">    
  
    <!-- 3.0 -->  
   <!--  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">  
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>  --> 
  
    <!-- 2.3.2  
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">  
    <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.js"></script>  
    -->  
    <!-- 下拉框搜索结束 -->
    
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
	<style type="text/css">
			.form-control {
				style:"withd:100px";
			}
	</style>
    <script type="text/javascript">
    $(window).on('load', function () { 
        	//搜索框
        	$('.selectpicker').selectpicker({  
                'selectedText': 'cat'  
            });
 			 // $('.selectpicker').selectpicker('hide');
        });
     </script>
</head>
<body class="page-header-fixed">
    <!-- BEGIN HEADER -->
    <%@ include  file="../../navi.jsp"%>
    <!-- END HEADER -->
    <!-- BEGIN CONTAINER -->
    <div class="page-container row-fluid">
        <!-- BEGIN SIDEBAR -->
        <%@ include  file="../../menus.jsp"%>
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
							热门项目
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">移民官网</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/official/home/">首页设置</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>热门项目</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <%-- <ul class="nav nav-tabs">
                            	<li> <a href="/country/add?coun_id=${coun.id}&operation=${operation}">成功案例</a></li>
								<li class="active"><a href="javascript:;">移民评估</a></li>
								<li><a href="/country/countrySurvey?coun_id=${coun.countryId}">政策动态</a></li>
                            </ul> --%>
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                         <form id="sform"  class="form-horizontal" method="post">
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                         <label class="control-label">热门项目：</label>
                                                         <div class="controls" style="width: 500px;float: left;">
				                                         	<select name="project_id" id="project_id" class="selectpicker show-tick form-control" data-live-search="true">
				                                         	<c:if test="${not empty project.projectId}">
				                                         		<option value="${project.projectId}" selected="selected">${project.projectName}</option>
				                                         	</c:if>
				                                         	<c:forEach items="${projectList}" var="pro">
				                                         		<option value="${pro.projectId}">${pro.projectName}</option>
				                                         	</c:forEach>
				                                         	</select>
				                                         	</div>
                                                    </div>
                                                </div>
                                            </div>
                                  <div class="control-group" style="border:none;">
                                  	<label class="control-label">上传图片：</label>
									<div class="controls">
										<input id="preferredPic" name="preferredPic" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty project.preferredPic}">
												<img  id="preferredPicImg" src="${project.preferredPic}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty project.preferredPic}">
												<img  id="preferredPicImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:102px;height:102px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="preferred_pic" name="preferred_pic" data-label="热门项目图片(官网)"
											must-be="true" value="${project.preferredPic}" />
										 </div> 
										 </div>
									</div> 
									<div class="control-group" style="border:none;">
									<label class="control-label"></label>
										<div class="controls" >
									 		<input type="button" id="preferredPicUpImg" value="选择图片">
									 	</div>
									</div>
									<div class="control-group" >
									<label class="control-label"></label>
										<div class="controls">
								 			<span class="label label-important">图片格式</span>
                                            <span>支持jpg、png格式，尺寸500px*500px，大小在500K以内</span>
								 		</div>
									</div>
                                            <!--/row-->
                                            <c:if test="${not empty project.projectId}">
                                            	<input  id="old_project_id" name="old_project_id" type="hidden" value="${project.projectId}" />
                                            </c:if>
											<input  name="operation" type="hidden" value="${operation}" />
                                            <!--/row-->
                                            <div class="form-actions" style="background-color:#ffffff;padding-left: 100px;">
                                                <button type="button" id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</button>
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
        <!-- <script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script> -->
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
		<script src="/views/media/js/form-validate.js"></script>
        <script src="/views/media/js/app.js"></script>
        <script src="/views/media/js/form-samples.js"></script>
        <script src="/views/media/js/form-components.js"></script>
        <script src="/views/media/js/table-managed.js"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
		<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
		
        <script>
        jQuery(document).ready(function() {    

 		   App.init(); // initlayout and core plugin

 			$("#back").click(function(e) {
 				location.href="/official/home/hotProjectList";
             });
 		   
 		   
 			//提交表单
 			$("#subBtn").click(function(e) {
 				//调用验证插件，进行form表单的验证
 				//$("#sform").formValidate();
 				var project_id = $("#project_id").val();
 				var preferred_pic = $("#preferred_pic").val();
 				var old_project_id = $("#old_project_id").val();
 				$.post(
						"/official/home/addHotProject",
						{
							"project_id" : project_id,
							"preferred_pic":preferred_pic,
							"operation":"${operation}",
							"old_project_id":old_project_id
						},
						function(data) {
							if (data.code == 0) {
								alert("保存成功！");
								window.location.href="/official/home/hotProjectList"
							} else
								alert("保存失败！");
						});
             });
 		});
       
        </script>
        <!-- END JAVASCRIPTS -->
		<script type="text/javascript">
		//代表icon（官网）
		$('#preferredPic').change(function() {
			var files = $('#preferredPic').prop('files');
			console.log(files);
			var imgUrl = $("#preferred_pic").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("preferredPicUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>500*1024){
					alert("图片大小要小于500k");
					document.getElementById("preferredPicUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#preferredPicImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("preferredPicUpImg").disabled = false;
							 $('#preferred_pic').val(data.picUrl);
						}
						else {
							 $('#preferred_pic').val('');
							 document.getElementById("preferredPicUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#preferredPicUpImg').click(function(){ 
			document.getElementById("preferredPicUpImg").disabled = true;
			$('#preferredPic').click(); 
		});
		</script>
</body>
<!-- END BODY -->

</html>