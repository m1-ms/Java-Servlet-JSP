<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>
<%
    Account account = (Account) session.getAttribute("account");
    if (account == null) { response.sendRedirect("login.jsp"); return; }
    String error   = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storm Cash — Profile</title>
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
    .nav-item.active { background: #FFFFFF; color: #1C1C1E; font-weight: 600; box-shadow: 0 1px 3px rgba(0,0,0,0.07); }
    .nav-item.active i { color: #1C1C1E; }
    .nav-item.danger { color: #FF3B30; }
    .nav-item.danger i { color: #FFB3B0; }
    .nav-item.danger:hover { background: #FFF2F1; }
    .sidebar-footer { margin-top: auto; padding: 10px; border-top: 1px solid rgba(0,0,0,0.05); }
    .user-row { display: flex; align-items: center; gap: 9px; padding: 8px; border-radius: 9px; }
    .avatar-lg { width: 28px; height: 28px; border-radius: 50%; background: #1C1C1E; display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 700; color: white; flex-shrink: 0; }
    .u-name { font-size: 12px; font-weight: 600; color: #1C1C1E; }
    .u-role { font-size: 11px; color: #AEAEB2; }

    .main { flex: 1; margin-left: 216px; min-height: 100vh; display: flex; flex-direction: column; }
    .topbar { display: flex; align-items: center; justify-content: space-between; padding: 16px 28px; background: rgba(242,242,247,0.85); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(0,0,0,0.06); position: sticky; top: 0; z-index: 10; }
    .page-title { font-size: 17px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.5px; }
    .page-sub { font-size: 12px; color: #AEAEB2; margin-top: 1px; }
    .back-btn { display: flex; align-items: center; gap: 5px; padding: 6px 13px; background: #FFFFFF; border: 1px solid rgba(0,0,0,0.09); border-radius: 8px; font-size: 12px; font-weight: 500; color: #3A3A3C; text-decoration: none; box-shadow: 0 1px 2px rgba(0,0,0,0.04); transition: background 0.12s; }
    .back-btn:hover { background: #F2F2F7; }
    .back-btn i { font-size: 14px; color: #AEAEB2; }

    .content { padding: 28px; display: flex; gap: 20px; align-items: flex-start; }

    /* PROFILE HEADER CARD */
    .profile-header {
      background: #1C1C1E; border-radius: 16px;
      padding: 28px; margin-bottom: 0;
      display: flex; align-items: center; gap: 20px;
      position: relative; overflow: hidden;
    }

    .profile-header::before {
      content: ''; position: absolute; top: -40px; right: -40px;
      width: 150px; height: 150px; border-radius: 50%;
      background: rgba(255,255,255,0.025); pointer-events: none;
    }

    .profile-avatar {
      width: 60px; height: 60px; border-radius: 50%;
      background: rgba(255,255,255,0.1);
      border: 2px solid rgba(255,255,255,0.15);
      display: flex; align-items: center; justify-content: center;
      font-size: 22px; font-weight: 700; color: white; flex-shrink: 0;
    }

    .profile-name { font-size: 20px; font-weight: 700; color: white; letter-spacing: -0.5px; }
    .profile-username { font-size: 13px; color: rgba(255,255,255,0.45); margin-top: 3px; }
    .profile-role {
      display: inline-flex; align-items: center; gap: 5px;
      margin-top: 8px; padding: 4px 10px;
      background: rgba(255,255,255,0.08);
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 20px; font-size: 11px; font-weight: 500;
      color: rgba(255,255,255,0.6);
    }

    /* LEFT COLUMN */
    .left-col { display: flex; flex-direction: column; gap: 16px; flex: 1; }

    /* INFO CARD */
    .info-card { background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06); border-radius: 14px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }
    .card-head { display: flex; align-items: center; justify-content: space-between; padding: 14px 18px 11px; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .card-title { font-size: 13px; font-weight: 650; color: #1C1C1E; letter-spacing: -0.3px; }

    .info-row { display: flex; justify-content: space-between; align-items: center; padding: 12px 18px; border-bottom: 1px solid rgba(0,0,0,0.04); font-size: 12px; }
    .info-row:last-child { border-bottom: none; }
    .info-k { color: #AEAEB2; display: flex; align-items: center; gap: 7px; }
    .info-k i { font-size: 14px; }
    .info-v { color: #1C1C1E; font-weight: 500; }

    /* UPDATE NAME CARD */
    .update-card { background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06); border-radius: 14px; padding: 20px 22px; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }
    .update-title { font-size: 13px; font-weight: 650; color: #1C1C1E; margin-bottom: 14px; }

    .msg { border-radius: 10px; padding: 10px 14px; font-size: 12px; margin-bottom: 14px; display: flex; align-items: center; gap: 8px; }
    .msg.error   { background: #FFF1F0; border: 1px solid rgba(255,59,48,0.2); color: #FF3B30; }
    .msg.success { background: #F0FAF4; border: 1px solid rgba(48,209,88,0.2); color: #1D9E55; }

    .field { margin-bottom: 14px; }
    label { display: block; font-size: 12px; font-weight: 500; color: #1C1C1E; margin-bottom: 6px; }

    input[type="text"] { width: 100%; background: #F2F2F7; border: 1.5px solid transparent; border-radius: 10px; padding: 11px 14px; font-size: 14px; color: #1C1C1E; font-family: 'Inter', sans-serif; outline: none; transition: all 0.15s; }
    input:focus { background: #FFFFFF; border-color: #1C1C1E; box-shadow: 0 0 0 3px rgba(28,28,30,0.06); }
    input::placeholder { color: #C7C7CC; }

    .save-btn { width: 100%; padding: 12px; background: #1C1C1E; border: none; border-radius: 10px; font-size: 13px; font-weight: 600; color: white; font-family: 'Inter', sans-serif; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 7px; transition: opacity 0.15s; }
    .save-btn:hover { opacity: 0.82; }

    /* QUICK LINKS */
    .quick-card { background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06); border-radius: 14px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }

    .quick-item { display: flex; align-items: center; gap: 12px; padding: 13px 18px; border-bottom: 1px solid rgba(0,0,0,0.04); text-decoration: none; transition: background 0.12s; }
    .quick-item:last-child { border-bottom: none; }
    .quick-item:hover { background: #FAFAFA; }

    .quick-ic { width: 32px; height: 32px; border-radius: 9px; background: #F2F2F7; display: flex; align-items: center; justify-content: center; font-size: 15px; color: #6C6C70; flex-shrink: 0; }
    .quick-ic.red { background: #FFF1F0; color: #FF3B30; }

    .quick-label { font-size: 13px; font-weight: 500; color: #1C1C1E; }
    .quick-sub { font-size: 11px; color: #AEAEB2; margin-top: 1px; }
    .quick-arrow { margin-left: auto; font-size: 14px; color: #C7C7CC; }
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
    <a href="DashboardController"                          class="nav-item"><i class="ti ti-home"></i> Dash Board</a>
    <a href="WalletController?action=showDepositPage"      class="nav-item"><i class="ti ti-arrow-down-circle"></i> Deposit</a>
    <a href="WalletController?action=showWithdrawPage"     class="nav-item"><i class="ti ti-arrow-up-circle"></i> Withdraw</a>
    <a href="WalletController?action=showTransferPage"     class="nav-item"><i class="ti ti-transfer"></i> Transfer</a>
    <a href="WalletController?action=showTransactionsPage" class="nav-item"><i class="ti ti-history"></i> Transactions</a>
  </div>
  <div class="nav-section">
    <span class="nav-lbl">Account</span>
    <a href="AccountController?action=showProfilePage"        class="nav-item active"><i class="ti ti-user"></i> Profile</a>
    <a href="AccountController?action=showChangePasswordPage" class="nav-item"><i class="ti ti-lock"></i> Change Password</a>
    <a href="AccountController?action=showDeletePage"         class="nav-item danger"><i class="ti ti-trash"></i> Delete Account</a>
  </div>
  
  
  <div class="sidebar-footer">
    <div class="user-row" onclick="toggleUserMenu()" style="cursor:pointer;">
      <div class="avatar-lg"><%= account.getFullName().substring(0,1).toUpperCase() %></div>
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
      <div class="page-title">Profile</div>
      <div class="page-sub">Your account information</div>
    </div>
    <a href="DashboardController" class="back-btn"><i class="ti ti-arrow-left"></i> Back</a>
  </div>

  <div class="content">
    <div class="left-col">

      <!-- PROFILE HEADER -->
      <div class="profile-header">
        <div class="profile-avatar"><%= account.getFullName().substring(0,1).toUpperCase() %></div>
        <div>
          <div class="profile-name"><%= account.getFullName() %></div>
          <div class="profile-username">@<%= account.getUsername() %></div>
          <div class="profile-role"><i class="ti ti-shield" style="font-size:11px;"></i> <%= account.getRole() %></div>
        </div>
      </div>

      <!-- ACCOUNT INFO -->
      <div class="info-card">
        <div class="card-head"><span class="card-title">Account Details</span></div>
        <div class="info-row">
          <span class="info-k"><i class="ti ti-user"></i> Full Name</span>
          <span class="info-v"><%= account.getFullName() %></span>
        </div>
        <div class="info-row">
          <span class="info-k"><i class="ti ti-at"></i> UserName</span>
          <span class="info-v"><%= account.getUsername() %></span>
        </div>
        <div class="info-row">
          <span class="info-k"><i class="ti ti-phone"></i> Phone</span>
          <span class="info-v"><%= account.getPhone() %></span>
        </div>
        <div class="info-row">
          <span class="info-k"><i class="ti ti-mail"></i> E-Mail</span>
          <span class="info-v"><%= account.getEmail() %></span>
        </div>
        <div class="info-row">
          <span class="info-k"><i class="ti ti-calendar"></i> Age</span>
          <span class="info-v"><%= account.getAge() %></span>
        </div>
        <div class="info-row">
          <span class="info-k"><i class="ti ti-wallet"></i> Balance</span>
          <span class="info-v">EGP <%= String.format("%,.2f", account.getBalance()) %></span>
        </div>
      </div>

      <!-- UPDATE NAME -->
      <div class="update-card">
        <div class="update-title">Update Display Name</div>

        <% if (error != null) { %>
        <div class="msg error"><i class="ti ti-alert-circle"></i> <%= error %></div>
        <% } %>
        <% if (success != null) { %>
        <div class="msg success"><i class="ti ti-circle-check"></i> <%= success %></div>
        <% } %>

        <form action="AccountController" method="post">
          <input type="hidden" name="action" value="updateName">
          <div class="field">
            <label>New Name</label>
            <input type="text" name="newName" placeholder="<%= account.getFullName() %>" required>
          </div>
          <button type="submit" class="save-btn"><i class="ti ti-check"></i> Save Changes</button>
        </form>
      </div>

      <!-- QUICK LINKS -->
      <div class="quick-card">
        <a href="AccountController?action=showChangePasswordPage" class="quick-item">
          <div class="quick-ic"><i class="ti ti-lock"></i></div>
          <div>
            <div class="quick-label">Change Password</div>
            <div class="quick-sub">Update your account password</div>
          </div>
          <i class="ti ti-chevron-right quick-arrow"></i>
        </a>
        <a href="AccountController?action=showDeletePage" class="quick-item">
          <div class="quick-ic red"><i class="ti ti-trash"></i></div>
          <div>
            <div class="quick-label" style="color:#FF3B30;">Delete Account</div>
            <div class="quick-sub">Permanently delete your account</div>
          </div>
          <i class="ti ti-chevron-right quick-arrow"></i>
        </a>
      </div>

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