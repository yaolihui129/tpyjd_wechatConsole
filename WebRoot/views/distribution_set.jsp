<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<link href="/views/media/css/publics.min.css" rel="stylesheet" type="text/css"/> 
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
	.tree a.tree-toggle{
		padding-left:20px;
	}
	</style>

</head>



<div class="w_content">
<input type="hidden" id="_clientId" value="0">
	<div class="w_left">
		<ul> 
			<li id="pan0" style="font-weight: bold;">预览</li>
			<li id="pan1"><i class="w_icon_ok"></i>会员管理</li>
			<li id="pan2"><i class="w_icon_ok"></i>项目管理</li>
			<li id="pan3"><i class="w_icon_ok"></i>流程跟踪</li>
			<li id="pan4"><i class="w_icon_ok"></i>投诉建议</li>
			<li id="pan5"><i class="w_icon_not"></i>系统日志</li> 
		</ul>
	</div>
	<div class="w_right widget-body" >
		<form class="form-horizontal no-margin"  id="upform"  name="upform"    enctype="multipart/form-data" >
			
		<span style="display: inline-block; float: left;width: 100%;">当前位置>首页>分销设置</span>
		<span style="font-weight: bold; font-size: 150%;margin-top: 5px;display: inline-block;">分销设置</span>


		<div  id="pan1_s" class="w_mian w_curr" style="border: 1px solid black; height: auto;">
			<span class="hidden-span-15">1</span>
				<span class="grade-span-marg-lef">一级分销模式设置</span><div class="form-group"></div>	
				
				<div class="form-group">
					<div class="col-sm-2 control-label">分销商分佣设置：</div>
					<div class="col-sm-3">
						<c:if test="${model1_size==0 }">
							<select class="form-control"  id="oneLevel_1_type_id" name="oneLevel_1_type_id"  >
								<c:forEach	items="${distributionTypes }"	var="distributionType">
									<option value="${distributionType.id }">${distributionType.typeName }</option>
								</c:forEach>
							</select>
						</c:if>
						
						<c:if test="${model1_size>0 }">
							<select class="form-control"  id="oneLevel_1_type_id" name="oneLevel_1_type_id"  >
								<c:forEach	items="${distributionTypes }"	var="distributionType">
									<c:forEach items="${distributionScales_model1 }" begin="0" end="0" var="ds_model1">
										<c:if test="${ds_model1.typeId== distributionType.id}">
											<option value="${distributionType.id }" selected="selected">${distributionType.typeName }</option>
										</c:if>
										<c:if test="${ds_model1.typeId!= distributionType.id}">
											<option value="${distributionType.id }">${distributionType.typeName }</option>
										</c:if>
									</c:forEach>
								</c:forEach>
							</select>
						</c:if>
						
					</div>
					<div class="col-sm-2 ">
						<c:if test="${model1_size==0 }">
							<input class="form-control" id="oneLevel_1_type_scale" name="oneLevel_1_type_scale"  placeholder="请输入比例"/>
						</c:if>
						<c:if test="${model1_size>0 }">
							<c:forEach items="${distributionScales_model1 }" begin="0" end="0" var="ds_model1">
								<input class="form-control" id="oneLevel_1_type_scale" name="oneLevel_1_type_scale"  value=' <fmt:formatNumber type="number" value="${ds_model1.typeScale*100 }"   maxFractionDigits="11"/> ' />
							</c:forEach>
						</c:if>
					</div>
					<div class="col-sm-1">
						<span style=" float:left; margin-top: 8px;">%</span>
					</div>
					<div class="col-sm-2">
						<span class="distribution_add_img"	onclick="oneLevelAdd();"></span>
					</div>
				</div>
				
			
				<c:if test="${model1_size>1 }">
					<c:forEach items="${distributionScales_model1 }" begin="1" end="${model1_size+1 }" varStatus="commend_index" var="ds_model1_ss">
							<!-- id='oneLevelDel_div_ -->
							<div class="form-group" id="oneLevelDel_div_${commend_index.index}">
								<div class="col-sm-2 control-label"></div>
								<div class="col-sm-3">
									<c:if test="${model1_size>1 }">
										<select class="form-control"  id="oneLevel_1_type_id" name="oneLevel_1_type_id"  >
											<c:forEach	items="${distributionTypes }"	var="distributionType">
												<c:forEach items="${distributionScales_model1 }" begin="${commend_index.index }" end="${commend_index.index }" var="ds_model1">
													<c:if test="${ds_model1.typeId== distributionType.id}">
														<option value="${distributionType.id }" selected="selected">${distributionType.typeName }</option>
													</c:if>
													<c:if test="${ds_model1.typeId!= distributionType.id}">
														<option value="${distributionType.id }">${distributionType.typeName }</option>
													</c:if>
												</c:forEach>
											</c:forEach>
										</select>
									</c:if>
									
								</div>
								
								<div class="col-sm-2 ">
									<c:if test="${model1_size==0 }">
										<input class="form-control" id="oneLevel_1_type_scale" name="oneLevel_1_type_scale"  placeholder="请输入比例"/>
									</c:if>
									<c:if test="${model1_size>1 }">
										<c:forEach items="${distributionScales_model1 }" begin="${commend_index.index }" end="${commend_index.index }" var="ds_model1">
											<input class="form-control" id="oneLevel_1_type_scale" name="oneLevel_1_type_scale"  value=' <fmt:formatNumber type="number" value="${ds_model1.typeScale*100 }"   maxFractionDigits="11"/> ' />
										</c:forEach>
									</c:if>
								</div>
								<div class="col-sm-1">
									<span style=" float:left; margin-top: 8px;">%</span>
								</div>
								<div class="col-sm-2">
									<span class="distribution_add_img"	onclick="oneLevelAdd();"></span>
									<span class='distribution_del_img' id='ddd' onclick='oneLevelDel(${commend_index.index})'></span>
								</div>
							</div>
							
						</c:forEach>
				</c:if>
				<input  type="hidden" id="model1_size" name="model1_size" value="${model1_size }">
				<input  type="hidden" id="model2_size" name="model2_size" value="${model1_size }">
				
				<div id="pan1_s_end" class="form-group" style="height: 30px;"></div>	
			
		</div>
		
		
		
	
	
	
		<div  id="pan2_s" class="w_mian w_curr"  style="border: 1px solid black; margin-top: 20px;">
			<span class="hidden-span-15">1</span>
				<span class="grade-span-marg-lef">二级分销模式设置</span>
				<div class="form-group"></div>	
				<div class="form-group">
					<div class="col-sm-2 control-label">一级分销商分佣：</div>
					<div class="col-sm-3">
						
						<c:if test="${model2_size==0 }">
							<select class="form-control"  id="twoLevel_1_type_id" name="twoLevel_1_type_id" onchange="funChange('twoLevel_1_type_id');" path="asset" >
								<c:forEach	items="${distributionTypes }"	var="distributionType">
									<option value="${distributionType.id }">${distributionType.typeName }</option>
								</c:forEach>
							</select>
						</c:if>
						
						<c:if test="${model2_size>0 }">
							<select class="form-control"  id="twoLevel_1_type_id" name="twoLevel_1_type_id" onchange="funChange('twoLevel_1_type_id');" path="asset" >
								<c:forEach	items="${distributionTypes }"	var="distributionType">
									<c:forEach items="${distributionScales_model2 }" begin="0" end="0" var="ds_model2">
										<c:if test="${ds_model2.typeId==distributionType.id }">
											<option value="${distributionType.id }" selected="selected">${distributionType.typeName }</option>
										</c:if>
										<c:if test="${ds_model2.typeId!=distributionType.id }">
											<option value="${distributionType.id }">${distributionType.typeName }</option>
										</c:if>
									</c:forEach>
								</c:forEach>
							</select>
						</c:if>
						
						<%-- <c:if test="${model2_size>0 }">
							
						</c:if> --%>
						
						<%-- <select class="form-control"  id="twoLevel_1_type_id" name="twoLevel_1_type_id" onchange="funChange('twoLevel_1_type_id');" path="asset" >
							<c:forEach	items="${distributionTypes }"	var="distributionType">
								<option value="${distributionType.id }">${distributionType.typeName }</option>
							</c:forEach>
						</select> --%>
					</div>
					
					<div class="col-sm-2 ">
						<c:if test="${model2_size==0 }">
							<input class="form-control" id="twoLevel_1_type_scale" name="twoLevel_1_type_scale"  placeholder="请输入比例"/>
						</c:if>
						
						<c:if test="${model2_size!=0 }">
							<c:forEach items="${distributionScales_model2 }" begin="0" end="0" var="ds_model2">
								<input class="form-control" id="twoLevel_1_type_scale" name="twoLevel_1_type_scale" value=' <fmt:formatNumber type="number" value="${ds_model2.level1Scale*100 }"   maxFractionDigits="11"/> ' />
							</c:forEach>
						</c:if>
						
					</div>
					<div class="col-sm-1">
						<span style=" float:left; margin-top: 8px;">%</span>
					</div>
					<div class="col-sm-2">
						<span class="distribution_add_img" onclick="twoLevelAdd_1()"></span>
					</div>
				</div>
				
				
				<c:if test="${model2_size>1 }">
					<c:forEach items="${distributionScales_model2 }" begin="1" end="${model2_size+1 }" varStatus="commend_index" >
					
							<div class="form-group"  id="twoLevelDel_div_1_${commend_index.index }">
								<div class="col-sm-2 control-label"></div>
								<div class="col-sm-3">
									
									<c:if test="${model2_size==0 }">
										<select class="form-control"  id="twoLevel_1_type_id" name="twoLevel_1_type_id" onchange="funChange('twoLevel_1_type_id');" path="asset" >
											<c:forEach	items="${distributionTypes }"	var="distributionType">
												<option value="${distributionType.id }">${distributionType.typeName }</option>
											</c:forEach>
										</select>
									</c:if>
									
									<c:if test="${model2_size>1 }">
										<select class="form-control"  id="twoLevel_1_type_id${commend_index.index }" name="twoLevel_1_type_id" onchange="funChange_A('${commend_index.index}');" path="asset" >
											<c:forEach	items="${distributionTypes }"	var="distributionType">
												<c:forEach items="${distributionScales_model2 }" begin="${commend_index.index}" end="${commend_index.index}" var="ds_model2">
													<c:if test="${ds_model2.typeId==distributionType.id }">
														<option value="${distributionType.id }" selected="selected">${distributionType.typeName }</option>
													</c:if>
													<c:if test="${ds_model2.typeId!=distributionType.id }">
														<option value="${distributionType.id }">${distributionType.typeName }</option>
													</c:if>
												</c:forEach>
											</c:forEach>
										</select>
									</c:if>
									
								</div>
								
								<div class="col-sm-2 ">
									<c:if test="${model2_size==0 }">
										<input class="form-control" id="twoLevel_1_type_scale" name="twoLevel_1_type_scale"  placeholder="请输入比例"/>
									</c:if>
									
									<c:if test="${model2_size>1 }">
										<c:forEach items="${distributionScales_model2 }" begin="${commend_index.index}" end="${commend_index.index}" var="ds_model2_v">
											<input class="form-control" id="twoLevel_1_type_scale" type="text" name="twoLevel_1_type_scale" value=' <fmt:formatNumber type="number" value="${ds_model2_v.level1Scale*100 }"   maxFractionDigits="11"/> ' />
										</c:forEach>
									</c:if>
									
								</div>
								<div class="col-sm-1">
									<span style=" float:left; margin-top: 8px;">%</span>
								</div>
								<div class="col-sm-2">
									<span class="distribution_add_img" onclick="twoLevelAdd_1()"></span>
									<span class='distribution_del_img'   onclick='twoLevelDel_1("${commend_index.index}")'></span>
								</div>
							</div>
								
					</c:forEach>
					
				</c:if>
			
				
				
				<div class="form-group"  id="pan2_s_end_1" style="height: 20px;"></div><div class="form-group"></div>
				
				
				
				
				<div class="form-group">
					<div class="col-sm-2 control-label">二级分销商分佣：</div>
					<div class="col-sm-3">
						<c:if test="${model2_size==0 }">
							 <input	 class="form-control" id="twoLevel_2_type_id" style="cursor: default; background-color: white;" name="twoLevel_2_type_id" readonly="readonly" type="text"    />
						 </c:if>
						 <c:if test="${model2_size>0 }">
							 <input	 class="form-control" id="twoLevel_2_type_id" style="cursor: default; background-color: white;" name="twoLevel_2_type_id" readonly="readonly" type="text"    />
						 </c:if>
						 <%-- <select class="form-control"  id="twoLevel_2_type_id" name="twoLevel_2_type_id"  path="asset" >
							<c:forEach	items="${distributionTypes }"	var="distributionType">
								<option value="${distributionType.id }">${distributionType.typeName }</option>
							</c:forEach>
						</select> --%>
					</div>
					
					<div class="col-sm-2 ">
						<c:if test="${model2_size==0 }">
							<input class="form-control" id="twoLevel_2_type_scale" name="twoLevel_2_type_scale" type="text"   placeholder="请输入比例"/>
						</c:if>
						<c:if test="${model2_size>0 }">
							<c:forEach items="${distributionScales_model2 }" begin="0" end="0" var="ds_model2">
								<input class="form-control" id="twoLevel_2_type_scale" name="twoLevel_2_type_scale" type="text"   value=' <fmt:formatNumber type="number" value="${ds_model2.level2Scale*100 }"   maxFractionDigits="11"/> ' />
							</c:forEach>
						</c:if>
					</div>
					<div class="col-sm-1">
						<span style=" float:left; margin-top: 8px;">%</span>
					</div>
					<div class="col-sm-2">
						<span class="distribution_add_img" onclick="twoLevelAdd_1()"></span>
					</div>
				</div>
				
				
				<c:if test="${model2_size>1 }">
						<c:forEach items="${distributionScales_model2 }" begin="1" end="${model2_size+1 }" varStatus="commend_index" >
							
							<div class="form-group"   id="twoLevelDel_div_2_${commend_index.index }">
								<div class="col-sm-2 control-label"></div>
								<div class="col-sm-3">
									 <%-- <c:if test="${model2_size>1 }">
											 <input	 class="form-control" id="twoLevel_2_type_id" value="$" style="cursor: default; background-color: white;" name="twoLevel_2_type_id" readonly="readonly" type="text"    />
									 </c:if> --%>
									 <c:if test="${model1_size>1 }">
											<c:forEach	items="${distributionTypes }"	var="distributionType">
											
												<c:forEach items="${distributionScales_model2 }" begin="${commend_index.index }" end="${commend_index.index }" var="ds_model1">
													<c:if test="${ds_model1.typeId== distributionType.id}">
														 <input	 class="form-control" id="twoLevel_2_type_id${commend_index.index }" value="${distributionType.typeName }" style="cursor: default; background-color: white;" name="twoLevel_2_type_id" readonly="readonly" type="text"    />
									
													</c:if>
												</c:forEach>
											</c:forEach>
									</c:if>
								</div>
								<div class="col-sm-2 ">
									<c:if test="${model2_size==0 }">
										<input class="form-control" id="twoLevel_2_type_scale" name="twoLevel_2_type_scale" type="text"   placeholder="请输入比例"/>
									</c:if>
									<c:if test="${model2_size>1 }">
										<c:forEach items="${distributionScales_model2 }" begin="${commend_index.index}" end="${commend_index.index}" var="ds_model2">
											<input class="form-control" id="twoLevel_2_type_scale" name="twoLevel_2_type_scale" type="text"  value=' <fmt:formatNumber type="number"  value="${ds_model2.level2Scale*100}"   maxFractionDigits="11"/> '/>
										</c:forEach>
									</c:if>
								</div>
								<div class="col-sm-1">
									<span style=" float:left; margin-top: 8px;">%</span>
								</div>
								<div class="col-sm-2">
									<span class="distribution_add_img" onclick="twoLevelAdd_1()"></span>
									<span class='distribution_del_img'  onclick='twoLevelDel_1("${commend_index.index}")'></span>
								</div>
							</div>
						</c:forEach>
				</c:if>
				<div class="form-group" style="height: 30px;"  id="pan2_s_end_2"></div>			
		</div>
		
		 <div class="col-sm-offset-1 col-sm-10" style="margin-top: 60px;">
               <button type="button" class="btn btn-info" id="saveSet"  style="width:200px; ">保存</button>
               <button type="button" class="btn btn-info" onclick="publicReturnList('/distribution/set');" style="width:200px; margin-left: 20%;">返回</button>
          </div>
		<div  class="w_mian w_curr"  style=" margin-top: 130px;visibility:hidden;"><div class="form-group" >1</div></div>
	</form>	
	</div>
