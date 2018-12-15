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
	gfdsgdf
</body>
</html>