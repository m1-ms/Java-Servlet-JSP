<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Info Result</title>

<style>
    * { margin: 0; padding: 0; box-sizing: border-box;
        font-family: Arial, sans-serif; }

    body { background-color: #f4f4f4; height: 100vh;
           display: flex; justify-content: center; align-items: center; }

    .container { background: #fff; padding: 30px; width: 400px;
                 border-radius: 12px;
                 box-shadow: 0 4px 12px rgba(0,0,0,0.1); text-align: left; }

    h1 { text-align: center; color: #333; margin-bottom: 25px; }

    .info { font-size: 20px; color: #444; margin-bottom: 15px;
            padding: 12px; background-color: #f8f9fa;
            border-left: 4px solid #007bff; border-radius: 5px; }

    .label { font-weight: bold; color: #007bff; }
</style>

</head>
<body>

<%
    String fullname = request.getParameter("fullname");
    String age      = request.getParameter("age");
%>

<div class="container">
    <h1>User Information</h1>

        <div class="info">
                <span class="label">Full Name:</span>
        <%= fullname %>
        </div>

        <div class="info">
                <span class="label">Age:</span>
        <%= age %>
        </div>
</div>

</body>
</html>