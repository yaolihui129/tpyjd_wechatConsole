<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->

<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->

<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->

<!-- BEGIN HEAD -->

<head>

	<meta charset="utf-8" />

	<title>太平洋加达－后台管理系统</title>

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

	<link href="/views/media/css/login.css" rel="stylesheet" type="text/css"/>

	<!-- END PAGE LEVEL STYLES -->

	<link rel="shortcut icon" href="/views/media/image/favicon.ico" />

</head>

<!-- END HEAD -->

<!-- BEGIN BODY -->

<body class="login">

	<!-- BEGIN LOGO -->

	<div class="logo">
		<img src="/images/logo.png" alt="" /> 
	</div>

	<!-- END LOGO -->

	<!-- BEGIN LOGIN -->

	<div class="content">

		<!-- BEGIN LOGIN FORM -->

		<!-- <form class="form-vertical login-form" action="http://localhost:8080/console/login"> -->
		<form method="get" action="/login">

			<h3 class="form-title">用户登录</h3>

			<div class="alert alert-error hide">

				<button class="close" data-dismiss="alert"></button>

				<span>输入用户名和密码.</span>

			</div>
			<div class="control-group">

				<div class="actions">

									<div class="btn-group">

										<a class="btn green" href="#" data-toggle="dropdown">
										<i class="icon-cogs"></i> ${sysname}&nbsp;(切换)
										<i class="icon-angle-down"></i>
										</a>

										<ul id="syslist" class="dropdown-menu pull-left">
											
										</ul>

									</div>

								</div>
			</div>

			<div class="control-group">

				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->

				<label class="control-label visible-ie8 visible-ie9">用户名</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-user"></i>

						<input class="m-wrap placeholder-no-fix" type="text" placeholder="用户名" id="username" name="username"/>

					</div>

				</div>

			</div>

			<div class="control-group">

				<label class="control-label visible-ie8 visible-ie9">密码</label>

				<div class="controls">

					<div class="input-icon left">

						<i class="icon-lock"></i>

						<input class="m-wrap placeholder-no-fix" type="password" placeholder="密码" id="password" name="password"/>

					</div>

				</div>

			</div>

			<div class="form-actions">

				<label class="checkbox">

				<input type="checkbox" id="remember" name="remember" /> 记住密码

				</label>

				<button type="submit" class="btn green pull-right">

				登录 <i class="m-icon-swapright m-icon-white"></i>

				</button>            

			</div>

			<div class="forget-password">

				<h4>忘记密码 ?</h4>

				<p>
					请与网站管理员联系.
				</p>

			</div>

			<div class="create-account">

				<p>

					Email:master@pacificimmi.cn

				</p>

			</div>

		</form>

		<!-- END LOGIN FORM -->        
	</div>

	<!-- END LOGIN -->

	<!-- BEGIN COPYRIGHT -->

	<div class="copyright">

		2016 &copy; Pacificimmi. Admin Dashboard.

	</div>

	<!-- END COPYRIGHT -->

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

	<script src="/views/media/js/jquery.validate.min.js" type="text/javascript"></script>

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js" type="text/javascript"></script>

	<script src="/views/media/js/login.js" type="text/javascript"></script>      

	<!-- END PAGE LEVEL SCRIPTS --> 

	<script>

		jQuery(document).ready(function() {     

		  App.init();
		  
		  $.getJSON("/syslist", function(data){
				    $.each(data.platforms, function(i,item){
				      $("#syslist").append("<li><a href='"+item.url+"'>"+item.name+"</a></li>");
				    });
			});
		  
		  Login.init();
		  
		  if ($.cookie("rmbuser") == "true") {
			  $("#remember").prop("checked", true);
			  $("#remember").parent().addClass("checked");
			  $("#username").val($.cookie("username"));
			  $("#password").val($.cookie("password"));
		  }
		  
		  $("#remember").click(function(){
			  if($(this).prop("checked")==true){
				  var username = $("#username").val();
				  var password = $("#password").val();
				  $.cookie("rmbuser", "true", { expires: 7 }); // 存储一个带7天期限的 cookie
				  $.cookie("username", username, { expires: 7 }); // 存储一个带7天期限的 cookie
				  $.cookie("password", password, { expires: 7 }); // 存储一个带7天期限的 cookie 
			  }
			  else{
				  $.cookie("rmbuser", "false", { expires: -1 });
				  $.cookie("username", '', { expires: -1 });
				  $.cookie("password", '', { expires: -1 }); 
			  }
		  });

		});

	</script>

	<!-- END JAVASCRIPTS -->

<!-- END BODY -->

</html>
