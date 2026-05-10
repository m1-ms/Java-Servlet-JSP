<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Task</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f2f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .card {
        background-color: white;
        padding: 40px 60px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        text-align: center;
    }

    .card h1 {
        color: #2c3e50;
        margin-bottom: 10px;
    }

    .card p {
        color: #7f8c8d;
        font-size: 14px;
        margin-bottom: 20px;
    }

    .result {
        background-color: #3498db;
        color: white;
        padding: 12px 30px;
        border-radius: 8px;
        font-size: 20px;
        font-weight: bold;
        display: inline-block;
    }
</style>
</head>
<body>

   <%
   int id = 2402;
   String name = "Mahmoud Soliman";
   %>

   <%!
   String printData(int id, String name) {
       return id + " - " + name;
   }
   %>

   <div class="card">
       <h1>Student Info</h1>
       <p>ID and Name concatenation result:</p>
       <div class="result">
           <%= printData(id, name) %>
       </div>
   </div>

</body>
</html>