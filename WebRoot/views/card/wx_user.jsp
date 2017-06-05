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
    
    <link rel="stylesheet" type="text/css" href="/views/media/css/chosen.css" />
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
    <link rel="stylesheet" href="/views/media/css/DT_bootstrap.css" />

    <!-- END PAGE LEVEL SCRIPTS -->
    <link rel="shortcut icon" href="/views/media/image/favicon.ico" />
    <style>
        .controls-text {
        	font-size: 14px;
        	font-weight: normal;
        	line-height: 25px;
        	padding-top: 5px;
        	color: #595959;
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

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
                 <div class="span12">
                     <ul class="breadcrumb" style="margin-top:10px; background-color: #fff;">
                         <li>
                             <i class="icon-home"></i>
                             <a href="/">首页</a>
                             <span class="icon-angle-right"></span>
                         </li>
                         <li>
                             <a href="/data/cardresource">微信用户设置</a>
                             <span class="icon-angle-right"></span>
                         </li>
                         <li>微信用户绑定</li>
                     </ul>
                 </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->
                <div class="row-fluid">
                         <form id="sform" class="form-horizontal">
                             <h3 class="form-section">微信用户绑定</h3>
                             
                             <div class="row-fluid">
                             	<div class="span6">
                               <div class="row-fluid">
                                   <div class="span12 ">
                                       <div class="control-group">
                                           <label class="control-label">微信昵称：</label>
                                           <div class="controls controls-text" >
                                           	<script type="text/javascript">
											         document.write(decodeURI("${weixin.wxName}"));
											</script>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                               
                               <div class="row-fluid">
                                   <div class="span12 ">
                                       <div class="control-group">
                                           <label class="control-label">openID：</label>
                                           <div class="controls controls-text" >
                                               ${weixin.openid}
                                           </div>
                                       </div>
                                   </div>
                               </div>
                              </div>
                              <div class="span6">
                              	<img style="width:80px;height:80px;" src="${weixin.headImg}">
                              </div>
                             </div>
                             
                             <div class="row-fluid">
                                 <div class="span12 ">
                                     <div class="control-group">
                                         <label class="control-label">对应用户：</label>
                                         <div class="controls">
                                         	<select id="userBind" class="span4 chosen" data-placeholder="Choose a Category" tabindex="1">
                                         		<option data-m="" data-n="" value="" />请选择</option>
												<c:if test="${userList != null}" >
													<c:forEach var="item" items="${userList}">
														<option value="${item.user_id}" data-m="${item.phone}" data-n="${item.user_name}"  
															<c:if test="${item.user_id==user.userId}">selected="selected"</c:if>>${item.user_name}－${item.dep_name}－${item.com_name}</option>
													</c:forEach>
												</c:if>
											</select>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                             
                             <div class="row-fluid">
                                 <div class="span12 ">
                                     <div class="control-group">
                                         <label class="control-label">绑定用户姓名：</label>
                                         <div class="controls controls-text"  id="showName">
                                         	${user.userName}
                                         </div>
                                     </div>
                                 </div>
                             </div>
                             
                             <div class="row-fluid">
                                 <div class="span12 ">
                                     <div class="control-group">
                                         <label class="control-label">绑定用户手机号：</label>
                                         <div class="controls controls-text"  id="showMobile">
                                         	${user.phone}
                                         </div>
                                     </div>
                                 </div>
                             </div>
                            	<input type="hidden" id="user_id" must-be="true" data-label="绑定用户姓名"  name="user_id" value="${user.userId}"/>
                                <input type="hidden" name="operation" value="${operation}" />
                             
                             <div class="form-actions" style="background-color:#ffffff;padding-left: 180px;">
                                 <a href="javascript:;" class="btn blue" id="subBtn"><i class="icon-ok"></i> 绑定</a>
                                 <a href="/data/cardresource" type="button" class="btn" >取消</a>
                             </div>
                         </form>
                         <!-- END FORM-->
                     </div>
                     
                     
                     
                 </div>
             </div>
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

			jQuery(document).ready(function() {    
	
			   App.init(); // initlayout and core plugin
	
				$("#back").click(function(e) {
	                window.history.back();
	            });
				
				//提交表单
				$("#subBtn").click(function(e) {
					//调用验证插件，进行form表单的验证
					$("#sform").formValidate();
	            });
				
				if(null != '${status}' && '${status}'==1) {
					alert("此用户已绑定");
				}
			});

			
			$('#userBind').change(function(){
				//console.log("id="+$(this).val()+"--m="+$(this).children('option:selected').attr("data-m")+"--n="+$(this).children('option:selected').attr("data-n"));
				var id = $(this).val(),
					mobile = $(this).children('option:selected').attr("data-m"),
					name = $(this).children('option:selected').attr("data-n");
				
				$('#user_id').val(id);
				$('#showName').text(name);
				$('#showMobile').text(mobile);
			});
		</script>

</body>
<!-- END BODY -->

</html>