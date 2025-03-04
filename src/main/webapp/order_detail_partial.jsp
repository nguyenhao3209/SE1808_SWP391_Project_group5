<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<p><strong>Order ID: </strong> ${order.orderID}</p>
<p><strong>Customer Name: </strong> ${order.customer.customerName}</p>
<p><strong>Phone: </strong> ${order.customer.phone}</p>
<p><strong>Date: </strong> ${order.createAt}</p>
<p><strong>Total Amount: </strong> $${order.totalPrice}</p>

<head>
    <style>

        body {
            font-family: 'Arial', sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f3f2ec;
            color: #333;
        }

        /* Tiêu ?? */
        h5 {
            margin-top: 15px;
            font-size: 18px; /* Nh? h?n m?t chút */
            color: #E0A96D; /* Màu xanh lá nh? */
            border-left: 4px solid #5ABA68;
            padding-left: 8px;
            display: flex;
            align-items: center;
        }

        h5 i {
            margin-right: 6px;
            color: #5ABA68;
        }

        /* Thông tin ??n hàng */
        p {
            font-size: 14px; /* Nh? h?n */
            margin: 6px 0;
            background: #fff;
            padding: 8px;
            border-radius: 5px;
            box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }

        p i {
            margin-right: 6px;
            color: #5ABA68;
        }

        /* B?ng hi?n th? s?n ph?m */
        .table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        /* Header c?a b?ng */
        .table th {
            background-color: 	#C49A6C; /* Màu xanh lá nh? */
            color: #fff;
            font-weight: 600;
            padding: 10px; /* Gi?m padding */
            text-transform: uppercase;
            text-align: center;
            font-size: 14px;
        }

        /* Dòng c?a b?ng */
        .table td {
            border-bottom: 1px solid #dee2e6;
            padding: 8px; /* Gi?m padding */
            text-align: center;
            font-size: 14px;
        }

        /* Dòng xen k? */
        .table tbody tr:nth-child(even) {
            background-color: #eceae0;
        }

        /* Hi?u ?ng hover */
        .table tbody tr:hover {
            background-color: #dcd9c9;
            transition: 0.3s ease-in-out;
        }

        /* Hi?u ?ng góc bo */
        .table th:first-child, .table td:first-child {
            border-left: none;
        }
        .table th:last-child, .table td:last-child {
            border-right: none;
        }
    </style>
</head>
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
        <c:forEach var="details" items="${orderDetails}">
            <tr>
                <td>${details.product.productID}</td>
                <td>${details.product.productName}</td>
                <td>${details.quantity}</td>
                <td>$${details.price}</td>
            </tr>
        </c:forEach>                                
    </tbody>
</table>
