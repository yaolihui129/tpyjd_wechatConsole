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
                <!-- BEGIN PAGE HEADER-->
                <div class="row-fluid">
                    <div class="span12">
                        <!-- BEGIN STYLE CUSTOMIZER -->
                       <!--  <a href="#" class="btn red" style=" float:right; margin-right:20px;margin-top:20px;"><i class=" icon-pencil" style="margin-right:5px;"></i>发布</a> -->
                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							项目管理
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
                            <li>基本信息</li>
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
                                <li><a href="javascript:alert('请先填写基本信息');">项目介绍</a></li>
                                <li><a href="javascript:alert('请先填写基本信息');">申请条件</a></li>
                                <li><a href="javascript:alert('请先填写基本信息');">办理流程</a></li>
								<li><a href="javascript:alert('请先填写基本信息');">费用详情</a></li>
								<li><a href="javascript:alert('请先填写基本信息');">材料清单</a></li>
								<li><a href="javascript:alert('请先填写基本信息');">图片/视频</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="" >
                                    <div class="portlet-body form">
                                        <!-- BEGIN FORM-->
                                        <form id="sform" class="form-horizontal" method="post" >
                                            <h3 class="form-section">基本信息</h3>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">项目名称:</label>
                                                        <div class="controls">
                                                            <input type="text" class="m-wrap span10" data-length="20" must-be="true" data-label="项目名称" placeholder="项目名称" name="project_name" />
                                                            <span style="color:red;margin-left:10px;">*</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12 ">
                                                    <div class="control-group">
                                                        <label class="control-label">项目类型:</label>
                                                        <div class="controls">
                                                            <select class="m-wrap span5" tabindex="1" name="project_type" must-be="true" data-label="项目类型" >
																<c:if test="${projectTypeList != null}">
																	<c:forEach var="item" items="${projectTypeList}">
																		<c:choose>
																			<c:when test="${!empty item.subDictionaries}">
																				<option style="font-weight:bold;" value="${item.dictCode}">${item.name}</option>
																				<c:forEach var="sub" items="${item.subDictionaries}">
																					<option  value="${sub.dictCode}">&nbsp&nbsp&nbsp&nbsp${sub.name}</option>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																					<option style="font-weight:bold;" value="${item.dictCode}">${item.name}</option>
																			</c:otherwise>
																		</c:choose>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:10px;">*</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">所在国家:</label>
                                                        <div class="controls">
                                                            <select id="countryCode" must-be="true" data-label="所在国家"  class="m-wrap span5" tabindex="1" name="country">
                                                            	<option value="">国家列表</option>
																<c:if test="${countryList != null}" >
																	<c:forEach var="item" items="${countryList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <select id="cityCode" class="m-wrap span5" tabindex="1" name="city">
                                                            	<option value="">城市列表</option>
															</select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">签证类型:</label>
                                                        <div class="controls">
                                                            <select class="m-wrap span5" tabindex="1" name="visa_type" must-be="true" data-label="签证类型" >
																<c:if test="${visaTypeList != null}" >
																	<c:forEach var="item" items="${visaTypeList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" data-label="签证类型描述"  class="m-wrap span5" placeholder="用于描述当前签证" name="visa_type_description">
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">居住要求:</label>
                                                        <div class="controls">
                                                            <select class="m-wrap span5" tabindex="1" name="live_requirement" must-be="true" data-label="居住要求" >
																<c:if test="${liveRequirementList != null}" >
																	<c:forEach var="item" items="${liveRequirementList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" data-label="居住要求描述"  class="m-wrap span5" placeholder="填写具体居住要求" name="live_requirement_description">
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">投资金额:</label>
                                                        <div class="controls">
                                                            <input type="text" data-length="20" class="m-wrap span5" must-be="true" data-label="投资金额"  placeholder="填写具体投资额度及单位，如50万美金" name="investments" /> <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">资产要求:</label>
                                                        <div class="controls">
                                                        	<select class="m-wrap span5" tabindex="1" name="asset" must-be="true" data-label="资产要求" >
																<c:if test="${assetList != null}" >
																	<c:forEach var="item" items="${assetList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" class="m-wrap span5" data-label="资产要求描述"  placeholder="对此资产有要求补充描述" name="asset_description"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">管理经验:</label>
                                                        <div class="controls">
                                                        	<select class="m-wrap span5" tabindex="1" name="manage" must-be="true" data-label="管理经验" >
																<c:if test="${manageList != null}" >
																	<c:forEach var="item" items="${manageList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" class="m-wrap span5" data-label="管理经验描述"  placeholder="对此管理经验要求补充描述" name="manage_description"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">学历要求:</label>
                                                        <div class="controls">
                                                        	<select class="m-wrap span5" tabindex="1" name="qualifications" must-be="true" data-label="学历要求" >
																<c:if test="${qualificationsList != null}" >
																	<c:forEach var="item" items="${qualificationsList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" class="m-wrap span5" data-label="学历要求描述"  placeholder="对此学历要求补充描述" name="qualifications_description"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span6">
                                                    <div class="control-group">
                                                        <label class="control-label">总体花费:</label>
                                                        <div class="controls">
                                                            <input must-be="true" data-label="总体花费"  data-min="0"   type="text" class="m-wrap span6" placeholder="填写项目大概花费，单位万元" name="immigration_budget">
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <em style="font-size: 14px;font-weight: normal;line-height: 35px;padding-top: 5px;color: #595959;font-style: normal;">万元</em>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">语言要求:</label>
                                                        <div class="controls">
                                                        	<select class="m-wrap span5" tabindex="1" name="language" must-be="true" data-label="语言要求" >
																<c:if test="${languageList != null}" >
																	<c:forEach var="item" items="${languageList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" class="m-wrap span5" data-label="语言要求描述"  placeholder="对此要求补充描述" name="language_description"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">年龄要求:</label>
                                                        <div class="controls">
                                                        	<select class="m-wrap span5" tabindex="1" name="age" must-be="true" data-label="年龄要求" >
																<c:if test="${ageList != null}" >
																	<c:forEach var="item" items="${ageList}">
																		<option value="${item.dictCode}">${item.name}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                            <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                            <input type="text" data-length="20" class="m-wrap span5" data-label="年龄要求描述" placeholder="对此要求补充描述" name="age_description"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">其他要求:</label>
                                                        <div class="controls">
                                                            <input type="text" data-length="20" data-label="其他要求" class="m-wrap span10" placeholder="对于项目申请的其他要求" name="other_description"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                                                                        
                                            <div class="control-group">
                                                 <label class="control-label">推荐指数:</label>
                                                 <div class="controls">
                                                     <span class="js-star icon-star onstar" style="margin-top:10px; font-size:30px;"></span>
                                                     <span class="js-star icon-star onstar" style="margin-top:10px;font-size:30px; "></span>
                                                     <span class="js-star icon-star onstar" style="margin-top:10px;font-size:30px;"></span>
                                                     <span class="js-star icon-star onstar" style="margin-top:10px;font-size:30px;"></span>
                                                     <span class="js-star icon-star onstar" style="margin-top:10px;font-size:30px;"></span>
                                                     <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
                                                 </div>
                                                 <input class="js-star-num" type="hidden" name="recommended" value="5" />
                                             </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">项目简介:</label>
                                                        <div class="controls">
                                                            <textarea data-length="300" data-label="项目简介" class="span10 m-wrap" rows="6" name="introduce"></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">项目优势:</label>
                                                        <div class="controls">
                                                            <textarea class="span10 m-wrap" data-length="200" data-label="项目优势"  rows="6" name="advantage"></textarea>
                                                        	<p style="float: left;margin:5px 0 0 10%;">填写说明：请分项录入项目优势，每项以英文分号；分隔</p>
                                                        	<div class="btn-group" style="top:3px;float:left;left:30px;">
																<a class="btn" href="javascript:;" data-toggle="dropdown">查看示例
																	<i class="icon-angle-down"></i>
																</a>
																<ul class="dropdown-menu" style="padding:10px 18px;">
																	<li>申请人无需参与项目经营；</li>
																	<li>美国拥有世界最好的教育资源、就业及经商环境；</li>
																	<li>美国无移民监限制，通行便利；</li>
																	<li>一人申请全家移民</li>
																</ul>
															</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
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
	                                                                            <img id="showImg" src="" alt="" />
	                                                                            <input id="pdtPic" name="pdtPic" multiple accept="image/*" type="file" style="display: none;">
	                                                                            <input  must-be="true" data-label="封面图片"  type="hidden" id="project_img" name="project_img" />
	                                                                        </div>
	                                                                        <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
	                                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 260px; max-height: 96px; line-height: 20px;"></div>
	                                                                    </div>
	                                                                    <div class="span5">
	                                                                         <input type="button" id="selectInfoImg" value="选择图片">
	                                                                         <div style="margin-top:10px;">
			                                                                    <span class="label">图片格式:</span>
			                                                                    <span>支持jpg、png格式，尺寸650*240px，大小在100K以内</span>
		                                                                    </div>
	                                                                   </div>
                                                                 </div>
                                                                 <div class="row-fluid span9">
                                                                		 <label class="control-label">官网图片:</label>
                                                                		 <div class="fileupload fileupload-new span4">
	                                                                        <div class="fileupload-new thumbnail" style="width: 320px; height: 220px;">
	                                                                            <img id="show_web_project_img" src="" alt="" />
	                                                                            <input id="pdt_web_project_img" name="pdt_web_project_img" multiple accept="image/*" type="file" style="display: none;">
	                                                                            <input  must-be="true" data-label="封面图片"  type="hidden" id="web_project_img" name="web_project_img" />
	                                                                        </div>
	                                                                        <span style="color:red;margin-left:5px;margin-right:5px;">*</span>
	                                                                        <div class="fileupload-preview fileupload-exists thumbnail" style="max-width: 320px; max-height: 220px; line-height: 20px;"></div>
	                                                                    </div>
	                                                                    <div class="span5">
	                                                                         <input type="button" id="select_web_project_img" value="选择图片">
	                                                                         <div style="margin-top:10px;">
			                                                                    <span class="label">图片格式:</span>
			                                                                    <span>支持jpg、png格式，尺寸320*220px，大小在500K以内</span>
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
                                                     <div class="control-group">
														<label class="control-label">项目级别:</label>
														<div class="controls span9">
															<label class="radio" >
																<input type="radio" id="project_level_one" name="project_level" value="${project_level_one}"  checked="checked"/>一级项目
															</label>
															<label class="radio" >
																<input type="radio" id="project_level_two" name="project_level" value="${project_level_two}" />二级项目
															</label>
														</div>
													</div>
                                                 </div>
                                             </div>
                                             
                                             <div id="bind_project" class="row-fluid" >
                                                <div class="span12">
                                                    <div class="control-group">
                                                        <label class="control-label">关联一级项目:</label>
                                                        <div class="controls">
                                                        	<select id="bind_project_pid" class="span4 chosen" data-placeholder="Choose a Category" tabindex="1" name="project_pid">
				                                         		<option value="" />请选择</option>
																<c:if test="${levelProjectList != null}" >
																	<c:forEach var="item" items="${levelProjectList}">
																		<option value="${item.projectId}" >${item.projectName}</option>
																	</c:forEach>
																</c:if>
															</select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!--/span-->
                                            </div>
                                             
                                             
                                            <div class="row-fluid">
                                               <div class="span12">
                                                    <div class="control-group">
                                                    	<label class="control-label">扩展推荐:</label>
														<div class="controls" style="padding-left:170px;">
															<c:if test="${expandsList != null}">
																<c:forEach var="item" items="${expandsList}">
																	<label class="checkbox" style="display:inline-block;padding-right:30px !important;">
																		<input type="checkbox" name="project_expands" value="${item.dictCode}" /> ${item.name}
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
                                                <a href="/project" type="button" class="btn" >取消</a>
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
				
				$("#bind_project").hide();
			});
			
			//微站图片
			$('#pdtPic').change(function() {
				var files = $('#pdtPic').prop('files');
				var imgUrl = $("#project_img").val();
				for(var m=0;m<files.length;m++){
					if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
			            alert("图片类型必须是.jpeg,jpg,png中的一种");
			            document.getElementById("selectInfoImg").disabled = false;
			            return false;  
			        }
					if(files[m].size>100*1024){
						alert("图片大小要小于100k");
						document.getElementById("selectInfoImg").disabled = false;
						return false;
					}
					lrz(files[m],{quality :0.3})
					  .then(function (rst) {
						var filename = rst.origin.name;
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								console.log(data);
								if(data.status==0){
									 $('#showImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("selectInfoImg").disabled = false;
									 $('#project_img').val(data.picUrl);
								}
								else {
									 $('#project_img').val('');
									 document.getElementById("selectInfoImg").disabled = false;
									alert(data.msg);
								}
							});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
					}
			});
			$('#selectInfoImg').click(function(){
				document.getElementById("selectInfoImg").disabled = true;
				$('#pdtPic').click();
			});
			
			//官网图片
			$('#pdt_web_project_img').change(function() {
				var files = $('#pdt_web_project_img').prop('files');
				var imgUrl = $("#web_project_img").val();
				for(var m=0;m<files.length;m++){
					if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
			            alert("图片类型必须是.jpeg,jpg,png中的一种");
			            document.getElementById("select_web_project_img").disabled = false;
			            return false;  
			        }
					if(files[m].size>500*1024){
						alert("图片大小要小于500k");
						document.getElementById("select_web_project_img").disabled = false;
						return false;
					}
					lrz(files[m],{quality :1})
					  .then(function (rst) {
						var filename = rst.origin.name;
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#show_web_project_img').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("select_web_project_img").disabled = false;
									 $('#web_project_img').val(data.picUrl);
								}
								else {
									 $('#web_project_img').val('');
									 document.getElementById("select_web_project_img").disabled = false;
									alert(data.msg);
								}
							});
					  })
					  .always(function () {
						  // 不管是成功失败，都会执行
					  });
					}
			});
			$('#select_web_project_img').click(function(){
				document.getElementById("select_web_project_img").disabled = true;
				$('#pdt_web_project_img').click();
			});
		
			//星星评价
            $(".js-star").on("click", function () { 
                var index = $(this).index();
                $(".js-star-num").val(index + 1);
                $(this).siblings().removeClass("onstar");
                for (var i = 0; i <= index; i++) {
                    $(".js-star").eq(i).addClass("onstar");
                }
            });
            
            $("#countryCode").change(function(){
            	$("#cityCode").empty();
            	$("#cityCode").append("<option value=''>城市列表</option>");
            	if($(this).val()) {
	            	$.post("/utils/getCity", {"country_code":$(this).val()}, function(data){
	             		if(data.status==0) {
	             			var obj = data.citys;
	             			var html="";
	             			if(obj.length) {
	             				for(var i=0; i<obj.length; i++) {
	             					html+='<option value="'+obj[i].dict_code+'">'+obj[i].name+'</option>';
	             				}
	             				$("#cityCode").empty();
	             				$("#cityCode").append("<option value=''>城市列表</option>"+html);
	             			}
	            		} else {
	            			alert(data.msg);
	            		}
	            	});
            	}
            });
            
            $("#project_level_one").click(function(e) {
            	$("#bind_project").hide();
            	$("#bind_project_pid").val("");
            });
			$("#project_level_two").click(function(e) {
				$("#bind_project").show();
            });
		</script>

</body>
<!-- END BODY -->

</html>