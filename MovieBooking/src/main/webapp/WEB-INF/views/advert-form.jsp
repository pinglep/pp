<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Add Advert Form</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<%@ include file="../views/header.jsp"%>
	<div id="container">
		<br />

		<h2>Adding a New Movie</h2>


		<form:form action="${contextPath}/advert/add" method="post"
			commandName="advert">

			<table>
				<tr>
					<td>Logged in By :</td>
					<td>${sessionScope.user.username}</td>
					<td><form:hidden path="postedBy"
							value="${sessionScope.user.personID}" /></td>
				</tr>

				<tr>
					<td>Movie:</td>
					<td><form:select style="    width: 190px;" path="categories"
							items="${categories}" multiple="true" required="required" /></td>
				</tr>

				<tr>
					<td>Movie Title:</td>
					<td><form:input type="text" path="title" size="30"
							required="required" /></td>
				</tr>

				<tr>
					<td>Description:</td>
					<td><form:input type="text" path="message" size="30"
							required="required" /></td>
				</tr>

				<tr>
					<td>Dates:</td>
					<td><form:input type="date" path="date" size="30"
							required="required" /></td>
				</tr>

				<tr>
					<td>Price per seat:</td>
					<td><form:input type="text" path="price" size="30"
							required="required" /></td>
				</tr>


				<tr>
					<td>Give Image Url:</td>
					<td><form:input type="text" path="imgSrc" size="30"
							required="required" /></td>
				</tr>
				<tr>
					<td>Time:</td>
					<td><div><form:input type="checkBox" path="time" size="30"
							value="9.30 AM" /><span>9.30 AM</span></div> <form:input type="checkBox"
							path="time" size="30" value="1.00 PM" />1.00 PM <form:input
							type="checkBox" path="time" size="30" value="4.30 PM" />4.30 PM
						<form:input type="checkBox" path="time" size="30" value="8.00 PM" />8.00
						PM <form:input type="checkBox" path="time" size="30"
							value="12.00 PM" />12.00 PM</td>
				</tr>



				<tr>
					<td colspan="2"><input type="submit"
						value="Add Movie Screening" /></td>
				</tr>
			</table>
			<h1 style="padding: 20px 0; MARGIN-TOP: 100PX;">This is what we
				do</h1>
			<blockquote>With GiftMyShow cards, you can gift your
				friends & family movie & play tickets, concert passes, whatever it
				is they love for their birthdays, anniversaries or simply for no
				reason other than how you feel about them. Pretty sweet, aint it?
				Delight yourself with crazy offers while you book your tickets.
				Whether its cashback, freebies or discounts you're after, there's a
				can't-miss bargain for every single one of you. Book your tickets on
				the go, only with a couple of clicks. Choose from a whopping 3,000+
				cinema screens across India and book as late as 20 minutes before
				showtime for those spur-of-the-moment plans. Discover events,
				handpicked by us, just for you!Based in New York City, Stripes Group
				is a leading growth equity firm that invests in Internet, Digital
				Media, Software, and Branded Consumer Products businesses around the
				world. For over a decade, Stripes Group has been partnering with
				market-leading companies with proven business models that are
				generating exceptional growth. For more information on Stripes
				Group, visit</blockquote>
	</div>
	<%@ include file="../views/footer.jsp"%>
	</form:form>

</body>
</html>