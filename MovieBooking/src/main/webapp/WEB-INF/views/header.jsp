<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/style1.css"
	rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/css/simple_menu.css"
	rel="stylesheet" type="text/css" />
<!--JS FILES -->
<script src="${pageContext.request.contextPath}js/jquery.tools.min.js"></script>
<script>
$(function () {
    $("#prod_nav ul").tabs("#panes > div", {
        effect: 'fade',
        fadeOutSpeed: 400
    });
});
</script>
<script>
$(document).ready(function () {
    $(".pane-list li").click(function () {
        window.location = $(this).find("a").attr("href");
        return false;
    });
});
</script>

</head>
<body>
<div class="header">
  <!-- Logo/Title -->
  <div id="site_title"><a href="index.html"> <img src="img/logo.png" alt=""></a> </div>
  <!-- Main Menu -->
  <ol id="menu">
    <li class="active_menu_item"><a style="color:#FFF">Home</a>
      <!-- sub menu -->
      
     <%--  <a href="${contextPath}/category/add" >Add Movie</a> <br />
<a href="${contextPath}/advert/add" >Movie Screening</a> <br />
<a href="${contextPath}/advert/list" >View All Movies</a> <br />
<a href="${contextPath}/review/viewAllReviews" >View All Movie Reviews</a> <br />
<a href="${contextPath}/user/logout" >Logout</a> <br /> --%>
      <ol>
        <li> <a href="${contextPath}/category/add" >Add Movie</a></li>
        <li><a href="${contextPath}/advert/add" >Movie Screening</a></li>
        <li><a href="${contextPath}/advert/list" >View All Movies</a> </li>
       <li> <a href="${contextPath}/review/viewAllReviews" >View All Reviews</a> </li>
      </ol>
    </li>
    <!-- end sub menu -->
    <li> <a href="${contextPath}/category/add" >Add Movie</a>
      <!-- sub menu -->
      
    </li>
    <!-- end sub menu -->
    <li><a href="${contextPath}/advert/add" >Movie Screening</a></li>
    <li><a href="${contextPath}/advert/list" >View All Movies</a>
      <!-- sub menu -->
      
    </li>
    
    <!-- end sub menu -->
    <li><a href="${contextPath}/user/logout" >Logout</a></li>
  </ol>
</div>



</body>
</html>