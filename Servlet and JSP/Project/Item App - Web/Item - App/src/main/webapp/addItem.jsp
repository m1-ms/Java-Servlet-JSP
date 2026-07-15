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
  <title>Add Item</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

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
      border: 0.5px solid rgba(0, 0, 0, 0.1);
      border-radius: 16px;
      padding: 40px 40px 32px;
      width: 100%;
      max-width: 520px;
    }

    /* Header */
    .card-top {
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 32px;
    }

    .card-icon {
      width: 40px;
      height: 40px;
      border-radius: 10px;
      background: #EEEDFE;
      color: #534AB7;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      flex-shrink: 0;
    }

    .card-title {
      font-family: 'Playfair Display', serif;
      font-size: 26px;
      font-weight: 700;
      color: #1a1a1a;
      line-height: 1.1;
    }

    .card-title span {
      background: linear-gradient(135deg, #7c6fcd, #a78bfa);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    /* Form rows */
    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
      margin-bottom: 16px;
    }

    .form-row.single {
      grid-template-columns: 1fr;
    }

    /* Fields */
    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .field label {
      font-size: 12px;
      font-weight: 500;
      color: #888780;
      letter-spacing: 0.5px;
      text-transform: uppercase;
    }

    .field input {
      height: 42px;
      border: 0.5px solid rgba(0, 0, 0, 0.15);
      border-radius: 8px;
      padding: 0 14px;
      font-size: 14px;
      color: #1a1a1a;
      background: #fff;
      font-family: 'Inter', sans-serif;
      outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    .field input:focus {
      border-color: #a78bfa;
      box-shadow: 0 0 0 3px rgba(167, 139, 250, 0.12);
    }

    .field input::placeholder {
      color: #B4B2A9;
    }

    /* Divider */
    .divider {
      height: 0.5px;
      background: rgba(0, 0, 0, 0.08);
      margin: 24px 0;
    }

    /* Actions */
    .actions {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .links {
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .back-link {
      font-size: 13px;
      color: #888780;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 6px;
      transition: color 0.2s;
    }

    .back-link:hover {
      color: #534AB7;
    }

    .btn-submit {
      height: 42px;
      padding: 0 28px;
      border-radius: 8px;
      border: none;
      background: #534AB7;
      color: #fff;
      font-size: 14px;
      font-weight: 500;
      font-family: 'Inter', sans-serif;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 8px;
      transition: opacity 0.2s;
    }

    .btn-submit:hover {
      opacity: 0.88;
    }

    .btn-submit:active {
      transform: scale(0.98);
    }

    /* Responsive */
    @media (max-width: 480px) {
      .card {
        padding: 28px 24px;
      }

      .form-row {
        grid-template-columns: 1fr;
      }

      .card-title {
        font-size: 22px;
      }
    }
  </style>
</head>
<body>

  <div class="card">

    <div class="card-top">
      <div class="card-icon">
        <i class="ti ti-plus"></i>
      </div>
      <h1 class="card-title">Add <span>Item</span></h1>
    </div>

    <form action="ItemController" method="post">

      <input type="hidden" name="action" value="addItem">

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

      <div class="form-row single">
        <div class="field">
          <label for="totalNumber">Total Number</label>
          <input type="text" id="totalNumber" name="totalNumber" placeholder="e.g. 50" required>
        </div>
      </div>

      <div class="divider"></div>

      <div class="actions">
        <div class="links">
          <a href="index.jsp" class="back-link">
            <i class="ti ti-home" style="font-size:16px"></i>
            Back to Home
          </a>
          <a href="ItemController?action=showItems" class="back-link">
            <i class="ti ti-layout-list" style="font-size:16px"></i>
            Back to Items
          </a>
        </div>
        <button type="submit" class="btn-submit">
          <i class="ti ti-check" style="font-size:16px"></i>
          Add Item
        </button>
      </div>

    </form>

  </div>

	<script>
	document.querySelector('form').addEventListener('submit', function(e) {
	    const name  = document.getElementById('name').value.trim();
	    const price = document.getElementById('price').value.trim();
	    const total = document.getElementById('totalNumber').value.trim();
	
	    if (!name) {
	        alert('Item name is required!'); e.preventDefault(); return;
	    }
	    if (!/^[A-Za-z ]{3,}$/.test(name)) {
	        alert('Name must be at least 3 letters!'); e.preventDefault(); return;
	    }
	    if (!price || isNaN(price) || parseFloat(price) <= 0) {
	        alert('Price must be a number greater than 0!'); e.preventDefault(); return;
	    }
	    if (!total || isNaN(total) || parseInt(total) < 0) {
	        alert('Total number must be 0 or greater!'); e.preventDefault(); return;
	    }
	});
	</script>


</body>
</html>