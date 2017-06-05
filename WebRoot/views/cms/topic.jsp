<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->

<!--[if !IE]><!--> 
<html lang="en" class="no-js"> <!--<![endif]-->
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
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    <!-- BEGIN PAGE LEVEL STYLES --> 
	<link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="page-header-fixed">

	<!-- BEGIN HEADER -->

	<%@ include  file="/views/navi.jsp"%>

	<!-- END HEADER -->

	<!-- BEGIN CONTAINER -->

	<div class="page-container">

		<!-- BEGIN SIDEBAR -->

		<%@ include  file="/views/menus.jsp"%>

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

							<li><a href="/cms/topics">专题管理</a><i class="icon-angle-right"></i>
                            </li>
							
                            <li>
                                ${operation}
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

								<div class="form-horizontal form-bordered form-row-stripped">
								<form id="sform" method="post">
												<div class="control-group">
                                                    <label class="control-label"><font color="#FF0000">*</font>专题名称：</label>
                                                    <div class="controls">
                                                        <input name="topic_name" type="text" class="span6 m-wrap" must-be="true" data-length="100" data-label="专题名称" value="${topic.topicName}"/>
                                                    </div>
                                                </div>
												
                                               <!-- 
                                                <div class="control-group">
                                                    <label class="control-label">顺序号：</label>
                                                    <div class="controls">
                                                        <input name="topic_sort" type="text" class="span2 m-wrap" value="${topic.topicSort}" />
                                                    </div>
                                                </div>
                                                -->
                                                
                                                <div class="control-group">
                                                    <label class="control-label"><font color="#FF0000">*</font>专题图片：</label>
                                                    <div class="controls">
                                                    		<input id="topPic" multiple accept="image/*" type="file" style="display: none;">
															<div style="float: left;   width:160px;height:76px;overflow:hidden;position:relative;">
                                                                <c:if test="${!empty topic.topicImage}">
                                                                    <img  id="showImg" src="${topic.topicImage}" style="position:absolute;left:-1px;top:-1px;width:160px;height:76px;">
                                                                </c:if>
                                                                <c:if test="${empty topic.topicImage}">
                                                                    <img  id="showImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:160px;height:76px;" src="/images/nopic.jpg">
                                                                </c:if>
                                                                <input type="hidden" id="topic_image" name="topic_image" value="${topic.topicImage}" />
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
                                                        <span>支持jpg,png格式图片，微站轮播图：建议图片尺寸为750px*360px,大小不超过200kb；  官网首页轮播图：建议尺寸为2560px*750px   内容文字显示在居中1170px宽以内；官网二级页面轮播图：建议尺寸为2560px*320px   内容文字显示在居中1170px宽以内</span>
												 	</div>
			                 
												</div>
                                                <div class="control-group">
                                                    <label class="control-label"><font color="#FF0000">*</font>链接地址：</label>
                                                    <div class="controls">
                                                        <input name="topic_url" id="topic_url" type="text" class="span6 m-wrap" must-be="true" data-label="链接地址" value="${topic.topicUrl}" placeholder="链接地址：http://"/>
                                                    </div>
                                                </div>
                                                
                                                <div class="control-group">
                                                    <label class="control-label">专题描述：</label>
                                                    <div class="controls">
                                                        <input name="topic_mark" type="text" data-length="200" data-label="专题描述" class="span6 m-wrap" value="${topic.topicMark}" />
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">SEO关键词：</label>
                                                    <div class="controls">
                                                        <input name="seo_keywords" type="text" class="span6 m-wrap" data-length="200"  data-label="SEO关键词" value="${topic.seoKeywords}"/>
                                                    </div>
                                                </div>
                                                
                                                <div class="control-group">
                                                    <label class="control-label">SEO描述：</label>
                                                    <div class="controls">
                                                        <input name="seo_mark" type="text" class="span6 m-wrap" data-length="200" data-label="SEO描述" value="${topic.seoMark}"/>
                                                    </div>
                                                </div>
                    							
                                                <div class="control-group">

												  <label class="control-label"><font color="#FF0000">*</font>推送位置：<br /><font color="#FF0000" size="1">(务必选择其中一项)</font></label>

													<div class="controls portlet box span6" style="height:300px; overflow:scroll">
														${tree}
													</div>

												</div>
												<div class="form-actions">
												<c:if test="${empty topic || topic.topicStatus == '未发布'}">
													<a id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</a>
													<a id="pubBtn" class="yellow btn"><i class="icon-ok-sign"></i> 发布</a>
													<button type="button" class="btn" id="back">取消</button>
												</c:if>
												<c:if test="${topic.topicStatus == '已发布' }">
													<a id="repubBtn" class="btn blue"><i class="icon-ok"></i> 重新发布</a>
													<a id="offline" class="yellow btn"><i class="icon-ok-sign"></i> 下线</a>
													<button type="button" class="btn" id="back">取消</button>
												</c:if>
												<c:if test="${topic.topicStatus == '已下线' }">
													<a id="repubBtn" class="btn blue"><i class="icon-ok"></i> 重新发布</a>
													<button type="button" class="btn" id="back">取消</button>
												</c:if>
												</div>
                                                <input id="fromurl" name="fromurl" type="hidden" value="" />
                                                <input id="operation" name="operation" type="hidden" value="${operation}" />
                                                <input id="topicStatus" name="topicStatus" type="hidden" value="${topic.topicStatus}" />
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
		 //选择处理
			$(".checker input[type='checkbox']").each(function(index, element) {
           	$(this).click(function(e) {
					if($(this).prop("checked")){
						//选中父级选项
						$(this).parents("li").each(function(i,el){
							var check=$(el).children("a:first-child").children("div.checker");
							if(check!=undefined && check.find("span")!=undefined){
								check.find("span").addClass("checked");
								check.find("input").prop("checked",true);
							}
						});
						//选中子选项
						var checks = $(this).parents("a").next().find("div.checker");
						checks.each(function(i, el) {
                           $(el).find("span").addClass("checked");
							$(el).find("input").prop("checked",true);
                       });
					}
					else{
						//取消选中子选项
						var checks = $(this).parents("a").next().find("div.checker");
						checks.each(function(i, el) {
                           $(el).find("span").removeClass("checked");
							$(el).find("input").prop("checked",false);
                       });
					}
               });
           });
			$("#back").click(function(e) {
                /* window.history.back(); */
                window.location.href="/cms/topics";
            });
			
			//提交表单
			$("#subBtn").click(function(e) {
				
				var fromurl = document.referrer;
				$("#fromurl").val("/cms/topics");
				var topic_image = $("#topic_image").val();
				if(!topic_image){alert("请上传专题图片！");return false;}
				var send_position = $("input[name='chks']:checked").size();
				if(send_position==0){alert("请选择推送位置");return false;}
				var topic_url = $("#topic_url").val();
				var Expression=/http(s)?:////([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
				var objExp=new RegExp(Expression); 
				if(!objExp.test(topic_url)==true){alert('请输入有效的链接地址');return false; }
				//调用验证插件，进行form表单的验证
				document.getElementById("subBtn").disabled = true;
				$("#sform").formValidate();
            });
			
			//提交表单
			$("#pubBtn").click(function(e) {
				var topic_image = $("#topic_image").val();
				if(!topic_image){alert("请上传专题图片！");return false;}
				var send_position = $("input[name='chks']:checked").size();
				if(send_position==0){alert("请选择推送位置");return false;}
				var topic_url = $("#topic_url").val();
				var Expression=/http(s)?:////([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
				var objExp=new RegExp(Expression); 
				if(!objExp.test(topic_url)==true){alert('请输入有效的链接地址');return false; }
				document.getElementById("pubBtn").disabled = true;
				if(confirm("是否确定要发布该专题?")){
					
					/* $.post("/cms/topics/topic/checkReleaseNum",function(data){
						if(data.code==0){
							var fromurl = document.referrer;
							$("#fromurl").val("/cms/topics");
							
							//调用验证插件，进行form表单的验证
							$("#sform").attr("action","/cms/topics/topic/publish/${id}");
							$("#sform").formValidate();
						}else{
							if(confirm("当前已发布专题已满5条，确认后将自动下线发布最早的专题。")){ */
								$("#fromurl").val("/cms/topics");
								
								//调用验证插件，进行form表单的验证
								$("#sform").attr("action","/cms/topics/topic/publish/${id}");
								$("#sform").formValidate();
							/* }else{
								document.getElementById("pubBtn").disabled = false;
							}
						}
					}); */
				}else{
					document.getElementById("pubBtn").disabled = false;
				}
            });
			//重新发布
			$("#repubBtn").click(function(e) {
				var topic_image = $("#topic_image").val();
				if(!topic_image){alert("请上传专题图片！");return false;}
				var send_position = $("input[name='chks']:checked").size();
				if(send_position==0){alert("请选择推送位置");return false;}
				var topic_url = $("#topic_url").val();
				var Expression=/http(s)?:////([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/; 
				var objExp=new RegExp(Expression); 
				if(!objExp.test(topic_url)==true){alert('请输入有效的链接地址');return false; }
				var topicStatus = $("#topicStatus").val();
				document.getElementById("repubBtn").disabled = true;
				if(confirm("重新发布后网站端将会实时同步！")){
					
					/* $.post("/cms/topics/topic/checkReleaseNum",function(data){
						if(data.code==0){
							var fromurl = document.referrer;
							$("#fromurl").val("/cms/topics");
							
							//调用验证插件，进行form表单的验证
							$("#sform").attr("action","/cms/topics/topic/publish/${id}");
							$("#sform").formValidate();
						}else{
							if(topicStatus != '已发布'){
								if(confirm("当前已发布专题已满5条，确认后将自动下线发布最早的专题。")){ */
									$("#fromurl").val("/cms/topics");
									//调用验证插件，进行form表单的验证
									$("#sform").attr("action","/cms/topics/topic/publish/${id}");
									$("#sform").formValidate();
								/* }else{
									document.getElementById("pubBtn").disabled = false;
								}
							}else{
								$("#fromurl").val("/cms/topics");
								//调用验证插件，进行form表单的验证
								$("#sform").attr("action","/cms/topics/topic/publish/${id}");
								$("#sform").formValidate();
							}
							
						} 
					});
					
					/* var fromurl = document.referrer;
					$("#fromurl").val("/cms/topics");
					
					//调用验证插件，进行form表单的验证
					$("#sform").attr("action","/cms/topics/topic/publish/${id}");
					$("#sform").formValidate(); */
				}else{
					document.getElementById("repubBtn").disabled = false;
				}
            });
			//下线
			$("#offline").click(function(e) {
				document.getElementById("offline").disabled = true;
				if(confirm("是否确定要下线本专题?")){
					$.post("/cms/topics/topic/offline/${id}",function(data){
						if(data.status==0){
							alert("下线成功！");
							var fromurl = document.referrer;
							$("#fromurl").val("/cms/topics");
							$("#sform").formValidate();
						}
						else
							alert(data.msg);
						document.getElementById("offline").disabled = false;
					});
					}else{
						document.getElementById("offline").disabled = false;
					}
            });
			
			///图片上传
			$('#topPic').change(function() {
			var files = $('#topPic').prop('files');
			console.log(files);
			var imgUrl = $("#topic_image").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");  
		            document.getElementById("selectInfoImg").disabled = false;
		            return false;  
		        }
				/* if(files[m].size>200*1024){
					alert("图片大小要小于200kb");
					document.getElementById("selectInfoImg").disabled = false;
					return false;
				} */
				lrz(files[m],{quality :1.0})
				  .then(function (rst) {
					var filename = rst.origin.name;
					
						$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
							function(data){
								if(data.status==0){
									 $('#showImg').attr("src",data.picUrl);
									 alert('上传成功!');
									 document.getElementById("selectInfoImg").disabled = false;
									 $('#topic_image').val(data.picUrl);
								}
								else {
									 $('#topic_image').val('');
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
			
			$('#showImg').click(function(){ 
				$('#topPic').click(); 
			});
			
			$('#selectInfoImg').click(function(){ 
				document.getElementById("selectInfoImg").disabled = true;
				$('#showImg').click(); 
			});
		});
	
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>