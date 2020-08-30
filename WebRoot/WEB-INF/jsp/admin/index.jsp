<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/taglibs.jsp"%>
<html>
<head>
<title>网上招聘系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx }/resource/adminnew/css/style.css" rel="stylesheet" type="text/css" />
<link rel="StyleSheet" href="${ctx }/resource/adminnew/css/dtree.css" type="text/css" />
<script type="text/javascript" src="${ctx }/resource/adminnew/js/dtree.js"></script>
</head>
<body scroll="no">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="79" background="${ctx }/resource/adminnew/images/top_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="500"><img src="${ctx }/resource/adminnew/images/top_left.gif" width="500" height="79"></td>
          <td>&nbsp;</td>
          <td width="500" height="79"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="${ctx }/resource/adminnew/images/top_right_a.gif" width="500" height="47"></td>
              </tr>
              <tr>
                <td><table width="500" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="150"><img src="${ctx }/resource/adminnew/images/top_right_b1.gif" width="150" height="32"></td>
                    <td width="146" height="32" background="${ctx }/resource/adminnew/images/top_right_b2.gif" class="white">${sessionScope.adminBean.username }</td>
                    <td width="74"><a href="#" target="page"><img src="${ctx }/resource/adminnew/images/top_right_b6.gif" width="74" height="32" border="0"></a></td>
                    <td width="50"><a href="${ctx }/adminLogin/out.html"><img src="${ctx }/resource/adminnew/images/top_right_b3.gif" width="50" height="32" border="0"></a></td>
                    <td width="50"><a href="#"><img src="${ctx }/resource/adminnew/images/top_right_b4.gif" width="50" height="32" border="0"></a></td>
                    <td width="30"><img src="${ctx }/resource/adminnew/images/top_right_b5.gif" width="30" height="32"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
      
      
      
  </tr>
  <tr>
    <td height="100%"><table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="background-repeat: repeat-x;">
        <tr>
          <td width="175" height="100%" valign="top"><table width="175" height="100%" border="0" cellspacing="0" cellpadding="0" background="${ctx }/resource/adminnew/images/menu_bg.gif">
              <tr>
                <td height="25"><img src="${ctx }/resource/adminnew/images/menu_top.gif" width="175" height="25"></td>
              </tr>
              <tr>
                <td height="100%" style="background-image:url(${ctx }/resource/adminnew/images/menu_bgT.gif); background-repeat:no-repeat" valign="top"><div class="dtree">
                    <script type="text/javascript">
					d = new dTree('d');
					d.config.stepDepth = 1;
					d.config.useStatusText = true;
					d.add(0,-1,' <strong>网上招聘系统</strong>');
					
					<c:if test="${sessionScope.adminBean.types=='系统管理员' }">
					d.add(1,0,'人事部门管理');
					d.add(11,1,'人事部门列表','${ctx}/admin/admin/frame.html?flag=1',"",'page');
					d.add(2,0,'求职者管理');
					d.add(21,2,'求职者列表','${ctx}/admin/customer/frame.html',"",'page');
					d.add(3,0,'薪水范围配置管理');
					d.add(31,3,'薪水范围配置列表','${ctx}/admin/fw/frame.html',"",'page');
					d.add(4,0,'岗位配置管理');
					d.add(41,4,'岗位配置列表','${ctx}/admin/gw/frame.html',"",'page');
					d.add(5,0,'学历配置管理');
					d.add(51,5,'学历配置列表','${ctx}/admin/xl/frame.html',"",'page');
					d.add(6,0,'工作地点配置管理');
					d.add(61,6,'工作地点配置列表','${ctx}/admin/gzdd/frame.html',"",'page');
					d.add(7,0,'工作经验配置管理');
					d.add(71,7,'工作经验配置列表','${ctx}/admin/gzjy/frame.html',"",'page');
					d.add(8,0,'行业领域配置管理');
					d.add(81,8,'行业领域配置列表','${ctx}/admin/hyly/frame.html',"",'page');
					</c:if>
      				<c:if test="${sessionScope.adminBean.types=='人事部门' }">
      				d.add(9,0,'招聘岗位管理');
					d.add(91,9,'招聘岗位列表','${ctx}/admin/zp/frame.html',"",'page');
					d.add(92,9,'聊天列表','${ctx}/admin/message/frame.html',"",'page');
      				</c:if>
					
					
					
					
					
					
					document.writeln(d);
					</script>
                </div></td>
              </tr>
              <tr>
                <td height="31"><img src="${ctx }/resource/adminnew/images/menu_foot.gif" width="175" height="31"></td>
              </tr>
            </table></td>
          <td><iframe src="${ctx }/admin/main.html" width="100%" height="100%" frameborder="0" scrolling="no" name="page"></iframe></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>