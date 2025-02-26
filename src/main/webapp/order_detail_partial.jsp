<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <p><strong>Order ID:</strong> ${order.orderID}</p>
    <p><strong>Customer Name:</strong> ${order.customer.customerName}</p>
    <p><strong>Phone:</strong> ${order.customer.phone}</p>
    <p><strong>Date:</strong> ${order.createAt}</p>
    <p><strong>Total Amount:</strong> $${order.totalPrice}</p>


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
