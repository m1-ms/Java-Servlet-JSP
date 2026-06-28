<%@ page import="com.item.model.Item" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
List<Item> items = (List<Item>) request.getAttribute("itemsData");
List<Long> itemsWithDetails = (List<Long>) request.getAttribute("itemsWithDetails");
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>All Items</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      min-height: 100vh;
      background: #f5f3ef;
      font-family: 'Inter', sans-serif;
      padding: 40px 24px;
    }

    .wrapper { width: 100%; max-width: 900px; margin: 0 auto; }

    .page-header {
      display: flex; align-items: center; justify-content: space-between;
      margin-bottom: 28px;
    }

    .header-left { display: flex; align-items: center; gap: 12px; }

    .page-icon {
      width: 40px; height: 40px; border-radius: 10px;
      background: #E1F5EE; color: #0F6E56;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px; flex-shrink: 0;
    }

    .page-title { font-family: 'Playfair Display', serif; font-size: 26px; font-weight: 700; color: #1a1a1a; }

    .page-title span {
      background: linear-gradient(135deg, #1D9E75, #5DCAA5);
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
    }

    .btn-add {
      height: 38px; padding: 0 18px; border-radius: 8px; border: none;
      background: #534AB7; color: #fff; font-size: 13px; font-weight: 500;
      font-family: 'Inter', sans-serif; cursor: pointer;
      display: flex; align-items: center; gap: 6px;
      text-decoration: none; transition: opacity 0.2s;
    }

    .btn-add:hover { opacity: 0.88; }

    .table-wrap {
      background: #ffffff; border: 0.5px solid rgba(0,0,0,0.1);
      border-radius: 16px; max-height: 800px; overflow-y: auto;
    }

    table { width: 100%; border-collapse: collapse; font-size: 13px; }

    thead { background: #f5f3ef; }

    thead th {
      padding: 14px 20px; text-align: left; font-size: 11px; font-weight: 500;
      color: #888780; text-transform: uppercase; letter-spacing: 0.5px;
      border-bottom: 0.5px solid rgba(0,0,0,0.08);
      position: sticky; top: 0; background: #f5f3ef; z-index: 1;
    }

    tbody tr { border-bottom: 0.5px solid rgba(0,0,0,0.06); transition: background 0.15s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #fafaf8; }
    tbody td { padding: 14px 20px; color: #1a1a1a; }

    .td-id { color: #888780; font-size: 12px; }
    .td-price { font-weight: 500; }
    .td-total { color: #5F5E5A; }

    .actions-cell { display: flex; gap: 8px; flex-wrap: wrap; }

    .btn-edit {
      height: 32px; padding: 0 14px; border-radius: 6px;
      border: 0.5px solid rgba(0,0,0,0.15); background: #FAEEDA; color: #854F0B;
      font-size: 12px; font-weight: 500; font-family: 'Inter', sans-serif;
      cursor: pointer; display: flex; align-items: center; gap: 5px;
      text-decoration: none; transition: background 0.15s;
    }
    .btn-edit:hover { background: #FAC775; }

    .btn-delete {
      height: 32px; padding: 0 14px; border-radius: 6px;
      border: 0.5px solid rgba(0,0,0,0.15); background: #FAECE7; color: #993C1D;
      font-size: 12px; font-weight: 500; font-family: 'Inter', sans-serif;
      cursor: pointer; display: flex; align-items: center; gap: 5px;
      text-decoration: none; transition: background 0.15s;
    }
    .btn-delete:hover { background: #F5C4B3; }

    .btn-detail-add {
      height: 32px; padding: 0 14px; border-radius: 6px;
      border: 0.5px solid rgba(0,0,0,0.15); background: #E1F5EE; color: #0F6E56;
      font-size: 12px; font-weight: 500; font-family: 'Inter', sans-serif;
      cursor: pointer; display: flex; align-items: center; gap: 5px;
      text-decoration: none; transition: background 0.15s;
    }
    .btn-detail-add:hover { background: #B7E4CE; }

    .btn-detail-update {
      height: 32px; padding: 0 14px; border-radius: 6px;
      border: 0.5px solid rgba(0,0,0,0.15); background: #EEEDFE; color: #534AB7;
      font-size: 12px; font-weight: 500; font-family: 'Inter', sans-serif;
      cursor: pointer; display: flex; align-items: center; gap: 5px;
      text-decoration: none; transition: background 0.15s;
    }
    .btn-detail-update:hover { background: #D4D2F7; }

    .empty-state { padding: 60px 20px; text-align: center; color: #888780; font-size: 14px; }
    .empty-state i { font-size: 36px; margin-bottom: 12px; display: block; color: #B4B2A9; }

    .back-link { margin-top: 20px; }
    .back-link a {
      font-size: 13px; color: #888780; text-decoration: none;
      display: inline-flex; align-items: center; gap: 6px; transition: color 0.2s;
    }
    .back-link a:hover { color: #534AB7; }

    @media (max-width: 560px) {
      .page-title { font-size: 20px; }
      thead th, tbody td { padding: 12px 12px; }
      .btn-edit, .btn-delete { padding: 0 10px; }
    }
  </style>
</head>
<body>

  <div class="wrapper">

    <div class="page-header">
      <div class="header-left">
        <div class="page-icon"><i class="ti ti-layout-list"></i></div>
        <h1 class="page-title">All <span>Items</span></h1>
      </div>
      <a href="addItem.html" class="btn-add">
        <i class="ti ti-plus" style="font-size:15px"></i>
        Add item
      </a>
    </div>

    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Total</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <% if (items == null || items.isEmpty()) { %>
            <tr>
              <td colspan="5">
                <div class="empty-state">
                  <i class="ti ti-inbox"></i>
                  No items found.
                </div>
              </td>
            </tr>
          <% } else { %>
            <% for (Item item : items) { %>
              <tr>
                <td class="td-id"><%= item.getId() %></td>
                <td><%= item.getName() %></td>
                <td class="td-price">$<%= item.getPrice() %></td>
                <td class="td-total"><%= item.getTotalNumber() %></td>
                <td>
                  <div class="actions-cell">
                    <a href="ItemController?action=showUpdatePage&id=<%= item.getId() %>" class="btn-edit">
                      <i class="ti ti-edit" style="font-size:13px"></i> Edit
                    </a>
                    <a href="ItemController?action=showDeletePage&id=<%= item.getId() %>" class="btn-delete">
                      <i class="ti ti-trash" style="font-size:13px"></i> Delete
                    </a>
                    <% if (itemsWithDetails != null && itemsWithDetails.contains(item.getId())) { %>
                      <a href="ItemController?action=showUpdateDetailPage&id=<%= item.getId() %>" class="btn-detail-update">
                        <i class="ti ti-file-pencil" style="font-size:13px"></i> Update Details
                      </a>
                    <% } else { %>
                      <a href="ItemController?action=showAddDetailPage&id=<%= item.getId() %>" class="btn-detail-add">
                        <i class="ti ti-file-plus" style="font-size:13px"></i> Add Details
                      </a>
                    <% } %>
                  </div>
                </td>
              </tr>
            <% } %>
          <% } %>
        </tbody>
      </table>
    </div>

    <div class="back-link">
      <a href="index.jsp">
        <i class="ti ti-arrow-left" style="font-size:15px"></i>
        Back to home
      </a>
    </div>

  </div>

</body>
</html>
