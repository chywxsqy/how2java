<%@ page language="java" errorPage="/error.jsp" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
var ctx='${ctx}';
</script>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="chinaz">
	<meta name="author" content="webThemez.com">
	<title>网上招聘系统</title>
	<link rel="favicon" href="${ctx }/resource/assets/images/favicon.png">
	<link rel="stylesheet" href="${ctx }/resource/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctx }/resource/assets/css/font-awesome.min.css"> 
	<link rel="stylesheet" href="${ctx }/resource/assets/css/bootstrap-theme.css" media="screen"> 
	<link rel="stylesheet" href="${ctx }/resource/assets/css/style.css">
    <link rel='stylesheet' id='camera-css'  href='${ctx }/resource/assets/css/camera.css' type='text/css' media='all'> 
	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="${ctx }/resource/assets/js/html5shiv.js"></script>
	<script src="${ctx }/resource/assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<body>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right mainNav">
					<li class="active"><a href="index.html">首页</a></li>
					<li><a href="${ctx }/customer/mine.html">我的推荐岗位</a></li>
					<li><a href="${ctx }/customer/detail.html">我的电子简历</a></li>
					<c:if test="${customerBean!=null }">
					<li><a href="${ctx }/customerLogin/out.html">注销(${customerBean.username })</a></c:if>
					<c:if test="${customerBean==null }">
					<li><a href="${ctx }/customerLogin/login.html">登录/注册</a></li>
					</c:if>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

	
	<div class="container" style="background-color: #E3FFFF;">
	<form id="form1" name="form1" action="" method="post">
	<input type="hidden" value="${map.id }" name="id" id="id" />
		<center>
			<table class="mobile" style="width: 95%;">
				<tr height="25">
					<td class="outDetail" style="width: 30%">账号： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">${map.username }</td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">密码： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2"><input type="text"
						value="${map.password }" name="password" /></td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">姓名： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2"><input type="text" value="${map.name }"
						name="name" /></td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">年龄： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2"><input type="text" value="${map.age }"
						name="age" /></td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">性别： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<select name="sex">
							<option value="">请选择...</option>
							<option value="男" ${map.sex=='男'?'selected':'' }>男</option>
							<option value="女" ${map.sex=='女'?'selected':'' }>女</option>
					</select>						
						</td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">学历： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<select name="xlId">
						<option value="">请选择...</option>
							<c:forEach items="${xlList }" var="xlLists">
								<option value="${xlLists.id }" ${map.xlId==xlLists.id?'selected':'' }>${xlLists.v1
									}</option>
							</c:forEach>
					</select>	
						
						</td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">岗位： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<select name="gwId">
						<option value="">请选择...</option>
							<c:forEach items="${gwList }" var="gwLists">
								<option value="${gwLists.id }" ${map.gwId==gwLists.id?'selected':'' }>${gwLists.v1
									}</option>
							</c:forEach>
					</select>
						</td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">薪水： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<select name="fwId">
						<option value="">请选择...</option>
							<c:forEach items="${fwList }" var="fwLists">
								<option value="${fwLists.id }" ${map.fwId==fwLists.id?'selected':'' }>${fwLists.v1
									}</option>
							</c:forEach>
					</select>	
						</td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">简介： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<textarea rows="5" cols="50" name="content">${map.content }</textarea>	
						</td>
				</tr>
				<tr height="25">
					<td class="outDetail" style="width: 30%">详细简历： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<input id="f_file" name="cmfile"
						onchange="triggerUpload(this);" title="选择简历附件" type="file">
						<input class="text" type="hidden" name="fileUrl" id="bbbbb" value="${map.fileUrl }">
						<c:if test="${map.fileUrl!=null }">
							<a href="${ctx }/${fileUrl}" id="aaaaa">简历</a>
						</c:if>
						
						
						</td>
				</tr> 
				<tr height="25">
					<td class="outDetail" style="width: 30%">是否首页推荐： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<select name=huiyuan>
							<option value="否" ${map.huiyuan=='否'?'selected':'' }>否</option>
							<option value="是" ${map.huiyuan=='是'?'selected':'' }>是</option>
					</select>						
						</td>
				</tr>
			</table>
		</center>
		<p align="center">
			<br> <input type="button" class="btn" value="保  存"
				onclick="save(this);" /> 
		</p>
		<form id="form1" name="form1" action="" method="post">
	</div>
	
	<hr>
	<div class="container" style="background-color: #F2FFFF;">
		<h3 style="color: blue;">适合您的岗位（如果没有推荐，请完善您的个人信息）</h3>
		<div class="row">
				<c:forEach items="${mineList }" var="lists">
				<div class="col-md-4">
					<div class="featured-box"> 
						<div class="text">
							<h3>岗位名称：${lists.gwName }</h3>
							学历要求：${lists.xlName }<br>薪资范围：${lists.fwName }<br>
							招聘人数：${lists.number }<br>
							技能要求：${lists.jn }<br>
							高校名称：${lists.title }<br>
							高校地址：${lists.address }<br>
							高校简介：${lists.content }
						</div>
					</div>
				</div>
				</c:forEach>
		</div>
	</div>
     
    <footer id="footer">
		<div class="footer2">
			<div class="container">
				<div class="row">

					<div class="col-md-6 panel">
						<div class="panel-body">
							<p class="text-right">
								Copyright &copy; 2020.Company name All rights reserved.
							</p>
						</div>
					</div>

				</div>
				<!-- /row of panels -->
			</div>
		</div>
	</footer>

	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="${ctx}/resource/admin/js/jquery-1.7.1.js" type="text/javascript"></script>
<script type="text/javascript"
	src="${ctx}/resource/admin/js/ajaxfileupload.js"></script>
	<script src="${ctx }/resource/assets/js/modernizr-latest.js"></script> 
    <script type='text/javascript' src='${ctx }/resource/assets/js/fancybox/jquery.fancybox.pack.js'></script>
    <script type='text/javascript' src='${ctx }/resource/assets/js/jquery.mobile.customized.min.js'></script>
    
</body>
<script type="text/javascript">
		function deleteOne(id){
		if(!confirm("确定要取消订单吗?")){
			return false;
		}
		var params={id:id};
		$.post("${ctx}/admin/order/editDelete.html",params,function(
				result){
			result=eval("("+result+")");
			if(result.status=="true"||result.status==true){
				alert('成功');
				window.location.reload();
			}
		});
	}
	
		function save(src) {
		$.post("editSave.html", $("#form1").serializeArray(), function(result) {
			result = eval("(" + result + ")");
			if (result.status == "true" || result.status == true) {
				alert('成功');
				window.location.reload();
			} else {
				alert('保存失败，请重试');
			}
		});
	}
	
	function triggerUpload(src) {
		$.ajaxFileUpload({
			url : '${ctx}/file/upload.json',
			secureuri : false,
			fileElementId : 'f_file',
			dataType : 'json',
			data : {
				fileloc : 'upload/',
				dir : 'temp'
			},
			success : function(data, status) {
				$("input[name='fileUrl']").val(data.data.filepath);
				$("#aaaaa").remove();
				$("#bbbbb").after("<a href=\"${ctx }/"+data.data.filepath+"\" id=\"aaaaa\">简历</a>");
			},
			error : function(data, status, e) {
				alert('文件上传失败');
			}
		});
	}
</script>
</html>
