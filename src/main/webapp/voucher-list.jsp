<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="Models.Vouchers" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Voucher List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Manage Vouchers</h2>

            <!-- Button to Add New Voucher -->
            <a href="voucher-form.jsp" class="btn btn-success mb-3">Add New Voucher</a>

            <!-- Display Voucher List -->
            <table class="table table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Discount %</th>
                        <th>Max Reducing</th>
                        <th>Code</th>
                        <th>Quantity</th>
                        <th>Expiry Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Vouchers> voucherList = (List<Vouchers>) request.getAttribute("voucherList");
                        if (voucherList != null && !voucherList.isEmpty()) {
                            for (Vouchers v : voucherList) {
                    %>
                    <tr>
                        <td><%= v.getVoucherID()%></td>
                        <td><%= v.getName()%></td>
                        <td><%= v.getDescription()%></td>
                        <td><%= v.getDiscountPercentage()%></td>
                        <td><%= v.getMaxReducing()%></td>
                        <td><%= v.getCode()%></td>
                        <td><%= v.getQuantity()%></td>
                        <td><%= v.getExpiryDate()%></td>
                        <td>
                            <a href="VoucherServlet?action=edit&id=<%= v.getVoucherID()%>" class="btn btn-warning btn-sm">Edit</a>
                            <a href="VoucherServlet?action=delete&id=<%= v.getVoucherID()%>" class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to delete this voucher?');">Delete</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center">No vouchers found.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </body>
</html>
