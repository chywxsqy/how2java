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
		if(username==''||password==''){
			alert('用户名和密码必须填写');
			return false;
		}
		
		
		var params = {username:username,password:password};
		$.ajax({
		      type: "POST",
		      async:false,  // 设置同步方式
		      cache:false,
		      url: "save.html",
				data:params,
				success:function(result){
				result = eval("("+result+")");
				if(result.status=='true'||result.status==true){
					if(result.msg=='1'){
						alert('登录成功');
						window.location.href='${ctx}/customer/index.html';
					}else if(result.msg=='0'){
						alert('用户名或密码错误');
					}else if(result.msg=='-1'){
					}
				}
		      }
			});
	}
	
function registerCheck(){
		var regUsername = $("#regUsername").val();
		if(regUsername==''){
			alert('账户不能为空');
			return false;
		}
		if (!checkMobile(regUsername)) {
				return false;
		}
		var regPassword = $("#regPassword").val();
		if(regPassword==''){
			alert('密码不能为空');
			return false;
		}
		
		var name = $("#name").val();
		var age = $("#age").val();
		var sex = $("#sex").val();
		var params = {username:regUsername,password:regPassword,name:name,age:age,sex:sex};
		$.ajax({
		      type: "POST",
		      async:false,  // 设置同步方式
		      cache:false,
		      url: "registerSave.html",
				data:params,
				success:function(result){
				result = eval("("+result+")");
				if(result.status=='true'||result.status==true){
					alert('注册成功');
					window.location.href='${ctx}/customer/index.html';
				}
		      }
			});
	}
	
	
	
function validateIdCard(idCard) {
		//15位和18位身份证号码的正则表达式
		var regIdCard = /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;

		//如果通过该验证，说明身份证格式正确，但准确性还需计算
		if (regIdCard.test(idCard)) {
			if (idCard.length == 18) {
				var idCardWi = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9,
						10, 5, 8, 4, 2); //将前17位加权因子保存在数组里
				var idCardY = new Array(1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
				var idCardWiSum = 0; //用来保存前17位各自乖以加权因子后的总和
				for ( var i = 0; i < 17; i++) {
					idCardWiSum += idCard.substring(i, i + 1) * idCardWi[i];
				}

				var idCardMod = idCardWiSum % 11;//计算出校验码所在数组的位置
				var idCardLast = idCard.substring(17);//得到最后一位身份证号码

				//如果等于2，则说明校验码是10，身份证号码最后一位应该是X
				if (idCardMod == 2) {
					if (idCardLast == "X" || idCardLast == "x") {
						//alert("恭喜通过验证啦！");
						return true;
					} else {
						alert("身份证号码错误！");
						return false;
					}
				} else {
					//用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
					if (idCardLast == idCardY[idCardMod]) {
						//alert("恭喜通过验证啦！");
						return true;
					} else {
						alert("身份证号码错误！");
						return false;
					}
				}
			}
		} else {
			alert("身份证格式不正确!");
			return false;
		}
	}

	/*
	 * 手机号码格式
	 * 只允许以13、15、18开头的号码
	 * 如：13012345678、15929224344、18201234676
	 */
	function checkMobile(tel) {
		var regMobile = /^1[3,5,8]\d{9}$/;
		if (regMobile.test(tel)) {
			//alert("恭喜通过验证啦！");
			return true;
		} else {
			alert("手机格式不正确！");
			return false;
		}
	}	
</script>
</head>
<body>
<h1>网上招聘系统</h1>

<div class="login" style="margin-top:50px;">
    
    <div class="header">
        <div class="switch" id="switch"><a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
			<a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a><div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>    
  
    
    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 335px;">    

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
                
                
                <div style="padding-left:50px;margin-top:20px;"><input type="button" onclick="loginCheck();" value="登 录" style="width:150px;" class="button_blue"/></div>
              </form>
           </div>
            	</div>
               
            </div>
            <!--登录end-->
  </div>

  <!--注册-->
    <div class="qlogin" id="qlogin" style="display: none; ">
   
    <div class="web_login"><form name="form2" id="regUser" accept-charset="utf-8"  action="http://www.js-css.cn" method="post">
	      <input type="hidden" name="to" value="reg"/>
		      		       <input type="hidden" name="did" value="0"/>
        <ul class="reg_form" id="reg-ul">
        		<div id="userCue" class="cue">快速注册请注意格式</div>
                <li>
                	
                    <label for="user"  class="input-tips2">手机号码：</label>
                    <div class="inputOuter2">
                        <input type="text" id="regUsername" name="regUsername" maxlength="11" class="inputstyle2"/>
                    </div>
                    
                </li>
                
                <li>
                <label for="passwd" class="input-tips2">密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="regPassword"  name="regPassword" maxlength="16" class="inputstyle2"/>
                    </div>
                    
                </li>
                <li>
                <label for="passwd2" class="input-tips2">姓名：</label>
                    <div class="inputOuter2">
                        <input type="text" id="name" name="name" maxlength="16" class="inputstyle2" />
                    </div>
                </li>
                <li>
                <label for="passwd2" class="input-tips2">年龄：</label>
                    <div class="inputOuter2">
                        <input type="text" id="age" name="age" maxlength="16" class="inputstyle2" />
                    </div>
                </li>
                <li>
                <label for="passwd2" class="input-tips2">性别：</label>
                    <div class="inputOuter2">
                        <select name="sex"  class="inputstyle2">
                        	<option value="男">男</option>
                        	<option value="女">女</option>
                        </select>
                    </div>
                </li>
                <li>
                    <div class="inputArea">
                        <input type="button" onclick="registerCheck();"  style="margin-top:10px;margin-left:85px;" class="button_blue" value="同意协议并注册"/> <a href="#" class="zcxy" target="_blank">注册协议</a>
                    </div>
                    
                </li><div class="cl"></div>
            </ul></form>
           
    
    </div>
   
    
    </div>
    <!--注册end-->
</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
</body></html>