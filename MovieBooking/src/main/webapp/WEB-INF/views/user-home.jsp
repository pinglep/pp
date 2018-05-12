<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Home</title>
</head>
<body>



	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<%@ include file="../views/header.jsp"%>

	<div id="container">
		<h1>Welcome, ${user.firstName}</h1>
		<%-- <a href="${contextPath}/category/add">Add Movie</a> <br /> <a
			href="${contextPath}/advert/add">Movie Screening</a> <br /> <a
			href="${contextPath}/advert/list">View All Movies</a> <br /> <a
			href="${contextPath}/review/viewAllReviews">View All Movie
			Reviews</a> <br /> <a href="${contextPath}/user/logout">Logout</a> <br /> --%>
		<%-- <c:forEach items="${requestScope.map.newlISTnew}" var="value"></c:forEach> --%>
		<%-- <c:forEach var="adv" items="${adverts}">
			<tr>
				<td>${adv.title}</td>
				<td>${adv.message}</td>
				<td>${adv.user.username}</td>
				<td><img src="${adv.imgSrc}"></img></td>
				<td><c:forEach var="categ" items="${adv.categories}">
                    	${categ} , 
                    </c:forEach></td>
			</tr>
		</c:forEach> --%>
		<div id="prod_nav">
			<c:forEach var="adv" items="${adverts}">
				<ul>

					<li><img src="${adv.imgSrc}" alt=""
						style="height: 150PX; WIDTH: 150PX" /> <strong>${adv.title}</strong>
					<td>$ ${adv.price}</td></li>
				</ul>
			</c:forEach>
		</div>
		<div style="clear: both"></div>
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



	</div>
	<%@ include file="../views/footer.jsp"%>
</body>
</html>