</div>
<script type="text/javascript">
	document.getElementById('twoLevel_2_type_id').value=$('#twoLevel_1_type_id   option:selected').text();
</script>

<script type="text/javascript">

	//document.getElementById('twoLevel_2_type_id').value=$('#twoLevel_1_type_id   option:selected').text();
	

</script>

<script type="text/javascript">

function funChange(data) {
	 	var vs = $('#twoLevel_1_type_id   option:selected').text();
     	document.getElementById('twoLevel_2_type_id').value=vs;
   		
     }    
function funChange_A(e){
		var  temp_1="#twoLevel_1_type_id"+e+"  option:selected";
		var vs = $(temp_1).text();
		var  temp_2="twoLevel_2_type_id"+e;
		document.getElementById(temp_2).value=vs;
}     
$(function(){
	
		$("#saveSet").click(function(){
			var checkNullIndex="ok"; 
		var oneLevelArray_1_type_id=[];
		var oneLevelArray_1_type_scale=[];
		var	oneLevel_1_type_id =document.getElementsByName("oneLevel_1_type_id");
		var oneLevel_1_type_scale = document.getElementsByName("oneLevel_1_type_scale");
		
		var twoLevelArray_1_type_id=[];
		var twoLevelArray_1_type_scale=[];
		var	twoLevel_1_type_id =document.getElementsByName("twoLevel_1_type_id");
		var twoLevel_1_type_scale = document.getElementsByName("twoLevel_1_type_scale");
		
		var twoLevelArray_2_type_id=[];
		var twoLevelArray_2_type_scale=[];
		var	twoLevel_2_type_id =document.getElementsByName("twoLevel_2_type_id");
		var twoLevel_2_type_scale = document.getElementsByName("twoLevel_2_type_scale");
		
		
		if(checkNullIndex=="ok"){	
			for(var i=0;i<oneLevel_1_type_id.length;i++){
				for(var j=i+1;j<oneLevel_1_type_id.length;j++){
					if(j<oneLevel_1_type_id.length){
						if(oneLevel_1_type_id[i].value==oneLevel_1_type_id[j].value){
							alert("一级模式下存在相同类型佣金类型,请切换类型!");
							checkNullIndex="error";break; 
						}
					}
				}
				oneLevelArray_1_type_id[i]=oneLevel_1_type_id[i].value;
				//alert(oneLevelArray_1_type_id[i].value);
				if(checkNullIndex=="error")break; 
			}
		}
		if(checkNullIndex=="ok"){
			for(var i=0;i<oneLevel_1_type_scale.length;i++){
				oneLevelArray_1_type_scale[i]=oneLevel_1_type_scale[i].value;
				if(oneLevel_1_type_scale[i].value==""){
					checkNullIndex="error";
					alert("请完整设置一级模式下比例值!");break; 
				}else  if(isNaN(oneLevel_1_type_scale[i].value)){
					checkNullIndex="error";
					alert("请设置一级模式下比例含非法字符!");break;
				}
			}	
		}
		/*二级模式下---1级*/
		if(checkNullIndex=="ok"){
			for(var i=0;i<twoLevel_1_type_id.length;i++){
				for(var j=i+1;j<twoLevel_1_type_id.length;j++){
					if(j<twoLevel_1_type_id.length){
						if(twoLevel_1_type_id[i].value==twoLevel_1_type_id[j].value){
							alert("二级模式下1级分销存在相同类型佣金类型,请切换类型!");
							checkNullIndex="error";break; 
						}
					}
				}
				twoLevelArray_1_type_id[i]=twoLevel_1_type_id[i].value ;
				if(checkNullIndex=="error")break; 
			}
		}
		if(checkNullIndex=="ok"){
			for(var i=0;i<twoLevel_1_type_scale.length;i++){ 
				twoLevelArray_1_type_scale[i]=twoLevel_1_type_scale[i].value;
				if(twoLevel_1_type_scale[i].value==""){
					checkNullIndex="error";
					alert("请完整设置二级模式1级分销下比例值!");break; 
				}else  if(isNaN(twoLevel_1_type_scale[i].value)){
					checkNullIndex="error";
					alert("请设置二级模式1级分销下比例含非法字符!");break;
				}
			}	
		} 
		/*二级模式下---2----级*/
		if(checkNullIndex=="ok"){
			for(var i=0;i<twoLevel_2_type_id.length;i++){
				for(var j=i+1;j<twoLevel_2_type_id.length;j++){
					if(j<twoLevel_2_type_id.length){
						if(twoLevel_2_type_id[i].value==twoLevel_2_type_id[j].value){
							alert("二级模式2级分销下存在相同类型佣金类型,请切换类型!");
							checkNullIndex="error";break; 
						}
					}
				}
				twoLevelArray_2_type_id[i]=twoLevel_2_type_id[i].value;
				if(checkNullIndex=="error")break; 
			}
		}
		if(checkNullIndex=="ok"){
			for(var i=0;i<twoLevel_2_type_scale.length;i++){ 
				twoLevelArray_2_type_scale[i]=twoLevel_2_type_scale[i].value;
				if(twoLevel_2_type_scale[i].value==""){
					checkNullIndex="error";
					alert("请完整设置二级模式2级分销下比例值!");break; 
				}else  if(isNaN(twoLevel_2_type_scale[i].value)){
					checkNullIndex=="error";
					alert("请设置二级模式2级分销下比例含非法字符!");break;
				}
			}	
		}
		if(checkNullIndex=="ok"){
			/* var data = {
				'oneLevelArray_1_type_id':oneLevelArray_1_type_id,
				'oneLevelArray_1_type_scale':oneLevelArray_1_type_scale,
				
				'twoLevelArray_1_type_id':twoLevelArray_1_type_id,
				'twoLevelArray_1_type_scale':twoLevelArray_1_type_scale,
				
				'twoLevelArray_2_type_id':twoLevelArray_2_type_id,
				'twoLevelArray_2_type_scale':twoLevelArray_2_type_scale
			} */
			
		/* 	var formData=  new FormData(document.getElementById("upform"));
		    formData.append("oneLevelArray_1_type_id",oneLevelArray_1_type_id);
		    formData.append("oneLevelArray_1_type_scale",oneLevelArray_1_type_scale);
		    formData.append("twoLevelArray_1_type_id",twoLevelArray_1_type_id);
		    formData.append("twoLevelArray_1_type_scale",twoLevelArray_1_type_scale);
		    formData.append("twoLevelArray_2_type_id",twoLevelArray_2_type_id);
		    formData.append("twoLevelArray_2_type_scale",twoLevelArray_2_type_scale); */
			 $.ajax({  
				    url: '/distribution/sets/save',  
				    data: {"oneLevelArray_1_type_id":oneLevelArray_1_type_id,
				     "oneLevelArray_1_type_scale":oneLevelArray_1_type_scale, 
				     "twoLevelArray_1_type_id":twoLevelArray_1_type_id,
				      "twoLevelArray_1_type_scale":twoLevelArray_1_type_scale,
				       "twoLevelArray_2_type_id":twoLevelArray_2_type_id, 
				        "twoLevelArray_2_type_scale":twoLevelArray_2_type_scale},
				    dataType: "json",
				    type: "POST",
				    traditional: true,  
				    success: function (responseJSON) { 
				    	if("success"==responseJSON.message){
				    		alert(responseJSON.message);
				    	}else{
				    		alert(responseJSON.message);
				    	}
				    }  
				}); 
			}
		});
});

