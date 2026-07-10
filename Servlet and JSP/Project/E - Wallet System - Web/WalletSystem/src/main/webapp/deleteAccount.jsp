<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>
<%
    Account account = (Account) session.getAttribute("account");
    if (account == null) { response.sendRedirect("login.jsp"); return; }
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storm Cash — Delete Account</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Inter', sans-serif; background: #F2F2F7; min-height: 100vh; display: flex; }

    .sidebar { width: 216px; background: #FAFAFA; border-right: 1px solid rgba(0,0,0,0.07); display: flex; flex-direction: column; flex-shrink: 0; min-height: 100vh; position: fixed; top: 0; left: 0; bottom: 0; }
    .brand { display: flex; align-items: center; gap: 10px; padding: 20px 18px 16px; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .logo-mark { width: 30px; height: 30px; border-radius: 8px; background: #1C1C1E; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .logo-mark svg { display: block; }
    .brand-name { font-size: 14px; font-weight: 650; color: #1C1C1E; letter-spacing: -0.4px; }
    .nav-section { padding: 14px 10px 4px; }
    .nav-lbl { font-size: 10px; font-weight: 600; color: #C7C7CC; letter-spacing: 1px; text-transform: uppercase; padding: 0 8px; margin-bottom: 3px; display: block; }
    .nav-item { display: flex; align-items: center; gap: 8px; width: 100%; padding: 7px 10px; font-size: 13px; font-weight: 500; color: #3A3A3C; border-radius: 9px; cursor: pointer; border: none; background: none; font-family: 'Inter', sans-serif; text-align: left; text-decoration: none; transition: background 0.12s; margin-bottom: 1px; }
    .nav-item i { font-size: 15px; color: #C7C7CC; width: 18px; text-align: center; flex-shrink: 0; }
    .nav-item:hover { background: #F2F2F7; color: #1C1C1E; }
    .nav-item:hover i { color: #6C6C70; }
    .nav-item.active { background: #FFFFFF; color: #FF3B30; font-weight: 600; box-shadow: 0 1px 3px rgba(0,0,0,0.07); }
    .nav-item.active i { color: #FF3B30; }
    .nav-item.danger { color: #FF3B30; }
    .nav-item.danger i { color: #FFB3B0; }
    .nav-item.danger:hover { background: #FFF2F1; }
    .sidebar-footer { margin-top: auto; padding: 10px; border-top: 1px solid rgba(0,0,0,0.05); }
    .user-row { display: flex; align-items: center; gap: 9px; padding: 8px; border-radius: 9px; }
    .avatar { width: 28px; height: 28px; border-radius: 50%; background: #1C1C1E; display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 700; color: white; flex-shrink: 0; }
    .u-name { font-size: 12px; font-weight: 600; color: #1C1C1E; }
    .u-role { font-size: 11px; color: #AEAEB2; }

    .main { flex: 1; margin-left: 216px; min-height: 100vh; display: flex; flex-direction: column; }

    .topbar { display: flex; align-items: center; justify-content: space-between; padding: 16px 28px; background: rgba(242,242,247,0.85); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(0,0,0,0.06); position: sticky; top: 0; z-index: 10; }
    .page-title { font-size: 17px; font-weight: 700; color: #FF3B30; letter-spacing: -0.5px; }
    .page-sub { font-size: 12px; color: #AEAEB2; margin-top: 1px; }
    .back-btn { display: flex; align-items: center; gap: 5px; padding: 6px 13px; background: #FFFFFF; border: 1px solid rgba(0,0,0,0.09); border-radius: 8px; font-size: 12px; font-weight: 500; color: #3A3A3C; text-decoration: none; box-shadow: 0 1px 2px rgba(0,0,0,0.04); transition: background 0.12s; }
    .back-btn:hover { background: #F2F2F7; }
    .back-btn i { font-size: 14px; color: #AEAEB2; }

    .content { padding: 32px 28px; display: flex; gap: 20px; align-items: flex-start; }

    .form-card { flex: 0 0 380px; background: #FFFFFF; border: 1px solid rgba(255,59,48,0.15); border-radius: 14px; padding: 28px; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }

    .warn-header { display: flex; align-items: center; gap: 14px; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .warn-icon { width: 44px; height: 44px; border-radius: 12px; background: #FFF1F0; display: flex; align-items: center; justify-content: center; font-size: 22px; color: #FF3B30; flex-shrink: 0; }
    .warn-title { font-size: 16px; font-weight: 700; color: #FF3B30; letter-spacing: -0.3px; }
    .warn-sub { font-size: 12px; color: #AEAEB2; margin-top: 2px; }

    .warn-list { margin-bottom: 22px; display: flex; flex-direction: column; gap: 10px; }
    .warn-item { display: flex; align-items: flex-start; gap: 10px; font-size: 12px; color: #3A3A3C; line-height: 1.5; }
    .warn-item i { font-size: 15px; color: #FF3B30; flex-shrink: 0; margin-top: 1px; }

    .msg { border-radius: 10px; padding: 10px 14px; font-size: 12px; margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
    .msg.error { background: #FFF1F0; border: 1px solid rgba(255,59,48,0.2); color: #FF3B30; }

    .field { margin-bottom: 16px; }
    label { display: block; font-size: 12px; font-weight: 500; color: #1C1C1E; margin-bottom: 6px; }

    .inp-wrap { position: relative; }
    input[type="password"], input[type="text"] { width: 100%; background: #F2F2F7; border: 1.5px solid transparent; border-radius: 10px; padding: 11px 40px 11px 14px; font-size: 14px; color: #1C1C1E; font-family: 'Inter', sans-serif; outline: none; transition: all 0.15s; }
    input:focus { background: #FFFFFF; border-color: #FF3B30; box-shadow: 0 0 0 3px rgba(255,59,48,0.08); }
    input::placeholder { color: #C7C7CC; }

    .eye-btn { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); font-size: 16px; color: #C7C7CC; cursor: pointer; background: none; border: none; padding: 0; }

    .delete-btn { width: 100%; padding: 13px; background: #FF3B30; border: none; border-radius: 10px; font-size: 14px; font-weight: 600; color: white; font-family: 'Inter', sans-serif; cursor: pointer; margin-top: 4px; display: flex; align-items: center; justify-content: center; gap: 7px; transition: opacity 0.15s; }
    .delete-btn:hover { opacity: 0.85; }

    .inactive-btn { width: 100%; padding: 11px; background: transparent; border: 1px solid rgba(0,0,0,0.1); border-radius: 10px; font-size: 13px; font-weight: 500; color: #6C6C70; font-family: 'Inter', sans-serif; cursor: pointer; margin-top: 8px; display: flex; align-items: center; justify-content: center; gap: 7px; transition: all 0.15s; }
    .inactive-btn:hover { background: #F2F2F7; color: #1C1C1E; }

    .info-card { flex: 1; background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06); border-radius: 14px; padding: 22px 24px; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }
    .info-title { font-size: 13px; font-weight: 650; color: #1C1C1E; margin-bottom: 14px; }
    .info-row { display: flex; justify-content: space-between; font-size: 12px; padding: 10px 0; border-bottom: 1px solid rgba(0,0,0,0.04); }
    .info-row:last-child { border-bottom: none; }
    .info-k { color: #AEAEB2; }
    .info-v { color: #1C1C1E; font-weight: 500; }
  </style>
</head>
<body>

<!-- SIDEBAR -->
<div class="sidebar">
  <div class="brand">
    <div class="logo-mark">
      <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
        <path d="M7 1.5L12 4.5V9.5L7 12.5L2 9.5V4.5L7 1.5Z" fill="white"/>
      </svg>
    </div>
    <span class="brand-name">Storm Cash</span>
  </div>
  
  <% if (account.isAdmin()) { %>
	<div class="nav-section" style="padding-top:8px;">
	  <span class="nav-lbl">Admin</span>
	  <a href="AdminController?action=showDashboard" class="nav-item">
	    <i class="ti ti-shield-check"></i> Admin DashBoard
	  </a>
	</div>
	<% } %>
  <div class="nav-section">
    <span class="nav-lbl">My Wallet</span>
    <a href="DashboardController" class="nav-item"><i class="ti ti-home"></i> Dash Board</a>
    <a href="WalletController?action=showDepositPage"      class="nav-item"><i class="ti ti-arrow-down-circle"></i> Deposit</a>
    <a href="WalletController?action=showWithdrawPage"     class="nav-item"><i class="ti ti-arrow-up-circle"></i> Withdraw</a>
    <a href="WalletController?action=showTransferPage"     class="nav-item"><i class="ti ti-transfer"></i> Transfer</a>
    <a href="WalletController?action=showTransactionsPage" class="nav-item"><i class="ti ti-history"></i> Transactions</a>
  </div>
  <div class="nav-section">
    <span class="nav-lbl">Account</span>
    <a href="AccountController?action=showProfilePage"        class="nav-item"><i class="ti ti-user"></i> Profile</a>
    <a href="AccountController?action=showChangePasswordPage" class="nav-item"><i class="ti ti-lock"></i> Change Password</a>
    <a href="AccountController?action=showDeletePage"         class="nav-item danger active"><i class="ti ti-trash"></i> Delete Account</a>
  </div>
  


	<div class="sidebar-footer">
	  <div class="user-row" onclick="toggleUserMenu()" style="cursor:pointer;">
	    <div class="avatar"><%= account.getFullName().substring(0,1).toUpperCase() %></div>
	    <div>
	      <div class="u-name"><%= account.getFullName().split(" ")[0] %></div>
	      <div class="u-role">User</div>
	    </div>
	    <i class="ti ti-chevron-up" id="chevron-icon" style="font-size:13px;color:#AEAEB2;margin-left:auto;"></i>
	  </div>
	
	  <div id="user-dropdown" style="display:none;background:#FFFFFF;border:1px solid rgba(0,0,0,0.08);border-radius:10px;margin:0 8px 8px;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.08);">
	    <a href="AccountController?action=showProfilePage"
	       style="display:flex;align-items:center;gap:9px;padding:10px 14px;font-size:13px;font-weight:500;color:#3A3A3C;text-decoration:none;">
	      <i class="ti ti-user" style="font-size:15px;color:#AEAEB2;"></i> Profile
	    </a>
	    <div style="height:1px;background:rgba(0,0,0,0.05);margin:0 10px;"></div>
	    <a href="#" onclick="confirmLogout()"
	       style="display:flex;align-items:center;gap:9px;padding:10px 14px;font-size:13px;font-weight:500;color:#FF3B30;text-decoration:none;">
	      <i class="ti ti-logout" style="font-size:15px;color:#FF3B30;"></i> Sign Out
	    </a>
	  </div>
	</div>

</div>

<!-- MAIN -->
<div class="main">
  <div class="topbar">
    <div>
      <div class="page-title">Delete Account</div>
      <div class="page-sub">This action is permanent and cannot be undone</div>
    </div>
    <a href="DashboardController" class="back-btn"><i class="ti ti-arrow-left"></i> Back</a>
  </div>

  <div class="content">

    <div class="form-card">
      <div class="warn-header">
        <div class="warn-icon"><i class="ti ti-alert-triangle"></i></div>
        <div>
          <div class="warn-title">Delete Account</div>
          <div class="warn-sub">Please read before proceeding</div>
        </div>
      </div>

      <div class="warn-list">
        <div class="warn-item"><i class="ti ti-x"></i> Your account will be permanently deleted</div>
        <div class="warn-item"><i class="ti ti-x"></i> All your transaction history will be lost</div>
        <div class="warn-item"><i class="ti ti-x"></i> Your remaining balance will be forfeited</div>
        <div class="warn-item"><i class="ti ti-x"></i> This action cannot be undone</div>
      </div>

      <% if (error != null) { %>
      <div class="msg error"><i class="ti ti-alert-circle"></i> <%= error %></div>
      <% } %>

      <!-- DELETE FORM -->
      <form action="AccountController" method="post">
        <input type="hidden" name="action" value="deleteAccount">
        <div class="field">
          <label>Confirm your password to delete</label>
          <div class="inp-wrap">
            <input type="password" name="password" id="del-pass" placeholder="••••••••" required>
            <button type="button" class="eye-btn" onclick="toggleEye('del-pass',this)"><i class="ti ti-eye"></i></button>
          </div>
        </div>
        <button type="submit" class="delete-btn"><i class="ti ti-trash"></i> Delete My Account</button>
      </form>

      <!-- INACTIVE FORM -->
      <form action="AccountController" method="post">
        <input type="hidden" name="action" value="inActive">
        <input type="hidden" name="password" id="inactive-pass-hidden">
        <button type="button" class="inactive-btn" onclick="confirmInactive(this.form)">
          <i class="ti ti-eye-off"></i> Just deactivate instead
        </button>
      </form>
    </div>

    <div class="info-card">
      <div class="info-title">Your Account</div>
      <div class="info-row"><span class="info-k">Name</span><span class="info-v"><%= account.getFullName() %></span></div>
      <div class="info-row"><span class="info-k">UserName</span><span class="info-v"><%= account.getUsername() %></span></div>
      <div class="info-row"><span class="info-k">Balance</span><span class="info-v" style="color:#FF3B30;">EGP <%= String.format("%,.2f", account.getBalance()) %></span></div>
      <div class="info-row"><span class="info-k">Email</span><span class="info-v"><%= account.getEmail() %></span></div>
    </div>

  </div>
</div>

<div id="logout-overlay" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.3);backdrop-filter:blur(4px);z-index:1000;align-items:center;justify-content:center;">
  <div style="background:#FFFFFF;border-radius:16px;padding:28px 24px;width:320px;box-shadow:0 20px 60px rgba(0,0,0,0.15);text-align:center;">
    <div style="width:44px;height:44px;border-radius:12px;background:#F2F2F7;display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:20px;color:#1C1C1E;">
      <i class="ti ti-logout"></i>
    </div>
    <div style="font-size:16px;font-weight:700;color:#1C1C1E;letter-spacing:-0.3px;margin-bottom:6px;">Sign out?</div>
    <div style="font-size:13px;color:#AEAEB2;margin-bottom:22px;">You'll need to sign in again to access your account.</div>
    <div style="display:flex;gap:8px;">
      <button onclick="closeLogout()" style="flex:1;padding:11px;background:#F2F2F7;border:none;border-radius:10px;font-size:13px;font-weight:600;color:#3A3A3C;cursor:pointer;font-family:'Inter',sans-serif;">Cancel</button>
      <button onclick="doLogout()" style="flex:1;padding:11px;background:#1C1C1E;border:none;border-radius:10px;font-size:13px;font-weight:600;color:white;cursor:pointer;font-family:'Inter',sans-serif;">Sign out</button>
    </div>
  </div>
</div>

<script>
  function toggleEye(id, btn) {
    const inp = document.getElementById(id);
    const show = inp.type === 'password';
    inp.type = show ? 'text' : 'password';
    btn.querySelector('i').className = show ? 'ti ti-eye-off' : 'ti ti-eye';
  }

  function confirmInactive(form) {
    const pass = document.getElementById('del-pass').value;
    if (!pass) { alert('Please enter your password first'); return; }
    document.getElementById('inactive-pass-hidden').value = pass;
    form.submit();
  }
  
  function toggleUserMenu() {
	    const menu = document.getElementById('user-dropdown');
	    const icon = document.getElementById('chevron-icon');
	    const isOpen = menu.style.display !== 'none';
	    menu.style.display = isOpen ? 'none' : 'block';
	    icon.className = isOpen ? 'ti ti-chevron-up' : 'ti ti-chevron-down';
	}

	document.addEventListener('click', function(e) {
	    const footer = document.querySelector('.sidebar-footer');
	    if (!footer.contains(e.target)) {
	        document.getElementById('user-dropdown').style.display = 'none';
	        document.getElementById('chevron-icon').className = 'ti ti-chevron-up';
	    }
	});

	function confirmLogout() {
	    document.getElementById('logout-overlay').style.display = 'flex';
	}

	function closeLogout() {
	    document.getElementById('logout-overlay').style.display = 'none';
	}

	function doLogout() {
	    window.location.href = "AuthController?action=logout";
	}
	
</script>

</body>
</html>