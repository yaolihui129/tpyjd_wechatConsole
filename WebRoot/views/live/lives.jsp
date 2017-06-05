<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

	<link href="/views/media/css/uniform.default.css" rel="styles
	<meta content="" name="author" />

	<link href="/views/media/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-metro.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/style-responsive.css" rel="stylesheet" type="text/css"/>

	<link href="/views/media/css/default.css" rel="stylesheet" type="text/css" id="style_color"/>
heet" type="text/css"/>

	<!-- END GLOBAL MANDATORY STYLES -->

	<!-- BEGIN PAGE LEVEL STYLES -->

	<link rel="stylesheet" type="text/css" href="/views/media/css/select2_metro.css" />
    <link rel="stylesheet" type="text/css" href="/views/media/css/bootstrap-tree.css" />
	<link rel="stylesheet" type="text/css" href="/views/media/css/DT_bootstrap.css" />
    <style type="text/css">
	th{
		cursor:pointer;
	}
	th div{
		float:left;
	}
	</style>

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

						<h3 class="page-title">直播管理</h3>

						<ul class="breadcrumb">

							<li>
								<i class="icon-home"></i>

								<a href="/">主页</a> 

								<i class="icon-angle-right"></i>

							</li>

							<li>直播内容</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<div class="row-fluid">
                    <div class="span12">
                    <div class="portlet box grey">
							<div class="portlet-title">
								<div class="caption"><i class="icon-list"></i></div>

								<div class="actions">
									<a href="/live/list/add" class="btn blue addnew"><i class="icon-pencil"></i> 新增</a>
								</div>

							</div>

					  <div class="portlet-body  no-more-tables">
                      <form method="post" id="searchForm" method="get">
                       	<div class="row-fluid">
                              <div class="span12">
                              	   <table width="100%" border="0" cellspacing="5" cellpadding="5">
                                      <tr>
                                        <td width="9%">直播名称</td>
                                        <td width="20%"><input type="text" name="live_title" id="live_title" placeholder="输入名称"  class="m-wrap span10" value="${living_title}" ></td>
                                        <td width="9%">直播时间</td>
                                        <td width="38%">	<input type="text" class="m-wrap span5" name="living_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${living_time}">
                                                <span style="line-height:35px;">--</span>
                                                <input type="text" class="m-wrap span5" name="living_time1" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${living_time1}">
                                        </td>
                                        <td width="6%">状态</td>
                                        <td width="18%">
                                        <div class="control-group">
                                        <select name="live_status" class="m-wrap span8">
                                        		<c:forEach items="${live_statuses}" var="livestatus">
                                                <option value="${livestatus.name}" <c:if test="${live_status==livestatus.name}">selected="true"</c:if> >${livestatus.name}</option>
                                            	</c:forEach>
                                        </select>
                                        </div>
                                        </td>
                                      </tr>
                                      <tr>
                                        <td>主播</td>
                                        <td><input type="text" name="steward_name" class="m-wrap span10" placeholder="输入主播姓名"  value="${steward_name}"></td>
                                        <td>创建时间</td>
                                        <td>
                                        	<input type="text" class="m-wrap span5" name="create_time" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${create_time}">
                                                <span style="line-height:35px;">--</span>
                                                <input type="text" class="m-wrap span5" name="create_time1" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" value="${create_time1}">
                                        </td>
                                        <td colspan="2"><a id="searchBtn" class="btn blue"><i class="icon-search"></i>搜索</a></td>
                                      </tr>
                                    </table>
                       	  </div>
                        </div>
								
                          <table class="table">
							  <thead>
                              <tr>
                              <th>
								类型
								</th><th>
                                人数限制
                   				</th><th>         
                                标题
                			    </th><th>         
                                主播
            			        </th><th>         
                                直播简介
   			                    </th><th>         
                                直播介绍图
                                </th><th>
                                状态
                                </th><th>
                                创建时间
                                </th><th>
                                报名开始
                                </th><th>
                                报名截止
                                </th><th>
                                直播开始时间
                                </th><th>
                                报名用户
                                </th><th>
                                临时申请
                                </th><th>
                                频道号
                                </th><th>
                                操作
                                </th>
                                </tr>
							  </thead>

							  <tbody id="list">
								  <c:forEach items="${list}" var="item">
									<tr>
                                    <td>${item.liveType}</td>
                                    <td>${item.liveLimit}</td>
                                    <td>${item.liveTitle}</td>
                                    <td>${item.stewardName}</td>
                                    <td>${item.liveIntroduce}</td>
                                    <td>
                                    <c:choose>
                                    <c:when test="${!empty item.livePoster}">
                                    已上传
                                    </c:when>
                                    <c:otherwise>
                                    未上传
                                    </c:otherwise>
                                    </c:choose>
                                    </td>
                                    <td>${item.liveStatus}</td>
                                    <td><fmt:formatDate value="${item.createTime}" type="both"/></td>
                                    <td><c:choose>
                                    		<c:when test="${item.liveType=='公开'}">
                                  			－
                                  		</c:when>
                                  		<c:otherwise>
                                  			<fmt:formatDate value="${item.signupStartTime}" type="date" dateStyle="short"/>
                                  		</c:otherwise>
                                  		</c:choose>
                                  	</td>
                                    <td>
                                    		<c:choose>
                                    		<c:when test="${item.liveType=='公开'}">
                                  			－
                                  		</c:when>
                                  		<c:otherwise>
                                  			<fmt:formatDate value="${item.signupEndTime}" type="date" dateStyle="short"/>
                                  		</c:otherwise>
                                  		</c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${item.liveStartTime}" type="both"/></td>
                                    <td>
                                    		<c:choose>
                                    			<c:when test="${item.liveType=='公开'}">
                                    				－
                                    			</c:when>
                                    			<c:otherwise>
                                    				<a href="/live/list/signup/${item.liveId}" style="color:blue;">${item.signupNum}</a>
                                    			</c:otherwise>
                                    		</c:choose>
                                    		</td>
                                    <td><a href="/live/list/room/${item.liveId}" style="color:blue;">${item.tempSignupNum}</a></td>
                                    <td><a href="/live/list/channel/${item.liveId}" style="color:blue;">${item.channelId}</a></td>
                                    <td>
                                        <div data-id="${item.liveId}">
                                             
                                             <!--<a class="btn purple-stripe mini"><i class="icon-trash">删除</i></a>-->
                                             <c:choose>
                                              <c:when test="${item.liveStatus=='未发布'}">
                                              	<a class="btn green-stripe mini"><i class="icon-pencil">编辑</i></a>
                                                  <a class="btn purple-stripe mini"><i class="icon-share-alt">发布</i></a>
                                                  <c:if test="${item.liveType=='私密'}">
                                                  <a class="btn purple-stripe mini" href="/live/list/code/${item.liveId}"><i class="icon-barcode">生成听课码</i></a></c:if>
                                              </c:when>
                                              <c:when test="${item.liveStatus=='已发布'}">
                                                  <a class="btn purple-stripe mini"><i class="icon-download">撤销发布</i></a>
                                                  <a class="btn purple-stripe mini"><i class="icon-youtube-play">启动直播</i></a>												  <c:if test="${item.liveType=='私密'}">
                                                  <a class="btn purple-stripe mini" href="/live/list/code/${item.liveId}"><i class="icon-barcode">生成听课码</i></a></c:if>
                                              </c:when>
                                              <c:when test="${item.liveStatus=='直播中'}">
                                                  <a class="btn purple-stripe mini" href="/live/list/room/${item.liveId}"><i class="icon-info-sign">查看详情</i></a>
                                              </c:when>
                                              <c:otherwise>
                                              	  <a class="btn purple-stripe mini" href="/live/list/statistics/${item.liveId}"><i class="icon-bar-chart">查看统计</i></a>
                                              </c:otherwise>
                                             </c:choose>
                                        </div>
                                    </td>
                                    </tr>
                                  </c:forEach>
							  </tbody>

						  </table>
                          		<input id="field" name="field" type="hidden" /> 
                                <input id="way" name="way" type="hidden" /> 
                                <div id="pageBar">
                                	<input type="hidden" name="page" value="1" />
                                    ${pageBar}
                                </div>
						</form>
						</div>
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

			2016 &copy; copyright xiuhexuan.

		</div>

		<div class="footer-tools">

			<span class="go-top">

			<i class="icon-angle-up"></i>

			</span>

		</div>

	</div>

	<!-- FOOTER -->

	<!-- BEGIN J2.1.1RIPTS(Lll reduce page load time) -->

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

	<script type="text/javascript" src="/views/media/js/select2.min.js"></script>

	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>

	<!--<script type="text/javascript" src="/views/media/js/DT_bootstrap.js"></script>-->

	<!-- END PAGE LEVEL PLUGINS -->

	<!-- BEGIN PAGE LEVEL SCRIPTS -->

	<script src="/views/media/js/app.js"></script>
	<script src="/js/json/json2.js"></script>
	<script src="/views/media/js/form-validate.js"></script>     
    <script src="/js/laydate/laydate.js"></script>
	<script>
		jQuery(document).ready(function() {    

		   App.init(); // initlayout and core plugins
		   //全选事件处理
				$("#all").click(function(e) {
                   if($(this).children(":last").text()=="全选"){
					   $(this).children(":last").text("反选");
					   $("input:checkbox").prop("checked",function(i,v){
							return true;   
						});
						$("div.checker>span").addClass("checked");
					}
					else{
						$(this).children(":last").text("全选");
						$("input:checkbox").prop("checked",function(i,v){
							return false;   
						});
						$("div.checker>span").removeClass("checked");
					}
                });
				//搜索触发
				$("#searchBtn").click(function(e) {
                    doRequest();
                });
				
				//排序事件处理
				$(".sorting,.sorting_asc,.sorting_desc").each(function(index, element) {
					$(this).click(function(e) {
						var field = $(this).attr("data-field");
						$("#field").val(field);
						
						$(this).siblings(".sorting,.sorting_asc,.sorting_desc").attr("class","sorting");
                        if($(this).attr("class")=="sorting"){
							$(this).attr("class","sorting_asc");
							$("#way").val("asc");
							//do something
							doRequest();
						}
						else if($(this).attr("class")=="sorting_asc"){
							$(this).attr("class","sorting_desc");
							$("#way").val("desc");
							//do something
							doRequest();
						}
						else{
							$(this).attr("class","sorting_asc");
							$("#way").val("asc");
							//do something
							doRequest();
						}
                    });
                });
				
				
			
				//绑定内容编辑
				$("i.icon-pencil").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						location.href="/live/list/update/"+id;
					});		
                });
				
				//发布直播
				$("i.icon-share-alt").each(function(index, element) {
					$(this).click(function(e){
						if(confirm("是否确认发布此直播活动？")){
							var id = $(this).parent().parent().attr("data-id");
							
							$.get("/live/list/publish/"+id,function(data){
								if(data.status==0){
									alert(data.msg);
									location.reload();	
								}
								else{
									alert(data.msg);	
								}
							});
						}
					});		
                });
				
				//撤销直播
				$("i.icon-download").each(function(index, element) {
					$(this).click(function(e){
						if(confirm("是否确认撤销此直播活动？")){
							var id = $(this).parent().parent().attr("data-id");
							
							$.get("/live/list/offline/"+id,function(data){
								if(data.status==0){
									alert(data.msg);
									location.reload();	
								}
								else{
									alert(data.msg);	
								}
							});
						}
					});		
                });
				
				//开启直播
				$("i.icon-youtube-play").each(function(index, element) {
					$(this).click(function(e){
						if(confirm("是否启动当前直播？")){
							var id = $(this).parent().parent().attr("data-id");
							
							$.get("/live/list/start/"+id,function(data){
								if(data.status==0){
									alert(data.msg);
									location.href="/live/list/room/"+id;	
								}
								else{
									alert(data.msg);	
								}
							});
						}
					});		
                });
				
				
				//绑定翻页
				$('li.pages').each(function(index, element) {
					if($(element).attr("data-page")!=undefined){
						$(this).click(function(e) {
							$("#page").val($(element).attr("data-page"));
							doRequest();
						});
					}
                });
			
			//提交查询请求
			function doRequest(){
				//$("#searchForm").submit();
				$("#searchForm").formValidate();
			}
	
		});

	</script>

</html>