<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Category Form</title>
</head>
<body>


	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<%@ include file="../views/header.jsp"%>
	<%-- <a href="${contextPath}/user/">Home</a>
	<br />
	<a href="${contextPath}/user/logout">Logout</a> --%>
	<br />



	<form:form action="${contextPath}/category/add" method="post"
		commandName="category">
		<DIV id=container>
			<h2>Add a New Movie</h2>
			<table>
				<tr>
					<td>Movie Name:</td>
					<td><form:input path="title" size="30" required="required" />
						<font color="red"><form:errors path="title" /></font></td>
				</tr>

				<tr>
					<td colspan="2"><input type="submit" value="Create Movie" /></td>
				</tr>
			</table>
			<h1 style="padding: 20px 0; MARGIN-TOP: 100PX;">This is what we
			do</h1>
		<blockquote>With GiftMyShow cards, you can gift your
			friends & family movie & play tickets, concert passes, whatever it is
			they love for their birthdays, anniversaries or simply for no reason
			other than how you feel about them. Pretty sweet, aint it? Delight
			yourself with crazy offers while you book your tickets. Whether its
			cashback, freebies or discounts you're after, there's a can't-miss
			bargain for every single one of you. Book your tickets on the go,
			only with a couple of clicks. Choose from a whopping 3,000+ cinema
			screens across India and book as late as 20 minutes before showtime
			for those spur-of-the-moment plans. Discover events, handpicked by
			us, just for you!Based in New York City, Stripes Group is a leading
			growth equity firm that invests in Internet, Digital Media, Software,
			and Branded Consumer Products businesses around the world. For over a
			decade, Stripes Group has been partnering with market-leading
			companies with proven business models that are generating exceptional
			growth. For more information on Stripes Group, visit</blockquote>
			
		</DIV>
		<div style="clear: both"></div>
		


	</form:form>
	<%@ include file="../views/footer.jsp"%>
</body>
</html>