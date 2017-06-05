<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->

<!--[if !IE]><!--> <html lang="en" class="no-js"> <!--<![endif]-->

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
    <link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES --> 
	
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
    
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    
   
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

	<!-- BEGIN HEADER -->

	<%@ include  file="../navi.jsp"%>

	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->

	<div class="page-container">

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

						<!-- BEGIN PAGE TITLE & BREADCRUMB-->

						<h3 class="page-title">${operation}</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>
								<a href="/">主页</a> 
								<i class="icon-angle-right"></i>
							</li>

							<li>
								<a href="/official/about/team/list">专业团队<i class="icon-angle-right"></i></a>
                            </li>
							
                            <li>
                                <a href="">${operation}</a>
                            </li>
							<li class="pull-right no-text-shadow">

								<div id="dashboard-report-range" class="dashboard-date-range tooltips no-tooltip-on-touch-device responsive" data-tablet="" data-desktop="tooltips" data-placement="top" data-original-title="Change dashboard date range">

									<i class="icon-calendar"></i>

									<span></span>

									<i class="icon-angle-down"></i>

								</div>

							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<div class="row-fluid">
                	<div class="portlet-title">
                    	<div class="caption"><i class="icon-list"></i>${operation}</div>
					</div>
              
                    <!-- 添加表单 -->
                    <div class="portlet-body form">
						<!-- BEGIN FORM-->

								<div class="form-horizontal">
								<form id="sform" method="post">
                                                <div class="control-group"> 
													<div class="controls">
														<span class="m-wrap span2" style="margin-top: 10px;">姓名：</span>  
														<span class="m-wrap span2" style="margin-top: 10px;">${User.userName}</span>
													</div>
												</div>
												
												<div class="control-group">  
													<div class="controls">
												     	<span class="m-wrap span2" style="margin-top: 10px;">英文名：</span>
														<span class="m-wrap span2" style="margin-top: 10px;">${User.englishName}</span>
													</div>
												</div>
											
												<div class="control-group"> 
													<div class="controls">  
												    	<span class="m-wrap span2" style="margin-top: 10px;">所属团队：</span>   
														<select class="m-wrap span6" style="float:left;" id="team_type" name="team_type">
		                                                	<option value="">未选择</option>
		                                                	<c:forEach items="${teamTypeList }" var="item">
		                                                		<c:if test="${item.name == teamUser.teamType }">
																	<option value="${item.name }" selected>${item.name }</option>
															</c:if>
		                                                		<c:if test="${item.name != teamUser.teamType }">
																	<option value="${item.name }">${item.name }</option>
															</c:if>
		                                                	</c:forEach>
		                                                </select>
													</div> 
												</div>
												
												<div class="control-group"> 
													<div class="controls">  
												    	<span class="m-wrap span2" style="margin-top: 10px;">头衔<b style="color:#FF003B;">*</b>：</span>   
														<input placeholder="必填项，如“资深移民专家”，最大可输入10个汉字" maxlength="10" class="m-wrap span6" type="text" data-label="头衔"  must-be="true" data-length="10" name="job_title" id="job_title" value="${User.jobTitle}">
													</div> 
												</div>
												
												 <div class="control-group">
                                                    <label class="control-label" style="text-align: left;">照片<font color="#FF0000" style="margin-left:5px">*</font>：</label>
                                                    <div class="controls">
                                                    		<input id="headImgPic" multiple accept="image/*" type="file" style="display: none;">
															<div style="float: left;   width:156px;height:156px;overflow:hidden;position:relative;">
                                                                <c:if test="${!empty User.headImg}">
                                                                    <img  id="showHeadImg" src="${User.headImg}" style="position:absolute;left:-1px;top:-1px;width:156px;height:156px;">
                                                                </c:if>
                                                                <c:if test="${empty User.headImg}">
                                                                    <img  id="showHeadImg" style="position:absolute;   top:0px;  right: -1px; left:0px; bottom:1px; width:156px;height:156px;" src="/images/nopic.jpg">
                                                                </c:if>
                                                                
                                                                <input type="hidden" must-be="true" data-label="照片" id="head_img" name="head_img" value="${User.headImg}" />
														 	</div> 
                                                   	</div>
                                                </div>
                                                <div class="control-group">
													<label class="control-label"></label>
												 	<div class="controls" >
												 		<input type="button" id="selectInfoImg" value="选择图片">
												 	</div>
												</div>
												<div class="control-group">
													<label class="control-label"></label>
												 	<div style="margin-left: 100px;">
												 		<span class="label label-important">图片格式</span>
                                                        <span> 支持jpg、png格式，尺寸235px*330px，大小在500k以内</span>
												 	</div>
			                 
												</div>
												
                                               	<div class="control-group"> 
													<div class="controls">
														<span class="m-wrap span2" style="margin-top: 10px;"><font color="#FF0000" style="margin-left:5px">*</font>个人简介：</span>  																												<%-- ${teamUser.introduce} ${!empty teamUser.provinceId}	${ provinces} --%>
														<textarea placeholder="一段文字介绍顾问" rows="7" class="m-wrap span6" must-be="true" data-label="个人简介" name="introduce" id="introduce">${User.introduce}</textarea>
													</div> 
												</div>
												
												<div class="control-group"> 
													<div class="controls"> 
                                                		<span class="m-wrap span2" style="margin-top: 10px;">视频地址：</span> 
														<input placeholder="请输入正确的视频地。" maxlength="200" class="m-wrap span6" type="text" data-label="视频地址" data-length="200" name="video" id="video" value="${teamUser.video}">
														<!-- <b style="color:#FF003B;">*</b> -->
													</div> 
												</div> 
												<div class="control-group"> 
													<div class="controls">
														<span class="m-wrap span2" style="margin-top: 10px;">擅长的国家：<br/>(最多可选择3个)</span>  		
														<c:forEach items="${countries.subDictionaries}" var="country">
															<input name="countries" type="checkbox" value="${country.name}" <c:forEach items="${Countries}" var="ct"><c:if test="${country.name==ct}"> checked="checked" </c:if></c:forEach>/>${country.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														</c:forEach>
													</div> 
												</div>
												
												<div class="control-group"> 
													<div class="controls">
														<span class="m-wrap span2" style="margin-top: 10px;">首页推荐：</span>  		
														<label class="radio">
															<input type="radio" name="index_show" value="0"  <c:if test="${teamUser.indexShow == 0}">checked="checked" </c:if>/> 否
														</label>
														<label class="radio">
															<input type="radio" name="index_show" <c:if test="${!empty enough}">disabled </c:if> value="1" <c:if test="${teamUser.indexShow == 1}">checked="checked" </c:if>/> 是
														</label>
													</div> 
												</div>
												
												<div class="form-actions">
												<c:if test="${teamUser.releaseMark!='已下线'}">
													<a id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</a>
													<a id="subBtnRe" class="btn blue" style="background: #FF9900;"><i class="icon-ok"></i> 发布</a>
												</c:if>
													<a id="back"  class="btn">取消</a>
												</div>
                                                <input id="fromurl" name="fromurl" type="hidden" value="" />
                                                 <input id="release_mark" name="release_mark" type="hidden" value="" />
                                                <input id="operation" name="operation" type="hidden" value="${operation}" />
											</form>
								</div>

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

	<div class="footer">

		<div class="footer-inner">

			2016 &copy; copyright pacificimmi.

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

	<script src="/views/media/js/excanvas.min.js"></script>

	<script src="/views/media/js/respond.min.js"></script>  

	<![endif]-->   

	<script src="/views/media/js/jquery.slimscroll.min.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.blockui.min.js" type="text/javascript"></script>  

	<script src="/views/media/js/jquery.cookie.min.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.uniform.min.js" type="text/javascript" ></script>

	<!-- END CORE PLUGINS -->

	<!-- BEGIN PAGE LEVEL PLUGINS -->

	<script src="/views/media/js/jquery.vmap.js" type="text/javascript"></script>   

	<script src="/views/media/js/jquery.vmap.russia.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.world.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.europe.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.germany.js" type="text/javascript"></script>

	<script src="/views/media/js/jquery.vmap.usa.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.vmap.sampledata.js" type="text/javascript"></script>  
	<script src="/views/media/js/jquery.flot.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.flot.resize.js" type="text/javascript"></script>
	<script src="/views/media/js/jquery.pulsate.min.js" type="text/javascript"></script>
	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/app.js" type="text/javascript"></script>
	<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    <script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script> 
		jQuery(document).ready(function() {     
		    App.init(); // initlayout and core plugin 
			$("#back").click(function(e) {
                window.history.back();
            });
			
		    $("input[type='checkbox']").click(function(){
		    		if($("input[type='checkbox']:checked").length>3){
		    			$(this).prop("checked",false);
		    			$(this).parent().removeClass("checked");
		    		}
		    });
			//发布-提交表单
			$("#subBtnRe").click(function(e) {
                //额外特殊输入的验证
                //所属机构必须选择
              	/*   if($(".checker input[type='checkbox']:checked").size()==0){
                		alert("请选择所属部门！");
                		return false;
                } */
                
				var fromurl = document.referrer;
				$("#fromurl").val(fromurl);
				$("#release_mark").val("已发布");
				//调用验证插件，进行form表单的验证
				$("#sform").formValidate();
            });
			
			//仅仅保存提交表单
			$("#subBtn").click(function(e) {
                //额外特殊输入的验证
                //所属机构必须选择
              /*   if($(".checker input[type='checkbox']:checked").size()==0){
                		alert("请选择所属部门！");
                		return false;
                } */
                
				var fromurl = document.referrer;
				$("#fromurl").val(fromurl);
				//$("#release_mark").val("未发布");
				//调用验证插件，进行form表单的验证
				$("#sform").formValidate();
            });
			
			$('input[type=radio]').click(function(){
				if($("input[name='index_show']:checked").val()==1){
					$.post("/official/about/team/list/check",{tt:$('#team_type').val()},function(data){
						if(data.status==0){
							var cur = $("input[name='index_show']:checked");
							var pre = cur.parents("label").prev().find("input");
							pre.prop("checked", true);
							pre.parent().addClass("checked");
							cur.prop("checked", false);
							cur.parent().removeClass("checked");
							alert(data.msg);
						}
					})
				}
			});
		});
		
		///图片上传
		$('#headImgPic').change(function() {
		var files = $('#headImgPic').prop('files');
		
		$('#showHeadImg').attr("src","/images/loading.gif");
		var imgUrl = $("#head_img").val();
		for(var m=0;m<files.length;m++){
			if (!/\.(jpg|jpeg|png|JPG|PNG)$/.test(files[m].name)) {  
	            alert("图片类型必须是.jpeg,jpg,png中的一种"); 
	            document.getElementById("selectInfoImg").disabled = false;
	            return false;  
	        }
			if(files[m].size>500*1024){
				alert("图片大小要小于500k");
				document.getElementById("selectInfoImg").disabled = false;
				return false;
			}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				
					$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
						function(data){
							if(data.status==0){
								 $('#showHeadImg').attr("src",data.picUrl);
								 alert('上传成功!');
								 document.getElementById("selectInfoImg").disabled = false;
								 $('#head_img').val(data.picUrl);
							}
							else {
								 $('#head_img').val('');
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
		
		/**$('#showHeadImg').click(function(){ 
			$('#headImgPic').click(); 
		});**/
		
		$('#selectInfoImg').click(function(){ 
			document.getElementById("selectInfoImg").disabled = true;
			//$('#showHeadImg').click();
			$('#headImgPic').click(); 
		});
		
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>