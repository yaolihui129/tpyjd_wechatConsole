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
    <!-- 下拉框搜索开始 -->
	<script type="text/javascript" src="http://www.daimajiayuan.com/download/jquery/jquery-1.10.2.min.js"></script>  
    <script type="text/javascript" src="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/js/bootstrap-select.js"></script>    
    <link rel="stylesheet" type="text/css" href="http://cdn.bootcss.com/bootstrap-select/2.0.0-beta1/css/bootstrap-select.css">    
  
    <!-- 3.0 -->  
   <!--  <link href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">  
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>  --> 
  
    <!-- 2.3.2  
    <link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">  
    <script src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.js"></script>  
    -->  
    <!-- 下拉框搜索结束 -->
    
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
	<style type="text/css">
			.form-control {
				style:"withd:100px";
			}
	</style>
	<style type="text/css">
	.img-content{
		width:600px;
		height: 301px; 
		position: relative;
		border:1px solid #dddddd;
	}
	.img-content .img{
		position: absolute;
		text-align: center;
		font-size: 34px;
		background:#dddddd;
		color:#fff;
	}
	.img-content .img1{
		width: 90px;
		height: 157px;
		left: 90px;
		top:47px;
		line-height: 157px;
	}
	.img-content .img2{
		width: 145px;
		height: 78px;
		left: 9px;
		bottom:11px;
		line-height: 78px
	}
	.img-content .img3{
		width: 145px;
		height: 78px;
		left: 190px;
		top:47px;
		line-height: 78px
	}
	.img-content .img4{
		width: 144px;
		height: 103px;
		left: 190px;
		bottom:64px;
		line-height: 103px
	}
	.img-content .img5{
		width: 214px;
		height: 114px;
		right: 42px;
		top:10px;
		line-height:114px
	}
	.img-content .img6{
		width: 90px;
		height: 157px;
		right: 166px;
		bottom:10px;
		line-height:157px
	}
	.img-content .img7{
		width: 144px;
		height: 77px;
		right: 12px;
		bottom:90px;
		line-height:77px
	}
	.img-content .bg{
		background: #e02222;
	}
	</style>
    <script type="text/javascript">
    $(window).on('load', function () { 
        	//搜索框
        	$('.selectpicker').selectpicker({  
                'selectedText': 'cat'  
            });
 			 // $('.selectpicker').selectpicker('hide');
        });
     </script>
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
                        <a href="#" class="btn red" id="release" style="float:right; margin-right:20px;margin-top:20px;"><i class=" icon-upload" style="margin-right:5px;"></i>发布</a>

                        <!-- END BEGIN STYLE CUSTOMIZER -->
                        <h3 class="page-title">
							公司大事记
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
                            <li>公司大事记</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">

                        <div class="tabbable tabbable-custom">
                            <%-- <ul class="nav nav-tabs">
                            	<li> <a href="/country/add?coun_id=${coun.id}&operation=${operation}">成功案例</a></li>
								<li class="active"><a href="javascript:;">移民评估</a></li>
								<li><a href="/country/countrySurvey?coun_id=${coun.countryId}">政策动态</a></li>
                            </ul> --%>
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                         <form id="sform"  class="form-horizontal" method="post">
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                         <label class="control-label">选择屏幕：</label>
                                                         <div class="controls">
				                                         	<select name="screen" id="screen" >
				                                         		<option value="1" selected="selected">第一屏</option>
				                                         		<option value="2">第二屏</option>
				                                         	</select>
				                                         </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                         <label class="control-label">选择图片位置：</label>
                                                        <div class="img-content" style="float:left;">                           
													            <div class="img img1" data-id="1" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸512px*274px，大小在2M以内">1</div>
													            <div class="img img2" data-id="2" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸320px*558px，大小在2M以内">2</div>                                                     
													            <div class="img img3" data-id="3" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸512px*274px，大小在2M以内">3</div>
													            <div class="img img4" data-id="4" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸512px*366px，大小在2M以内">4</div>                            
													            <div class="img img5" data-id="5" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸760px*406px，大小在2M以内">5</div>
													            <div class="img img6" data-id="6" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸320px*558px，大小在2M以内">6</div>
													            <div class="img img7" data-id="7" pic_url="" re_pic_url="" describe="" pic_size="支持jpg、png格式，尺寸512px*274px，大小在2M以内">7</div>                        
													     </div>
                                                    </div>
                                                </div>
                                            </div>
                                  <div class="control-group" style="border:none;">
                                  	<label class="control-label">上传图片：</label>
									<div class="controls">
										<input id="pictureUrl" name="pictureUrl" multiple accept="image/*" type="file" style="display: none;">
										<div style="float: left;   width:100px;height:100px;overflow:hidden;position:relative;">
											<c:if test="${!empty project.pictureUrl}">
												<img  id="pictureUrlImg" src="${project.pictureUrl}" style="position:absolute;left:-1px;top:-1px;width:102px;height:102px;">
											</c:if>
											<c:if test="${empty project.pictureUrl}">
												<img  id="pictureUrlImg" style="position:absolute;   top:2px;  right: -1px; left:1px; bottom:1px; width:102px;height:102px;" src="/images/nopic.jpg">
											</c:if>
											<input type="hidden" id="picture_url" name="picture_url" data-label="热门项目图片(官网)"
											must-be="true" value="${project.pictureUrl}" />
										 </div> 
										 </div>
									</div> 
									<div class="control-group" style="border:none;">
									<label class="control-label"></label>
										<div class="controls" >
									 		<input type="button" id="pictureUrlUpImg" value="选择图片">
									 	</div>
									</div>
									<div class="control-group" >
									<label class="control-label"></label>
										<div class="controls">
								 			<span class="label label-important">图片格式</span>
                                            <span id="pic_val">支持jpg、png格式，尺寸512px*274px，大小在2M以内</span>
								 		</div>
									</div>
									
									<div class="row-fluid">
                                                <div class="span12">
                                                    <div class="control-group">
                                                         <label class="control-label">图片描述：</label>
                                                         <div class="controls">
				                                         	<textarea name="describe" id="describe" cols="5" data-id="1" rows="5" style="width: 600px;height: 150px;" placeholder="请输入图片描述，不超过150个字"></textarea>
				                                         </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!--/row-->
                                            <input  name="position" type="hidden" value="" />
											<input  name="operation" type="hidden" value="${operation}" />
                                            <!--/row-->
                                            <div class="form-actions" style="background-color:#ffffff;padding-left: 100px;">
                                                <button type="button" id="subBtn" class="btn blue"><i class="icon-ok"></i> 保存</button>
                                                <button type="button" class="btn" id="back">取消</button>
                                                <input id="saveSuccess" name=saveSuccess type="hidden" value="${saveSuccess}"/>
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
        <!-- <script src="/views/media/js/jquery-1.10.1.min.js" type="text/javascript"></script> -->
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
		<script src="/bower_components/lrz/dist/lrz.bundle.js" type="text/javascript"></script>
		
        <script>
        jQuery(document).ready(function() {    

 		   App.init(); // initlayout and core plugin

 			$("#back").click(function(e) {
 				location.href="/";
             });
 			function isNull(arg1)
 			{
 			 return !arg1 && arg1!==0 && typeof arg1!=="boolean"?true:false;
 			}
 			//提交表单
 			$("#subBtn").click(function(e) {
 				var screen = $("#screen").val();
 				var blue = true;
 				$("div.img").each(function(index, element) {
 					var $this = $(this);
 					var position = $this.attr("data-id");
 					var pic_url = $this.attr("pic_url");
 					//获取当前位置的本次页面上传的图片
 					var re_pic_url = $this.attr("re_pic_url");
 					var describe = $this.attr("describe");
 					if(!isNull(re_pic_url)){
 						pic_url = re_pic_url;
 					}
 					//依次保存每个位置的图片
 					if(!isNull(screen)&& !isNull(position) && (!isNull(pic_url) || !isNull(describe))){
 						$.ajax({
 							type : "post",
 							async: false,
 							url : "/official/home/saveMemorabilia",
 							data : {
 									"position" : position,
	 								"pic_url":pic_url,
	 								"screen":screen,
	 								"describe":describe
 							},
 							success : function(data) {

 							},
 							error : function() {
 								blue = false;
 								return;
 							}
 						});
 						/* $.post("/official/home/saveMemorabilia",
 	 							{
 	 								"position" : position,
 	 								"pic_url":pic_url,
 	 								"screen":screen,
 	 								"describe":describe
 	 							},
 	 							function(data) {
 	 								//多次保存不返回信息，默认保存成功...
 	 								if(data.code == 0){
 	 									
 	 								}else{
 	 									
 	 								}
 	 								
 	 							}); */
 					}
 					
 				});
 				
 				if(blue){
 					alert("保存成功！");
 				}else{
 					alert("保存失败！");
 				}
 				
             });
 		});
       
        </script>
        <!-- END JAVASCRIPTS -->
		<script type="text/javascript">
		//图片上传（官网）
		$('#pictureUrl').change(function() {
			var files = $('#pictureUrl').prop('files');
			console.log(files);
			var imgUrl = $("#picture_url").val();
			for(var m=0;m<files.length;m++){
				if (!/\.(jpg|png|JPG|PNG)$/.test(files[m].name)) {  
		            alert("图片类型必须是jpg,png中的一种");
		            document.getElementById("pictureUrlUpImg").disabled = false;
		            return false;  
		        }
				if(files[m].size>2*1024*1024){
					alert("图片大小要小于2M");
					document.getElementById("preferredPicUpImg").disabled = false;
					return false;
				}
			lrz(files[m],{quality :1.0})
			  .then(function (rst) {
				var filename = rst.origin.name;
				$.post("/fileupload", { "filename": filename, "content": rst.base64, "imgUrl":imgUrl},
					function(data){
						if(data.status==0){
							 $('#pictureUrlImg').attr("src",data.picUrl);
							 alert('上传成功!');
							 document.getElementById("pictureUrlUpImg").disabled = false;
							 $('#picture_url').val(data.picUrl);
							 //将图片地址赋值到有bg属性的img的re_pic_url值上
							 $("div .img.bg").attr("re_pic_url",data.picUrl);
						}
						else {
							 $('#picture_url').val('');
							 document.getElementById("pictureUrlUpImg").disabled = false;
							alert(data.msg);
						}
					});
			  })
			  .always(function () {
				  // 不管是成功失败，都会执行
			  });
			}
		});
		$('#pictureUrlUpImg').click(function(){ 
			document.getElementById("pictureUrlUpImg").disabled = true;
			$('#pictureUrl').click(); 
		});
		</script>
		
		<script type="text/javascript">
		//点击每个位置时查询这个屏幕，这个位置上的图片信息
		$("div.img").each(function(index, element) {
			$(this).click(function(e) {
				var $this = $(this);
				//切换背景颜色（红色）
				$this.addClass("bg").siblings().removeClass("bg");
				//获取显示位置1-7
				var position = $this.attr("data-id");
				var pic_size = $this.attr("pic_size");
				//将显示位置赋值给隐藏域，以便保存的时候获取图片位置
				$("#position").val(position);
				$("#pic_val").text(pic_size);
				$("#describe").attr("data-id",position);
				//获取当前位置的本次页面上传的图片
				var re_pic_url = $this.attr("re_pic_url");
				if(!isNull(re_pic_url)){
					$('#picture_url').val(re_pic_url);
					$("#pictureUrlImg").attr("src",re_pic_url);
				}else{
					//每次重新获取，防止screen不变
					var screen = $("#screen").val();
					//查询这个屏幕这个位置上的图片，显示到上传图片右方
					$.post("/official/home/selectMemorabilia",
								{
									"position" : position,
									"screen":screen,
								},
								function(data) {
									if(data.code == 0){
										$this.attr("pic_url",data.pic_url);
										$this.attr("describe",data.describe);
										$('#picture_url').val(data.pic_url);
										$("#pictureUrlImg").attr("src",(data.pic_url==undefined?"/images/nopic.jpg":data.pic_url));
										$("#describe").val((data.describe == undefined?"":data.describe));
									}else{
										//无任何动作
										$('#picture_url').val('');
										$("#pictureUrlImg").attr("src",'/images/nopic.jpg');
										$("#describe").val('');
									}
								});
					
				}
				
				
			});
		});
		$("#describe").blur(function(){
			var describe = $("#describe").val();
			$("div .img.bg").attr("describe",describe);
		});
		//判断是否为空
		function isNull(arg1)
			{
			 return !arg1 && arg1!==0 && typeof arg1!=="boolean"?true:false;
			}
		//切换第几屏时去掉所有显示的东西
		$("#screen").change(function(){
			$('#picture_url').val('');
			$("#pictureUrlImg").attr("src",'/images/nopic.jpg');
			$("#describe").val('');
			$("div.img").each(function(index, element) {
				$this = $(this);
				$this.removeClass("bg");
			});
		});
		//发布
		var reclick = true;
		$("#release").click(function(e) {
			if(reclick){
				if(confirm("请先保存再进行发布，发布后官网将会实时同步！确定要发布吗？")){
					reclick = false;
					var screen = $("#screen").val();
					$.post(
							"/official/home/releaseMemorabilia",
							{"screen":screen},
							function(data){
								if(data.code == 0){
									reclick = true;
									alert("发布成功！");
									window.location.reload();
								}else if(data.code == 1){
									alert(data.msg);
									reclick = true;
								}else if(data.code == 2){
									alert(data.msg);
									reclick = true;
								}
							}
					);
					
				}
			}
		});

		</script>
</body>
<!-- END BODY -->

</html>