<%@page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>
<%@include file="/taglibs.jsp"%>
<%@taglib uri="http://displaytag.sf.net/el" prefix="display"%>
<style type="text/css">
@import url("${ctx}/resource/admin/displaytag/zdisplaytag.css");
@import url("${ctx}/resource/admin/displaytag/alternative.css");
</style>
<html>
	<body>
		<display:table name="list"
			requestURI="list.html" class="list"
			id="row" cellspacing="0" cellpadding="0" pagesize="5">
			<display:column style="width:60px;" media="html" title="编号">
				<c:out value="${row_rowNum}"/>
			</display:column>
			<display:column title="账号" property="username"/>
			<display:column title="密码" property="password"/>
			<display:column title="姓名" property="name"/>
			<display:column title="年龄" property="age"/>
			<display:column title="性别" property="sex"/>
			<display:column title="学历" property="xlName"/>
			<display:column title="岗位" property="gwName"/>
			<display:column title="薪水" property="fwName"/>
			<display:column title="简介" property="content"/>
			<display:column title="详细简历">
				<c:if test="${row.fileUrl!=null }">
					<a href="${ctx }/${row.fileUrl }">简历下载</a>
				</c:if>
			</display:column>
			<display:column title="是否显示到首页" property="huiyuan"/>
			<display:column title="修改" style="width:40px;">
				<img src="${ctx}/resource/admin/images/pencil.png"
					onclick="return modifyOne('${row.id}');" style="cursor:hand;"/>
			</display:column>
			<display:column title="删除" style="width:40px;">
				<img src="${ctx}/resource/admin/images/delete.png"
					onclick="return deleteOne('${row.id}');" style="cursor:hand;"/>
			</display:column>
		</display:table>
	</body>
	<script type="text/javascript">
	function deleteOne(id){
		if(!confirm("确定要删除吗?")){
			return false;
		}
		var params={id:id};
		$.post("editDelete.html",params,function(
				result){
			result=eval("("+result+")");
			if(result.status=="true"||result.status==true){
				alert('成功');
			window.parent.form1.submit();
			}
		});
	}
	function modifyOne(id){
			MyWindow.OpenCenterWindow('edit.html?id='+id,'modify',500,600);
	}
</script>
</html>
