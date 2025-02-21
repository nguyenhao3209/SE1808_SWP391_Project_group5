<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Vouchers" %>
<%
    Vouchers voucher = (Vouchers) request.getAttribute("voucher");
    boolean isEdit = (voucher != null);
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= isEdit ? "Edit Voucher" : "Add Voucher" %></title>
    <link rel="stylesheet" 
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4"><%= isEdit ? "Edit Voucher" : "Add New Voucher" %></h2>

        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <form action="VoucherServlet" method="post">
            <!-- Xác định action để Servlet phân biệt -->
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">

            <!-- Khi Edit, cần voucherID để update -->
            <% if (isEdit) { %>
                <input type="hidden" name="voucherID" value="<%= voucher.getVoucherID() %>">
            <% } %>

            <!-- Voucher Name -->
            <div class="mb-3">
                <label class="form-label">Voucher Name</label>
                <input type="text" class="form-control" name="name" required 
                       value="<%= isEdit ? voucher.getName() : "" %>">
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea class="form-control" name="description" rows="3" required><%= isEdit ? voucher.getDescription() : "" %></textarea>
            </div>

            <!-- Discount Percentage -->
            <div class="mb-3">
                <label class="form-label">Discount Percentage (%)</label>
                <input type="number" class="form-control" name="discountPercentage" step="1" required 
                       value="<%= isEdit ? voucher.getDiscountPercentage() : "" %>">
            </div>

            <!-- Max Reducing -->
            <div class="mb-3">
                <label class="form-label">Max Reducing</label>
                <input type="number" class="form-control" name="maxReducing" required 
                       value="<%= isEdit ? voucher.getMaxReducing() : "" %>">
            </div>

            <!-- Voucher Code -->
            <div class="mb-3">
                <label class="form-label">Voucher Code</label>
                <input type="text" class="form-control" name="code" required 
                       value="<%= isEdit ? voucher.getCode() : "" %>">
            </div>

            <!-- Quantity -->
            <div class="mb-3">
                <label class="form-label">Quantity</label>
                <input type="number" class="form-control" name="quantity" required 
                       value="<%= isEdit ? voucher.getQuantity() : "" %>">
            </div>

            <!-- Expiry Date -->
            <div class="mb-3">
                <label class="form-label">Expiry Date</label>
                <input type="date" class="form-control" name="expiryDate" required 
                       value="<%= isEdit ? voucher.getExpiryDate() : "" %>">
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary">
                <%= isEdit ? "Update" : "Add" %> Voucher
            </button>
            <a href="VoucherServlet?action=list" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
