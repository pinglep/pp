<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List Adverts</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<%@ include file="../views/headerForCustomer.jsp"%>
	<div id="container">
		<h1>Hi, ${user.firstName}</h1>

		<form:form action="${contextPath}/advert/searchForReview"
			method="post" commandName="advert">

			<table>
				<tr>
					<td style="width: 200px;">Search movie name for review:</td>
					<td><input type="text" name="keywordvalue" /><input
						type="hidden" name="userTextName" value="${user.firstName}" /></input></td>
				</tr>

				<tr>
					<td colspan="2"><input type="submit" value="Search"></input> </input></td>
				</tr>
			</table>

		</form:form>
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