<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
							优选国家
						</h3>
                        <ul class="breadcrumb">
                            <li>
                                <i class="icon-home"></i>
                                <a href="/">移民官网</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>
                                <a href="/official/home/basic">首页设置</a>
                                <span class="icon-angle-right"></span>
                            </li>
                            <li>优选国家</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">
                        <div class="tabbable tabbable-custom">
                         <c:if test="${fn:length(countryList) < 4}">
                        	<div class="portlet-title">
								<div class="actions">
									<a href="/official/home/addPreferenceCountry" class="btn blue addnew"><i class="icon-pencil"></i> 新增</a>
								</div>
							</div>
							</c:if>
                           <%--  <ul class="nav nav-tabs">
                            	<li> <a href="/country/add?coun_id=${coun.id}&operation=${operation}">成功案例</a></li>
								<li><a href="/country/countrySurvey?coun_id=${coun.countryId}">移民评估</a></li>
								<li class="active"><a href="javascript:;">政策动态</a></li>
                            </ul> --%>
                            <!-- <table border="0">
                                <tr>
									<td align="right">
										<a href="/official/home/basic/addPreferenceCountry" class="btn blue addnew"><i class=" icon-plus"></i> 新增</a>
									</td>
								</tr> 
                            </table> -->
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                         <form id="sform"  class="form-horizontal" method="post">
                                            <table class="table  table-bordered" id="para_table">
											    <tr>  
											        <th style="text-align:center" width="100">编号</th>  
											        <th style="text-align:center" width="200">国家</th>
											        <th style="text-align:center" width="200">图片</th>   
											        <th style="text-align:center" width="100">操作</th>  
											    </tr>
											    <c:if test="${not empty countryList}">
											    <c:forEach items="${ countryList }" var="country" varStatus="status">
												    <tr>  
												      <td  style="text-align:center;">${status.count}</td>
												      <td  style="text-align:center;">${country.countryName}</td>
												      <td  style="text-align:center;">
												      <div align="center">
															<c:if test="${not empty country.preferredPic}">
																<img src="${country.preferredPic}" style="width:60px;height:30px;">
															</c:if>
															<c:if test="${empty country.preferredPic}">
																<img src="/images/nopic.jpg" style="width:60px;height:30px;">
															</c:if>
														 </div>
												      </td>  
												      <td data-id="${country.id}">
												      <c:if test="${status.index != 0}">
												      	<!-- <a href="#" class="btn green-stripe mini"><i class="icon-upload">置顶</i>&nbsp;&nbsp;</a> -->
                                                    	<a href="#" class="btn green-stripe mini"><i class="icon-long-arrow-up">上移</i>&nbsp;&nbsp;</a>  
                                                      </c:if>
                                                      <c:if test="${!status.last }">	
                                                    	<a href="#" class="btn green-stripe mini"><i class="icon-long-arrow-down">下移</i>&nbsp;&nbsp;</a>
                                                      </c:if>
                                                      		<a class="btn green-stripe mini"><i class="icon-edit">编辑</i></a>
														<!--	<a class="btn purple-stripe mini"><i class="icon-trash m-icon-black">删除</i></a>	
												             <button type="button"  class="btn btn-xs btn-link" onclick="edit_to_save(this)">编辑</button>  
												        	 <button type="button"  class="btn btn-xs btn-link" onclick="deletetr(this)">删除</button> -->
												      </td>
												      <!-- <td   style="text-align:center; " onclick="deletetr(this)">  
												        <button type="button"  class="btn btn-xs btn-link">删除</button>  
												      </td>  --> 
												    </tr> 
											    </c:forEach>
											    </c:if>
											</table>
                                            <!--/row-->
											<input  name="operation" type="hidden" value="${operation}" />
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
		<script src="/views/media/js/form-validate.js"></script>
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
        <script type="text/javascript">
        
      //绑定内容编辑
		$("i.icon-edit")
				.each(
						function(index, element) {
							$(this)
									.click(
											function(e) {
												var id = $(
														this)
														.parent()
														.parent()
														.attr("data-id");
												location.href = "/official/home/addPreferenceCountry?country_id="+ id;
											});
						});
        
      //绑定置顶按钮
		$("i.icon-upload").each(function(index, element) {
			$(this).click(function(e){
				var id = $(this).parent().parent().attr("data-id");
				$.post("/official/home/countrytopsort",{"id":id},function(data){
					if(data.status==0){
						window.location.reload();
						//doRequest();
					}
					else
						alert(data.msg);
				});
			});		
        });
	
	//绑定上移按钮
		$("i.icon-long-arrow-up").each(function(index, element) {
			$(this).click(function(e){
				var id = $(this).parent().parent().attr("data-id");
				$.post("/official/home/countryupsort",{"id":id},function(data){
					if(data.status==0){
						window.location.reload();
						//doRequest();
					}
					else
						alert(data.msg);
				});
			});		
        });
	//绑定下移按钮
		$("i.icon-long-arrow-down").each(function(index, element) {
			$(this).click(function(e){
				var id = $(this).parent().parent().attr("data-id");
				$.post("/official/home/countrydownsort",{"id":id},function(data){
					if(data.status==0){
						window.location.reload();
						//doRequest();
					}
					else
						alert(data.msg);
				});
			});		
        });
        </script>

</body>
<!-- END BODY -->

</html>