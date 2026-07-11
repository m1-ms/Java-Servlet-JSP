<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Account, java.util.List" %>
<%
    Account admin = (Account) session.getAttribute("account");
    if (admin == null || !admin.isAdmin()) { response.sendRedirect("login.jsp"); return; }
    List<Account> allAccounts = (List<Account>) request.getAttribute("allAccounts");
    long totalAccounts = allAccounts != null ? allAccounts.size() : 0;
    long activeCount   = allAccounts != null ? allAccounts.stream().filter(a -> a.isActive()).count() : 0;
    long inactiveCount = totalAccounts - activeCount;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storm Cash — All Accounts</title>
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
    .sidebar-footer { margin-top: auto; padding: 10px; border-top: 1px solid rgba(0,0,0,0.05); }
    .user-row { display: flex; align-items: center; gap: 9px; padding: 8px; border-radius: 9px; cursor: pointer; }
    .avatar { width: 28px; height: 28px; border-radius: 50%; background: #1C1C1E; display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 700; color: white; flex-shrink: 0; }
    .u-name { font-size: 12px; font-weight: 600; color: #1C1C1E; }
    .u-role { font-size: 11px; color: #AEAEB2; }

    .main { flex: 1; margin-left: 216px; min-height: 100vh; display: flex; flex-direction: column; }
    .topbar { display: flex; align-items: center; justify-content: space-between; padding: 16px 28px; background: rgba(242,242,247,0.85); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(0,0,0,0.06); position: sticky; top: 0; z-index: 10; }
    .page-title { font-size: 17px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.5px; }
    .page-sub { font-size: 12px; color: #AEAEB2; margin-top: 1px; }
    .topbar-right { display: flex; align-items: center; gap: 10px; }
    .admin-tag { display: inline-flex; align-items: center; gap: 5px; padding: 5px 11px; background: #1C1C1E; border-radius: 7px; font-size: 11px; font-weight: 600; color: white; }
    .back-btn { display: flex; align-items: center; gap: 5px; padding: 6px 13px; background: #FFFFFF; border: 1px solid rgba(0,0,0,0.09); border-radius: 8px; font-size: 12px; font-weight: 500; color: #3A3A3C; text-decoration: none; box-shadow: 0 1px 2px rgba(0,0,0,0.04); transition: background 0.12s; }
    .back-btn:hover { background: #F2F2F7; }

    .content { padding: 24px 28px; display: flex; flex-direction: column; gap: 16px; }

    .stats { display: grid; grid-template-columns: repeat(3,1fr); gap: 10px; }
    .stat-card { background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06); border-radius: 13px; padding: 16px; box-shadow: 0 1px 2px rgba(0,0,0,0.03); }
    .stat-top { display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px; }
    .stat-icon { width: 30px; height: 30px; border-radius: 8px; background: #F2F2F7; display: flex; align-items: center; justify-content: center; font-size: 15px; color: #6C6C70; }
    .stat-num { font-size: 22px; font-weight: 700; color: #1C1C1E; letter-spacing: -0.8px; }
    .stat-lbl { font-size: 11px; color: #AEAEB2; margin-top: 2px; }

    .table-card { background: #FFFFFF; border: 1px solid rgba(0,0,0,0.06); border-radius: 14px; overflow: hidden; box-shadow: 0 1px 3px rgba(0,0,0,0.04); display: flex; flex-direction: column; max-height: calc(100vh - 280px); }
    .table-head { display: flex; align-items: center; justify-content: space-between; padding: 14px 18px 11px; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .table-title { font-size: 13px; font-weight: 650; color: #1C1C1E; }
    .count-tag { background: #F2F2F7; border-radius: 6px; padding: 2px 9px; font-size: 11px; font-weight: 500; color: #6C6C70; }

    .search-wrap { position: relative; padding: 12px 18px; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .search-inp { width: 100%; background: #F2F2F7; border: 1.5px solid transparent; border-radius: 9px; padding: 9px 14px 9px 36px; font-size: 13px; color: #1C1C1E; font-family: 'Inter', sans-serif; outline: none; transition: all 0.15s; }
    .search-inp:focus { background: #FFFFFF; border-color: #1C1C1E; }
    .search-inp::placeholder { color: #C7C7CC; }
    .search-icon { position: absolute; left: 30px; top: 50%; transform: translateY(-50%); font-size: 15px; color: #C7C7CC; pointer-events: none; }

    .table-scroll { overflow-y: auto; flex: 1; }

    table.tbl { width: 100%; border-collapse: collapse; font-size: 12px; }
    table.tbl thead th { padding: 9px 16px; text-align: left; font-size: 10px; letter-spacing: 1px; text-transform: uppercase; color: #C7C7CC; font-weight: 600; border-bottom: 1px solid rgba(0,0,0,0.05); background: #FAFAFA; position: sticky; top: 0; z-index: 1; white-space: nowrap; }
    table.tbl tbody td { padding: 12px 16px; color: #1C1C1E; border-bottom: 1px solid rgba(0,0,0,0.04); vertical-align: middle; white-space: nowrap; }
    table.tbl tbody tr:last-child td { border-bottom: none; }
    table.tbl tbody tr:hover td { background: #FAFAFA; }
    .td-muted { color: #AEAEB2 !important; font-size: 11px; }

    .ava-sm { width: 26px; height: 26px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; font-size: 9px; font-weight: 700; margin-right: 7px; vertical-align: middle; background: #F2F2F7; color: #6C6C70; }

    .badge { display: inline-flex; align-items: center; padding: 2px 8px; border-radius: 6px; font-size: 10px; font-weight: 600; }
    .b-admin   { background: #1C1C1E; color: white; }
    .b-user    { background: #F2F2F7; color: #6C6C70; }
    .b-active  { background: #F0FAF4; color: #28B348; }
    .b-inactive{ background: #FFF1F0; color: #FF3B30; }

    .deactivate-btn { padding: 4px 10px; background: #FFF1F0; border: 1px solid rgba(255,59,48,0.2); border-radius: 6px; font-size: 11px; font-weight: 600; color: #FF3B30; cursor: pointer; font-family: 'Inter', sans-serif; white-space: nowrap; display: inline-flex; align-items: center; gap: 4px; }
    .deactivate-btn:hover { background: #FFE5E5; }
  </style>
</head>
<body>

<div class="sidebar">
  <div class="brand">
    <div class="logo-mark">
      <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
        <path d="M7 1.5L12 4.5V9.5L7 12.5L2 9.5V4.5L7 1.5Z" fill="white"/>
      </svg>
    </div>
    <span class="brand-name">Storm Cash</span>
  </div>
  <div class="nav-section">
    <span class="nav-lbl">Admin</span>
    <a href="AdminController?action=showDashboard"    class="nav-item"><i class="ti ti-layout-dashboard"></i> Dash Board</a>
    <a href="AdminController?action=showAllAccounts"  class="nav-item active"><i class="ti ti-users"></i> All Accounts</a>
  </div>
  <div class="nav-section">
    <span class="nav-lbl">My Wallet</span>
    <a href="WalletController?action=showDepositPage"      class="nav-item"><i class="ti ti-arrow-down-circle"></i> Deposit</a>
    <a href="WalletController?action=showWithdrawPage"     class="nav-item"><i class="ti ti-arrow-up-circle"></i> Withdraw</a>
    <a href="WalletController?action=showTransferPage"     class="nav-item"><i class="ti ti-transfer"></i> Transfer</a>
    <a href="WalletController?action=showTransactionsPage" class="nav-item"><i class="ti ti-history"></i> Transactions</a>
  </div>
  <div class="nav-section">
    <span class="nav-lbl">Account</span>
    <a href="AccountController?action=showChangePasswordPage" class="nav-item"><i class="ti ti-lock"></i> Change Password</a>
  </div>
  <div class="sidebar-footer">
    <div class="user-row" onclick="toggleUserMenu()" style="cursor:pointer;">
      <div class="avatar"><%= admin.getFullName().substring(0,1).toUpperCase() %></div>
      <div>
        <div class="u-name"><%= admin.getFullName().split(" ")[0] %></div>
        <div class="u-role">Admin</div>
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
        <i class="ti ti-logout" style="font-size:15px;color:#FF3B30;"></i> Sign out
      </a>
    </div>
  </div>
</div>

<div class="main">
  <div class="topbar">
    <div>
      <div class="page-title">All Accounts</div>
      <div class="page-sub">Manage All Registered Accounts</div>
    </div>
    <div class="topbar-right">
      <div class="admin-tag"><i class="ti ti-shield-check" style="font-size:12px;"></i> Admin</div>
      <a href="AdminController?action=showDashboard" class="back-btn"><i class="ti ti-arrow-left"></i> Back</a>
    </div>
  </div>

  <div class="content">

    <div class="stats">
      <div class="stat-card">
        <div class="stat-top"><div class="stat-lbl">Total Accounts</div><div class="stat-icon"><i class="ti ti-users"></i></div></div>
        <div class="stat-num"><%= totalAccounts %></div>
      </div>
      <div class="stat-card">
        <div class="stat-top"><div class="stat-lbl">Active</div><div class="stat-icon"><i class="ti ti-circle-check"></i></div></div>
        <div class="stat-num"><%= activeCount %></div>
      </div>
      <div class="stat-card">
        <div class="stat-top"><div class="stat-lbl">Inactive</div><div class="stat-icon"><i class="ti ti-circle-x"></i></div></div>
        <div class="stat-num"><%= inactiveCount %></div>
      </div>
    </div>

    <div class="table-card">
      <div class="table-head">
        <span class="table-title">Accounts</span>
        <span class="count-tag"><%= totalAccounts %> accounts</span>
      </div>
      <div class="search-wrap">
        <i class="ti ti-search search-icon"></i>
        <input type="text" class="search-inp" id="search-inp" placeholder="Search by name or username..." oninput="filterTable()">
      </div>
      <div class="table-scroll">
        <table class="tbl" id="accounts-table">
          <thead>
            <tr>
              <th>Name</th>
              <th>UserName</th>
              <th>Phone</th>
              <th>E-Mail</th>
              <th style="text-align:right;">Balance</th>
              <th style="text-align:center;">Role</th>
              <th style="text-align:center;">Status</th>
              <th style="text-align:center;">Action</th>
            </tr>
          </thead>
          <tbody id="table-body">
            <% if (allAccounts != null) { for (Account acc : allAccounts) { %>
            <tr>
              <td><span class="ava-sm"><%= acc.getFullName().substring(0,1).toUpperCase() %></span><%= acc.getFullName() %></td>
              <td class="td-muted"><%= acc.getUsername() %></td>
              <td class="td-muted"><%= acc.getPhone() %></td>
              <td class="td-muted"><%= acc.getEmail() %></td>
              <td style="text-align:right;font-weight:600;"><%= String.format("%,.2f", acc.getBalance()) %></td>
              <td style="text-align:center;"><span class="badge <%= acc.getRole().equals("ADMIN") ? "b-admin" : "b-user" %>"><%= acc.getRole() %></span></td>
              <td style="text-align:center;"><span class="badge <%= acc.isActive() ? "b-active" : "b-inactive" %>"><%= acc.isActive() ? "Active" : "Inactive" %></span></td>
              <td style="text-align:center;white-space:nowrap;">
                <% if (acc.isActive()) { %>
                <form action="AdminController" method="post" style="display:inline;margin:0;padding:0;">
                  <input type="hidden" name="action" value="deactivateAccount">
                  <input type="hidden" name="userName" value="<%= acc.getUsername() %>">
                  <button type="submit" class="deactivate-btn">
                    <i class="ti ti-user-off" style="font-size:12px;"></i> Deactivate
                  </button>
                </form>
                <% } else { %>
                <span style="font-size:11px;color:#AEAEB2;font-style:italic;">Inactive</span>
                <% } %>
              </td>
            </tr>
            <% } } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- LOGOUT DIALOG -->
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

  function filterTable() {
    const val = document.getElementById('search-inp').value.toLowerCase();
    document.querySelectorAll('#table-body tr').forEach(row => {
      const name = row.cells[0].textContent.toLowerCase();
      const user = row.cells[1].textContent.toLowerCase();
      row.style.display = (name.includes(val) || user.includes(val)) ? '' : 'none';
    });
  }
</script>

</body>
</html>