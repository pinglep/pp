<%-- <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Advert Application Lab8</title>
</head>
<body>

	<a href="user/register.htm">Register a new User</a><br/>

	<h2>Login</h2>
	<form action="user/login" method="post">
	
		<table>
		<tr>
		    <td>User Name:</td>
		    <td><input name="username" size="30" required="required" /></td>
		</tr>
		
		<tr>
		    <td>Password:</td>
		    <td><input type="password" name="password" size="30" required="required"/></td>
		</tr>
		
		<tr>
		    <td colspan="2"><input type="submit" value="Login" /></td>
		</tr>
				
		</table>

	</form>


</body>
</html>

 --%>
 
 
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>Movie Booking And Review</title>

	<!-- Google Fonts -->
	<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700|Lato:400,100,300,700,900' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" href="css/animate.css">
	<!-- Custom Stylesheet -->
	<link rel="stylesheet" href="css/style.css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
</head>

<body>
	<div class="container">
		<div class="top" style="    margin-top: -100px;">
			<h1 id="title" class="hidden"><span id="logo">Movie Booking And Review</span></h1>
		</div>
		<form action="user/login" method="post">
		<div class="login-box animated fadeInUp" style="    margin-top: -90px;">
			<div class="box-header">
				<h2>Log In</h2>
			</div>
			<label for="username">Username</label>
			<br/>
			<input  id="username" name="username" size="30" required="required" />
			
			<br/>
			<label for="password">Password</label>
			<br/>
			<input id="password" type="password" name="password" size="30" required="required"/>
			<br/>
			<!-- <button type="submit">Sign In</button> -->
			<input type="submit" value="Login" />
			<br/>
			<a href="user/register.htm"><br/><p class="small">Register a new User</p></a>
		</div>
		</form>
	</div>
</body>

<script>
	$(document).ready(function () {
    	$('#logo').addClass('animated fadeInDown');
    	$("input:text:visible:first").focus();
	});
	$('#username').focus(function() {
		$('label[for="username"]').addClass('selected');
	});
	$('#username').blur(function() {
		$('label[for="username"]').removeClass('selected');
	});
	$('#password').focus(function() {
		$('label[for="password"]').addClass('selected');
	});
	$('#password').blur(function() {
		$('label[for="password"]').removeClass('selected');
	});
</script>

</html>