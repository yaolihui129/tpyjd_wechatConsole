<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="//cdn.bootcss.com/SyntaxHighlighter/3.0.83/styles/shCore.min.css" rel="stylesheet">
    <link href="//cdn.bootcss.com/SyntaxHighlighter/3.0.83/styles/shThemeDefault.min.css" rel="stylesheet">
    <!-- nePlayer CSS -->
    <link href="//nos.netease.com/vod163/nep.min.css" rel="stylesheet">
						<div class="row-fluid">
							<div class="span9 ">
								<div class="control-group">
									<label class="control-label">直播间${live.channelId }：${live.liveTitle }
										<c:if test="${living == live.liveStatus }">
											<button class="btn mini red" style="margin-left: 100px;" id="btnEndLive"><i class="icon-off"></i> 结束直播 </button>
										</c:if>
									</label>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 ">
								<div class="control-group">
									<label class="control-label">直播简介：${live.liveIntroduce }</label>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span6 ">
								<div class="control-group">
									<label class="control-label">直播开始时间：<fmt:formatDate value="${live.liveStartTime }" pattern="yyyy年MM月dd日 HH:mm"/></label>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span9 ">
								<div class="control-group">
									<label class="control-label" id="continuedTime">直播持续时间：</label>
									<script type="text/javascript">
										window.onload = 
											function continuedTime()
										{
											var HH = ${h};
											var mm = ${m};
											var ss = ${s};
											var str = '';
											var timer = setInterval(function(){
												str = "";												
												if(++ss==60)
												{
													if(++mm==60)
													{
														HH++;
														mm=0;
													}
													ss=0;
												}
												
												str+=HH<10?"0"+HH:HH;
												str+="小时";
												str+=mm<10?"0"+mm:mm;
												str+="分钟";
												str+=ss<10?"0"+ss:ss;
												str+="秒";
												document.getElementById("continuedTime").innerHTML = "直播持续时间："+str;
											},1000);

										}
										
										//结束直播
										   $("#btnEndLive").click(function(e) {
								               alert("调用接口结束直播");
								           });
									</script>
								</div>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span9 ">
								<video id="my-video" class="video-js vjs-big-play-centered" x-webkit-airplay="allow" webkit-playsinline controls poster="//nos.netease.com/vod163/poster.png" preload="auto" width="960" height="540" data-setup="{}">
						            <source src="${channel.hlsPullUrl }" type="application/x-mpegURL">
						        </video>
							</div>
						</div>
						<div class="row-fluid">
							<div class="span9 ">
								<label style="line-height: 20px;"></label>
							</div>
						</div>
						<script src="//nos.netease.com/vod163/nep.min.js"></script>