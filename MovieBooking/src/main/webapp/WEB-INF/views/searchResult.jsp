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
#result {
	position: absolute;
	width: 100%;
	max-width: 870px;
	cursor: pointer;
	overflow-y: auto;
	max-height: 400px;
	box-sizing: border-box;
	z-index: 1001;
}

.link-class:hover {
	background-color: #f1f1f1;
}

body {
	margin: 50px auto;
	width: 600px;
}

/* CSS for Credit Card Payment form */
.credit-card-box .panel-title {
	display: inline;
	font-weight: bold;
}

.credit-card-box .form-control.error {
	border-color: red;
	outline: 0;
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px
		rgba(255, 0, 0, 0.6);
}

.credit-card-box label.error {
	font-weight: bold;
	color: red;
	padding: 2px 8px;
	margin-top: 2px;
}

.credit-card-box .payment-errors {
	font-weight: bold;
	color: red;
	padding: 2px 8px;
	margin-top: 2px;
}

.credit-card-box label {
	display: block;
}
/* The old "center div vertically" hack */
.credit-card-box .display-table {
	display: table;
}

.credit-card-box .display-tr {
	display: table-row;
}

.credit-card-box .display-td {
	display: table-cell;
	vertical-align: middle;
	width: 50%;
}
/* Just looks nicer */
.credit-card-box .panel-heading img {
	min-width: 180px;
}
</style>
</head>
</html>

<script>
	$(document)
			.ready(
					function() {
						$.ajaxSetup({
							cache : false
						});
						$('#search')
								.keyup(
										function() {
											$('#result').html('');
											$('#state').val('');
											var searchField = $('#search')
													.val();
											var expression = new RegExp(
													searchField, "i");
											var url = $("#contectURL").val();
											$
													.getJSON(
															url
																	+ '/css/data.json',
															function(data) {
																$
																		.each(
																				data,
																				function(
																						key,
																						value) {
																					if (value.name
																							.search(expression) != -1
																							|| value.location
																									.search(expression) != -1) {
																						$(
																								'#result')
																								.append(
																										'<li class="list-group-item link-class" style="    width: 370px;"><img src="'+value.image+'" height="40" width="40" class="img-thumbnail" /><span class="text-muted">'
																												+ value.location
																												+ '</span></li>');
																					}
																				});
															});
										});

						$('#result').on(
								'click',
								'li',
								function() {
									var click_text = $(this).text().split('|');
									$('#search').val($.trim(click_text[0]));
									var selectedAddress = $('#search').val(
											$.trim(click_text[0]));
									;
									console.log(selectedAddress[0].value);
									$("#result").html('');
								});

						var sitSelectionArray = [];
						var newArray = []
						myFunction();
						myFunctionNew()

						$('.active').click(function() {

							var sit = $(this).val();

							sitSelectionArray.push(sit);
							document.getElementById("selectedSitsText").value = sitSelectionArray;
							$.each(sitSelectionArray, function(key, value) {

							});
							var sits = sitSelectionArray.length;

							document.getElementById("sits").value = sits;
							var costOf = sitSelectionArray.length * 15;

							document.getElementById("cost").value = costOf;
							if ($(this).hasClass('active')) {

								$(this).removeClass('active')
							} else {

								$(this).addClass('active')
							}

						});
						
						$('.seelctionTime').on('click', function(){
							console.log($(this).val())
						})
					})
function myFunction() {
		
		var x = document.getElementById("myDIV");
		if (x.style.display === "none") {
			x.style.display = "block";
		} else {
			x.style.display = "none";
		}
	}
	/* function selectedTime(value) {

		document.getElementById("selectedTime").value = value;
		console.log(value + "selectedTimew")
	} */
	function myFunctionNew() {

		var x = document.getElementById("proceedCheckOutDiv");
		if (x.style.display === "none") {
			x.style.display = "block";
		} else {
			x.style.display = "none";
		}
	}
		
