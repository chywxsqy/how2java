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
			<display:column title="学历" property="xlName"/>
			<display:column title="岗位" property="gwName"/>
			<display:column title="薪水范围" property="fwName"/>
			<display:column title="工作地点" property="gzddName"/>
			<display:column title="工作经验" property="gzjyName"/>
			<display:column title="行业领域" property="hylyName"/>
			<display:column title="技能要求" property="jn"/>
			<display:column title="高校名称" property="title"/>
			<display:column title="高校简介" property="content"/>
			<display:column title="招聘人数" property="number"/>
			<display:column title="高校地点" property="address"/>
			<display:column title="是否会员才能查看" property="huiyuan"/>
			<display:column title="查看投递" style="width:40px;">
				<img src="${ctx}/resource/admin/images/pencil.png"
					onclick="return tdList('${row.id}');" style="cursor:hand;"/>
			</display:column>
			<display:column title="查看投递电子简历" style="width:40px;">
				<img src="${ctx}/resource/admin/images/pencil.png"
					onclick="return dzList('${row.id}');" style="cursor:hand;"/>
			</display:column>
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
	
	function tdList(id){
			MyWindow.OpenCenterWindow('tdList.html?id='+id,'modifdfsy',700,800);
	}
	
	function dzList(id){
			MyWindow.OpenCenterWindow('dzList.html?id='+id+'&flag=2','modifdfs22y',800,800);
	}
</script>
</html>
