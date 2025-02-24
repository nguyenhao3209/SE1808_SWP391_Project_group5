<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Details</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#orderDetailModal">
                View Order Details
            </button>

            <!-- Modal -->
            <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="orderDetailModalLabel">Order Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <c:forEach var="order" items="${order}">
                                <p><strong>Order ID:</strong> ${order.orderID}</p>
                                <p><strong>Customer Name:</strong> ${order.customer.customerName}</p>
                                <p><strong>Phone:</strong> ${order.customer.phone}</p>
                                <p><strong>Date:</strong> ${order.createAt}</p>
                                <p><strong>Total Amount:</strong> $${order.totalPrice}</p>
                                </c:forEach> 
                                <h5>Products</h5>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Product ID</th>
                                            <th>Product Name</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="orderDetails" items="${orderDetails}">
                                            <tr>
                                                <td>${orderDetails.product.productID}</td>
                                                <td>${orderDetails.product.productName}</td>
                                                <td>${orderDetails.quantity}</td>
                                                <td>${orderDetails.product.price}</td>
                                            </tr>
                                        </c:forEach>                                
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>