</script>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
	
	<form action="${contextPath}/book/booking" commandName="booking" method="POST">
		<h1>Hi, ${userTextField}</h1>
		<div>

			<c:if test="${requestScope.map.msgtype eq 'search'}">Your Searched for "${requestScope.map.querySearched}" </c:if>
			<c:if test="${requestScope.map.msgtype eq 'search'}">
				<c:forEach  items="${requestScope.map.mList}" var="msg">
				<input type="hidden" name = "bookedBy" value = "${userTextField}"/>
        Movie Name : <input type="text" name = "movie" value = "${msg.title}"></input><br>
        Movie title : ${msg.message}<br>
        Available Dates : <input value="${msg.date}" name = "date"></input>
					<br>
         Available Time :
        <c:forEach items="${requestScope.map.newlISTnew}" var="value">
						<input type="radio" class="seelctionTime" name="movieTime" id="seelctionTime"
							 value="${value}"/>${value}

					</c:forEach>
					<br>
					
				</c:forEach>

				<br />
				<br />
				<span style="float: left">Select Thearter:</span>
				<div class="container"
					style="float: left; margin-left: 0px; margin-top: -48px; width: 400px;">
					<br /> <br />
					<div align="center">
						<input type="text"  id="search" name="location"
							placeholder="Search By Address" class="form-control" />
					</div>
					<ul class="list-group" id="result"></ul>
					<br />
				</div>
				<br>

				<input type="hidden" id="contectURL"
					value="${pageContext.request.contextPath}" />
				<br>
				<div style="float: left; margin-left: -498px;">
					<input type="button" value="Proceed to sit selection"
						onclick="myFunction()" style="float: left;"></input>
				</div>
				
				<br>
				<div id="myDIV" style="margin-top: 26px;">
				
				
				<c:forEach items="${requestScope.map.newSeatsList}" var="number">
				
				${number}
				</c:forEach>
					
				<div style="width:700px;">
				<c:forEach begin="1" end="3" var="k">
				<input id="a${k}" class="active" type="button" styel=""
								style="    WIDTH: 40px;" value="A${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="4" end="10" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="A${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="11" end="13" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="A${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>
					
					
					
					</div>
					<br>
					<div style="width:700px;">
				<c:forEach begin="1" end="3" var="k">
				<input id="a${k}" class="active" type="button" styel=""
								style="    WIDTH: 40px;" value="B${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="4" end="10" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="B${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="11" end="13" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="B${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>
					
					
					
					</div>
				<br>
					<div style="width:700px;">
				<c:forEach begin="1" end="3" var="k">
				<input id="a${k}" class="active" type="button" styel=""
								style="    WIDTH: 40px;" value="C${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="4" end="10" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="C${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="11" end="13" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="C${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>
					
					
					
					</div>
					<br>
					<div style="width:700px;">
				<c:forEach begin="1" end="3" var="k">
				<input id="a${k}" class="active" type="button" styel=""
								style="    WIDTH: 40px;" value="D${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="4" end="10" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="D${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="11" end="13" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="D${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>
					
					
					
					</div>
					<br>
					<div style="width:700px;">
				<c:forEach begin="1" end="3" var="k">
				<input id="a${k}" class="active" type="button" styel=""
								style="    WIDTH: 40px;" value="E${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="4" end="10" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="E${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="11" end="13" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="E${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>
					
					
					
					</div>
					
					<br>
					<div style="width:700px;">
				<c:forEach begin="1" end="3" var="k">
				<input id="a${k}" class="active" type="button" styel=""
								style="    WIDTH: 40px;" value="F${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="4" end="10" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="F${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
				<c:forEach begin="11" end="13" var="k">
				<input id="a${k}" class="active" type="button" styel="    WIDTH: 37PX;"
								style="WIDTH: 40px;" value="F${k}"
								onClick="jQuery(this).toggleClass('active')">&nbsp</input>
				</c:forEach>
					
					
					
					</div>
					<br><br>
					<div style="background-color: black; text-align: center;   margin-left: 77px;"><span style="color:white">Screen This Way</span></div>
					
					

				</div>
				<br>
				<br>
				<div>
					Selected Sits: <input type="text" id="selectedSitsText" name="selecetdSits"></input>
				</div>
				<br>
				<div>
					No of sits selected: <input type="text" id="sits" name="noOfSits"></input>
				</div>
				<br>
				<div>
					<input type="button" value="Proceed To Checkout"
						onclick="myFunctionNew()"></input>
				</div>
				<div id="proceedCheckOutDiv">
					<div>
						
      	Total Price: <input type="text" id="cost"></input>
							
					</div>

				</div>
				<br>
				<div >
					<input type="submit" value="Checkout"></input>
				</div>
				<div id="paymentDiv" style="float: left;">
					
					<!-- If you're using Stripe for payments -->
					<script type="text/javascript" src="https://js.stripe.com/v2/"></script>
				</div>
				
				</c:if>
				</div>
	</form>
</body>

</div>


<br />

</body>
</html>
