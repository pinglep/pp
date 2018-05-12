<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>Hi, ${user.firstName}</h1>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />

	<a href="${contextPath}/user/">Home</a>
	<br />
	<a href="${contextPath}/user/logout">Logout</a>
	<br />
	<table border="1" cellpadding="5" cellspacing="5">
		<tr>
			<td><b>MOVIE NAME</b></td>
			<td><b>DETAILS</b></td>
			<td><b>POSTED BY</b></td>
			<td><b>DATE</b></td>
			<td><b>TIME</b></td>
		</tr>
		<c:forEach var="adv" items="${adverts}">
			<tr>
				<td>${adv.title}</td>
				<td>${adv.message}</td>
				<td>${adv.user.username}</td>
				<td>${adv.date}</td>
				<td>${adv.time}</td>
				<%-- <td><c:forEach var="categ" items="${adv.categories}">
                    	${categ} , 
                    </c:forEach></td> --%>
			</tr>
		</c:forEach>
	</table>
</body>
</html>