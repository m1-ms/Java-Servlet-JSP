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
  <title>Update Item</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      min-height: 100vh;
      background: #f5f3ef;
      display: flex;
      align-items: flex-start;
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
    .card-top { display: flex; align-items: center; gap: 12px; margin-bottom: 32px; }
    .card-icon {
      width: 40px; height: 40px;
      border-radius: 10px;
      background: #FAEEDA; color: #854F0B;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px; flex-shrink: 0;
    }
    .card-title { font-family: 'Playfair Display', serif; font-size: 26px; font-weight: 700; color: #1a1a1a; }
    .card-title span {
      background: linear-gradient(135deg, #EF9F27, #FAC775);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }
    .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
    .field label { font-size: 12px; font-weight: 500; color: #888780; letter-spacing: 0.5px; text-transform: uppercase; }
    .field select, .field input {
      height: 42px;
      border: 0.5px solid rgba(0,0,0,0.15);
      border-radius: 8px; padding: 0 14px;
      font-size: 14px; color: #1a1a1a;
      background: #fff; font-family: 'Inter', sans-serif;
      outline: none; transition: border-color 0.2s, box-shadow 0.2s;
    }
    .field select {
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23888780' stroke-width='2'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
      background-repeat: no-repeat; background-position: right 14px center;
      background-color: #fff; padding-right: 36px; cursor: pointer;
    }
    .field select:focus, .field input:focus {
      border-color: #EF9F27; box-shadow: 0 0 0 3px rgba(239,159,39,0.12);
    }
    .field input::placeholder { color: #B4B2A9; }
    .info-bar {
      background: #FAEEDA; border: 0.5px solid rgba(239,159,39,0.3);
      border-radius: 10px; padding: 14px 16px; margin-bottom: 20px;
      display: none; gap: 16px; align-items: center;
    }
    .info-bar.visible { display: flex; }
    .info-bar-item { display: flex; flex-direction: column; gap: 2px; }
    .info-bar-label { font-size: 10px; color: #854F0B; text-transform: uppercase; letter-spacing: 0.5px; font-weight: 500; }
    .info-bar-value { font-size: 13px; color: #1a1a1a; font-weight: 500; }
    .info-bar-divider { width: 0.5px; height: 32px; background: rgba(239,159,39,0.3); }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px; }
    .form-row .field { margin-bottom: 0; }
    .fields-section { display: none; }
    .fields-section.visible { display: block; }
    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 24px 0; }
    .actions { display: flex; align-items: center; justify-content: space-between; }
    .btn-back {
      font-size: 13px; color: #888780;
      text-decoration: none; display: flex; align-items: center; gap: 6px; transition: color 0.2s;
    }
    .btn-back:hover { color: #854F0B; }
    .btn-submit {
      height: 42px; padding: 0 28px;
      border-radius: 8px; border: none;
      background: #BA7517; color: #fff;
      font-size: 14px; font-weight: 500;
      font-family: 'Inter', sans-serif; cursor: pointer;
      display: flex; align-items: center; gap: 8px; transition: opacity 0.2s;
    }
    .btn-submit:hover { opacity: 0.88; }
    .btn-submit:active { transform: scale(0.98); }
    @media (max-width: 480px) {
      .card { padding: 28px 24px; }
      .form-row { grid-template-columns: 1fr; }
      .card-title { font-size: 22px; }
    }
  </style>
</head>
<body>

  <div class="card">
    <div class="card-top">
      <div class="card-icon"><i class="ti ti-edit"></i></div>
      <h1 class="card-title">Update <span>Item</span></h1>
    </div>

    <form action="ItemController" method="post">
      <input type="hidden" name="action" value="updateItem">
      <input type="hidden" name="id" id="hiddenId" value="">

      <div class="field">
        <label for="itemSelect">Select Item</label>
        <select id="itemSelect" onchange="onItemSelect(this)">
          <option value="">-- Choose an item --</option>
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

      <div class="fields-section" id="fieldsSection">
        <div class="form-row">
          <div class="field">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" placeholder="e.g. Laptop" required>
          </div>
          <div class="field">
            <label for="price">Price</label>
            <input type="text" id="price" name="price" placeholder="e.g. 999.99" required>
          </div>
        </div>
        <div class="field">
          <label for="totalNumber">Total number</label>
          <input type="text" id="totalNumber" name="totalNumber" placeholder="e.g. 50" required>
        </div>
      </div>

      <div class="divider"></div>

      <div class="actions">
        <div style="display:flex; flex-direction:column; gap:8px;">
          <a href="index.jsp" class="btn-back">
            <i class="ti ti-home" style="font-size:16px"></i>
            Back to home
          </a>
          <a href="ItemController?action=showItems" class="btn-back">
            <i class="ti ti-layout-list" style="font-size:16px"></i>
            Back to items
          </a>
        </div>
        <button type="submit" class="btn-submit" id="saveBtn" style="display:none">
          <i class="ti ti-device-floppy" style="font-size:16px"></i>
          Save changes
        </button>
      </div>

    </form>
  </div>

  <script>
    function onItemSelect(select) {
      const opt = select.options[select.selectedIndex];
      const infoBar = document.getElementById('infoBar');
      const fieldsSection = document.getElementById('fieldsSection');
      const saveBtn = document.getElementById('saveBtn');

      if (!select.value) {
        infoBar.classList.remove('visible');
        fieldsSection.classList.remove('visible');
        saveBtn.style.display = 'none';
        document.getElementById('hiddenId').value = '';
        return;
      }

      const name  = opt.dataset.name;
      const price = opt.dataset.price;
      const total = opt.dataset.total;

      document.getElementById('barId').textContent    = select.value;
      document.getElementById('barName').textContent  = name;
      document.getElementById('barPrice').textContent = '$' + price;
      document.getElementById('barTotal').textContent = total;

      document.getElementById('hiddenId').value    = select.value;
      document.getElementById('name').value        = name;
      document.getElementById('price').value       = price;
      document.getElementById('totalNumber').value = total;

      infoBar.classList.add('visible');
      fieldsSection.classList.add('visible');
      saveBtn.style.display = 'flex';
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
