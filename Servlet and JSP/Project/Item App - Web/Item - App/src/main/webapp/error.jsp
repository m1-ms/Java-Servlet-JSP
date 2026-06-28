<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error</title>
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
      text-align: center;
    }

    .icon-wrap {
      width: 64px; height: 64px;
      border-radius: 16px;
      background: #FAECE7;
      color: #993C1D;
      display: flex; align-items: center; justify-content: center;
      font-size: 32px;
      margin: 0 auto 24px;
    }

    .card-title {
      font-family: 'Playfair Display', serif;
      font-size: 26px; font-weight: 700; color: #1a1a1a;
      margin-bottom: 8px;
    }

    .card-title span {
      background: linear-gradient(135deg, #D85A30, #F5A58A);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    .card-sub {
      font-size: 13px;
      color: #888780;
      margin-bottom: 4px;
    }

    .error-msg-box {
      background: #FFF5F3;
      border: 0.5px solid rgba(216,90,48,0.2);
      border-radius: 10px;
      padding: 14px 16px;
      margin: 20px 0;
      font-size: 13px;
      color: #993C1D;
      text-align: left;
      display: flex;
      align-items: flex-start;
      gap: 10px;
      line-height: 1.6;
    }

    .error-msg-box i { font-size: 18px; flex-shrink: 0; margin-top: 1px; }

    .divider { height: 0.5px; background: rgba(0,0,0,0.08); margin: 24px 0; }

    .actions {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
    }

    .btn-back {
      height: 42px; padding: 0 24px;
      border-radius: 8px;
      border: 0.5px solid rgba(0,0,0,0.15);
      background: #fff; color: #5F5E5A;
      font-size: 14px; font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      display: flex; align-items: center; gap: 8px;
      text-decoration: none;
      transition: background 0.2s;
    }

    .btn-back:hover { background: #f5f3ef; }

    .btn-home {
      height: 42px; padding: 0 24px;
      border-radius: 8px; border: none;
      background: #534AB7; color: #fff;
      font-size: 14px; font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      display: flex; align-items: center; gap: 8px;
      text-decoration: none;
      transition: opacity 0.2s;
    }

    .btn-home:hover { opacity: 0.88; }
  </style>
</head>
<body>

  <div class="card">

    <div class="icon-wrap">
      <i class="ti ti-alert-triangle"></i>
    </div>

    <h1 class="card-title">Oops! <span>Something went wrong</span></h1>
    <p class="card-sub">An error occurred while processing your request.</p>

    <div class="error-msg-box">
      <i class="ti ti-info-circle"></i>
      <span><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error occurred. Please try again." %></span>
    </div>

    <div class="divider"></div>

    <div class="actions">
      <a href="javascript:history.back()" class="btn-back">
        <i class="ti ti-arrow-left" style="font-size:16px"></i>
        Go back
      </a>
      <a href="index.jsp" class="btn-home">
        <i class="ti ti-home" style="font-size:16px"></i>
        Home
      </a>
    </div>

  </div>

</body>
</html>
