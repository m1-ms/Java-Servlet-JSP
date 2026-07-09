<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account" %>
<%
    Account account = (Account) session.getAttribute("account");
    if (account == null) { response.sendRedirect("login.jsp"); return; }

    String op = request.getAttribute("operation") != null
        ? (String) request.getAttribute("operation") : "deposit";

    String pageTitle = op.equals("withdraw") ? "Withdraw" : op.equals("transfer") ? "Transfer" : "Deposit";
    String pageIcon  = op.equals("withdraw") ? "ti-arrow-up-circle" : op.equals("transfer") ? "ti-transfer" : "ti-arrow-down-circle";
    String pageDesc  = op.equals("withdraw") ? "Take money from your wallet"
                     : op.equals("transfer") ? "Send money to another user"
                     : "Add money to your wallet";

    String error   = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");

    double balance = account.getBalance();
    long balInt = (long) balance;
    int  balDec = (int) Math.round((balance - balInt) * 100);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storm Cash — <%= pageTitle %></title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body { font-family: 'Inter', sans-serif; background: #F2F2F7; min-height: 100vh; display: flex; }

    /* SIDEBAR — same as dashboard */
    .sidebar {
      width: 216px; background: #FAFAFA;
      border-right: 1px solid rgba(0,0,0,0.07);
      display: flex; flex-direction: column; flex-shrink: 0;
      min-height: 100vh; position: fixed; top: 0; left: 0; bottom: 0;
    }

    .brand { display: flex; align-items: center; gap: 10px; padding: 20px 18px 16px; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .logo-mark { width: 30px; height: 30px; border-radius: 8px; background: #1C1C1E; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .logo-mark svg { display: block; }
    .brand-name { font-size: 14px; font-weight: 650; color: #1C1C1E; letter-spacing: -0.4px; }
    .nav-section { padding: 14px 10px 4px; }
    .nav-lbl { font-size: 10px; font-weight: 600; color: #C7C7CC; letter-spacing: 1px; text-transform: uppercase; padding: 0 8px; margin-bottom: 3px; display: block; }

    .nav-item {
      display: flex; align-items: center; gap: 8px; width: 100%; padding: 7px 10px;
      font-size: 13px; font-weight: 500; color: #3A3A3C; border-radius: 9px; cursor: pointer;
      border: none; background: none; font-family: 'Inter', sans-serif;
      text-align: left; text-decoration: none; transition: background 0.12s; margin-bottom: 1px;
    }

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
    .avatar { width: 28px; height: 28px; border-radius: 50%; background: #1C1C1E; display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 700; color: white; flex-shrink: 0; }
    .u-name { font-size: 12px; font-weight: 600; color: #1C1C1E; }
    .u-role { font-size: 11px; color: #AEAEB2; }

    /* MAIN */
    .main { flex: 1; margin-left: 216px; min-height: 100vh; display: flex; flex-direction: column; }

    .topbar {
      display: flex; align-items: center; justify-content: space-between;
      padding: 16px 28px; background: rgba(242,242,247,0.85);
      backdrop-filter: blur(12px); border-bottom: 1px solid rgba(0,0,0,0.06);
      position: sticky; top: 0; z-index: 10;
    }

    .page-title { font-size: 17px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.5px; }
    .page-sub { font-size: 12px; color: #AEAEB2; margin-top: 1px; }

    .back-btn {
      display: flex; align-items: center; gap: 5px; padding: 6px 13px;
      background: #FFFFFF; border: 1px solid rgba(0,0,0,0.09); border-radius: 8px;
      font-size: 12px; font-weight: 500; color: #3A3A3C; text-decoration: none;
      box-shadow: 0 1px 2px rgba(0,0,0,0.04); transition: background 0.12s;
    }

    .back-btn:hover { background: #F2F2F7; }
    .back-btn i { font-size: 14px; color: #AEAEB2; }

    .content { padding: 32px 28px; display: flex; gap: 20px; align-items: flex-start; }

    /* FORM CARD */
    .form-card {
      flex: 0 0 360px;
      background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06);
      border-radius: 14px; padding: 26px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.04);
    }

    .form-head { display: flex; align-items: center; gap: 13px; margin-bottom: 22px; }

    .form-icon {
      width: 42px; height: 42px; border-radius: 11px; background: #F2F2F7;
      display: flex; align-items: center; justify-content: center;
      font-size: 21px; color: #1C1C1E; flex-shrink: 0;
    }

    .form-title { font-size: 17px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.4px; }
    .form-sub { font-size: 12px; color: #AEAEB2; margin-top: 2px; }

    .bal-bar {
      background: #F2F2F7; border-radius: 10px;
      padding: 12px 14px; margin-bottom: 22px;
      display: flex; align-items: center; justify-content: space-between;
    }

    .bal-lbl { font-size: 11px; font-weight: 500; color: #AEAEB2; }
    .bal-val { font-size: 16px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.5px; }
    .bal-cur { font-size: 11px; font-weight: 500; color: #AEAEB2; margin-right: 3px; }

    .msg { border-radius: 10px; padding: 10px 14px; font-size: 12px; margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
    .msg.error   { background: #FFF1F0; border: 1px solid rgba(255,59,48,0.2); color: #FF3B30; }
    .msg.success { background: #F0FAF4; border: 1px solid rgba(48,209,88,0.2); color: #1D9E55; }

    .field { margin-bottom: 16px; }

    label { display: block; font-size: 12px; font-weight: 500; color: #1C1C1E; margin-bottom: 6px; }

    .inp-wrap { position: relative; }

    input[type="text"], input[type="number"] {
      width: 100%; background: #F2F2F7;
      border: 1.5px solid transparent; border-radius: 10px;
      padding: 11px 14px; font-size: 14px; color: #1C1C1E;
      font-family: 'Inter', sans-serif; outline: none; transition: all 0.15s;
    }

    input:focus { background: #FFFFFF; border-color: #1C1C1E; box-shadow: 0 0 0 3px rgba(28,28,30,0.06); }
    input::placeholder { color: #C7C7CC; }

    input.amount { padding-left: 48px; font-size: 22px; font-weight: 700; letter-spacing: -0.8px; }

    .cur-badge {
      position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
      font-size: 11px; font-weight: 600; color: #AEAEB2; pointer-events: none;
    }

    .quick { display: flex; gap: 6px; margin-top: 8px; flex-wrap: wrap; }

    .q-btn {
      padding: 4px 11px; background: #F2F2F7;
      border: 1px solid rgba(0,0,0,0.07); border-radius: 7px;
      font-size: 11px; font-weight: 500; color: #6C6C70;
      cursor: pointer; font-family: 'Inter', sans-serif; transition: all 0.12s;
    }

    .q-btn:hover { background: #1C1C1E; color: white; border-color: #1C1C1E; }

    .submit-btn {
      width: 100%; padding: 13px; background: #1C1C1E;
      border: none; border-radius: 10px; font-size: 14px; font-weight: 600;
      color: white; font-family: 'Inter', sans-serif; cursor: pointer; margin-top: 4px;
      display: flex; align-items: center; justify-content: center; gap: 7px;
      transition: opacity 0.15s; letter-spacing: -0.2px;
    }

    .submit-btn:hover { opacity: 0.82; }

    /* SUMMARY CARD */
    .summary-card {
      flex: 1; background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06);
      border-radius: 14px; padding: 22px 24px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.04);
    }

    .sum-title { font-size: 13px; font-weight: 650; color: #1C1C1E; letter-spacing: -0.2px; margin-bottom: 14px; }

    .sum-row {
      display: flex; justify-content: space-between; align-items: center;
      font-size: 12px; padding: 10px 0; border-bottom: 1px solid rgba(0,0,0,0.05);
    }

    .sum-row:last-of-type { border-bottom: none; }
    .sum-k { color: #AEAEB2; }
    .sum-v { color: #1C1C1E; font-weight: 500; }
    .sum-v.green { color: #30D158; }
    .sum-v.big { font-size: 16px; font-weight: 700; letter-spacing: -0.5px; }

    .note {
      background: #F2F2F7; border-radius: 10px;
      padding: 12px 14px; font-size: 12px; color: #6C6C70; line-height: 1.6;
      display: flex; gap: 9px; align-items: flex-start; margin-top: 14px;
    }

    .note i { font-size: 15px; color: #C7C7CC; flex-shrink: 0; margin-top: 1px; }

    /* TRANSFER RECEIVER PREVIEW */
    .recv-preview {
      background: #F2F2F7; border-radius: 10px;
      padding: 10px 14px; margin-top: 8px;
      display: flex; align-items: center; gap: 10px; display: none;
    }

    .recv-ava {
      width: 28px; height: 28px; border-radius: 50%; background: #1C1C1E;
      display: flex; align-items: center; justify-content: center;
      font-size: 10px; font-weight: 700; color: white; flex-shrink: 0;
    }

    .recv-name { font-size: 12px; font-weight: 600; color: #1C1C1E; }
    .recv-user { font-size: 11px; color: #AEAEB2; }
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
    <span class="nav-lbl">Menu</span>
    <a href="DashboardController" class="nav-item"><i class="ti ti-home"></i> Dash Board</a>
    <a href="WalletController?action=showDepositPage"      class="nav-item <%= op.equals("deposit")  ? "active" : "" %>"><i class="ti ti-arrow-down-circle"></i> Deposit</a>
    <a href="WalletController?action=showWithdrawPage"     class="nav-item <%= op.equals("withdraw") ? "active" : "" %>"><i class="ti ti-arrow-up-circle"></i> Withdraw</a>
    <a href="WalletController?action=showTransferPage"     class="nav-item <%= op.equals("transfer") ? "active" : "" %>"><i class="ti ti-transfer"></i> Transfer</a>
    <a href="WalletController?action=showTransactionsPage" class="nav-item"><i class="ti ti-history"></i> Transactions</a>
  </div>


  <div class="nav-section">
    <span class="nav-lbl">Account</span>
    <a href="AccountController?action=showProfilePage"        class="nav-item"><i class="ti ti-user"></i> Profile</a>
    <a href="AccountController?action=showChangePasswordPage" class="nav-item"><i class="ti ti-lock"></i> Change Password</a>
    <a href="AccountController?action=showDeletePage"         class="nav-item danger"><i class="ti ti-trash"></i> Delete Account</a>
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
      <div class="page-title"><%= pageTitle %></div>
      <div class="page-sub"><%= pageDesc %></div>
    </div>
    <a href="DashboardController" class="back-btn"><i class="ti ti-arrow-left"></i> Back</a>
  </div>

  <div class="content">

    <!-- FORM -->
    <div class="form-card">
      <div class="form-head">
        <div class="form-icon"><i class="ti <%= pageIcon %>"></i></div>
        <div>
          <div class="form-title"><%= pageTitle %></div>
          <div class="form-sub"><%= pageDesc %></div>
        </div>
      </div>

      <div class="bal-bar">
        <span class="bal-lbl"><%= op.equals("deposit") ? "Current" : "Available" %> Balance</span>
        <span class="bal-val">
          <span class="bal-cur">EGP</span>
          <%= String.format("%,d", balInt) %>.<%= String.format("%02d", balDec) %>
        </span>
      </div>

      <% if (error != null) { %>
      <div class="msg error"><i class="ti ti-alert-circle"></i> <%= error %></div>
      <% } %>
      <% if (success != null) { %>
      <div class="msg success"><i class="ti ti-circle-check"></i> <%= success %></div>
      <% } %>

      <form action="WalletController" method="post">
        <input type="hidden" name="action" value="<%= op %>">

        <% if (op.equals("transfer")) { %>
        <div class="field">
          <label>Recipient Username</label>
          <input type="text" name="targetUsername" id="recv-input" placeholder="e.g. ahmed_99" required>
          <div class="recv-preview" id="recv-box">
            <div class="recv-ava" id="recv-ic">?</div>
            <div>
              <div class="recv-name" id="recv-nm">—</div>
              <div class="recv-user" id="recv-un">—</div>
            </div>
          </div>
        </div>
        <% } %>

        <div class="field">
          <label>Amount</label>
          <div class="inp-wrap">
            <span class="cur-badge">EGP</span>
            <input type="number" name="amount" id="amount-inp" class="amount" placeholder="0" min="1" step="0.01" required>
          </div>
          <div class="quick">
            <button type="button" class="q-btn" onclick="setAmount(100)">100</button>
            <button type="button" class="q-btn" onclick="setAmount(500)">500</button>
            <button type="button" class="q-btn" onclick="setAmount(1000)">1,000</button>
            <button type="button" class="q-btn" onclick="setAmount(5000)">5,000</button>
          </div>
        </div>

        <button type="submit" class="submit-btn">
          <i class="ti <%= pageIcon %>"></i> Confirm <%= pageTitle %>
        </button>
      </form>
    </div>

    <!-- SUMMARY -->
    <div class="summary-card">
      <div class="sum-title">Summary</div>
      <div class="sum-row"><span class="sum-k">Type</span><span class="sum-v"><%= pageTitle %></span></div>
      <div class="sum-row">
        <span class="sum-k"><%= op.equals("deposit") ? "To" : "From" %></span>
        <span class="sum-v"><%= account.getUsername() %></span>
      </div>
      <% if (op.equals("transfer")) { %>
      <div class="sum-row"><span class="sum-k">To</span><span class="sum-v" id="sum-to" style="color:#AEAEB2;">—</span></div>
      <% } %>
      <div class="sum-row"><span class="sum-k">Fee</span><span class="sum-v green">Free</span></div>
      <div class="sum-row"><span class="sum-k">Balance after</span><span class="sum-v big" id="sum-after">—</span></div>

      <div class="note">
        <i class="ti ti-info-circle"></i>
        <% if (op.equals("deposit")) { %>
          Deposits are instant and free. Minimum amount is 1 EGP.
        <% } else if (op.equals("withdraw")) { %>
          You cannot withdraw more than your available balance.
        <% } else { %>
          Double-check the username before confirming. Transfers cannot be reversed.
        <% } %>
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
  const BAL = <%= balance %>;

  function setAmount(val) {
    document.getElementById('amount-inp').value = val;
    updateSummary();
  }

  function updateSummary() {
    const v = parseFloat(document.getElementById('amount-inp').value) || 0;
    const after = '<%= op %>'.indexOf('deposit') !== -1 ? BAL + v : BAL - v;
    const el = document.getElementById('sum-after');
    if (v > 0) {
      el.textContent = 'EGP ' + after.toLocaleString('en', {minimumFractionDigits:2, maximumFractionDigits:2});
      el.style.color = (after < 0 && '<%= op %>' !== 'deposit') ? '#FF3B30' : '#1C1C1E';
    } else {
      el.textContent = '—';
      el.style.color = '#1C1C1E';
    }
  }

  document.getElementById('amount-inp').addEventListener('input', updateSummary);

  <% if (op.equals("transfer")) { %>
  document.getElementById('recv-input').addEventListener('input', function() {
    const v = this.value.trim();
    const box = document.getElementById('recv-box');
    const sumTo = document.getElementById('sum-to');
    if (v.length >= 2) {
      box.style.display = 'flex';
      document.getElementById('recv-ic').textContent = v.substring(0,2).toUpperCase();
      document.getElementById('recv-nm').textContent = v;
      document.getElementById('recv-un').textContent = '@' + v;
      sumTo.textContent = v; sumTo.style.color = '#1C1C1E';
    } else {
      box.style.display = 'none';
      sumTo.textContent = '—'; sumTo.style.color = '#AEAEB2';
    }
  });
  <% } %>
	  
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
