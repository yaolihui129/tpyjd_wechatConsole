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
								<a href="/steward/list">移民管家管理<i class="icon-angle-right"></i></a>
                            </li>
							
                            <li>
                                管家详情
                                <i class="icon-angle-right"></i>
                            </li>
							<li>
								评价信息
							</li>

						</ul>

						<!-- END PAGE TITLE & BREADCRUMB-->

					</div>

				</div>

				<!-- END PAGE HEADER-->

				<div class="row-fluid">
                    <div class="portlet-body">
                    	 <div class="tabbable tabbable-custom tabbable-full-width">

							<ul class="nav nav-tabs">

								<li><a href="/steward/list/detail/${stewardId}">基本信息</a></li>

								<li class="active"><a href="/steward/list/detail/evalute/${stewardId}">评价信息</a></li>

								<li><a href="/steward/list/detail/sign/${stewardId}">聘用纪录</a></li>

								<li><a href="/steward/list/detail/customer/${stewardId}">服务用户</a></li>

								<li><a href="/steward/list/detail/like/${stewardId}">点赞人数</a></li>

							</ul>

							<div class="tab-content">

								<div class="tab-pane active">
                                	<div class="row-fluid">
                                    <form id="searchForm" method="post">
                                    <table width="70%" border="0" cellspacing="0" cellpadding="0" style="font-size:14px;">
                                      <tr>
                                        <td><table width="100%" border="0" cellspacing="5" cellpadding="5">
                                          <tr>
                                            <td width="46%">管家姓名：${cu.userName}</td>
                                            <td width="54%">英文名：${cu.englishName}</td>
                                          </tr>
                                          <tr>
                                            <td>综合评价：
                                            <c:forEach var="i" begin="1" end="${stars}" varStatus="status">
											       <img src="/views/lib/img/star-on.png" />
											</c:forEach>
                                            &nbsp;${score}分</td>
                                            <td></td>
                                          </tr>
                                        </table></td>
                                      </tr>
                                      <tr>
                                        <td>
                                        	<table width="100%" border="0" cellspacing="5" cellpadding="5">
                                              <tr>
                                                <td width="46%">服务态度：很满意&nbsp;<fmt:formatNumber value="${service.good}" pattern="#0.0"/> %</td>
                                                <td width="27%">一般&nbsp;<fmt:formatNumber value="${service.normal}" pattern="#0.0"/> %</td>
                                                <td width="27%">不满意&nbsp;<fmt:formatNumber value="${service.bad}" pattern="#0.0"/> %</td>
                                              </tr>
                                              <tr>
                                                <td>服务态度：很满意&nbsp;<fmt:formatNumber value="${specialized.good}" pattern="#0.0"/> %</td>
                                                <td>一般&nbsp;<fmt:formatNumber value="${specialized.normal}" pattern="#0.0"/> %</td>
                                                <td>不满意&nbsp;<fmt:formatNumber value="${specialized.bad}" pattern="#0.0"/> %</td>
                                              </tr>
                                              <tr>
                                                <td>服务态度：很满意&nbsp;<fmt:formatNumber value="${feedback.good}" pattern="#0.0"/> %</td>
                                                <td>一般&nbsp;<fmt:formatNumber value="${feedback.normal}" pattern="#0.0"/> %</td>
                                                <td>不满意&nbsp;<fmt:formatNumber value="${feedback.bad}" pattern="#0.0"/> %</td>
                                              </tr>
                                            </table>
                                        </td>
                                      </tr>
                                    </table>
                                    </div>
                                    <div class="row-fluid">
                                    <table class="table">
                                      <thead>
                                          <tr>
                                              <c:choose>
                                                  <c:when test="${field=='service_attitude' && way=='asc'}">
                                                      <th width="10%"  class="sorting_asc" data-field="service_attitude">服务态度</th>
                                                  </c:when>
                                                  <c:when test="${field=='service_attitude' && way=='desc'}">
                                                      <th width="10%"  class="sorting_desc" data-field="service_attitude">服务态度</th>
                                                  </c:when>
                                                  <c:otherwise>
                                                     <th width="10%"  class="sorting" data-field="service_attitude">服务态度</th>
                                                  </c:otherwise>
                                              </c:choose>
                                              
                                               <c:choose>
                                                  <c:when test="${field=='specialized_knowledge' && way=='asc'}">
                                                      <th width="10%"  class="sorting_asc" data-field="specialized_knowledge">专业知识</th>
                                                  </c:when>
                                                  <c:when test="${field=='specialized_knowledge' && way=='desc'}">
                                                      <th width="10%"  class="sorting_desc" data-field="specialized_knowledge">专业知识</th>
                                                  </c:when>
                                                  <c:otherwise>
                                                     <th width="10%"  class="sorting" data-field="specialized_knowledge">专业知识</th>
                                                  </c:otherwise>
                                              </c:choose>
                                              
                                            
                                              <c:choose>
                                                  <c:when test="${field=='feedback_efficiency' && way=='asc'}">
                                                      <th width="10%"  class="sorting_asc" data-field="feedback_efficiency">反馈效率</th>
                                                  </c:when>
                                                  <c:when test="${field=='feedback_efficiency' && way=='desc'}">
                                                      <th width="10%"  class="sorting_desc" data-field="feedback_efficiency">反馈效率</th>
                                                  </c:when>
                                                  <c:otherwise>
                                                     <th width="10%"  class="sorting" data-field="feedback_efficiency">反馈效率</th>
                                                  </c:otherwise>
                                              </c:choose>
                                              
                                              <c:choose>
                                                  <c:when test="${field=='star_level' && way=='asc'}">
                                                      <th width="15%"  class="sorting_asc" data-field="star_level">综合评价</th>
                                                  </c:when>
                                                  <c:when test="${field=='star_level' && way=='desc'}">
                                                      <th width="15%"  class="sorting_desc" data-field="star_level">综合评价</th>
                                                  </c:when>
                                                  <c:otherwise>
                                                     <th width="15%"  class="sorting" data-field="star_level">综合评价</th>
                                                  </c:otherwise>
                                              </c:choose> 
                                              
                                                <th width="10%" >其他建议</th>
                                               <th width="10%" >评价时间</th>
                                               <th width="10%" >评价用户</th>
                                               <th>状态</th>
                                              <th width="15%" >快捷操作&nbsp;</th>
                                          </tr>
        
                                      </thead>
        
                                      <tbody id="list">
                                          <c:forEach items="${list}" var="item">
                                            <tr>                         
                                                <c:choose>
                                                    <c:when test="${item.service_attitude == 0}">
                                                        <td width="10%">很满意</td>
                                                    </c:when>
                                                    <c:when test="${item.service_attitude == 1}">
                                                        <td width="10%">一般</td>
                                                    </c:when>
                                                    <c:when test="${item.service_attitude == 2}">
                                                        <td width="10%">不满意</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td width="10%">暂无信息</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                
                                                <c:choose>
                                                    <c:when test="${item.specialized_knowledge eq 0}">
                                                        <td width="10%">很满意</td>
                                                    </c:when>
                                                    <c:when test="${item.specialized_knowledge eq 1}">
                                                        <td width="10%">一般</td>
                                                    </c:when>
                                                    <c:when test="${item.specialized_knowledge eq 2}">
                                                        <td width="10%">不满意</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td width="10%">暂无信息</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                 
                                                <c:choose>
                                                    <c:when test="${item.feedback_efficiency eq 0}">
                                                        <td width="10%">很满意</td>
                                                    </c:when>
                                                    <c:when test="${item.feedback_efficiency eq 1}">
                                                        <td width="10%">一般</td>
                                                    </c:when>
                                                    <c:when test="${item.feedback_efficiency eq 2}">
                                                        <td width="10%">不满意</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td width="10%">暂无信息</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                   
                                                 
                                                <td  width="15%">
                                                <c:forEach var="i" begin="1" end="${item.star_level}" varStatus="status">
											       <img src="/views/lib/img/star-on.png" />
												</c:forEach>
                                                      
                                                </td>
         
                                                <td  width="10%">
                                                    ${item.content}
                                                </td>
                                                <td  width="10%">
                                                    <fmt:formatDate value="${item.create_time}" type="both"/>
                                                </td>
                                                <td  width="10%" >
                                                    <c:choose>
		                                             	<c:when test="${empty item.name}">
		                                             		未设置
		                                             	</c:when>
		                                             	<c:otherwise>
		                                             		<script type="text/javascript">document.write(decodeURI("${item.name}"));</script>
		                                             	</c:otherwise>
		                                             </c:choose>
                                                </td>
                                                <td>
                                                <c:if test="${item.hidden==0}">
                                                显示
                                                </c:if>
                                                <c:if test="${item.hidden==1}">
                                               <span class="popovers" data-trigger="hover" data-placement="bottom" data-content="${item.hidden_reason}" data-original-title="隐藏原因"> 隐藏</span>
                                                </c:if>
                                                </td>
                                                
                                                <td width="17%" data-title="操作" >
                                                        <div data-id="${item.evaluate_id}">
                                                        	<c:if test="${item.hidden==0}">
                                                        		<a href="#hideBox" class="btn green-stripe mini" data-toggle="modal"><i class="icon-eye-close">设为隐藏</i></a>
                                                            </c:if>
                                                            <c:if test="${item.hidden==1}">
                                                        		<a class="btn green-stripe mini"><i class="icon-eye-open">设为展示</i></a>
                                                            </c:if>
                                                             <a class="btn purple-stripe mini"><i class="icon-trash">删除</i></a>
                                                        </div>
                                                </td>
                                            </tr>
                                          </c:forEach>
                                      </tbody>
        
                                  </table>
                                        <input id="field" name="field" type="hidden" /> 
                                        <input id="way" name="way" type="hidden" /> 
                                        <div id="pageBar">
                                            <input type="hidden" id="page" name="page" value="1" />
                                            ${pageBar}
                                        </div>
                                </form>
                                    </div>
                            	</div>
                             
                            </div>
                          </div>
					</div>
                </div>
			</div>
			<div id="hideBox" class="modal hide fade" tabindex="-1" role="dialog"  aria-hidden="true" style="display: none;">

                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>

                    <h3>隐藏后用户不可看到该评价，是否继续隐藏？</h3>

                </div>
				<form id="hideForm" action="/steward/list/detail/evaluateHide" method="post">
                <div class="modal-body">

                    <table width="100%" border="0" cellspacing="10" cellpadding="10">
                      <tr>
                        <td><font color="#FF0000">*</font>隐藏原因：</td>
                      </tr>
                      <tr>
                        <td><textarea id="reason" name="reason" rows="5" must-be="true" style="width:495px;"></textarea></td>
                      </tr>
                    </table>

                </div>

                <div class="modal-footer">

                    
                    <input type="hidden" name="vid" id="vid" value="" />
					<input type="hidden" name="from" id="from" value="" />
                    <a id="hideBtn" class="btn yellow">隐藏</a>
                    <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>

                </div>
				</form>
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

	<!-- BEGIN PAGE LEVEL SCRIPTS -->
	<script type="text/javascript" src="/views/media/js/jquery.dataTables.js"></script>
	<script src="/views/media/js/app.js" type="text/javascript"></script>
    <script src="/views/media/js/form-validate.js"></script>   
	<!-- END PAGE LEVEL SCRIPTS -->  

	<script> 
		jQuery(document).ready(function() {     
		    App.init(); // initlayout and core plugin 
			
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
			//绑定删除按钮
				$("i.icon-trash").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						 
						if(confirm("警告!删除之后数据数据将无法恢复!您确认要删除?")){
							$.post("/steward/list/detail/removeEvaluate",{"id":id},function(data){
								if(data.status==0){
									$(element).parent().parents("#list>tr").remove();
									location.reload();
								}
								else
									alert(data.msg);
							});
						} 
					});		
                });
				
				//设置为隐藏
				$("i.icon-eye-close").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						$("#vid").val(id);
						$("#from").val(location.href);
					});		
                });
				
				//设置为展示
				$("i.icon-eye-open").each(function(index, element) {
					$(this).click(function(e){
						var id = $(this).parent().parent().attr("data-id");
						 
						if(confirm("是否显示此信息到前台?")){
							$.post("/steward/list/detail/evaluateShow",{"id":id},function(data){
								if(data.status==0){
									location.reload();
								}
								else
									alert(data.msg);
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
			
			$("#hideBtn").click(function(e) {
                $("#hideForm").formValidate();
            });
		});
	</script>

	<!-- END JAVASCRIPTS -->
<!-- END BODY -->

</html>