<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Favorite Place </title>
</head>
<body>

		<%
		
			String place = request.getParameter("place");
			
			Cookie myCookie = new Cookie("favoritePlace" , place);
			
			myCookie.setMaxAge( 30 * 24 * 60 * 60 );
			
			response.addCookie(myCookie);
		
		
		%>
		
	<h2> Your Favorite Place Is : <%= place %> </h2>
	
	<a href="start.html" >Back</a>

</body>
</html>