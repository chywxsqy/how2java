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
			requestURI="dzList.html" class="list"
			id="row" cellspacing="0" cellpadding="0" >
			<display:column style="width:60px;" media="html" title="编号">
				<c:out value="${row_rowNum}"/>
			</display:column>
			<display:column title="真实姓名" property="v1"/>
			<display:column title="年龄" property="v2"/>
			<display:column title="家庭住址" property="v3"/>
			<display:column title="工作经验" property="v4"/>
			<display:column title="得奖描述" property="v5"/>
			<display:column title="特长" property="v6"/>
			<display:column title="爱好" property="v7"/>
			<display:column title="期望薪资" property="v8"/>
			<display:column title="状态" property="status"/>
			<c:if test="${param.flag==2 }">
										<display:column title="操作">
				<c:if test="${row.status=='待审核' }">
				<a href="javascript:updateColumnstatus('通过','${row.ppId}');">通过</a><br/>
				<a href="javascript:updateColumnstatus('不通过','${row.ppId}');">不通过</a><br/>
				</c:if>
			</display:column>
				
			</c:if>
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
	
	function updateColumnstatus(status,id){
		var params={id:id,status:status};
		$.post("updateColumnstatus.html",params,function(
				result){
			result=eval("("+result+")");
			if(result.status=="true"||result.status==true){
				alert('成功');
			window.location.reload();
			}
		});
	}
	
	
	function modifyOne(id){
			MyWindow.OpenCenterWindow('edit.html?id='+id,'modify',500,600);
	}
	
	function tdList(id){
			MyWindow.OpenCenterWindow('tdList.html?id='+id,'modifdfsy',700,800);
	}
</script>
</html>
