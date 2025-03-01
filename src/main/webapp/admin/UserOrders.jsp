<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<h3>Customer Orders</h3>
<table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer Name</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Total Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="orders" items="${listorders}">
                                    <tr>
                                        <td>${orders.orderID}</td>
                                        <td>${orders.customer.customerName}</td>
                                        <td>${orders.createAt}</td>
                                        <td class="order-status">${orders.status.trim()}</td>
                                        <td>$${orders.totalPrice}</td>


                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>