<%-- 
    Document   : searchResult
    Created on : Feb 20, 2018, 9:36:40 PM
    Author     : Pooja
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/css/maincss.css"
	rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.payment.js"></script>
<style>
@import
	url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

fieldset, label {
	margin: 0;
	padding: 0;
}

body {
	margin: 20px;
}

h1 {
	font-size: 1.5em;
	margin: 10px;
}

/****** Style Star Rating Widget *****/
.rating {
	border: none;
	float: left;
}

.rating>input {
	display: none;
}

.rating>label:before {
	margin: 5px;
	font-size: 1.25em;
	font-family: FontAwesome;
	display: inline-block;
	content: "\f005";
}

.rating>.half:before {
	content: "\f089";
	position: absolute;
}

.rating>label {
	color: #ddd;
	float: right;
}

/***** CSS Magic to Highlight Stars on Hover *****/
.rating>input:checked ~ label, /* show gold star when clicked */ .rating:not
	 (:checked ) >label:hover, /* hover current star */ .rating:not (:checked
	 ) >label:hover ~ label {
	color: #FFD700;
} /* hover previous stars in list */
.rating>input:checked+label:hover,
	/* hover current star when changing rating */ .rating>input:checked ~
	label:hover, .rating>label:hover ~ input:checked ~ label,
	/* lighten current selection */ .rating>input:checked ~ label:hover ~
	label {
	color: #FFED85;
}
</style>
<script>
	
</script>


<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	<%@ include file="../views/headerForCustomer.jsp"%>
	<div id="container">
		<form action="${contextPath}/review/addComments"
			commandName="movieReviews" method="POST">
			<h1>Hi, ${userTextField}</h1>
			<div>

				<c:if test="${requestScope.map.msgtype eq 'search'}">
					<span><b>Your Searched for
							"${requestScope.map.querySearched}"</b></span>
					<c:forEach items="${requestScope.map.mList}" var="msg">
						<table>
							<tr>
								<td>Movie Name :</td>
								<td><input type="text" name="movie" value="${msg.title}"><input
									type="hidden" name="bookedBy" value="${userTextField}" /></td>
							</tr>
							<tr>
								<td>Movie title :</td>
								<td> ${msg.message}</td>
							</tr>
							<tr>
								<td>Add Review :</td>
								<td><input type="text" id="sits" name="reviews"></td>
							</tr>

							<tr>
								<td>Rate your movie:</td>
								<td><fieldset class="rating">
										<input type="radio" id="star5" name="rating" value="5" /><label
											class="full" for="star5" title="Awesome - 5 stars"></label>
											
									 <input
											type="radio" id="star4" name="rating" value="4" /><label
											class="full" for="star4" title="Pretty good - 4 stars"></label>
										<input type="radio" id="star3" name="rating" value="3" /><label
											class="full" for="star3" title="Meh - 3 stars"></label> <input
											type="radio" id="star2" name="rating" value="2" /><label
											class="full" for="star2" title="Kinda bad - 2 stars"></label>

										<input type="radio" id="star1" name="rating" value="1" /><label
											class="full" for="star1" title="Sucks big time - 1 star"></label>

									</fieldset></td>
							</tr>
						</table>
					</c:forEach>


				</c:if>



				<input type="submit" value="Submit Reviews"></input>
		</form>
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

</div>
</body>
</html>
