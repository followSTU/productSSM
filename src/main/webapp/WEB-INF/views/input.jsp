<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="static/js/jquery-3.3.1.min.js"></script>

<script>
	$(function(){
		$("#name").change(function(){
			var val=$(this).val();
			val=$.trim(val);
			var $this=$(this);
			if(val!=""){
				var url="checkName";
				var args={"name":val,"time":new Date()};
				$.post(url,args,function(data){
					if(data=="1"){
					    	$("font").remove();
							$this.after("<font style='color: green'>用户名可用</font>");
					}else if(data=="0"){
                        $("font").remove();
                        $this.after("<font style='color: red'>用户名不可用</font>");
						
					}else{
						alert("服务器出现异常！！！")
					}
				})
			}
		})
	})
</script>
</head>
<body>
<!-- ${pageContext.request.contextPath }/ 遇到的重大问题之一-->
<h2>学生信息</h2>
<c:set var="url" value="${pageContext.request.contextPath}/stu"></c:set>
<c:if test="${student.id!=null}">
		<c:set var="url" value="${pageContext.request.contextPath}/stu/${student.id}"></c:set>
</c:if>
<form:form action="${url}" method="POST" modelAttribute="student">
	<c:if test="${student.id==null}">
		姓名：<form:input path="name" id="name"/><form:errors path="name" cssStyle="color:red"/>
	</c:if>
	<c:if test="${student.id!=null}">
		<form:hidden path="id"/>
		姓名：<form:input path="name" readonly="true"/>
		<input type="hidden" name="_method" value="PUT">
	</c:if><br><br>
	性别<form:radiobuttons path="gender" items="${genders}"/><br><br>
	邮箱:<form:input path="email"/><br><br>
	电话：<form:input path="phone"/><br><br>
	出生日期：<form:input path="birth"/><br><br>
	注册时间：<form:input path="regTime"/><br><br>
	所学专业：<form:select path="major.majorId" items="${majors}" itemLabel="majorName" itemValue="majorId"></form:select>
	<br><br><input type="submit" value="ADD">
</form:form>
</body>
</html>