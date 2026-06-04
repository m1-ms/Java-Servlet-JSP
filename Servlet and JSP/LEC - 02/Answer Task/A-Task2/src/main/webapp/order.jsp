<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Choose Your Food</title>

<style>
    *{
        margin:0;
        padding:0;
        box-sizing:border-box;
        font-family: Arial, sans-serif;
    }

    body{
        background:#f4f6f9;
        display:flex;
        justify-content:center;
        align-items:center;
        min-height:100vh;
    }

    .container{
        background:white;
        padding:30px;
        border-radius:15px;
        box-shadow:0 4px 15px rgba(0,0,0,0.15);
        width:350px;
    }

    h2{
        text-align:center;
        margin-bottom:20px;
        color:#333;
    }

    .food-item{
        margin:10px 0;
        font-size:16px;
        color:#444;
    }

    input[type="checkbox"]{
        margin-right:10px;
        transform:scale(1.1);
    }

    input[type="submit"]{
        width:100%;
        padding:12px;
        margin-top:20px;
        border:none;
        border-radius:8px;
        background:#007bff;
        color:white;
        font-size:16px;
        cursor:pointer;
        transition:0.3s;
    }

    input[type="submit"]:hover{
        background:#0056b3;
    }
</style>

</head>
<body>

<div class="container">

    <h2>Choose Your Food</h2>

    <form action="allOrders.jsp" method="post">

        <div class="food-item"><input type="checkbox" name="food" value="Pizza"> Pizza</div>
        <div class="food-item"><input type="checkbox" name="food" value="Burger"> Burger</div>
        <div class="food-item"><input type="checkbox" name="food" value="Sushi"> Sushi</div>
        <div class="food-item"><input type="checkbox" name="food" value="Pasta"> Pasta</div>
        <div class="food-item"><input type="checkbox" name="food" value="Shawarma"> Shawarma</div>
        <div class="food-item"><input type="checkbox" name="food" value="Kabsa"> Kabsa</div>
        <div class="food-item"><input type="checkbox" name="food" value="Rice"> Rice</div>
        <div class="food-item"><input type="checkbox" name="food" value="Chicken"> Chicken</div>
        <div class="food-item"><input type="checkbox" name="food" value="Salad"> Salad</div>
        <div class="food-item"><input type="checkbox" name="food" value="Falafel"> Falafel</div>

        <input type="submit" value="Order Now">

    </form>

</div>

</body>
</html>