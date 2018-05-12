<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.payment.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Movie Reviews</title>
</head>
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
</head>
</html>
<script>
	
</script>

<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<%@ include file="../views/header.jsp"%>
	<div id="container">
		<br />

		<table border="1" cellpadding="5" cellspacing="5">


			<div id="dd"></div>
<tr>
					<td><b>MOVIE NAME</b></td>
					<td><b>REVIEWS</b></td>
					<td><b>POSTED BY</b></td>
					<td><b>RATINGS</b></td>
					<td><b>TAKE ACTIONS</b></td>
				</tr>
			<c:forEach var="mobj" items="${mr}">
				
				<tr>
					<td>${mobj.movie}</td>
					<td>${mobj.reviews}</td>
					<td>${mobj.postedBy}</td>
					<td>
						<c:if test="${mobj.ratings eq 1}">
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							</c:if>
							<c:if test="${mobj.ratings eq 2}">
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							</c:if>
							<c:if test="${mobj.ratings eq 3}">
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							</c:if>
							<c:if test="${mobj.ratings eq 4}">
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							 </c:if>
							<c:if test="${mobj.ratings eq 5}">
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img>
							<img style="height:30px"src="https://upload.wikimedia.org/wikipedia/commons/2/29/Gold_Star.svg"></img></c:if>
							</td>
							<td><a href="${contextPath}/advert/list" >Delete Review</a></td>
							
				</tr>

			</c:forEach>
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
	</div>
	<%@ include file="../views/footer.jsp"%>
</body>
</html>