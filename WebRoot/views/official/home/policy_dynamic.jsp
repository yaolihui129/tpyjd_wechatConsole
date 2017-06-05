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
							首页设置
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
                            <li>基本设置</li>
                        </ul>
                    </div>
                </div>
                <!-- END PAGE HEADER-->
                <!-- BEGIN PAGE CONTENT-->

                <div class="row-fluid">
                    <div class="span12">
                        <div class="tabbable tabbable-custom">
                            <ul class="nav nav-tabs">
                            	<li> <a href="/official/home/successfulCase">成功案例</a></li>
								<li><a href="/official/home/estimateNumber">移民评估</a></li>
								<li class="active"><a href="javascript:;">政策动态</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active">
                                    <div class="portlet-body form">
                                         <!-- BEGIN FORM-->
                                         <form id="sform"  class="form-horizontal" method="post">
                                            <table class="table  table-bordered" id="para_table">  
											    <tr>  
											        <th style="text-align:center" width="100">编号</th>  
											        <th style="text-align:center" width="200">标题</th>  
											        <th style="text-align:center" width="100">操作</th>  
											    </tr>
											    <c:if test="${not empty policy_dynamic}">
											    <c:set value="${ fn:split(policy_dynamic, ',') }" var="policys" /> 
											    <c:forEach items="${ policys }" var="policy" varStatus="status">
												    <tr>  
												      <td  style="text-align:center; ">${status.count}</td>
												      <td  style="text-align:center; " class="policys">${policy}</i></td>  
												      <td  style="text-align:center; ">  
												        <button type="button"  class="btn btn-xs btn-link" onclick="edit_to_save(this)">编辑</button>  
												        <!-- <button type="button"  class="btn btn-xs btn-link" onclick="deletetr(this)">删除</button> -->
												      </td>
												      <!-- <td   style="text-align:center; " onclick="deletetr(this)">  
												        <button type="button"  class="btn btn-xs btn-link">删除</button>  
												      </td>  --> 
												    </tr> 
											    </c:forEach>
											    </c:if>
											</table>
											<!-- 超过三个不显示添加按钮 -->
											 <%-- <c:if test="${fn:length(policys) < 3}">
											<div id="addtrdiv" style="margin-top:-15px; width: 15%; float: right;">  
											      <button type="button" class="btn btn-xs btn-link" onclick="addtr()">添加</button></td>
											</div> 
											</c:if>   --%>
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
        function save_para_table(){  
            
            var tableinfo = gettableinfo();  
            alert(tableinfo);  
          
          
        }  
        //get table infomation  
        function gettableinfo(){  
            var key = "";  
            var value = "";  
            var tabledata = "";  
            var table = $("#para_table");  
            var tbody = table.children();  
            var trs = tbody.children();  
            for(var i=1;i<trs.length;i++){  
                var tds = trs.eq(i).children();  
                for(var j=0;j<tds.length;j++){  
                    if(j==0){  
                        if(tds.eq(j).text()==null||tds.eq(j).text()==""){  
                            return null;  
                        }  
                        key = "key\":\""+tds.eq(j).text();  
                    }  
                    if(j==1){  
                        if(tds.eq(j).text()==null||tds.eq(j).text()==""){  
                            return null;  
                        }  
                        value = "value\":\""+tds.eq(j).text();  
                    }  
                }  
                if(i==trs.length-1){  
                    tabledata += "{\""+key+"\",\""+value+"\"}";  
                }else{  
                    tabledata += "{\""+key+"\",\""+value+"\"},";  
                }  
            }  
            tabledata = "["+tabledata+"]";  
            return tabledata;  
        }  
        var resave = 0;
         function edit_to_save(buobject){
        	 if(resave == 0){
        		 resave = 1;
            	 var but=$(buobject);
            	 but.attr("onclick", "save(this)");
            	 //将按钮改为保存
                 but.text("保存")
                 var td = but.parent().prev();
            	 console.log(td);
            	 
            	//1,取出当前td中的文本内容保存起来  
                 var text=td.text();  
                 //2,清空td里面的内容  
                 td.html(""); //也可以用td.empty();  
                 //3，建立一个文本框，也就是input的元素节点  
                 var input=$("<input>");  
                 //4，设置文本框的值是保存起来的文本内容  
                 input.attr("value",text); 
               	//5，将文本框加入到td中  
                 td.append(input); 
        	 }else{
        		 alert("请先保存正在编辑的内容");
        	 }
         }
         
         function save(buobject){
        	 resave = 0
        	 var but=$(buobject);
        	 but.attr("onclick", "edit_to_save(this)");
        	 //将按钮改为编辑
             but.text("编辑");
             var td = but.parent().prev();
             var inputnode=td.children("input");
             var inputtext=inputnode.val();  
             //var tdNode=inputnode.parent();  
             td.html(inputtext);
             var policy_dynamic= "";
             //遍历获取全部标题并保存
             $(".policys").each(function(){
            	 policy_dynamic += $(this).text()+",";
             });
             policy_dynamic = policy_dynamic.substring(0,policy_dynamic.length-1);
             $.post(
						"/official/home/policyDynamic",
						{
							"policy_dynamic" : policy_dynamic,
							"operation":"${operation}"
						},
						function(data) {
							if (data.code == 0) {
								alert("保存成功！");
								window.location.reload();
							} else
								alert("保存失败！");
						});
         }
        function tdclick(tdobject){  
            var td=$(tdobject);  
            td.attr("onclick", "");  
            //1,取出当前td中的文本内容保存起来  
            var text=td.text();  
            //2,清空td里面的内容  
            td.html(""); //也可以用td.empty();  
            //3，建立一个文本框，也就是input的元素节点  
            var input=$("<input>");  
            //4，设置文本框的值是保存起来的文本内容  
            input.attr("value",text);  
            input.bind("blur",function(){  
                var inputnode=$(this);  
                var inputtext=inputnode.val();  
                var tdNode=inputnode.parent();  
                tdNode.html(inputtext);  
                tdNode.click(tdclick);  
                td.attr("onclick", "tdclick(this)");  
            });  
            input.keyup(function(event){  
                var myEvent =event||window.event;  
                var kcode=myEvent.keyCode;  
                if(kcode==13){  
                    var inputnode=$(this);  
                    var inputtext=inputnode.val();  
                    var tdNode=inputnode.parent();  
                    tdNode.html(inputtext);  
                    tdNode.click(tdclick);  
                }  
            });  
          
            //5，将文本框加入到td中  
            td.append(input);  
            var t =input.val();  
            input.val("").focus().val(t);  
        //              input.focus();  
          
            //6,清除点击事件  
            td.unbind("click");  
        }  
        function addtr(){  
            var table = $("#para_table");  
            var tr= $("<tr>" +  
                "<td >"+"</td>" +  
                "<td class='policys'>"+"</td>" +  
                "<td  align='center'><button type='button'  class='btn btn-xs btn-link' onclick='edit_to_save(this)'>"+"编辑"+"</button><button type='button'  class='btn btn-xs btn-link' onclick='deletetr(this)'>删除</button></td></tr>");  
            table.append(tr);  
        }  
        function deletetr(buobject){  
            var bu=$(buobject);  
            bu.parent("td").parents("tr").remove();
            var policy_dynamic= "";
            //遍历获取全部标题并保存
            $(".policys").each(function(){
           	 policy_dynamic += $(this).text()+",";
            });
            policy_dynamic = policy_dynamic.substring(0,policy_dynamic.length-1);
            $.post(
						"/official/home/policyDynamic",
						{
							"policy_dynamic" : policy_dynamic,
							"operation":"${operation}"
						},
						function(data) {
							if (data.code == 0) {
								alert("删除成功！");
								window.location.reload();
							} else
								alert("删除失败！");
						});
        }  
        	
        </script>

</body>
<!-- END BODY -->

</html>