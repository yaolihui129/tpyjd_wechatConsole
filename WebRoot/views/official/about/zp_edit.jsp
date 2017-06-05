<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->
<!-- BEGIN HEAD -->
<head>

	<meta charset="utf-8" />
	<title>太平洋加达出国－后台管理系统 v1.0</title>
	<meta content="width=device-width, initial-scale=1.0" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	
	<!-- BEGIN GLOBAL MANDATORY STYLES -->
	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>
	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
	<link href="/views/media/css/uniform.default.css" rel="stylesheet" type="text/css"/>
	<!-- END GLOBAL MANDATORY STYLES -->
	
	<!-- BEGIN PAGE LEVEL STYLES --> 
	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
	<!-- END PAGE LEVEL SCRIPTS -->

	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />
	
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>

</head>
<!-- END HEAD -->

<!-- BEGIN BODY -->
<body class="page-header-fixed">
	<!-- BEGIN HEADER -->

	<%@ include file="/views/navi.jsp"%>

	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->
	<div class="page-container row-fluid">
		<!-- BEGIN SIDEBAR -->

		<%@ include file="/views/menus.jsp"%>

		<!-- END SIDEBAR -->
	

		<!-- BEGIN PAGE -->  
		<div class="page-content">

			<!-- BEGIN PAGE CONTAINER-->
			<div class="container-fluid">
				<!-- BEGIN PAGE HEADER-->   
				<div class="row-fluid">
					<div class="span12">
						
						<h3 class="page-title">
							诚聘英才-${operation }
							 <small></small>
						</h3>

						<ul class="breadcrumb">
							<li>
								<i class="icon-home"></i>
								<a href="/">首页</a> 
								<span class="icon-angle-right"></span>
							</li>

							<li>
								移民官网
								<span class="icon-angle-right"></span>
								诚聘英才
								<span class="icon-angle-right"></span>
								${operation }
							</li>
						</ul>
					</div>
				</div>

				<!-- END PAGE HEADER-->

				<!-- BEGIN PAGE CONTENT-->
				
				<div class="tab-content">
					<!-- 会员信息 开始 -->
					<div class="tab-pane active" id="tab_1">
						<div class="portlet box green">
							<div class="portlet-title">
								<div class="caption"><i class="icon-reorder"></i>职位信息</div>
								<div class="tools">
									<a href="javascript:;" class="collapse"></a>
								</div>
							</div>

							<div class="portlet-body form">

								<!-- BEGIN FORM-->

								<form action="#" class="form-horizontal" id="jobForm" method="get">
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label"><span style="color:red;">*</span>职位名称：</label>
												<input type="text" value="${job.position }" maxlength="10"  id="position" name="position" class="m-wrap span6" placeholder="请输入职位名称，不超过10个字" data-label="职位名称" must-be="true">
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">工作经验：</label>
												<select class="large m-wrap" name="work_exp" id="work_exp">
													<option value="">--全部--</option>
													<c:forEach items="${expList}" var="item">
														<c:if test="${job.workExp == item.dict_code }">
															<option value="${item.dict_code }" selected>${item.name}</option>
														</c:if>
														<c:if test="${job.workExp != item.dict_code }">
															<option value="${item.dict_code }">${item.name}</option>
														</c:if>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">学历要求：</label>
												<div class="controls">  
													 
													<select class="large m-wrap" name="education" id="education" data-label="学历要求">
													<option value="">--全部--</option>
													<c:forEach items="${eduList}" var="item">
														<c:if test="${job.education == item.dict_code }">
															<option value="${item.dict_code }" selected>${item.name}</option>
														</c:if>
														<c:if test="${job.education != item.dict_code }">
															<option value="${item.dict_code }">${item.name}</option>
														</c:if>
													</c:forEach>
												</select>     
												</div>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">招聘人数：</label>
												<input type="text" value="${job.nums }" id="nums" name="nums" class="m-wrap span6" placeholder="招聘人数">
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label" style="float:left; line-height: 30px; margin-right:10px;">工作地点：</label>
	                                            <div class="controls">
	                                                <select id="province" class="large m-wrap" name="province">
		                                               <option value="">省份</option>
														<c:forEach items="${provinceList}" var="province">
															<c:if test="${job.province == province.dictCode }"> 
																<option value="${province.dictCode }" selected="selected">${province.name}</option> 
															</c:if>
															<c:if test="${job.province != province.dictCode }"> 
																<option value="${province.dictCode }" >${province.name}</option> 
															</c:if>
														</c:forEach>
													</select>
													
	                                                <select id="city" class="large m-wrap" name="city">
		                                               <option value="">城市</option>
														 <c:forEach items="${cityList}" var="city">
															<option value="${city.dictCode }" <c:if test="${job.city == city.dictCode }">selected </c:if> >${city.name}</option>
														</c:forEach> 
													</select>
	                                            </div>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label">所属公司：</label>
												<div class="controls">  
													<select class="large m-wrap" name="company" id="company" data-label="所属公司">
													<option value="">--全部--</option>
													<c:forEach items="${comList}" var="item">
														<c:if test="${job.comId == item.dict_code }">
															<option value="${item.dict_code }" selected>${item.name}</option>
														</c:if>
														<c:if test="${job.comId != item.dict_code }">
															<option value="${item.dict_code }">${item.name}</option>
														</c:if>
													</c:forEach>
												</select>     
												</div>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label"><span style="color:red;">*</span>职位描述：</label>
												<textarea class="span6 m-wrap" rows="5" id="description" maxlength="200" name="description" must-be="true" data-label="职位描述">${job.description}</textarea>
											</div>
										</div>
									</div>
									
									<div class="row-fluid">
										<div class="span9 ">
											<div class="control-group">
												<label class="control-label"><span style="color:red;">*</span>任职要求：</label>
												<textarea class="span6 m-wrap" rows="5" id="demand" maxlength="200" name="demand" must-be="true" data-label="任职要求">${job.demand}</textarea>
											</div>
										</div>
									</div>
									
									     
									
									<div class="form-actions">
										<input type="hidden" id="or_id" name="or_id" value="${job.orId }">
										<button type="button" class="btn blue" id="subBtn"><i class="icon-ok"></i> 保存并发布 </button>
										<button type="button" class="btn" id="back">取消</button>
									</div>
								</form>
								<!-- END FORM-->                
							</div>
						</div>
					</div>
					<!-- 会员信息 结束 -->
								
				</div>
						
				<!-- END PAGE CONTENT-->         
			</div>
			<!-- END PAGE CONTAINER-->
		</div>
		<!-- END PAGE -->  
	</div>
	<!-- END CONTAINER -->


	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->

	<!-- BEGIN CORE PLUGINS -->

	<script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->

	<script src="/views/media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>      
	<script src="/views/media/js/bootstrap.min.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>
	<!-- END CORE PLUGINS -->
	
	<script type="text/javascript" src="/views/media/js/form-validate.js"></script>

	<!-- BEGIN PAGE LEVEL PLUGINS -->
	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/table-advanced.js"></script>	
	<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script src="/views/media/js/app.js"></script>
	<script src="/views/media/js/form-samples.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->
	
	<script src="/js/laydate/laydate.js"></script><!-- 日期控件 -->
	<script>
		jQuery(document).ready(function() {    
		   // initiate layout and plugins
		   App.init();
		   FormSamples.init();
		   TableAdvanced.init();
		   
		   $("#back").click(function(e) {
				window.history.back();
			});
		   
		 //提交表单
			$("#subBtn")
					.click(
							function(e) {
								//调用验证插件，进行form表单的验证
								$("#jobForm").formValidate();
								
							});
		
		
		//省份改变
		$('#province').change(function () {
			var sheng = $("#province").val();
			if(sheng != ""){
				$.post("/members/city",{"province":sheng},function(result){
					if (result.lists.length > 0) {
                        data = result.lists,
                        html = '<option value="1">城市</option>';
                        $.each(data, function (i, obj) {
                        	html += '<option value="'+obj.dict_code+'" >'+obj.name+
                            '</option>';
                        });
                        
                        //$("#city").find("option:last").after(html);
                        $("#city").html(html);
                    } 
				});
			}
        });
		
		})
	</script>
	<!-- END JAVASCRIPTS -->   
<!-- END BODY -->
</html>