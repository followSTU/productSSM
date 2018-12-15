<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="static/js/jquery-3.3.1.min.js"></script>

<script>
$(function(){
	$(".delete").click(function(){
		var href=$(this).attr("href");
		var name=$(this).parent().parent().find("td:eq(1)").text();
		var flag=confirm("确定要删除"+name+"吗");

		if(flag){
			$("form").attr("action",href).submit();
		}
		return false;
	})
})
</script>
</head>
<body>
	<p>显示所有学生信息</p>
	<form action="" method="POST">
		<input type="hidden" name="_method" value="DELETE">
	</form>
	<c:if test="${empty requestScope.students}">
		没有学生信息
	</c:if>

	<c:if test="${!empty requestScope.students}">
		<table border="1" cellpadding="10px" cellspacing="0">
			<tr>
				<td>ID</td>
				<td>Name</td>
				<td>Gender</td>
				<td>Email</td>
				<td>Phone</td>
				<td>Birth</td>
				<td>RegTime</td>
				<td>Major</td>
				<td>DELETE</td>
				<td>Update</td>
			</tr>
			<c:forEach items="${requestScope.students}" var="stu">
				<tr>
					<td>${stu.id}</td>
					<td>${stu.name}</td>
					<td>${stu.gender}</td>
					<td>${stu.email}</td>
					<td>${stu.phone}</td>
					<td><fmt:formatDate value="${stu.birth}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td><fmt:formatDate value="${stu.regTime}" pattern="yyyy-MM-dd hh:mm:ss"></fmt:formatDate></td>
					<td>${stu.major.majorName}</td>
					<td><a href="stu/${stu.id}" class="delete">Delete</a></td>
					<td><a href="stu/${stu.id}">Edit</td>
				</tr>
			</c:forEach>
		</table>
		<p></p><p></p>
		<p><a href="stu">添加学生</a></p>
	</c:if>
</body>
</html>