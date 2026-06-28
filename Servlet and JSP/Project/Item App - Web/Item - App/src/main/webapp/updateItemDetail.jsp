<%@ page import="com.item.model.ItemDetail" %>
<%@ page import="com.item.model.Item" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    ItemDetail detail = (ItemDetail) request.getAttribute("itemDetail");
    Item item = (Item) request.getAttribute("item");
    String itemName = item != null ? item.getName() : "";
    String description = detail != null && detail.getDescription() != null ? detail.getDescription() : "";
    String manufacturer = detail != null && detail.getManufacturer() != null ? detail.getManufacturer() : "";
    long itemId = detail != null ? detail.getItemId() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Item Details</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      min-height: 100vh; background: #f5f3ef;
      display: flex; align-items: flex-start; justify-content: center;
      font-family: 'Inter', sans-serif; padding: 40px 24px;
    }
    .card {
      background: #fff; border: 0.5px solid rgba(0,0,0,0.1);
      border-radius: 16px; padding: 40px 40px 32px;
      width: 100%; max-width: 460px;
    }
    .card-top { margin-bottom: 28px; }
    .card-icon-row { display: flex; align-items: center; gap: 12px; margin-bottom: 16px; }
    .card-icon {
      width: 44px; height: 44px; border-radius: 12px;
      background: #EEEDFE; color: #534AB7;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px; flex-shrink: 0;
    }
    .card-title { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 700; color: #1a1a1a; }
    .card-title span {
      background: linear-gradient(135deg, #7c6fcd, #a78bfa);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }
    .item-bar {
      background: #f5f3ef; border: 0.5px solid rgba(0,0,0,0.08);
      border-radius: 10px; padding: 12px 16px;
      display: flex; align-items: center; gap: 16px; flex-wrap: wrap;
    }
    .item-bar-item { display: flex; flex-direction: column; gap: 2px; }
    .item-bar-label { font-size: 10px; font-weight: 500; color: #888780; text-transform: uppercase; letter-spacing: 0.5px; }
    .item-bar-value { font-size: 14px; font-weight: 600; color: #1a1a1a; }
    .item-bar-sub { font-size: 13px; color: #888780; font-weight: 500; }
    .item-bar-divider { width: 0.5px; height: 32px; background: rgba(0,0,0,0.1); }
    .field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
    .field label { font-size: 11px; font-weight: 500; color: #888780; letter-spacing: 0.5px; text-transform: uppercase; }
    .field input, .field textarea {
      border: 0.5px solid rgba(0,0,0,0.15); border-radius: 8px;
      padding: 10px 14px; font-size: 13px; color: #1a1a1a;
      background: #fff; font-family: 'Inter', sans-serif; outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .field input { height: 40px; }
    .field textarea { height: 90px; resize: none; }
    .field input:focus, .field textarea:focus {
      border-color: #a78bfa; box-shadow: 0 0 0 3px rgba(167,139,250,0.12);
    }
    .field input::placeholder, .field textarea::placeholder { color: #B4B2A9; }
    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 20px 0; }
    .actions { display: flex; align-items: center; justify-content: space-between; }
    .btn-back {
      font-size: 13px; color: #888780; text-decoration: none;
      display: flex; align-items: center; gap: 6px; transition: color 0.2s;
    }
    .btn-back:hover { color: #534AB7; }
    .btn-submit {
      height: 40px; padding: 0 24px; border-radius: 8px; border: none;
      background: #534AB7; color: #fff; font-size: 13px; font-weight: 500;
      font-family: 'Inter', sans-serif; cursor: pointer;
      display: flex; align-items: center; gap: 6px; transition: opacity 0.2s;
    }
    .btn-submit:hover { opacity: 0.88; }
  </style>
</head>
<body>
  <div class="card">
    <div class="card-top">
      <div class="card-icon-row">
        <div class="card-icon"><i class="ti ti-file-pencil"></i></div>
        <h1 class="card-title">Update <span>Details</span></h1>
      </div>
      <div class="item-bar">
        <div class="item-bar-item">
          <p class="item-bar-label">ID</p>
          <p class="item-bar-sub">#<%= itemId %></p>
        </div>
        <div class="item-bar-divider"></div>
        <div class="item-bar-item">
          <p class="item-bar-label">Item</p>
          <p class="item-bar-value"><%= itemName %></p>
        </div>
        <div class="item-bar-divider"></div>
        <div class="item-bar-item">
          <p class="item-bar-label">Manufacturer</p>
          <p class="item-bar-sub"><%= manufacturer %></p>
        </div>
      </div>
    </div>

    <form action="ItemController" method="post">
      <input type="hidden" name="action" value="updateItemDetail">
      <input type="hidden" name="itemId" value="<%= itemId %>">

      <div class="field">
        <label for="description">Description</label>
        <textarea id="description" name="description" placeholder="e.g. Gaming Laptop with RTX 4090"><%= description %></textarea>
      </div>
      <div class="field">
        <label for="manufacturer">Manufacturer</label>
        <input type="text" id="manufacturer" name="manufacturer" value="<%= manufacturer %>" placeholder="e.g. Dell">
      </div>

      <div class="divider"></div>
      <div class="actions">
        <a href="ItemController?action=showItems" class="btn-back">
          <i class="ti ti-arrow-left" style="font-size:15px"></i> Back
        </a>
        <button type="submit" class="btn-submit">
          <i class="ti ti-device-floppy" style="font-size:15px"></i> Save Changes
        </button>
      </div>
    </form>
  </div>
</body>
</html>
