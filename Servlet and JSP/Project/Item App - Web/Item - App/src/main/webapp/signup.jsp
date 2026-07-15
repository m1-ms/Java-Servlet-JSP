<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign Up</title>
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
      max-width: 520px;
    }

    .card-top { text-align: center; margin-bottom: 32px; }

    .card-icon {
      width: 48px; height: 48px;
      border-radius: 12px;
      background: #E1F5EE; color: #0F6E56;
      display: flex; align-items: center; justify-content: center;
      font-size: 22px; margin: 0 auto 16px;
    }

    .card-title {
      font-family: 'Playfair Display', serif;
      font-size: 24px; font-weight: 700; color: #1a1a1a;
      margin-bottom: 4px;
    }

    .card-title span {
      background: linear-gradient(135deg, #1D9E75, #5DCAA5);
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

    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
      margin-bottom: 14px;
    }

    .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 14px; }
    .field.no-margin { margin-bottom: 0; }

    .field label {
      font-size: 11px; font-weight: 500;
      color: #888780; letter-spacing: 0.5px; text-transform: uppercase;
    }

    .field input {
      height: 40px;
      border: 0.5px solid rgba(0,0,0,0.15);
      border-radius: 8px; padding: 0 14px;
      font-size: 13px; color: #1a1a1a;
      background: #fff; font-family: 'Inter', sans-serif;
      outline: none; transition: border-color 0.2s, box-shadow 0.2s;
    }

    .field input:focus {
      border-color: #1D9E75;
      box-shadow: 0 0 0 3px rgba(29,158,117,0.1);
    }

    .field input::placeholder { color: #B4B2A9; }

    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 20px 0; }

    /* Terms */
    .terms {
      display: flex; align-items: flex-start; gap: 10px;
      margin-bottom: 20px;
    }

    .terms input[type="checkbox"] {
      width: 16px; height: 16px;
      margin-top: 2px; accent-color: #0F6E56;
      flex-shrink: 0; cursor: pointer;
    }

    .terms label {
      font-size: 12px; color: #5F5E5A;
      line-height: 1.5; cursor: pointer;
    }

    .terms label a { color: #0F6E56; text-decoration: none; font-weight: 500; }
    .terms label a:hover { text-decoration: underline; }

    .btn-submit {
      width: 100%; height: 42px;
      border-radius: 8px; border: none;
      background: #0F6E56; color: #fff;
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

    @media (max-width: 480px) {
      .card { padding: 28px 24px; }
      .form-row { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

  <div class="card">

    <div class="card-top">
      <div class="card-icon"><i class="ti ti-user-plus"></i></div>
      <h1 class="card-title">Create <span>Account</span></h1>
      <p class="card-sub">Fill in your details to get started</p>
    </div>

    <% if (request.getAttribute("errorMessage") != null) { %>
      <div class="error-msg">
        <i class="ti ti-alert-circle" style="font-size:16px"></i>
        <%= request.getAttribute("errorMessage") %>
      </div>
    <% } %>

    <form action="AuthController" method="post">
      <input type="hidden" name="action" value="signup">

      <div class="form-row">
        <div class="field no-margin">
          <label for="firstName">First name</label>
          <input type="text" id="firstName" name="firstName" placeholder="e.g." required>
        </div>
        <div class="field no-margin">
          <label for="lastName">Last name</label>
          <input type="text" id="lastName" name="lastName" placeholder="e.g." required>
        </div>
      </div>

      <div class="form-row">
        <div class="field no-margin">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" placeholder="e.g. userName" required>
        </div>
        <div class="field no-margin">
          <label for="phone">Phone number</label>
          <input type="text" id="phone" name="phone" placeholder="e.g. 01012345678">
        </div>
      </div>

      <div class="field">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="e.g. mahmoud@email.com" required>
      </div>

      <div class="form-row">
        <div class="field no-margin">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>
        <div class="field no-margin">
          <label for="confirmPassword">Confirm password</label>
          <input type="password" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required>
        </div>
      </div>

      <div class="divider"></div>

      <div class="terms">
        <input type="checkbox" id="terms" name="terms" required>
        <label for="terms">
          I agree to the <a href="#">Terms and Conditions</a> and <a href="#">Privacy Policy</a>
        </label>
      </div>

      <button type="submit" class="btn-submit">
        <i class="ti ti-user-check" style="font-size:16px"></i>
        Sign up
      </button>

    </form>

    <p class="auth-link">Already have an account? <a href="login.jsp">Sign in</a></p>

  </div>


	<script>
	document.querySelector('form').addEventListener('submit', function(e) {
	    const firstName = document.getElementById('firstName').value.trim();
	    const lastName  = document.getElementById('lastName').value.trim();
	    const username  = document.getElementById('username').value.trim();
	    const email     = document.getElementById('email').value.trim();
	    const password  = document.getElementById('password').value.trim();
	    const confirm   = document.getElementById('confirmPassword').value.trim();
	
	    if (!firstName || !/^[A-Za-z]{3,}$/.test(firstName)) {
	        alert('First name must be at least 3 letters!'); e.preventDefault(); return;
	    }
	    if (!lastName || !/^[A-Za-z]{3,}$/.test(lastName)) {
	        alert('Last name must be at least 3 letters!'); e.preventDefault(); return;
	    }
	    if (!username || username.length < 3) {
	        alert('Username must be at least 3 characters!'); e.preventDefault(); return;
	    }
	    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
	        alert('Please enter a valid email!'); e.preventDefault(); return;
	    }
	    if (!password || password.length < 6) {
	        alert('Password must be at least 6 characters!'); e.preventDefault(); return;
	    }
	    if (password !== confirm) {
	        alert('Passwords do not match!'); e.preventDefault(); return;
	    }
	});
	</script>



	<%
	    Boolean showSignupOTPModal = (Boolean) session.getAttribute("showSignupOTPModal");
	    String signupOtpError = (String) session.getAttribute("signupOtpError");
	    if (showSignupOTPModal != null) session.removeAttribute("showSignupOTPModal");
	    if (signupOtpError != null) session.removeAttribute("signupOtpError");
	%>
	
	<!-- SignUp OTP Modal -->
	<% if (showSignupOTPModal != null && showSignupOTPModal) { %>
	<div style="
	    position: fixed; inset: 0;
	    background: rgba(0,0,0,0.4);
	    z-index: 300;
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
	            background: #E1F5EE; color: #0F6E56;
	            display: flex; align-items: center; justify-content: center;
	            font-size: 22px; margin: 0 auto 16px;
	        ">
	            <i class="ti ti-mail-check"></i>
	        </div>
	
	        <p style="font-family:'Playfair Display',serif; font-size:18px; font-weight:700; color:#1a1a1a; margin-bottom:8px;">
	            Verify Your Email
	        </p>
	        <p style="font-size:13px; color:#888780; margin-bottom:20px;">
	            Enter the 6-digit code sent to your email to complete signup
	        </p>
	
	        <% if (signupOtpError != null) { %>
	        <div style="
	            background: #FFF5F3; border: 0.5px solid rgba(216,90,48,0.2);
	            border-radius: 8px; padding: 10px 14px; margin-bottom: 16px;
	            font-size: 12px; color: #993C1D;
	            display: flex; align-items: center; gap: 8px;
	        ">
	            <i class="ti ti-alert-circle" style="font-size:16px"></i>
	            <%= signupOtpError %>
	        </div>
	        <% } %>
	
	        <form action="AuthController" method="post">
	            <input type="hidden" name="action" value="verifySignupOTP">
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
	
	            <!-- عدد 5 دقايق -->
	            <p style="font-size:12px; color:#888780; margin-bottom:16px;">
	                Code expires in: <span id="signupTimer" style="color:#0F6E56; font-weight:600;">05:00</span>
	            </p>
	
	            <button type="submit" style="
	                width: 100%; height: 42px;
	                border-radius: 8px; border: none;
	                background: #0F6E56; color: #fff;
	                font-size: 14px; font-weight: 500;
	                font-family: 'Inter', sans-serif;
	                cursor: pointer; margin-bottom: 12px;
	            ">
	                <i class="ti ti-check"></i> Verify & Create Account
	            </button>
	        </form>
	
	        <!-- ReSend -->
	        <p id="signupResendText" style="font-size:12px; color:#888780; display:none;">
	            Didn't receive the code?
	            <a href="signup.jsp" style="color:#0F6E56; text-decoration:none; font-weight:500;">
	                Go Back & Try Again
	            </a>
	        </p>
	    </div>
	</div>
	
	<script>
	    let signupSeconds = 300;
	    const signupTimer = document.getElementById('signupTimer');
	    const signupResendText = document.getElementById('signupResendText');
	
	    const signupCountdown = setInterval(() => {
	        signupSeconds--;
	        const m = Math.floor(signupSeconds / 60).toString().padStart(2, '0');
	        const s = (signupSeconds % 60).toString().padStart(2, '0');
	        signupTimer.textContent = m + ':' + s;
	
	        if (signupSeconds <= 0) {
	            clearInterval(signupCountdown);
	            signupTimer.textContent = '00:00';
	            signupResendText.style.display = 'block';
	        }
	    }, 1000);
	</script>
	<% } %>


</body>
</html>
