<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Order</title>

        <!-- Thư viện Bootstrap & Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <!-- File CSS của dự án -->
        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css">

        <style>
            .container.edit-order {
                max-width: 500px;
                padding: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease-in-out;
                margin-top: 50px;
            }

            .container.edit-order:hover {
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                transform: translateY(-5px);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                font-size: 28px;
                font-weight: 700;
                color: #ff7f50;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                font-size: 15px;
                color: #555;
            }

            input[type="text"],
            select {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                background-color: #f9f9f9;
                color: #333;
                transition: border-color 0.3s ease;
            }

            input[type="text"]:focus,
            select:focus {
                border-color: #007bff;
                outline: none;
            }

            button[type="submit"] {
                display: block;
                width: 100%;
                padding: 14px;
                background: linear-gradient(90deg, #b29f7d, #6e6e6e);
                color: white;
                border: none;
                border-radius: 50px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 10px;
                transition: all 0.3s ease;
            }

            button[type="submit"]:hover {
                transform: translateY(-3px);
            }
        </style>
    </head>

    <body>

        <div class="container edit-order">
            <h2>Edit Order</h2>

            <form action="OrderUpdateServlet" method="post">
                <div class="form-group">
                    <label for="orderID">Order ID</label>
                    <input type="text" name="orderID" value="${order.orderID}" readonly>
                </div>

                <div class="form-group">
                    <label for="userName">User Name</label>
                    <input type="text" name="userName" value="${order.customer.customerName}" readonly>
                </div>

                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" pattern="\d{10}" name="phone" value="${order.phone}" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" name="address" value="${order.address}" required>
                </div>

                <div class="form-group">
                    <label for="statusDL">Status Delivery</label>
                    <select name="statusDL" required>
                        <option value="PACK" ${order.statusDL == 'PACK' ? 'selected' : ''}>PACK</option>
                        <option value="DELIVERY" ${order.statusDL == 'DELIVERY' ? 'selected' : ''}>DELIVERY</option>
                        <option value="CANCELLED" ${order.statusDL == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                        <option value="COMPLETED" ${order.statusDL == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select name="status" required>
                        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        <option value="COMPLETED" ${order.status == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                    </select>
                </div>

                <button type="submit">Save Changes</button>
            </form>
        </div>

    </body>
</html>
