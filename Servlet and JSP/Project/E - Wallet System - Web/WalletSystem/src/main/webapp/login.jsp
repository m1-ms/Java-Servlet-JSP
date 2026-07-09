<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storm Cash — Login</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: 'Inter', sans-serif;
      background: #F2F2F7;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 24px;
    }

    .card {
      background: #FFFFFF;
      border-radius: 20px;
      width: 100%;
      max-width: 860px;
      min-height: 500px;
      display: flex;
      overflow: hidden;
      box-shadow: 0 4px 6px rgba(0,0,0,0.04), 0 1px 3px rgba(0,0,0,0.06);
    }

    /* LEFT */
    .left {
      flex: 1.05;
      background: #1C1C1E;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 40px 40px 36px;
      position: relative;
      overflow: hidden;
    }

    .left::after {
      content: '';
      position: absolute;
      bottom: -60px; right: -60px;
      width: 220px; height: 220px;
      border-radius: 50%;
      background: rgba(255,255,255,0.025);
      pointer-events: none;
    }

    .brand { display: flex; align-items: center; gap: 10px; }

    .logo-mark {
      width: 30px; height: 30px; border-radius: 8px;
      background: white;
      display: flex; align-items: center; justify-content: center;
      flex-shrink: 0;
    }

    .logo-mark svg { display: block; }

    .brand-name {
      font-size: 15px; font-weight: 650;
      color: #FFFFFF; letter-spacing: -0.4px;
    }

    .hero { flex: 1; display: flex; flex-direction: column; justify-content: center; padding: 36px 0 28px; }

    .eyebrow {
      font-size: 10px; font-weight: 600;
      color: rgba(255,255,255,0.3);
      letter-spacing: 2px; text-transform: uppercase; margin-bottom: 14px;
    }

    .hero-title {
      font-size: 30px; font-weight: 300;
      color: #FFFFFF; line-height: 1.3; letter-spacing: -0.8px;
    }

    .hero-title strong { font-weight: 700; }

    .hero-desc {
      margin-top: 14px; font-size: 13px;
      color: rgba(255,255,255,0.35); line-height: 1.7; max-width: 240px;
    }

    .stats { display: flex; gap: 28px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.07); }

    .stat-num { font-size: 17px; font-weight: 600; color: white; letter-spacing: -0.5px; }
    .stat-lbl { font-size: 11px; color: rgba(255,255,255,0.28); margin-top: 2px; }

    /* RIGHT */
    .right {
      flex: 1;
      background: #FFFFFF;
      display: flex; flex-direction: column; justify-content: center;
      padding: 44px 44px;
    }

    .form-eyebrow {
      font-size: 10px; font-weight: 600; color: #AEAEB2;
      letter-spacing: 2px; text-transform: uppercase; margin-bottom: 6px;
    }

    .form-title {
      font-size: 22px; font-weight: 700;
      color: #1C1C1E; letter-spacing: -0.5px; margin-bottom: 26px;
    }

    /* Segmented control */
    .seg {
      display: flex; background: #F2F2F7;
      border-radius: 10px; padding: 3px;
      margin-bottom: 24px; gap: 2px;
    }

    .seg-btn {
      flex: 1; padding: 8px;
      font-size: 13px; font-weight: 500; color: #8E8E93;
      background: none; border: none;
      border-radius: 8px; cursor: pointer;
      font-family: 'Inter', sans-serif; transition: all 0.18s;
    }

    .seg-btn.active {
      background: #FFFFFF; color: #1C1C1E;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06);
    }

    /* Error message */
    .error-msg {
      background: #FFF1F0; border: 1px solid rgba(255,59,48,0.2);
      border-radius: 10px; padding: 10px 14px;
      font-size: 12px; color: #FF3B30; margin-bottom: 16px;
      display: flex; align-items: center; gap: 8px;
    }

    .field { margin-bottom: 14px; }

    label {
      display: block; font-size: 12px; font-weight: 500;
      color: #1C1C1E; margin-bottom: 6px;
    }

    input[type="text"], input[type="password"], input[type="number"] {
      width: 100%;
      background: #F2F2F7; border: 1.5px solid transparent;
      border-radius: 10px; padding: 11px 14px;
      font-size: 14px; color: #1C1C1E;
      font-family: 'Inter', sans-serif; outline: none; transition: all 0.18s;
    }

    input:focus {
      background: #FFFFFF; border-color: #1C1C1E;
      box-shadow: 0 0 0 3px rgba(28,28,30,0.06);
    }

    input::placeholder { color: #C7C7CC; }

    .btn {
      width: 100%; padding: 13px;
      background: #1C1C1E; border: none; border-radius: 10px;
      font-size: 14px; font-weight: 600; color: white;
      font-family: 'Inter', sans-serif; cursor: pointer;
      margin-top: 6px; letter-spacing: -0.2px; transition: opacity 0.18s;
    }

    .btn:hover { opacity: 0.82; }

    .switch-link {
      text-align: center; margin-top: 16px;
      font-size: 12px; color: #AEAEB2;
    }

    .switch-link a {
      color: #1C1C1E; font-weight: 500;
      text-decoration: none; cursor: pointer;
    }

    .panel { display: none; }
    .panel.active { display: block; }
  </style>
</head>
<body>

<div class="card">


  <div class="left">
    <div class="brand">
      <div class="logo-mark">
        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
          <path d="M7 1.5L12 4.5V9.5L7 12.5L2 9.5V4.5L7 1.5Z" fill="#1C1C1E"/>
        </svg>
      </div>
      <span class="brand-name">Storm Cash</span>
    </div>

    <div class="hero">
      <h1 class="hero-title">Your Money,<br><strong>Under Control.</strong></h1>
      <p class="hero-desc">Send, receive, and manage your balance with clarity and confidence.</p>
    </div>

    <div class="stats">
      <div><div class="stat-num">100%</div><div class="stat-lbl">Secure</div></div>
      <div><div class="stat-num">0 Fees</div><div class="stat-lbl">Transfers</div></div>
      <div><div class="stat-num">24 / 7</div><div class="stat-lbl">Available</div></div>
    </div>
  </div>

  <!-- RIGHT -->
  <div class="right">
    <div class="form-eyebrow">Welcome</div>
    <div class="form-title" id="form-title">Sign in to Your Account</div>

    <div class="seg">
      <button class="seg-btn active" onclick="switchForm('login', this)">Login</button>
      <button class="seg-btn" onclick="switchForm('register', this)">Register</button>
    </div>

    <!-- Error from server -->
    <% if (request.getAttribute("error") != null) { %>
    <div class="error-msg">
      <i class="ti ti-alert-circle"></i>
      <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <!-- LOGIN PANEL -->
    <div id="panel-login" class="panel active">
      <form action="AuthController" method="post">
        <input type="hidden" name="action" value="login">
        <div class="field">
          <label>UserName</label>
          <input type="text" name="username" placeholder="" required>
        </div>
        <div class="field">
          <label>Password</label>
          <input type="password" name="password" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn">Sign In</button>
      </form>
      
    <div style="text-align:center;margin-top:10px;">
	  <a href="AuthController?action=ForgetPassword"
	     style="font-size:12px;color:#AEAEB2;text-decoration:none;">
	    Forget Password ?
	  </a>
	</div>
      
      <div class="switch-link">No Account ? <a onclick="switchFormByName('register')">Create One</a></div>
    </div>


    <!-- REGISTER PANEL -->
    <div id="panel-register" class="panel">
      <form action="AuthController" method="post">
        <input type="hidden" name="action" value="register">
        <div class="field">
          <label>Full Name</label>
          <input type="text" name="fullName" placeholder="" required>
        </div>
        <div class="field">
          <label>UserName</label>
          <input type="text" name="username" placeholder="" required>
        </div>
        <div class="field">
          <label>Phone Number</label>
          <input type="text" name="phone" placeholder="" required>
        </div>
        
        <div class="field">
			<label>E-Mail</label>
  			<input type="text" name="email" placeholder="example@gmail.com" required>
		</div>
        
        <div class="field">
          <label>Age</label>
          <input type="number" name="age" placeholder="21" min="18" max="100" required>
        </div>
        <div class="field">
          <label>Password</label>
          <input type="password" name="password" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn">Create Account</button>
      </form>
      <div class="switch-link">Already have One? <a onclick="switchFormByName('login')">Sign In</a></div>
      
      
    </div>

  </div>
</div>

<script>
  function switchForm(name, el) {
    document.querySelectorAll('.seg-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
    el.classList.add('active');
    document.getElementById('panel-' + name).classList.add('active');
    document.getElementById('form-title').textContent =
      name === 'login' ? 'Sign in to your account' : 'Create your account';
  }
  function switchFormByName(name) {
    const btns = document.querySelectorAll('.seg-btn');
    switchForm(name, name === 'login' ? btns[0] : btns[1]);
  }
</script>

</body>
</html>
