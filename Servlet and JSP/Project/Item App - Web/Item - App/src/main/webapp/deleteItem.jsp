<%@ page import="com.item.model.Item" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
List<Item> items = (List<Item>) request.getAttribute("itemsData");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Delete Item</title>
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

    .card-top {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 32px;
    }

    .card-icon {
      width: 40px; height: 40px;
      border-radius: 10px;
      background: #FAECE7;
      color: #993C1D;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px; flex-shrink: 0;
    }

    .card-title {
      font-family: 'Playfair Display', serif;
      font-size: 26px; font-weight: 700; color: #1a1a1a;
    }

    .card-title span {
      background: linear-gradient(135deg, #D85A30, #F5A58A);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }

    .field label {
      font-size: 12px; font-weight: 500;
      color: #888780; letter-spacing: 0.5px; text-transform: uppercase;
    }

    .field select {
      height: 42px;
      border: 0.5px solid rgba(0,0,0,0.15);
      border-radius: 8px;
      padding: 0 36px 0 14px;
      font-size: 14px; color: #1a1a1a;
      font-family: 'Inter', sans-serif;
      outline: none;
      cursor: pointer;
      appearance: none;
      background-color: #fff;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23888780' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 14px center;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    .field select:focus {
      border-color: #D85A30;
      box-shadow: 0 0 0 3px rgba(216,90,48,0.12);
    }

    .info-bar {
      background: #FAECE7;
      border: 0.5px solid rgba(216,90,48,0.25);
      border-radius: 10px;
      padding: 14px 16px;
      margin-bottom: 20px;
      display: none;
      gap: 16px;
      align-items: center;
    }

    .info-bar.visible { display: flex; }

    .info-bar-item { display: flex; flex-direction: column; gap: 2px; }

    .info-bar-label {
      font-size: 10px; color: #993C1D;
      text-transform: uppercase; letter-spacing: 0.5px; font-weight: 500;
    }

    .info-bar-value { font-size: 13px; color: #1a1a1a; font-weight: 500; }

    .info-bar-divider { width: 0.5px; height: 32px; background: rgba(216,90,48,0.25); }

    .confirm-section { display: none; }
    .confirm-section.visible { display: block; }

    .confirm-msg {
      background: #FFF5F3;
      border: 0.5px solid rgba(216,90,48,0.2);
      border-radius: 10px;
      padding: 14px 16px;
      margin-bottom: 20px;
      font-size: 13px;
      color: #993C1D;
      display: flex;
      align-items: center;
      gap: 10px;
      line-height: 1.5;
    }

    .confirm-msg i { font-size: 18px; flex-shrink: 0; }

    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 24px 0; }

    .actions { display: flex; align-items: center; justify-content: space-between; }

    .btn-cancel {
      font-size: 13px; color: #888780;
      background: none; border: none;
      display: flex; align-items: center; gap: 6px;
      cursor: pointer; font-family: 'Inter', sans-serif;
      transition: color 0.2s;
    }

    .btn-cancel:hover { color: #993C1D; }

    .btn-delete {
      height: 42px; padding: 0 28px;
      border-radius: 8px; border: none;
      background: #C0392B; color: #fff;
      font-size: 14px; font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      display: flex; align-items: center; gap: 8px;
      text-decoration: none;
      transition: opacity 0.2s;
    }

    .btn-delete:hover { opacity: 0.88; }
    .btn-delete:active { transform: scale(0.98); }

    .always-back {
      margin-top: 24px;
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .always-back a {
      font-size: 13px; color: #888780;
      text-decoration: none;
      display: inline-flex; align-items: center; gap: 6px;
      transition: color 0.2s;
    }

    .always-back a:hover { color: #993C1D; }

    @media (max-width: 480px) {
      .card { padding: 28px 24px; }
      .card-title { font-size: 22px; }
      .info-bar { flex-wrap: wrap; }
    }
  </style>
</head>
<body>

  <div class="card">

    <div class="card-top">
      <div class="card-icon"><i class="ti ti-trash"></i></div>
      <h1 class="card-title">Delete <span>Item</span></h1>
    </div>

    <!-- Dropdown -->
    <div class="field">
      <label for="itemSelect">Select Item</label>
      <select id="itemSelect" onchange="onItemSelect(this)">
        <option value="">-- Choose an Item --</option>
        <% if (items != null) { %>
          <% for (Item item : items) { %>
            <option value="<%= item.getId() %>"
                    data-name="<%= item.getName() %>"
                    data-price="<%= item.getPrice() %>"
                    data-total="<%= item.getTotalNumber() %>">
              <%= item.getId() %> — <%= item.getName() %>
            </option>
          <% } %>
        <% } %>
      </select>
    </div>

    <!-- Info bar -->
    <div class="info-bar" id="infoBar">
      <div class="info-bar-item">
        <span class="info-bar-label">ID</span>
        <span class="info-bar-value" id="barId">—</span>
      </div>
      <div class="info-bar-divider"></div>
      <div class="info-bar-item">
        <span class="info-bar-label">Name</span>
        <span class="info-bar-value" id="barName">—</span>
      </div>
      <div class="info-bar-divider"></div>
      <div class="info-bar-item">
        <span class="info-bar-label">Price</span>
        <span class="info-bar-value" id="barPrice">—</span>
      </div>
      <div class="info-bar-divider"></div>
      <div class="info-bar-item">
        <span class="info-bar-label">Total</span>
        <span class="info-bar-value" id="barTotal">—</span>
      </div>
    </div>

    <!-- Confirm section -->
    <div class="confirm-section" id="confirmSection">
      <div class="confirm-msg">
        <i class="ti ti-alert-triangle"></i>
        Are you sure you want to delete this Item? This action cannot be undone.
      </div>

      <div class="divider"></div>

      <div class="actions">
        <button class="btn-cancel" type="button" onclick="onCancel()">
          <i class="ti ti-x" style="font-size:16px"></i> Cancel
        </button>
        <a id="deleteBtn" href="#" class="btn-delete">
          <i class="ti ti-trash" style="font-size:16px"></i> Delete Item
        </a>
      </div>
    </div>

    <!-- Back links -->
    <div class="always-back">
      <a href="index.jsp">
        <i class="ti ti-home" style="font-size:15px"></i>
        Back to Home
      </a>
      <a href="ItemController?action=showItems">
        <i class="ti ti-layout-list" style="font-size:15px"></i>
        Back to Items
      </a>
    </div>

  </div>

  <script>
    function onItemSelect(select) {
      const opt = select.options[select.selectedIndex];
      const infoBar = document.getElementById('infoBar');
      const confirmSection = document.getElementById('confirmSection');

      if (!select.value) {
        infoBar.classList.remove('visible');
        confirmSection.classList.remove('visible');
        return;
      }

      document.getElementById('barId').textContent    = select.value;
      document.getElementById('barName').textContent  = opt.dataset.name;
      document.getElementById('barPrice').textContent = '$' + opt.dataset.price;
      document.getElementById('barTotal').textContent = opt.dataset.total;

      document.getElementById('deleteBtn').href =
        'ItemController?action=deleteItem&id=' + select.value;

      infoBar.classList.add('visible');
      confirmSection.classList.add('visible');
    }

    function onCancel() {
      document.getElementById('itemSelect').value = '';
      document.getElementById('infoBar').classList.remove('visible');
      document.getElementById('confirmSection').classList.remove('visible');
    }
    
    window.onload = function() {
        const selectedId = '<%= request.getAttribute("selectedId") != null ? request.getAttribute("selectedId") : "" %>';
        if (selectedId) {
            const select = document.getElementById('itemSelect');
            select.value = selectedId;
            onItemSelect(select);
        }
    };
  </script>

</body>
</html>
