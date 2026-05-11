<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result Page</title>
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }

    .card {
        background-color: white;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        width: 450px;
    }

    h2 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }

    .data-row {
        display: flex;
        justify-content: space-between;
        padding: 12px 0;
        border-bottom: 1px solid #f0f0f0;
        font-size: 15px;
    }

    .data-row:last-child {
        border-bottom: none;
    }

    .data-label {
        color: #888;
        font-weight: bold;
    }

    .data-value {
        color: #2c3e50;
    }

    .back-btn {
        display: block;
        text-align: center;
        margin-top: 25px;
        padding: 10px;
        background-color: #3498db;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        transition: background 0.3s;
    }

    .back-btn:hover {
        background-color: #2980b9;
    }
</style>
</head>
<body>

<div class="card">
    <h2>Student Data</h2>

    <%
    // form
    String fullName = request.getParameter("fullName");
    String password = request.getParameter("password");
    String age      = request.getParameter("age");
    String city     = request.getParameter("city");
    String address  = request.getParameter("address");
    %>

    <div class="data-row">
        <span class="data-label">Full Name</span>
        <span class="data-value"><%= fullName %></span>
    </div>

    <div class="data-row">
        <span class="data-label">Password</span>
        <span class="data-value"><%= password %></span>
    </div>

    <div class="data-row">
        <span class="data-label">Age</span>
        <span class="data-value"><%= age %></span>
    </div>

    <div class="data-row">
        <span class="data-label">City</span>
        <span class="data-value"><%= city %></span>
    </div>

    <div class="data-row">
        <span class="data-label">Address</span>
        <span class="data-value"><%= address %></span>
    </div>

    <%
    /*
        -> Print
    out.println(" <p> Full Name : " + fullName + " </p> ");
    out.println(" <p> Password  : " + password + " </p> ");
    out.println(" <p> Age       : " + age      + " </p> ");
    out.println(" <p> City      : " + city     + " </p> ");
    out.println(" <p> Address   : " + address  + " </p> ");
    */
    %>

    <a href="form.jsp" class="back-btn">Back to Form</a>

</div>

</body>
</html>