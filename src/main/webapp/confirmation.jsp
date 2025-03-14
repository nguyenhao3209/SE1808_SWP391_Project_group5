<%-- 
    Document   : confirmation
    Created on : Feb 16, 2025, 9:56:17 PM
    Author     : HAO
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
        <!-- Thư viện Font Awesome để sử dụng các icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/iconHome.webp" />
        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .invoice-container {
                max-width: 800px;
                margin: 50px auto;
                background: #ffffff;
                padding: 20px 30px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .invoice-header {
                text-align: center;
                margin-bottom: 20px;
            }
            .invoice-header img {
                max-width: 100px;
                margin-bottom: 10px;
            }
            .invoice-title {
                font-size: 24px;
                font-weight: bold;
                color: #007bff;
            }
            .table th, .table td {
                padding: 10px;
                vertical-align: middle;
                border: 1px solid #dee2e6;
            }
            .table th {
                background-color: #007bff;
                color: white;
                text-align: center;
            }
            .table td {
                text-align: center;
            }
            .total-row {
                font-weight: bold;
                font-size: 18px;
            }
            .thank-you {
                text-align: center;
                margin-top: 20px;
                font-size: 16px;
                font-style: italic;
                color: #333;
            }
            .btn-home {
                margin-top: 20px;
                display: block;
                width: 100%;
                text-align: center;
                padding: 10px;
                background-color: #007bff;
                color: white;
                font-weight: bold;
                text-decoration: none;
                border-radius: 5px;
            }
            .btn-home:hover {
                background-color: #0056b3;
            }
            .original-price {
                text-decoration: line-through;
                color: red;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="common/header.jsp"/>
        <div style="margin-top: 120px;"  class="invoice-container">
            <!-- Header with Logo -->
            <div class="invoice-header">
                <img src="./img/logo4.png" alt="Company Logo" width="80" height="80">
                <h1 class="invoice-title">Invoice</h1>
            </div>

            <!-- Customer Info -->
            <table class="table">
                <tbody>
                    <tr>
                        <th>Customer Name</th>
                        <td>${sessionScope.user.customerName}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${sessionScope.user.email}</td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td>${sessionScope.user.phone}</td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td>${sessionScope.user.address}</td>
                    </tr>
                    <tr>
                        <th>Payment Method</th>
                        <td>${paymentMethod}</td>
                    </tr>
                </tbody>
            </table>

            <!-- Order Summary -->
            <h4 class="mt-4">Order Summary</h4>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Product Name</th>
                        <th>Price ($)</th>
                        <th>Quantity</th>
                        <th>Subtotal ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.cartList}" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${item.product.productName}</td>
                            <td>
                                <c:if test="${item.product.discountProduct > 0}">
                                    <div class="product-price">
                                        <span class="original-price"><fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" />$</span><br/>
                                        <span class="discounted-price text-success fw-bold"><fmt:formatNumber value="${String.format('%f', item.product.price * (1 - item.product.discountProduct / 100))}" pattern="###,##0.00" />$</span>
                                    </div>
                                </c:if>
                                <c:if test="${item.product.discountProduct le 0}">
                                    <div class="product-price"><fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" />$</div>
                                </c:if>
                            </td>
                            <td>
                                ${item.quantity}
                            </td>
                            <td>
                                <c:if test="${item.product.discountProduct > 0}">
                                    <fmt:formatNumber value="${item.quantity * item.product.price * (1 - item.product.discountProduct / 100)}" pattern="###,##0.00" />
                                </c:if>
                                <c:if test="${item.product.discountProduct le 0}">
                                    <fmt:formatNumber value="${item.quantity * item.product.price}" pattern="###,##0.00" />
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr class="total-row">
                        <td colspan="4" class="text-end">Grand Total</td>
                        <td>
                            <fmt:formatNumber value="${sessionScope.brandTotal}" pattern="###,##0.00" />
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Thank You Section -->
            <p class="thank-you">Thank you for your purchase! We hope to see you again.</p>
        </div>
        <jsp:include page="common/footer.jsp"/>
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
    </body>
</html>
