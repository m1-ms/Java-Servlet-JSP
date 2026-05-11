<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Form</title>
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

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        color: #555;
        font-size: 14px;
        margin-bottom: 6px;
        font-weight: bold;
    }

    input[type="text"],
    input[type="password"],
    input[type="number"],
    select {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
        outline: none;
        transition: border 0.3s;
    }

    input:focus, select:focus {
        border-color: #3498db;
    }

    .radio-group {
        display: flex;
        gap: 20px;
        margin-top: 6px;
    }

    .radio-group label {
        font-weight: normal;
        display: flex;
        align-items: center;
        gap: 6px;
        cursor: pointer;
    }

    input[type="submit"] {
        width: 100%;
        padding: 12px;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background 0.3s;
        margin-top: 10px;
    }

    input[type="submit"]:hover {
        background-color: #2980b9;
    }
</style>
</head>
<body>

<div class="card">
    <h2>Student Form</h2>

    <form action="result.jsp" method="post">

        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullName"
                   pattern="[A-Za-z ]+"
                   title="Letters only!"
                   placeholder="Enter your full name"
                   required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password"
                   placeholder="Enter your password"
                   required>
        </div>

        <div class="form-group">
            <label>Age</label>
            <input type="number" name="age"
                   min="1" max="100"
                   placeholder="Enter your age"
                   required>
        </div>

        <div class="form-group">
            <label>City (Radio)</label>
            <div class="radio-group">
                <label><input type="radio" name="city" value="Cairo"> Cairo</label>
                <label><input type="radio" name="city" value="Alex"> Alex</label>
                <label><input type="radio" name="city" value="Menofia"> Menofia</label>
            </div>
        </div>

        <div class="form-group">
            <label>Address (Select)</label>
            <select name="address">
                <option value="">-- Choose --</option>
                <option value="Cairo">Cairo</option>
                <option value="Alex">Alex</option>
                <option value="Menofia">Menofia</option>
            </select>
        </div>

        <input type="submit" value="Submit">

    </form>
</div>

</body>
</html>