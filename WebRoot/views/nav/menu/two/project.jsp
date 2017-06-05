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
    <%@ include  file="../../../navi.jsp"%>
    <!-- END HEADER -->
    <!-- BEGIN CONTAINER -->
    <div class="page-container row-fluid">
        <!-- BEGIN SIDEBAR -->
        <%@ include  file="../../../menus.jsp"%>
        <!-- END SIDEBAR -->
        <!-- BEGIN PAGE -->
        <div class="page-content">
            <!-- BEGIN PAGE CONTAINER-->
            <div class="container-fluid">
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <h3 class="page-title">
							${operation}二级菜单
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">首页</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
								<a href="/official/nav/menu">导航菜单</a> 
								<i class="icon-angle-right"></i>
							</li>
							<li>
								<a href="/official/nav/menu/two/${menu_pid}">二级菜单</a> 
								<i class="icon-angle-right"></i>
							</li>
                            <li>${operation}二级菜单</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                        <form id="sform" class="form-horizontal"  method="post">
                                            <!-- <h3 class="form-section">基本信息</h3> -->
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">一级菜单:</label>
                                                        <div class="controls" style="font-size: 14px;font-weight: normal;line-height: 25px;padding-top: 5px;color: #595959;">${pm.menuName}</div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">二级菜单:</label>
                                                        <div class="controls">
                                                            <input type="text" class="m-wrap span5" data-length="20" must-be="true" data-label="二级菜单" 
                                                              placeholder="二级菜单" name="menu_name" value="${menu.menuName}">
                                                              <span style="color:red;margin-left:10px;">*</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                 <div class="span12">
                                                     <div class="control-group">
														<label class="control-label">项目类型:</label>
														<div class="controls">
														
															<select class="m-wrap span5" tabindex="1" name="dict_code" must-be="true" data-label="项目类型" >
																<c:if test="${projectTypeList != null}">
																	<c:forEach var="item" items="${projectTypeList}">
																		<option <c:if test="${menu.dictCode==item.dictCode}">selected="selected"</c:if> value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
															
														</div>
													</div>
                                                 </div>
                                             </div>
                                             
                                             <div class="row-fluid">
                                                 <div class="span12">
                                                     <div class="control-group">
														<label class="control-label">打开方式:</label>
														<div class="controls">
														
															<c:if test="${null != modeList}">
																<c:forEach var="item" items="${modeList}" varStatus="status">
																	<label class="radio" >
																		<input type="radio" name="open_mode" value="${item.dictCode}" 
																			<c:if test="${menu.openMode==item.dictCode}">checked="checked"</c:if>
																			<c:if test="${checked != null || status.count==1}">checked="checked"</c:if>/>${item.name}
																	</label>
																</c:forEach>
															</c:if>
															
														</div>
													</div>
                                                 </div>
                                             </div>
                                             
                                            <!--/row-->
											<input  name="operation" type="hidden" value="${operation}" />
                                            <!--/row-->
                                            <div class="form-actions" style="background-color:#ffffff;padding-left: 180px;">
                                                <button type="button" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存</button>
                                                <a href="javascript:window.history.back();" type="button" class="btn" >取消</a>
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
              
            });
			
        </script>
        <!-- END JAVASCRIPTS -->

</body>
<!-- END BODY -->

</html>