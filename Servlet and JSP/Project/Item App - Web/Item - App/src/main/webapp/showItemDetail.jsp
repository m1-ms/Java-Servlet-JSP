<%@ page import="com.item.model.Item" %>
<%@ page import="com.item.model.ItemDetail" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Item item = (Item) request.getAttribute("item");
    ItemDetail detail = (ItemDetail) request.getAttribute("itemDetail");
    if (item == null || detail == null) {
        response.sendRedirect("ItemController?action=showItems");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Item Details</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      min-height: 100vh; background: #f5f3ef;
      display: flex; align-items: center; justify-content: center;
      font-family: 'Inter', sans-serif; padding: 40px 24px;
    }
    .card {
      background: #fff; border: 0.5px solid rgba(0,0,0,0.1);
      border-radius: 16px; padding: 40px 40px 32px;
      width: 100%; max-width: 480px;
    }
    .card-top { display: flex; align-items: center; gap: 12px; margin-bottom: 28px; }
    .card-icon {
      width: 44px; height: 44px; border-radius: 12px;
      background: #EEF2FF; color: #3B4ED8;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px; flex-shrink: 0;
    }
    .card-title { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 700; color: #1a1a1a; }
    .card-title span {
      background: linear-gradient(135deg, #3B4ED8, #818CF8);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }

    .item-bar {
      background: #f5f3ef; border: 0.5px solid rgba(0,0,0,0.08);
      border-radius: 10px; padding: 14px 16px;
      display: flex; align-items: center; gap: 16px;
      margin-bottom: 24px; flex-wrap: wrap;
    }
    .item-bar-item { display: flex; flex-direction: column; gap: 2px; }
    .item-bar-label { font-size: 10px; font-weight: 500; color: #888780; text-transform: uppercase; letter-spacing: 0.5px; }
    .item-bar-value { font-size: 14px; font-weight: 600; color: #1a1a1a; }
    .item-bar-sub { font-size: 13px; color: #888780; font-weight: 500; }
    .item-bar-divider { width: 0.5px; height: 32px; background: rgba(0,0,0,0.1); }

    .detail-field { display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px; }
    .detail-label { font-size: 11px; font-weight: 500; color: #888780; letter-spacing: 0.5px; text-transform: uppercase; }
    .detail-value {
      font-size: 14px; color: #1a1a1a;
      background: #f5f3ef; border: 0.5px solid rgba(0,0,0,0.08);
      border-radius: 8px; padding: 10px 14px; line-height: 1.5;
    }

    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 24px 0; }

    .actions { display: flex; align-items: center; justify-content: space-between; gap: 8px; }
    .btn-back {
      font-size: 13px; color: #888780; text-decoration: none;
      display: flex; align-items: center; gap: 6px; transition: color 0.2s;
    }
    .btn-back:hover { color: #3B4ED8; }
    .btn-update {
      height: 38px; padding: 0 20px; border-radius: 8px; border: none;
      background: #534AB7; color: #fff; font-size: 13px; font-weight: 500;
      font-family: 'Inter', sans-serif; cursor: pointer;
      display: flex; align-items: center; gap: 6px;
      text-decoration: none; transition: opacity 0.2s;
    }
    .btn-update:hover { opacity: 0.88; }
  </style>
</head>
<body>
  <div class="card">
    <div class="card-top">
      <div class="card-icon"><i class="ti ti-file-info"></i></div>
      <h1 class="card-title">Item <span>Details</span></h1>
    </div>

    <!-- Item info bar -->
    <div class="item-bar">
      <div class="item-bar-item">
        <p class="item-bar-label">ID</p>
        <p class="item-bar-sub">#<%= item.getId() %></p>
      </div>
      <div class="item-bar-divider"></div>
      <div class="item-bar-item">
        <p class="item-bar-label">Item</p>
        <p class="item-bar-value"><%= item.getName() %></p>
      </div>
      <div class="item-bar-divider"></div>
      <div class="item-bar-item">
        <p class="item-bar-label">Price</p>
        <p class="item-bar-sub">$<%= item.getPrice() %></p>
      </div>
    </div>

    <div class="detail-field">
      <p class="detail-label">Description</p>
      <p class="detail-value"><%= detail.getDescription() != null ? detail.getDescription() : "—" %></p>
    </div>
    <div class="detail-field">
      <p class="detail-label">Manufacturer</p>
      <p class="detail-value"><%= detail.getManufacturer() != null ? detail.getManufacturer() : "—" %></p>
    </div>

    <div class="divider"></div>

    <div class="actions">
      <a href="ItemController?action=showItems" class="btn-back">
        <i class="ti ti-arrow-left" style="font-size:15px"></i> Back to Items
      </a>
      <a href="ItemController?action=showUpdateDetailPage&id=<%= item.getId() %>" class="btn-update">
        <i class="ti ti-file-pencil" style="font-size:14px"></i> Update Details
      </a>
    </div>
  </div>
</body>
</html>
