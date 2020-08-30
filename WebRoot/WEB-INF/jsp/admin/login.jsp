<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
var ctx='${ctx}';
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<title>网上招聘系统</title> 
<meta name="keywords" content="aa" />
<meta name="description" content="aa" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="${ctx }/resource/company/js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="${ctx }/resource/company/images/login.js"></script>
<link href="${ctx }/resource/company/css/login2.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
	function loginCheck(){
		var username = $("#username").val();
		var password = $("#password").val();
		var type = "管理员";
		
		
		if(username==''||password==''){
			alert('用户名和密码必须填写');
			return false;
		}
		var out ="";
		var run="";
		if(type=='员工'){
			out="${ctx}/userLogin/save.html";
			run="${ctx}/user/index.html";
		}else{
			out="${ctx}/adminLogin/save.html";
			run="${ctx}/admin/index.html";
		}
		var params = {username:username,password:password};
		$.ajax({
		      type: "POST",
		      async:false,  // 设置同步方式
		      cache:false,
		      url: out,
				data:params,
				success:function(result){
				result = eval("("+result+")");
				if(result.status=='true'||result.status==true){
					if(result.msg=='1'){
						alert('登录成功');
						window.location.href=run;
					}else if(result.msg=='0'){
						alert('密码或用户名错误');
					}
				}
		      }
			});
	}
	

</script>
</head>
<body>
<h1>网上招聘系统</h1>

<div class="login" style="margin-top:50px;">
    
    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 435px;">    

            <!--登录-->
            <div class="web_login" id="web_login">
               
               
               <div class="login-box">
    
            
			<div class="login_form" id="login_form" name="login_form">
				<form action="http://www.js-css.cn" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post"><input type="hidden" name="did" value="0"/>
               <input type="hidden" name="to" value="log"/>
                <div class="uinArea" id="uinArea">
                <label class="input-tips" for="u">帐号：</label>
                <div class="inputOuter" id="uArea">
                    
                    <input type="text" id="username" name="username" class="inputstyle"/>
                </div>
                </div>
               <div class="pwdArea" id="pwdArea">
               <label class="input-tips" for="p">密码：</label> 
               <div class="inputOuter" id="pArea">
                    <input type="password" id="password" name="password" class="inputstyle"/>
                </div>
                </div>
                
                <%--
                <div class="pwdArea" id="pwdArea">
               <label class="input-tips" for="p">角色：</label> 
               <div class="inputOuter" id="pArea">
                    <select name="type" id="type">
                    	<option  value="员工">员工</option>
                    	<option value="管理员">管理员</option>
                    </select>
                </div>
                </div>
                 --%>
                <div style="padding-left:50px;margin-top:20px;"><input type="button" onclick="loginCheck();" value="登 录" style="width:150px;" class="button_blue"/></div>
              </form>
           </div>
            	</div>
               
            </div>
            <!--登录end-->
  </div>
    
    </div>
    <!--注册end-->
</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
</body></html>