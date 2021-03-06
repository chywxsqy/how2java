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
	<c:forEach items="${list }" var="lists">
		<p>
		<c:if test="${lists.types=='1' }">应聘者：</c:if>
		<c:if test="${lists.types=='2' }">人事部门：</c:if>
		${lists.content }(${lists.insertDate })</p><br>
	</c:forEach>
	
	
	
	<input type="hidden" value="${param.adminId }" name="adminId" id="adminId" />
		<center>
			<table class="mobile" style="width: 95%;">
				<tr height="25">
					<td class="outDetail" style="width: 30%">内容： <label
						style="font-weight: bold; color: red"> * </label></td>
					<td class="outDetail2">
					<textarea rows="5" cols="50" name="content" id="content"></textarea>	
						</td>
				</tr>
			</table>
		</center>
		<p align="center">
			<br> <input type="button" class="btn" value="保  存"
				onclick="save(this);" /> 
		</p>
		</form>
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
		var content = $("#content").val();
		$.post("editSavemessage.html", {adminId:'${param.adminId }',content:content}, function(result) {
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
