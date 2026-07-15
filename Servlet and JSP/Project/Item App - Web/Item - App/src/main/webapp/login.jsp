<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("loggedUser") != null) {
        response.sendRedirect("index.jsp");
        return;
    }

	
	String successMessage = (String) session.getAttribute("successMessage");
	if (successMessage != null) {
	    session.removeAttribute("successMessage");
	}


	String rememberedUserName = "";
	Cookie[] cookies = request.getCookies();
	
	if (cookies != null) {
		for (Cookie cookie : cookies){
			if (cookie.getName().equals("rememberedUserName")) {
				rememberedUserName = cookie.getValue();
				break;
			}
		}
	}

%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      min-height: 100vh;
      background: #f5f3ef;
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: 'Inter', sans-serif;
      padding: 40px 24px;
    }

    .card {
      background: #ffffff;
      border: 0.5px solid rgba(0,0,0,0.1);
      border-radius: 16px;
      padding: 40px 40px 32px;
      width: 100%;
      max-width: 420px;
    }

    .card-top {
      text-align: center;
      margin-bottom: 32px;
    }

    .card-icon {
      width: 48px; height: 48px;
      border-radius: 12px;
      background: #EEEDFE; color: #534AB7;
      display: flex; align-items: center; justify-content: center;
      font-size: 22px; margin: 0 auto 16px;
    }

    .card-title {
      font-family: 'Playfair Display', serif;
      font-size: 24px; font-weight: 700; color: #1a1a1a;
      margin-bottom: 4px;
    }

    .card-title span {
      background: linear-gradient(135deg, #7c6fcd, #a78bfa);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }

    .card-sub { font-size: 12px; color: #888780; }

    /* Error message */
    .error-msg {
      background: #FFF5F3;
      border: 0.5px solid rgba(216,90,48,0.2);
      border-radius: 8px;
      padding: 10px 14px;
      margin-bottom: 16px;
      font-size: 12px;
      color: #993C1D;
      display: flex; align-items: center; gap: 8px;
    }

    .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }

    .field label {
      font-size: 11px; font-weight: 500;
      color: #888780; letter-spacing: 0.5px; text-transform: uppercase;
    }

    .field input {
      height: 42px;
      border: 0.5px solid rgba(0,0,0,0.15);
      border-radius: 8px; padding: 0 14px;
      font-size: 14px; color: #1a1a1a;
      background: #fff; font-family: 'Inter', sans-serif;
      outline: none; transition: border-color 0.2s, box-shadow 0.2s;
    }

    .field input:focus {
      border-color: #a78bfa;
      box-shadow: 0 0 0 3px rgba(167,139,250,0.12);
    }

    .field input::placeholder { color: #B4B2A9; }

    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 24px 0; }

    .btn-submit {
      width: 100%; height: 42px;
      border-radius: 8px; border: none;
      background: #534AB7; color: #fff;
      font-size: 14px; font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      display: flex; align-items: center; justify-content: center; gap: 8px;
      transition: opacity 0.2s;
    }

    .btn-submit:hover { opacity: 0.88; }
    .btn-submit:active { transform: scale(0.98); }

    .auth-link {
      text-align: center; margin-top: 16px;
      font-size: 12px; color: #888780;
    }

    .auth-link a { color: #534AB7; text-decoration: none; font-weight: 500; }
    .auth-link a:hover { text-decoration: underline; }
    
	  .success-msg {
	  background: #E1F5EE;
	  border: 0.5px solid rgba(29,158,117,0.3);
	  border-radius: 8px;
	  padding: 10px 14px;
	  margin-bottom: 16px;
	  font-size: 12px;
	  color: #0F6E56;
	  display: flex;
	  align-items: center;
	  gap: 8px;
	  animation: fadeIn 0.3s ease;
	}
	
	@keyframes fadeIn {
	  from { opacity: 0; transform: translateY(-8px); }
	  to   { opacity: 1; transform: translateY(0); }
	}
    
  </style>
</head>
<body>

  <div class="card">

	<% if (successMessage != null) { %>
	  <div class="success-msg">
	    <i class="ti ti-circle-check" style="font-size:16px"></i>
	    <%= successMessage %>
	  </div>
	<% } %>

    <div class="card-top">
      <div class="card-icon"><i class="ti ti-lock"></i></div>
      <h1 class="card-title">Welcome <span>Back</span></h1>
      <p class="card-sub">Sign in to your account to continue</p>
    </div>

    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="error-msg">
        <i class="ti ti-alert-circle" style="font-size:16px"></i>
        <%= request.getAttribute("errorMessage") %>
      </div>
    <% } %>

    <form action="AuthController" method="post">
      <input type="hidden" name="action" value="login">

      <div class="field">
        <label for="username">UserName</label>
        <input type="text" id="username" name="username" value="<%= rememberedUserName %>" placeholder="e.g. username" required>
      </div>

      <div class="field">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="••••••••" required>
      </div>

      <div class="divider"></div>

      <button type="submit" class="btn-submit">
        <i class="ti ti-login" style="font-size:16px"></i>
        Sign in
      </button>

	<p class="auth-link">
  <a href="forgotPassword.jsp">Forgot your Password?</a>
</p>

    </form>

    <p class="auth-link">Don't have an Account? <a href="signup.jsp">Sign Up</a></p>

  </div>


	<script>
	document.querySelector('form').addEventListener('submit', function(e) {
	    const username = document.getElementById('username').value.trim();
	    const password = document.getElementById('password').value.trim();
	
	    if (!username) {
	        alert('Username is required!'); e.preventDefault(); return;
	    }
	    if (!password) {
	        alert('Password is required!'); e.preventDefault(); return;
	    }
	    if (password.length < 6) {
	        alert('Password must be at least 6 characters!'); e.preventDefault(); return;
	    }
	});
	</script>


	<%
	    Boolean showOTPModal = (Boolean) session.getAttribute("showOTPModal");
	    String otpError = (String) session.getAttribute("otpError");
	    if (showOTPModal != null) session.removeAttribute("showOTPModal");
	    if (otpError != null) session.removeAttribute("otpError");
	%>
	
	<!-- OTP Modal -->
	<% if (showOTPModal != null && showOTPModal) { %>
	<div id="otpModal" style="
	    position: fixed; inset: 0;
	    background: rgba(0,0,0,0.4);
	    z-index: 200;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	">
	    <div style="
	        background: #fff;
	        border-radius: 16px;
	        padding: 32px;
	        max-width: 360px;
	        width: 90%;
	        text-align: center;
	        box-shadow: 0 20px 60px rgba(0,0,0,0.15);
	    ">
	        <div style="
	            width: 48px; height: 48px; border-radius: 12px;
	            background: #EEF2FF; color: #3B4ED8;
	            display: flex; align-items: center; justify-content: center;
	            font-size: 22px; margin: 0 auto 16px;
	        ">
	            <i class="ti ti-mail-check"></i>
	        </div>
	
	        <p style="font-family:'Playfair Display',serif; font-size:18px; font-weight:700; color:#1a1a1a; margin-bottom:8px;">
	            Verify Your Identity
	        </p>
	        <p style="font-size:13px; color:#888780; margin-bottom:20px;">
	            Enter the 6-digit code sent to Your Email
	        </p>
	
	        <% if (otpError != null) { %>
	        <div style="
	            background: #FFF5F3; border: 0.5px solid rgba(216,90,48,0.2);
	            border-radius: 8px; padding: 10px 14px; margin-bottom: 16px;
	            font-size: 12px; color: #993C1D;
	            display: flex; align-items: center; gap: 8px;
	        ">
	            <i class="ti ti-alert-circle" style="font-size:16px"></i>
	            <%= otpError %>
	        </div>
	        <% } %>
	
	        <form action="AuthController" method="post">
	            <input type="hidden" name="action" value="verifyLoginOTP">
	            <input type="text" name="otp" maxlength="6"
	                placeholder="000000"
	                style="
	                    width: 100%; height: 48px;
	                    border: 0.5px solid rgba(0,0,0,0.15);
	                    border-radius: 8px; padding: 0 14px;
	                    font-size: 20px; text-align: center;
	                    letter-spacing: 6px; color: #1a1a1a;
	                    font-family: 'Inter', sans-serif;
	                    outline: none; margin-bottom: 16px;
	                " required>
	
	            <!-- عداد 5 دقايق -->
	            <p style="font-size:12px; color:#888780; margin-bottom:16px;">
	                Code expires in: <span id="timer" style="color:#3B4ED8; font-weight:600;">05:00</span>
	            </p>
	
	            <button type="submit" style="
	                width: 100%; height: 42px;
	                border-radius: 8px; border: none;
	                background: #3B4ED8; color: #fff;
	                font-size: 14px; font-weight: 500;
	                font-family: 'Inter', sans-serif;
	                cursor: pointer; margin-bottom: 12px;
	            ">
	                <i class="ti ti-check"></i> Verify OTP
	            </button>
	        </form>
	
	        <!-- Resend -->
	        <p id="resendText" style="font-size:12px; color:#888780; display:none;">
	            Didn't receive the code?
	            <a href="AuthController?action=resendLoginOTP" style="color:#3B4ED8; text-decoration:none; font-weight:500;">
	                Re - Send OTP
	            </a>
	        </p>
	    </div>
	</div>
	
	<script>
	    // عدد 5 دقايق
	    let seconds = 300;
	    const timer = document.getElementById('timer');
	    const resendText = document.getElementById('resendText');
	
	    const countdown = setInterval(() => {
	        seconds--;
	        const m = Math.floor(seconds / 60).toString().padStart(2, '0');
	        const s = (seconds % 60).toString().padStart(2, '0');
	        timer.textContent = m + ':' + s;
	
	        if (seconds <= 0) {
	            clearInterval(countdown);
	            timer.textContent = '00:00';
	            timer.style.color = '#993C1D';
	            resendText.style.display = 'block';
	        }
	    }, 1000);
	</script>
	<% } %>


</body>
</html>
