<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ItemApp</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&family=Dancing+Script:wght@700&family=Caveat:wght@700&display=swap" rel="stylesheet">

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

    .wrapper { width: 100%; max-width: 680px; }

    .hero { text-align: center; margin-bottom: 48px; }

    .welcome-label {
      font-size: 11px;
      letter-spacing: 4px;
      text-transform: uppercase;
      color: #888780;
      margin-bottom: 10px;
      font-weight: 500;
    }

    .welcome-hand {
      font-family: 'Caveat', cursive;
      font-size: 96px;
      font-weight: 700;
      line-height: 1;
      color: #1a1a1a;
      display: block;
      margin-bottom: -8px;
    }

    .welcome-app {
      font-family: 'Playfair Display', serif;
      font-size: 36px;
      font-weight: 700;
      background: linear-gradient(135deg, #7c6fcd 0%, #a78bfa 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      display: block;
      margin-bottom: 14px;
    }

    .welcome-sub {
      font-size: 15px;
      color: #5F5E5A;
      font-weight: 400;
      letter-spacing: 0.2px;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
      gap: 16px;
    }

    .feature-card {
      background: #ffffff;
      border: 0.5px solid rgba(0,0,0,0.12);
      border-radius: 12px;
      padding: 24px 20px;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      gap: 12px;
      cursor: pointer;
      transition: border-color 0.2s, transform 0.15s, box-shadow 0.2s;
      text-decoration: none;
    }

    .feature-card:hover {
      border-color: rgba(0,0,0,0.3);
      transform: translateY(-2px);
      box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    }

    .feature-card:active { transform: scale(0.98); }

    .icon-wrap {
      width: 40px; height: 40px;
      border-radius: 8px;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px;
    }

    .icon-purple { background: #EEEDFE; color: #534AB7; }
    .icon-teal   { background: #E1F5EE; color: #0F6E56; }
    .icon-coral  { background: #FAECE7; color: #993C1D; }
    .icon-amber  { background: #FAEEDA; color: #854F0B; }

    .divider {
      width: 40px; height: 2px;
      border-radius: 2px;
      background: #a78bfa;
      margin-bottom: 4px;
    }

    .card-label { font-size: 13px; font-weight: 500; color: #1a1a1a; line-height: 1.3; margin-bottom: 4px; }
    .card-desc  { font-size: 12px; color: #5F5E5A; line-height: 1.5; }

    .signature { text-align: center; margin-top: 56px; }

    .signature-text {
      font-family: 'Dancing Script', cursive;
      font-size: 28px; font-weight: 700;
      background: linear-gradient(135deg, #7c6fcd 0%, #a78bfa 100%);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
      letter-spacing: 1px;
    }

    .signature-line {
      width: 120px; height: 1.5px;
      background: linear-gradient(90deg, transparent, #a78bfa, transparent);
      margin: 8px auto 0; border-radius: 2px;
    }

    .overlay {
      display: none;
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.3);
      z-index: 200;
      align-items: center;
      justify-content: center;
    }

    .overlay.visible { display: flex; }

    .dialog {
      background: #fff;
      border-radius: 16px;
      padding: 32px;
      max-width: 360px;
      width: 90%;
      text-align: center;
      box-shadow: 0 20px 60px rgba(0,0,0,0.15);
    }

    .dialog-icon {
      width: 48px; height: 48px;
      border-radius: 12px;
      display: flex; align-items: center; justify-content: center;
      font-size: 22px;
      margin: 0 auto 16px;
    }

    .dialog-title {
      font-family: 'Playfair Display', serif;
      font-size: 18px; font-weight: 700; color: #1a1a1a;
      margin-bottom: 8px;
    }

    .dialog-sub { font-size: 13px; color: #888780; margin-bottom: 24px; }

    .dialog-actions { display: flex; gap: 12px; justify-content: center; }

    .btn-cancel {
      height: 38px; padding: 0 24px;
      border-radius: 8px;
      border: 0.5px solid rgba(0,0,0,0.15);
      background: #fff; color: #5F5E5A;
      font-size: 13px; font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      transition: background 0.2s;
    }

    .btn-cancel:hover { background: #f5f3ef; }

    .btn-confirm {
      height: 38px; padding: 0 24px;
      border-radius: 8px; border: none;
      background: #C0392B; color: #fff;
      font-size: 13px; font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      display: inline-flex; align-items: center; gap: 6px;
      text-decoration: none;
      transition: opacity 0.2s;
    }

    .btn-confirm:hover { opacity: 0.88; }

    @media (max-width: 480px) {
      .features-grid { grid-template-columns: 1fr 1fr; }
    }
  </style>
</head>
<body>

  <!-- Top Buttons -->
  <div style="position: fixed; top: 16px; right: 24px; z-index: 100; display:flex; gap:8px;">

    <!-- Delete Account -->
    <button onclick="document.getElementById('deleteAccountOverlay').classList.add('visible')" style="
        display: inline-flex; align-items: center; gap: 6px;
        font-size: 13px; color: #888780;
        font-family: 'Inter', sans-serif; font-weight: 500;
        background: #fff;
        border: 0.5px solid rgba(0,0,0,0.15);
        border-radius: 8px; padding: 8px 16px;
        cursor: pointer;
    ">
        <i class="ti ti-user-x" style="font-size:15px"></i>
        Delete Account
    </button>

    <!-- Logout -->
    <button onclick="document.getElementById('logoutOverlay').classList.add('visible')" style="
        display: inline-flex; align-items: center; gap: 6px;
        font-size: 13px; color: #993C1D;
        font-family: 'Inter', sans-serif; font-weight: 500;
        background: #FAECE7;
        border: 0.5px solid rgba(216,90,48,0.2);
        border-radius: 8px; padding: 8px 16px;
        cursor: pointer;
    ">
        <i class="ti ti-logout" style="font-size:15px"></i>
        Logout
    </button>
  </div>

  <!-- Logout Dialog -->
  <div id="logoutOverlay" class="overlay">
    <div class="dialog">
      <div class="dialog-icon" style="background:#FAECE7; color:#993C1D;">
        <i class="ti ti-logout"></i>
      </div>
      <p class="dialog-title">Logout</p>
      <p class="dialog-sub">Are you sure you want to logout?</p>
      <div class="dialog-actions">
        <button class="btn-cancel" onclick="document.getElementById('logoutOverlay').classList.remove('visible')">
          Cancel
        </button>
        <a href="AuthController?action=logout" class="btn-confirm">
          <i class="ti ti-logout" style="font-size:14px"></i>
          Yes, Logout
        </a>
      </div>
    </div>
  </div>

  <!-- Delete Account Dialog -->
  <div id="deleteAccountOverlay" class="overlay">
    <div class="dialog">
      <div class="dialog-icon" style="background:#FAECE7; color:#993C1D;">
        <i class="ti ti-user-x"></i>
      </div>
      <p class="dialog-title">Delete Account</p>
      <p class="dialog-sub">Are you sure? This action cannot be undone and all your data will be permanently deleted.</p>
      <div class="dialog-actions">
        <button class="btn-cancel" onclick="document.getElementById('deleteAccountOverlay').classList.remove('visible')">
          Cancel
        </button>
        <a href="AuthController?action=deleteAccount" class="btn-confirm">
          <i class="ti ti-user-x" style="font-size:14px"></i>
          Yes, Delete
        </a>
      </div>
    </div>
  </div>

  <div class="wrapper">

    <div class="hero">
      <p class="welcome-label">Item Management System</p>
      <span class="welcome-hand">Welcome</span>
      <span class="welcome-app">Item App</span>
      <p class="welcome-sub">Manage your inventory easily — add, view, edit, and remove items.</p>
    </div>

    <div class="features-grid">

      <a class="feature-card" href="addItem.html">
        <div class="icon-wrap icon-purple"><i class="ti ti-plus"></i></div>
        <div>
          <div class="divider" style="background:#a78bfa"></div>
          <p class="card-label">Add Item</p>
          <p class="card-desc">Add a new product to the inventory</p>
        </div>
      </a>

      <a class="feature-card" href="ItemController?action=showItems">
        <div class="icon-wrap icon-teal"><i class="ti ti-layout-list"></i></div>
        <div>
          <div class="divider" style="background:#1D9E75"></div>
          <p class="card-label">Show All Items</p>
          <p class="card-desc">Browse and manage all items</p>
        </div>
      </a>

      <a class="feature-card" href="ItemController?action=showUpdatePage">
        <div class="icon-wrap icon-amber"><i class="ti ti-edit"></i></div>
        <div>
          <div class="divider" style="background:#EF9F27"></div>
          <p class="card-label">Update Item</p>
          <p class="card-desc">Edit details of an existing item</p>
        </div>
      </a>

      <a class="feature-card" href="ItemController?action=showDeletePage">
        <div class="icon-wrap icon-coral"><i class="ti ti-trash"></i></div>
        <div>
          <div class="divider" style="background:#D85A30"></div>
          <p class="card-label">Delete Item</p>
          <p class="card-desc">Remove an item from the list</p>
        </div>
      </a>

    </div>

    <div class="signature">
      <p class="signature-text">By : Mahmoud Soliman</p>
      <div class="signature-line"></div>
    </div>

  </div>

</body>
</html>