</script>
	






<script type="text/javascript">
	var oneLevelDel_div=1;
	var twoLevelDel_div_1=1;
	var oneLevelDel_div_temp= document.getElementById("model1_size").value;
	var twoLevelDel_div_1_temp= document.getElementById("model2_size").value;
	
	oneLevelDel_div=oneLevelDel_div_temp*1+1;
	twoLevelDel_div_1=twoLevelDel_div_1_temp*1+1;
	
	function oneLevelAdd(){
		/* if(oneLevelDel_div_temp>0){
			oneLevelDel_div
		} */
		$("#pan1_s_end").before("<div class='form-group' id='oneLevelDel_div_"+oneLevelDel_div+"'>"+
			"<div class='col-sm-2 control-label'></div>"+
			"<div class='col-sm-3'>"+
				"<select class='form-control'  id='oneLevel_1_type_id' name='oneLevel_1_type_id'  path='asset' >"+
					"<c:forEach	items='${distributionTypes }'	var='distributionType'>"+
						"<option value='${distributionType.id }'>${distributionType.typeName }</option>"+
					"</c:forEach>"+
				"</select>"+
			"</div>"+
			"<div class='col-sm-2 '>"+
				"<input class='form-control' id='oneLevel_1_type_scale' name='oneLevel_1_type_scale'  placeholder='请输入比例'/>"+
			"</div>"+
			"<div class='col-sm-1'>"+
				"<span style=' float:left; margin-top: 8px;'>%</span>"+
			"</div>"+
			"<div class='col-sm-2'>"+
				"<span class='distribution_add_img' onclick='oneLevelAdd()'></span>"+
				/* "<span class='distribution_del_img' ></span>"+ */
				 "<span class='distribution_del_img' id='ddd' onclick='oneLevelDel("+oneLevelDel_div+")'></span>"+ 
			"</div>"+
		"</div>");
		//$("#pan1_s_end").before("#pan1_s").append(); 
		oneLevelDel_div=oneLevelDel_div+1;
		$("#pan1_s").css("height","auth");
	}
	
	var commend_tow_1=1;
	var commend_tow_1_re=document.getElementById("model2_size").value;
	commend_tow_1=commend_tow_1_re*1+1;
	function twoLevelAdd_1(){
		$("#pan2_s_end_1").before("<div class='form-group' id='twoLevelDel_div_1_"+commend_tow_1+"'>"+
			"<div class='col-sm-2 control-label'></div>"+
			"<div class='col-sm-3'>"+
				"<select class='form-control'  id='twoLevel_1_type_id"+commend_tow_1+"' name='twoLevel_1_type_id'  onchange='funChange_A("+commend_tow_1+");' path='asset' >"+
					"<c:forEach	items='${distributionTypes }'	var='distributionType'>"+
						"<option value='${distributionType.id }'>${distributionType.typeName }</option>"+
					"</c:forEach>"+
				"</select>"+
			"</div>"+
			
			"<div class='col-sm-2 '>"+
				"<input class='form-control' id='twoLevel_1_type_scale' name='twoLevel_1_type_scale'  placeholder='请输入比例'/>"+
			"</div>"+
			"<div class='col-sm-1'>"+
				"<span style=' float:left; margin-top: 8px;'>%</span>"+
			"</div>"+
			"<div class='col-sm-2'>"+
				"<span class='distribution_add_img' onclick='twoLevelAdd_1()'></span>"+
				 "<span class='distribution_del_img'   onclick='twoLevelDel_1("+twoLevelDel_div_1+")'></span>"+ 
			"</div>"+
		"</div>");
		
		
		$("#pan2_s_end_2").before("<div class='form-group' id='twoLevelDel_div_2_"+commend_tow_1+"'>"+
			"<div class='col-sm-2 control-label'></div>"+
			"<div class='col-sm-3'>"+
				"<input	 class='form-control' id='twoLevel_2_type_id"+commend_tow_1+"' style='cursor: default; background-color: white;' name='twoLevel_2_type_id' readOnly='true' type='text'    />"+
			"</div>"+
			
			"<div class='col-sm-2 '>"+
				"<input class='form-control' id='twoLevel_2_type_scale' name='twoLevel_2_type_scale'   placeholder='请输入比例'/>"+
			"</div>"+
			"<div class='col-sm-1'>"+
				"<span style=' float:left; margin-top: 8px;'>%</span>"+
			"</div>"+
			"<div class='col-sm-2'>"+
				"<span class='distribution_add_img' onclick='twoLevelAdd_1()'></span>"+
				 "<span class='distribution_del_img'  onclick='twoLevelDel_1("+twoLevelDel_div_1+")'></span>"+ 
			"</div>"+
		"</div>");
		
	    twoLevelDel_div_1=twoLevelDel_div_1+1;
		var  temp_1="#twoLevel_1_type_id"+commend_tow_1+"  option:selected";
		var vs = $(temp_1).text();
		var  temp_2="twoLevel_2_type_id"+commend_tow_1;
		document.getElementById(temp_2).value=vs;
		$("#pan2_s").css("height","auth");
		commend_tow_1=commend_tow_1+1;
	}
	
	
</script>