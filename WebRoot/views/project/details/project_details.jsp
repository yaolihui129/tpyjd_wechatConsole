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

    <!-- END PAGE LEVEL SCRIPTS -->
    <link rel="shortcut icon" href="/views/media/image/favicon.ico" />
    <style>
        .js-star {
            color: #ccc;
        }
        .onstar {
            color: #f5ba5e;
        }
        
        .controls-text {
        	font-size: 14px;
        	font-weight: normal;
        	line-height: 25px;
        	padding-top: 5px;
        	color: #595959;
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
                        <!-- BEGIN STYLE CUSTOMIZER -->
                        
                        <a href="javascript:;" class="btn red" style="float:right; margin-right:20px;margin-top:20px;" onclick="release();"><i class=" icon-pencil" style="margin-right:5px;"></i>发布</a>
                        <a href="${OFFICIAL_URL}" target="_blank" class="btn yellow" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-pencil" style="margin-right:5px;"></i>预览</a>
                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							项目详情
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">首页</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/project">项目管理</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>项目详情_基本信息</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="javascript:;" >基本信息</a></li>
                                <li><a href="/project/details/intro/${project.projectId}">项目介绍</a></li>
                                <li><a href="/project/details/applyc/${project.projectId}">申请条件</a></li>
                                <li><a href="/project/details/applyp/${project.projectId}">办理流程</a></li>
								<li><a href="/project/details/cost/${project.projectId}">费用详情</a></li>
								<li><a href="/project/details/material/${project.projectId}">材料清单</a></li>
								<li><a href="/project/details/resource/${project.projectId}">图片/视频</a></li>
								<c:if test="${subProject>0}">
									<li><a href="/project/details/subProject/${project.projectId}">二级项目</a></li>
								</c:if>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                        <form id="sform" class="form-horizontal">
                                            <h3 class="form-section">基本信息</h3>
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">项目名称:</label>
                                                        <div class="controls controls-text" >
                                                            ${project.projectName}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">项目类型:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${projectType != null}" >
																	${projectType}
																</c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">项目状态:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${projectStatus != null}" >
																	${projectStatus}
																</c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">项目编号:</label>
                                                        <div class="controls controls-text" >
                                                            ${project.projectCode}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                                                        
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">所在国家:</label>
                                                        <div class="controls controls-text" >
                                                        		<c:if test="${country != null}" >
																	${country}
																</c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">所在城市:</label>
                                                        <div class="controls controls-text" >
                                                        		<c:if test="${city != null}" >
																	${city}
																</c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">签证类型:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${visaType != null}" >
																	${visaType}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.visaTypeDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">居住要求:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${liveRequirement != null}" >
																	${liveRequirement}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.liveRequirementDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">投资金额:</label>
                                                        <div class="controls controls-text" >
                                                            ${project.investments}
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">资产要求:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${asset != null}" >
																	${asset}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.assetDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">管理经验:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${manage != null}" >
																	${manage}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.manageDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">学历要求:</label>
                                                        <div class="controls controls-text" >
																<c:if test="${qualifications != null}" >
																	${qualifications}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.qualificationsDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">总体花费:</label>
                                                        <div class="controls controls-text" >
                                                            ${project.immigrationBudget}万元
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">语言要求:</label>
                                                        <div class="controls controls-text" >
                                                        		<c:if test="${language != null}" >
																	${language}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.languageDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">年龄要求:</label>
                                                        <div class="controls controls-text" >
                                                        		<c:if test="${age != null}" >
																	${age}
																</c:if>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            ${project.ageDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">其他要求:</label>
                                                        <div class="controls controls-text" >
                                                        	${project.otherDescription}
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                                                       
                                            <div class="control-group">
                                                 <label class="control-label">推荐指数:</label>
                                                 <div class="controls">
                                                 	
                                                     <span class="js-star icon-star <c:if test='${project.recommended ==1 || project.recommended>1}'>onstar</c:if>" style="margin-top:10px; font-size:30px;"></span>
                                                     <span class="js-star icon-star <c:if test='${project.recommended ==2 || project.recommended>2}'>onstar</c:if>" style="margin-top:10px;font-size:30px; "></span>
                                                     <span class="js-star icon-star <c:if test='${project.recommended ==3 || project.recommended>3}'>onstar</c:if>" style="margin-top:10px;font-size:30px;"></span>
                                                     <span class="js-star icon-star <c:if test='${project.recommended ==4 || project.recommended>4}'>onstar</c:if>" style="margin-top:10px;font-size:30px;"></span>
                                                     <span class="js-star icon-star <c:if test='${project.recommended ==5 || project.recommended>5}'>onstar</c:if>" style="margin-top:10px;font-size:30px;"></span>
                                                     
                                                     <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                 </div>
                                             </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">项目简介:</label>
                                                        <div class="controls controls-text" >
                                                            <p>${project.introduce}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">项目特点:</label>
                                                        <div class="controls controls-text" >
                                                            <p>${project.advantage}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <%-- <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="portlet-body form">
                                                        <!-- BEGIN FORM-->
                                                            <div class="control-group">
                                                                <label class="control-label">封面图片:</label>
                                                                <div class="controls">
                                                                    <div class="fileupload fileupload-new">
                                                                        <div class="fileupload-new thumbnail" style="width: 260px; height: 96px;">
                                                                            <img id="showImg" src="${project.projectImg}" alt="" />
                                                                        </div>
                                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 96px; line-height: 20px;"></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        <!-- END FORM-->
                                                    </div>
                                                </div>
                                            </div> --%>
                                            
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="portlet-body form">
                                                            <div class="control-group">
                                                                <label class="control-label">封面图片:</label>
                                                                <div class="controls">
                                                                	<label class="span12"></label>
                                                                	<div class="row-fluid span8">
                                                                		 <label class="control-label">微站图片:</label>
                                                                		 <div class="fileupload fileupload-new span4">
	                                                                        <div class="fileupload-new thumbnail" style="width: 260px; height: 96px;">
	                                                                            <img id="showImg" src="${project.projectImg}" alt="" />
	                                                                        </div>
	                                                                        <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
	                                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 96px; line-height: 20px;"></div>
	                                                                    </div>
                                                                 </div>
                                                                 <div class="row-fluid span8">
                                                                		 <label class="control-label">官网图片:</label>
                                                                		 <div class="fileupload fileupload-new span4">
	                                                                        <div class="fileupload-new thumbnail" style="width: 260px; height: 96px;">
	                                                                            <img id="show_web_project_img" src="${project.webProjectImg}" alt="" />
	                                                                        </div>
	                                                                        <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
	                                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 96px; line-height: 20px;"></div>
	                                                                    </div>
                                                                 </div>
                                                             </div>
                                                         </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">项目级别:</label>
                                                        <div class="controls controls-text" >
                                                            <p>${projectLevelName}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <c:if test="${projectPName != null}">
	                                            <div class="row-fluid">
	                                                <div class="span12">
	                                                    <div class="control-group">
	                                                        <label class="control-label">关联项目:</label>
	                                                        <div class="controls controls-text" >
	                                                            <p>${projectPName}</p>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <!--/span-->
	                                            </div>
                                            </c:if>
                                            
                                            <c:if test="${project_expands_name != null}">
	                                            <div class="row-fluid">
	                                                <div class="span12">
	                                                    <div class="control-group">
	                                                        <label class="control-label">扩展推荐:</label>
	                                                        <div class="controls controls-text" >
	                                                            <p>${project_expands_name}</p>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                                <!--/span-->
	                                            </div>
                                            </c:if>
                                            
                                            <!--/row-->
                                            <!--/row-->
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
</body>
<!-- END BODY -->

	<script type="text/javascript">
	 	function release() {
			$.post("/project/details/release/${project.projectId}", function(data){
				if(data.status==0) {
					alert(data.msg);
					window.location.reload();
				} else {
					alert(data.msg);
				}
			})
		}
	</script>
</html>