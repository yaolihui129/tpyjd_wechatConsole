<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %> 
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
	<link rel="stylesheet" type="text/css" href="/views/media/css/jquery.fileupload-ui.css">
    <script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
    
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

							<li><a href="/live/list">直播内容</a><i class="icon-angle-right"></i>
                            </li>
							
                            <li>
                                生成听课码
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
                    	<div class="caption"><i class="icon-list"></i>生成听课码</div>
					</div>
              
                    <!-- 添加表单 -->
                    <div class="portlet-body form">

						<!-- BEGIN FORM-->

						<div class="form-horizontal">
                        	<div class="controls" style="font-size:16px;margin:10px 0;">
                                正在为《${live.liveTitle}》生成邀请码
                            </div>
                            <div class="controls" style="font-size:14px;margin:10px 0;">
                                直播人数上限：${live.liveLimit}
                            </div>
                            <div class="controls" style="font-size:14px;margin:10px 0;">
                                已生成邀请码：${codeNum}
                            </div>
                            <div class="controls" style="font-size:14px;margin:10px 0;">
                                还可生成：${rest}
                            </div>
							<div style="height:1px; background-color:#ccc;margin:10px 0;"></div>
                            <div class="control-group">
                                <label class="control-label">选择发码人 ：</label>
                                <div class="controls">
                                    <select id="stewardId" must-be="true" class="m-wrap span4">
                                        <c:forEach items="${stewards}" var="steward">
                                            <option value="${steward.stewardId}">${steward.stewardName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">生成数量：</label>
                                <div class="controls">
                                    <input type="text" id="num" placeholder="" /><span style="margin-left:20px;"><a id="crtBtn" class="btn blue">生成</a></span>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">已生成邀请码：</label>
                                <div class="controls" style="border:#ccc 1px solid;padding:5px;width:300px;height:200px; overflow:scroll;">
                                   <table id="Codes" width="100%" border="0" cellspacing="0" cellpadding="0">
                                      
                                    </table>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label"></label>
                                <div class="controls">
                                    <a class="btn blue" id="downloadBtn">下载邀请码</a>
                                </div>
                            </div>
                            <div style="height:1px; background-color:#ccc;margin:10px 0;"></div>
                            <div class="controls" style="font-size:16px;margin:10px 0; text-align:center;">
                                <a onClick="javascript:history.back();" class="btn green">返回直播列表</a>
                            </div>
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
    <script src="/js/laydate/laydate.js"></script>
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script>

		jQuery(document).ready(function() {    

		   App.init(); // initlayout and core plugin
		   
		   $("#crtBtn").click(function(e) {
            	var stewardId = $("#stewardId").val();
				var num = $("#num").val();
				
				if(stewardId==''){
					alert("请选择为哪个顾问生成邀请码！");
					return false;
				}
				if(num==''){
					alert("请输入要生成的邀请码数量！");
					return false;
				}
				
				$.post("/live/list/code/ceateCode",{"liveId":"${live.liveId}","stewardId":stewardId,"num":num},function(data){
					if(data.status==0){
						$.each(data.list, function(i, n){
						  $("#Codes").append("<tr><td>"+n+"</td></tr>");
						});
						
						var downUrl = "/live/list/code/download/"+data.filename;
						$("#downloadBtn").attr("href",downUrl);
						alert("生成成功!");
					}
					else
					{
						alert(data.msg);
					}	
				});
        	});
		});
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>