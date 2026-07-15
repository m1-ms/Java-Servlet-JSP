<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Forgot Password</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      min-height: 100vh; background: #f5f3ef;
      display: flex; align-items: center; justify-content: center;
      font-family: 'Inter', sans-serif; padding: 40px 24px;
    }
    .card {
      background: #fff; border: 0.5px solid rgba(0,0,0,0.1);
      border-radius: 16px; padding: 40px 40px 32px;
      width: 100%; max-width: 420px;
    }
    .card-top { text-align: center; margin-bottom: 32px; }
    .card-icon {
      width: 48px; height: 48px; border-radius: 12px;
      background: #EEF2FF; color: #3B4ED8;
      display: flex; align-items: center; justify-content: center;
      font-size: 22px; margin: 0 auto 16px;
    }
    .card-title { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 700; color: #1a1a1a; margin-bottom: 4px; }
    .card-title span {
      background: linear-gradient(135deg, #3B4ED8, #818CF8);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }
    .card-sub { font-size: 12px; color: #888780; }

    .error-msg {
      background: #FFF5F3; border: 0.5px solid rgba(216,90,48,0.2);
      border-radius: 8px; padding: 10px 14px; margin-bottom: 16px;
      font-size: 12px; color: #993C1D;
      display: flex; align-items: center; gap: 8px;
    }

    .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 14px; }
    .field label { font-size: 11px; font-weight: 500; color: #888780; letter-spacing: 0.5px; text-transform: uppercase; }
    .field input {
      height: 42px; border: 0.5px solid rgba(0,0,0,0.15);
      border-radius: 8px; padding: 0 14px;
      font-size: 14px; color: #1a1a1a;
      background: #fff; font-family: 'Inter', sans-serif;
      outline: none; transition: border-color 0.2s, box-shadow 0.2s;
    }
    .field input:focus {
      border-color: #3B4ED8; box-shadow: 0 0 0 3px rgba(59,78,216,0.12);
    }
    .field input::placeholder { color: #B4B2A9; }

    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 20px 0; }

    .actions { display: flex; align-items: center; justify-content: space-between; }
    .btn-back {
      font-size: 13px; color: #888780; text-decoration: none;
      display: flex; align-items: center; gap: 6px; transition: color 0.2s;
    }
    .btn-back:hover { color: #3B4ED8; }
    .btn-submit {
      height: 42px; padding: 0 24px; border-radius: 8px; border: none;
      background: #3B4ED8; color: #fff; font-size: 14px; font-weight: 500;
      font-family: 'Inter', sans-serif; cursor: pointer;
      display: flex; align-items: center; gap: 6px; transition: opacity 0.2s;
    }
    .btn-submit:hover { opacity: 0.88; }
  </style>
</head>
<body>
  <div class="card">
    <div class="card-top">
      <div class="card-icon"><i class="ti ti-lock-question"></i></div>
      <h1 class="card-title">Forgot <span>Password?</span></h1>
      <p class="card-sub">Enter your Details to Verify Your Account</p>
    </div>

    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="error-msg">
        <i class="ti ti-alert-circle" style="font-size:16px"></i>
        <%= request.getAttribute("errorMessage") %>
      </div>
    <% } %>

    <form action="AuthController" method="post">
      <input type="hidden" name="action" value="sendOTP">

      
		<div class="field">
		    <label for="identifier">Email or UserName</label>
		    <input type="text" id="identifier" name="identifier" 
		           placeholder="e.g. email@gmail.com or UserName" required>
		</div>
      

      <div class="divider"></div>
      <div class="actions">
        <a href="login.jsp" class="btn-back">
          <i class="ti ti-arrow-left" style="font-size:15px"></i> Back to Log In
        </a>
        <button type="submit" class="btn-submit">
          <i class="ti ti-check" style="font-size:15px"></i> Verify
        </button>
      </div>
    </form>
  </div>
</body>
</html>
