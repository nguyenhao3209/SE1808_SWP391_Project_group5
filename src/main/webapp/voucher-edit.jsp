<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Vouchers" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Voucher</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Edit Voucher</h2>

        <%
            Vouchers voucher = (Vouchers) request.getAttribute("voucher");
            if (voucher == null) {
        %>
            <div class="alert alert-danger">Voucher không tồn tại!</div>
        <%
            } else {
        %>
        <form action="VoucherServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="voucherID" value="<%= voucher.getVoucherID() %>">

            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" class="form-control" name="name" value="<%= voucher.getName() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea class="form-control" name="description" required><%= voucher.getDescription() %></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Discount Percentage</label>
                <input type="number" class="form-control" name="discountPercentage" step="0.01" 
                       value="<%= (voucher.getDiscountPercentage() != null) ? voucher.getDiscountPercentage() : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Max Reducing</label>
                <input type="number" class="form-control" name="maxReducing" step="0.01" 
                       value="<%= (voucher.getMaxReducing() != null) ? voucher.getMaxReducing() : "" %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Code</label>
                <input type="text" class="form-control" name="code" value="<%= voucher.getCode() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Quantity</label>
                <input type="number" class="form-control" name="quantity" min="1" 
                       value="<%= voucher.getQuantity() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Expiry Date</label>
                <input type="date" class="form-control" name="expiryDate" value="<%= voucher.getExpiryDate() %>" required>
            </div>

            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="VoucherServlet?action=list" class="btn btn-secondary">Cancel</a>
        </form>
        <%
            }
        %>
    </div>
</body>
</html>
