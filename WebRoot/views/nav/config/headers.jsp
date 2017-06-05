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
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no" name="viewport" id="viewport">
    <meta name="screen-orientation" content="portrait" />
    <!-- 避免缓存cache -->
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    
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
    <link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="/views/media/css/chosen.css" />
    <!-- END PAGE LEVEL SCRIPTS -->
    <link rel="shortcut icon" href="/views/media/image/favicon.ico" />
    <style>
        .js-star {
            color: #ccc;
        }
        .onstar {
            color: #f5ba5e;
        }
    </style>
    
    
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
                        <h3 class="page-title">
							通用设置
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">首页</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="javascript:;">导航设置</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>通用设置</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="javascript:;" >顶部管理</a></li>
								<li><a href="/official/nav/config/footers">底部管理</a></li>
								<li><a href="/official/nav/config/copyright">版权资质</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                        <form id="sform" class="form-horizontal"  method="post">
                                            <!-- <h3 class="form-section">基本信息</h3> -->
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="portlet-body form">
                                                            <div class="control-group">
                                                                <label class="control-label">官网Logo:</label>
                                                                <div class="controls">
                                                                    <div class="fileupload fileupload-new">
                                                                        <div class="fileupload-new thumbnail" style="width: 455px; height: 46px;float:left;">
                                                                            <img id="show_logo_img" src="${headers.logoImg}" alt="" />
                                                                            <input id="pdt_logo_img" name="pdt_logo_img" multiple accept="image/*" type="file" style="display: none;">
                                                                            <input must-be="true" data-label="封面图片"  type="hidden" id="logo_img" name="logo_img" value="${headers.logoImg}"/>
                                                                        </div>
                                                                        <div class="span5">
	                                                                         <input type="button" id="select_logo_img" value="选择图片">
	                                                                         <div style="margin-top:10px;">
			                                                                    <span class="label">图片格式:</span>
			                                                                    <span>支持jpg、png格式，尺寸455*46px，大小在100K以内</span>
		                                                                    </div>
	                                                                   </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">客服电话:</label>
                                                        <div class="controls">
                                                            <input type="text" class="m-wrap span2" data-length="20" must-be="true" data-label="客服电话" 
                                                              placeholder="客服电话" name="phone" value="${headers.phone}">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="portlet-body form">
                                                            <div class="control-group">
                                                                <label class="control-label">微信关注:</label>
                                                                <div class="controls">
                                                                	<label class="span10"></label>
                                                                	<div class="row-fluid span8" style="margin-bottom:15px;">
                                                                		 <label class="control-label">图片描述:</label>
                                                                		 <div class="controls">
                                                                		 	<input type="text" class="m-wrap span5" data-length="15" must-be="true" data-label="图片描述" 
                                                            							  placeholder="关注公众号" name="wx_img_one_description" value="${headers.wxImgOneDescription}">
                                                                		 </div>
                                                                	</div>
                                                                	
                                                                	<div class="row-fluid span8">
                                                                		 <label class="control-label">上传图片:</label>
                                                                		 <div class="controls">
	                                                                		 <div class="fileupload fileupload-new span10">
		                                                                        <div class="fileupload-new thumbnail span6" style="width: 120px; height: 120px;">
		                                                                            <img id="show_wx_img_one" src="${headers.wxImgOne}" alt="" />
		                                                                            <input id="pdt_wx_img_one" name="pdt_wx_img_one" multiple accept="image/*" type="file" style="display: none;">
		                                                                            <input  must-be="true" data-label="上传图片"  type="hidden" id="wx_img_one" name="wx_img_one" value="${headers.wxImgOne}"/>
		                                                                        </div>
			                                                                    <div class="span6">
			                                                                         <input type="button" id="select_wx_img_one" value="选择图片">
			                                                                         <div style="margin-top:10px;">
					                                                                    <span class="label">图片格式:</span>
					                                                                    <span>支持jpg、png格式，大小在100K以内</span>
				                                                                    </div>
			                                                                   </div>
	                                                                   		</div>
	                                                                   </div>
                                                                 </div>
                                                                 
                                                                 <div class="row-fluid span8" style="margin-bottom:15px;">
                                                               		 <label class="control-label">图片描述:</label>
                                                               		 <div class="controls">
                                                               		 	<input type="text" class="m-wrap span5" data-length="15" must-be="true" data-label="图片描述" 
                                                             					placeholder="关注公众号" name="wx_img_two_description" value="${headers.wxImgTwoDescription}">
                                                               		 </div>
                                                               	</div>
                                                                	
                                                                 <div class="row-fluid span8">
                                                                		 <label class="control-label">上传图片:</label>
                                                                		 <div class="controls">
	                                                                		 <div class="fileupload fileupload-new span10">
		                                                                        <div class="fileupload-new thumbnail span6" style="width: 120px; height: 120px;">
		                                                                            <img id="show_wx_img_two" src="${headers.wxImgTwo}" alt="" />
		                                                                            <input id="pdt_wx_img_two" name="pdt_wx_img_two" multiple accept="image/*" type="file" style="display: none;">
		                                                                            <input  must-be="true" data-label="上传图片"  type="hidden" id="wx_img_two" name="wx_img_two" value="${headers.wxImgTwo}"/>
		                                                                        </div>
			                                                                    <div class="span6">
			                                                                         <input type="button" id="select_wx_img_two" value="选择图片">
			                                                                         <div style="margin-top:10px;">
					                                                                    <span class="label">图片格式:</span>
					                                                                    <span>支持jpg、png格式，大小在100K以内</span>
				                                                                    </div>
			                                                                   </div>
	                                                                	</div>
	                                                                </div>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                    </div>
                                                </div>
                                            </div>
                                             
                                             <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="portlet-body form">
                                                            <div class="control-group">
                                                                <label class="control-label">直接联系:</label>
                                                                <div class="controls">
                                                                    <div class="fileupload fileupload-new">
                                                                        <div class="fileupload-new thumbnail" style="width: 120px; height: 120px;float:left;">
                                                                            <img id="show_contact_img" src="${headers.contactImg}" alt="" />
                                                                            <input id="pdt_contact_img" name="pdt_contact_img" multiple accept="image/*" type="file" style="display: none;">
                                                                            <input must-be="true" data-label="封面图片"  type="hidden" id="contact_img" name="contact_img" value="${headers.contactImg}"/>
                                                                        </div>
                                                                        <div class="span5">
	                                                                         <input type="button" id="select_contact_img" value="选择图片">
	                                                                         <div style="margin-top:10px;">
			                                                                    <span class="label">图片格式:</span>
			                                                                    <span>支持jpg、png格式，大小在100K以内</span>
		                                                                    </div>
	                                                                   </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!--/row-->
											<input  name="page_headers_id" type="hidden" value="${headers.pageHeadersId}" />
											<input  name="operation" type="hidden" value="${operation}" />
                                            <!--/row-->
                                            <div class="form-actions" style="background-color:#ffffff;padding-left: 180px;">
                                                <button type="button" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存</button>
                                                <!-- <a href="javascript:window.history.back();" type="button" class="btn" >取消</a> -->
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
        <script type="text/javascript" src="/views/media/js/chosen.jquery.min.js"></script>
        <script type="text/javascript" src="/views/media/js/select2.min.js"></script>
        <script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
        <script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="/views/media/js/app.js"></script>
        <script src="/views/media/js/form-samples.js"></script>
        <script src="/views/media/js/form-components.js"></script>
        <script src="/views/media/js/table-managed.js"></script>
        <script src="/views/media/js/form-validate.js"></script>
        <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->

        <script>
	       
        
            jQuery(document).ready(function () {
            	
                // initiate layout and plugins
                App.init();
                
              //提交表单
				$("#subBtn").click(function(e) {
					//调用验证插件，进行form表单的验证
					$("#sform").formValidate();
	            });
              
				var status = '${status}';
            	if(status && status==1) {
            		alert("保存成功！");
            	}
            	
            });
            
			
			//图片 logo_img
			$('#pdt_logo_img').change(function() {
				loadImg ("pdt_logo_img", "logo_img", "select_logo_img", "show_logo_img");
			});
			$('#select_logo_img').click(function(){
				document.getElementById("select_logo_img").disabled = true;
				$('#pdt_logo_img').click();
			});
			
			$('#pdt_wx_img_one').change(function() {
				loadImg ("pdt_wx_img_one", "wx_img_one", "select_wx_img_one", "show_wx_img_one");
			});
			$('#select_wx_img_one').click(function(){
				document.getElementById("select_wx_img_one").disabled = true;
				$('#pdt_wx_img_one').click();
			});
			
			$('#pdt_wx_img_two').change(function() {
				loadImg ("pdt_wx_img_two", "wx_img_two", "select_wx_img_two", "show_wx_img_two");
			});
			$('#select_wx_img_two').click(function(){
				document.getElementById("select_wx_img_two").disabled = true;
				$('#pdt_wx_img_two').click();
			});
			
			$('#pdt_contact_img').change(function() {
				loadImg ("pdt_contact_img", "contact_img", "select_contact_img", "show_contact_img");
			});
			$('#select_contact_img').click(function(){
				document.getElementById("select_contact_img").disabled = true;
				$('#pdt_contact_img').click();
			});
			
			//上传图片
			function loadImg (pdt, imgurl, select, show) {
				var files = $('#'+pdt).prop('files');
				var imgUrl = $("#"+imgurl).val();
				for(var m=0;m<files.length;m++){
					if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
			            alert("图片类型必须是.jpeg,jpg,png中的一种");
			            document.getElementById(select).disabled = false;
			            return false;  
			        }
					if(files[m].size>100*1024){
						alert("图片大小要小于100k");
						document.getElementById(select).disabled = false;
						return false;
					}
					lrz(files[m],{quality :1})
					  .then(function (rst) {
						var filename = rst.origin.name;
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#'+show).attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById(select).disabled = false;
									 $('#'+imgurl).val(data.picUrl);
								}
								else {
									 $('#'+imgurl).val('');
									 document.getElementById(select).disabled = false;
									alert(data.msg);
								}
							});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
					}
			}
			
			
        </script>
        <!-- END JAVASCRIPTS -->

</body>
<!-- END BODY -->

</html>