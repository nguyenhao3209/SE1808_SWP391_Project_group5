<%-- 
    Document   : payment_method
    Created on : Feb 16, 2024, 3:16:53 PM
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Arial', sans-serif;
            }
            .container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-top: 30px;
            }
            .left-column, .right-column {
                background: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 20px;
                flex: 1;
                min-width: 300px;
            }
            .left-column {
                flex: 2;
            }
            .right-column {
                flex: 1;
            }
            .invoice-title {
                font-size: 28px;
                font-weight: bold;
                color: #333333;
                margin-bottom: 20px;
            }
            .table th {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                text-align: center;
                border: 1px solid #dee2e6;
            }
            .table td {
                vertical-align: middle;
                text-align: center;
                border: 1px solid #dee2e6;
            }
            .total-row {
                font-weight: bold;
            }
            .payment-method-title {
                font-size: 20px;
                margin-top: 20px;
                font-weight: bold;
            }
            .btn-submit {
                font-size: 16px;
                font-weight: bold;
                padding: 10px 20px;
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
        <c:if test="${empty sessionScope.cartList}">
            <p style="color:red;">Cart is empty</p>
        </c:if>
        <div class="container">
            <!-- Left Column: Invoice Details -->
            <div class="left-column">
                <h1 class="invoice-title">Invoice Details</h1>
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="item" items="${sessionScope.cartList}">
                            <tr>
                                <td>${item.product.productName}</td>
                                <td>
                                    <c:if test="${item.product.discountProduct > 0}">
                                        <div class="product-price">
                                            <span class="original-price"><fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" /> VND</span><br/>
                                            <span class="product-price discounted-price text-success fw-bold">$<fmt:formatNumber value="${String.format('%f', item.product.price * (1 - item.product.discountProduct / 100))}" pattern="###,##0.00" /></span>
                                        </div>
                                    </c:if>
                                    <c:if test="${item.product.discountProduct le 0}">
                                        <div class="product-price">$<fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" /></div>
                                    </c:if>
                                </td>
                                <td>${item.quantity}</td>
                                <td>
                                    $<fmt:formatNumber value="${item.quantity * (item.product.price * (1 - item.product.discountProduct / 100))}" pattern="###,##0.00" />
                                </td>
                            </tr>
                        </c:forEach>
                        <!-- Grand Total Row -->
                        <tr class="total-row">
                            <td colspan="2" class="text-end">Total</td>
                            <td colspan="2">
                                $<fmt:formatNumber value="${sessionScope.brandTotal}" pattern="###,##0.00" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Right Column: User Information and Payment Method -->
            <div class="right-column">
                <h3 class="payment-method-title">Customer Information</h3>
                <form action="payment" method="post">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <th>Name</th>
                                <td>${sessionScope.user.customerName}</td>
                            </tr>
                            <tr>
                                <th>Email</th>
                                <td>${sessionScope.user.email}</td>
                            </tr>
                            <tr>
                                <th>Phone</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty sessionScope.user.phone}">
                                            <input type="text" name="phoneNumber" class="form-control" placeholder="Enter your phone number" required>
                                        </c:when>
                                        <c:otherwise>
                                            ${sessionScope.user.phone}
                                            <input type="hidden" value="${sessionScope.user.phone}">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th>Address</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${empty sessionScope.user.address}">
                                            <input type="text" name="address" class="form-control" placeholder="Enter your address" required>
                                        </c:when>
                                        <c:otherwise>
                                            ${sessionScope.user.address}
                                            <input type="hidden" value="${sessionScope.user.address}">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <h2 class="payment-method-title mt-4">Choose Payment Method</h2>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="Credit_Card" required>
                        <label class="form-check-label" for="creditCard">Credit Card</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="MoMo">
                        <label class="form-check-label" for="paypal">VNpay</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="cashOnDelivery" value="Cash_On_Delivery">
                        <label class="form-check-label" for="cashOnDelivery">Cash on Delivery</label>
                    </div>

                    <!-- Submit Button -->
                    <div class="text-end mt-3">
                        <button type="submit" class="btn btn-primary btn-submit">Confirm & Pay</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
