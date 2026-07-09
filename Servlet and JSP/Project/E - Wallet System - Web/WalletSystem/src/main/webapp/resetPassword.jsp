<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String resetUsername = (String) session.getAttribute("resetUsername");
    if (resetUsername == null) { response.sendRedirect("forgotPassword.jsp"); return; }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storm Cash — Reset Password</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Inter', sans-serif; background: #F2F2F7; min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 24px; }

    .card { background: #FFFFFF; border-radius: 20px; width: 100%; max-width: 440px; padding: 40px; box-shadow: 0 4px 6px rgba(0,0,0,0.04), 0 1px 3px rgba(0,0,0,0.06); }

    .logo-row { display: flex; align-items: center; gap: 10px; margin-bottom: 32px; }
    .logo-mark { width: 30px; height: 30px; border-radius: 8px; background: #1C1C1E; display: flex; align-items: center; justify-content: center; }
    .logo-mark svg { display: block; }
    .brand-name { font-size: 15px; font-weight: 650; color: #1C1C1E; letter-spacing: -0.4px; }

    .icon-wrap { width: 48px; height: 48px; border-radius: 13px; background: #F0FAF4; display: flex; align-items: center; justify-content: center; font-size: 22px; color: #30D158; margin-bottom: 16px; }

    .title { font-size: 22px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.5px; margin-bottom: 6px; }
    .subtitle { font-size: 13px; color: #AEAEB2; margin-bottom: 28px; line-height: 1.6; }

    .verified-badge { display: flex; align-items: center; gap: 8px; background: #F0FAF4; border: 1px solid rgba(48,209,88,0.2); border-radius: 10px; padding: 10px 14px; font-size: 12px; color: #1D9E55; font-weight: 500; margin-bottom: 20px; }

    .msg { border-radius: 10px; padding: 10px 14px; font-size: 12px; margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
    .msg.error { background: #FFF1F0; border: 1px solid rgba(255,59,48,0.2); color: #FF3B30; }

    .field { margin-bottom: 14px; }
    label { display: block; font-size: 12px; font-weight: 500; color: #1C1C1E; margin-bottom: 6px; }

    .inp-wrap { position: relative; }
    input[type="password"], input[type="text"] { width: 100%; background: #F2F2F7; border: 1.5px solid transparent; border-radius: 10px; padding: 11px 40px 11px 14px; font-size: 14px; color: #1C1C1E; font-family: 'Inter', sans-serif; outline: none; transition: all 0.15s; }
    input:focus { background: #FFFFFF; border-color: #1C1C1E; box-shadow: 0 0 0 3px rgba(28,28,30,0.06); }
    input::placeholder { color: #C7C7CC; }

    .eye-btn { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 16px; color: #C7C7CC; cursor: pointer; background: none; border: none; padding: 0; }
    .eye-btn:hover { color: #6C6C70; }

    .btn { width: 100%; padding: 13px; background: #1C1C1E; border: none; border-radius: 10px; font-size: 14px; font-weight: 600; color: white; font-family: 'Inter', sans-serif; cursor: pointer; margin-top: 6px; transition: opacity 0.15s; display: flex; align-items: center; justify-content: center; gap: 7px; }
    .btn:hover { opacity: 0.82; }
  </style>
</head>
<body>
<div class="card">
  <div class="logo-row">
    <div class="logo-mark">
      <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
        <path d="M7 1.5L12 4.5V9.5L7 12.5L2 9.5V4.5L7 1.5Z" fill="white"/>
      </svg>
    </div>
    <span class="brand-name">Storm Cash</span>
  </div>

  <div class="icon-wrap"><i class="ti ti-lock-check"></i></div>
  <div class="title">Reset Password</div>
  <div class="subtitle">Identity verified! Enter your New Password Below.</div>

  <div class="verified-badge">
    <i class="ti ti-circle-check" style="font-size:15px;"></i>
    Verified as <strong style="margin-left:4px;"><%= resetUsername %></strong>
  </div>

  <% if (error != null) { %>
  <div class="msg error"><i class="ti ti-alert-circle"></i> <%= error %></div>
  <% } %>

  <form action="AuthController" method="post">
    <input type="hidden" name="action" value="resetPassword">
    <div class="field">
      <label>New Password</label>
      <div class="inp-wrap">
        <input type="password" name="newPassword" id="new-pass" placeholder="••••••••" required>
        <button type="button" class="eye-btn" onclick="toggleEye('new-pass',this)"><i class="ti ti-eye"></i></button>
      </div>
    </div>
    <div class="field">
      <label>Confirm New Password</label>
      <div class="inp-wrap">
        <input type="password" name="confirmPassword" id="conf-pass" placeholder="••••••••" required>
        <button type="button" class="eye-btn" onclick="toggleEye('conf-pass',this)"><i class="ti ti-eye"></i></button>
      </div>
    </div>
    <button type="submit" class="btn"><i class="ti ti-lock-check"></i> Reset Password</button>
  </form>
</div>

<script>
  function toggleEye(id, btn) {
    const inp = document.getElementById(id);
    const show = inp.type === 'password';
    inp.type = show ? 'text' : 'password';
    btn.querySelector('i').className = show ? 'ti ti-eye-off' : 'ti ti-eye';
  }
</script>
</body>
</html>