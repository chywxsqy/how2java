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
					<li><a href="${ctx }/admin/zp/dzList2.html" target="_blank">我的电子简历投递</a>
					<li><a href="${ctx }/customerLogin/out.html">注销(${customerBean.username })</a></c:if>
					<c:if test="${customerBean==null }">
					<li><a href="${ctx }/customerLogin/login.html">登录/注册</a></li>
					</c:if>
					<li><a href="${ctx }/resource/jlmb.doc">简历模板下载</a></li>
					<li><a href="${ctx }/admin/zp/dzList3.html" target="_blank">拟聘人员</a></li>

				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

	<!-- Header -->
	<header id="head">
		<div class="container">
             <div class="heading-text">							
							<h1 class="animated flipInY delay1">阿里巴巴招聘啦！！！！</h1>
							<p>快点来注册成为我们的会员吧，可以把你的简历推送给大家知道.</p>
						</div>
					<div class="fluid_container">                       
                    <div class="camera_wrap camera_emboss pattern_1" id="camera_wrap_4">
                        <div data-thumb="${ctx }/resource/assets/images/slides/thumbs/img1.jpg" data-src="${ctx }/resource/assets/images/slides/img1.jpg">
                        </div> 
                        <div data-thumb="${ctx }/resource/assets/images/slides/thumbs/img2.jpg" data-src="${ctx }/resource/assets/images/slides/img2.jpg">
                        </div>
                        <div data-thumb="${ctx }/resource/assets/images/slides/thumbs/img3.jpg" data-src="${ctx }/resource/assets/images/slides/img3.jpg">
                        </div> 
                    </div><!-- #camera_wrap_3 -->
                </div><!-- .fluid_container -->
		</div>
	</header>
	<!-- /Header -->
   <section class="container">
			<h3 style="font-size: 58px;color: blue;">工作岗位</h3>
			<hr>
			<form action="index.html" name="form1" id="form1" method="post">
			岗位名称：
			<input type="text" name="keyword1" value="" placeholder="岗位名称模糊查询"/>
			<%--
			<select  name="keyword1">
				<option value="">请选择...</option>
				<c:forEach items="${gwList }" var="gwLists">
					<option value="${gwLists.id }" ${param.keyword1==gwLists.id?'selected':'' }>${gwLists.v1
						}</option>
				</c:forEach>
			</select> --%>
			薪水范围：<select  name="keyword2">
					<option value="">请选择...</option>
					<c:forEach items="${fwList }" var="fwLists">
						<option value="${fwLists.id }" ${param.keyword2==fwLists.id?'selected':'' }>${fwLists.v1
							}</option>
					</c:forEach>
			</select>
			学历：<select name="keyword3">
					<option value="">请选择...</option>
					<c:forEach items="${xlList }" var="xlLists">
						<option value="${xlLists.id }" ${param.keyword3==xlLists.id?'selected':'' }>${xlLists.v1
							}</option>
					</c:forEach>
			</select>
			工作地点：<select name="keyword4">
					<option value="">请选择...</option>
					<c:forEach items="${gzddList }" var="lists">
						<option value="${lists.id }" ${param.keyword4==lists.id?'selected':'' }>${lists.v1
							}</option>
					</c:forEach>
			</select>
			工作经验：<select name="keyword5">
					<option value="">请选择...</option>
					<c:forEach items="${gzjyList }" var="lists">
						<option value="${lists.id }" ${param.keyword5==lists.id?'selected':'' }>${lists.v1
							}</option>
					</c:forEach>
			</select>
			行业领域：<select name="keyword6">
					<option value="">请选择...</option>
					<c:forEach items="${hylyList }" var="lists">
						<option value="${lists.id }" ${param.keyword6==lists.id?'selected':'' }>${lists.v1
							}</option>
					</c:forEach>
			</select>
			<input type="button" value="查询" onclick="searchOne();" style="width: 100px;"/>
			</form>
			
			<hr>
			<div class="row">
				<c:forEach items="${list }" var="lists" varStatus="vs">
				<div class="col-md-4">
					<div class="featured-box"> 
						<div class="text">
							<h3><a href="shows.html?id=${lists.id }">岗位名称：${lists.gwName }</a></h3>
							学历要求：${lists.xlName }<br>薪资范围：${lists.fwName }<br>
							招聘人数：${lists.number }<br>
							技能要求：${lists.jn }<br>
							高校名称：${lists.title }<br>
							高校地址：${lists.address }<br>
							高校简介：${lists.content }<br>
							<font color="red">如果您对此职位感兴趣，请投递简历吧：</font>
							<div id="upcosdf${vs.index+1 }">
							<input id="f_file${vs.index }" name="cmfile"
						onchange="triggerUpload(this,'upcosdf${vs.index+1 }',${lists.id },${vs.index });" title="选择简历附件" type="file"><br/>
						<br>
						<input type="button" value="跟我们聊聊" onclick="goll('${lists.adminId}');"/>
						</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
	</section>
   
	<section class="container">
			<h3 style="font-size: 58px;color: blue;">优秀简历</h3>
			<div class="row">
				<c:forEach items="${customerList }" var="lists">
				<div class="col-md-4">
					<div class="featured-box"> 
						<div class="text">
							<h3>求职岗位：${lists.gwName }</h3>
							姓名：${lists.name }<br>
							年龄：${lists.age }<br>
							性别：${lists.sex }<br>
							学历：${lists.xlName }<br>
							薪水范围：${lists.fwName }<br>
							个人简介：${lists.content }<br>
							详细简历下载：<a href="${ctx }/${lists.fileUrl}">简历下载</a><br>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
	</section>
      <section class="container">
      <div class="row">
      	<div class="col-md-8"><div class="title-box clearfix "><h2 class="title-box_primary">关于我们</h2></div> 
        <p><span>我们是高校招聘平台</span></p>
         </div>
      </div>
      </section>
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
    <script type='text/javascript' src='${ctx }/resource/assets/js/jquery.easing.1.3.js'></script> 
    <script type='text/javascript' src='${ctx }/resource/assets/js/camera.min.js'></script> 
    <script src="${ctx }/resource/assets/js/bootstrap.min.js"></script> 
    <script>
    
    function goll(adminId){
    	window.location.href='${ctx}/customer/goll.html?adminId='+adminId;
    }
    
    
    var upFile="";
    
    
		jQuery(function(){
			
			jQuery('#camera_wrap_4').camera({
                transPeriod: 500,
                time: 3000,
				height: '600',
				loader: 'false',
				pagination: true,
				thumbnails: false,
				hover: false,
                playPause: false,
                navigation: false,
				opacityOnGrid: false,
				imagePath: '${ctx }/resource/assets/images/'
			});

		});
		
      	function searchOne(){
      		form1.submit();
      	}
      	
      function uploadFile(id,fileUrl){
		if(!confirm("确定要投递吗?")){
			return false;
		}
		var params={id:id,fileUrl:fileUrl};
		$.post("upFile.html",params,function(
				result){
			result=eval("("+result+")");
			if(result.status=="true"||result.status==true){
				alert('投递成功');
			window.location.reload();
			}
		});
	}
      	function triggerUpload(src,ppp,id,rowindex) {
		$.ajaxFileUpload({
			url : '${ctx}/file/upload.json',
			secureuri : false,
			fileElementId : 'f_file'+rowindex,
			dataType : 'json',
			data : {
				fileloc : 'upload/',
				dir : 'temp'
			},
			success : function(data, status) {
				upFile = data.data.filepath;
				$("#"+ppp).empty();
				$("#"+ppp).after("<input type=\"button\" value=\"确认上传\" onclick=\"uploadFile("+id+",'"+upFile+"');\"/>");
			},
			error : function(data, status, e) {
				alert('文件上传失败');
			}
		});
	}
	</script>
    
</body>
</html>
