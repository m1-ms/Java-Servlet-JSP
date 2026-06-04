<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Orders</title>

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family:Arial, sans-serif;
    }

    body{
        background:#f4f6f9;
        display:flex;
        justify-content:center;
        align-items:center;
        min-height:100vh;
    }

    .container{
        width:450px;
        background:#fff;
        padding:30px;
        border-radius:15px;
        box-shadow:0 4px 15px rgba(0,0,0,0.15);
    }

    h2{
        text-align:center;
        color:#333;
        margin-bottom:20px;
    }

    ul{
        list-style:none;
    }

    li{
        background:#f8f9fa;
        margin-bottom:10px;
        padding:12px;
        border-left:5px solid #007bff;
        border-radius:6px;
        color:#333;
        font-weight:500;
    }

    .empty{
        text-align:center;
        color:#777;
        padding:15px;
    }

    .btn{
        display:block;
        text-align:center;
        margin-top:20px;
        padding:12px;
        background:#007bff;
        color:white;
        text-decoration:none;
        border-radius:8px;
        transition:0.3s;
    }

    .btn:hover{
        background:#0056b3;
    }
</style>

</head>
<body>

<%
String[] selected = request.getParameterValues("food");
List<String> orders = (List<String>) session.getAttribute("orders");

if (orders == null) {
    orders = new ArrayList<String>();
}

if (selected != null) {
    for (String food : selected) {
        orders.add(food);
    }
}

session.setAttribute("orders", orders);
%>

<div class="container">

    <h2>Your Orders</h2>

    <% if (orders.isEmpty()) { %>

        <p class="empty">No orders selected yet.</p>

    <% } else { %>

        <ul>
            <% for (String item : orders) { %>
                <li><%= item %></li>
            <% } %>
        </ul>

    <% } %>

    <a href="order.jsp" class="btn">Back to Order</a>

</div>

</body>
</html>