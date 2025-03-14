<%-- 
    Document   : view-imported-details
    Created on : Mar 7, 2025, 12:42:14 AM
    Author     : HAO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table border="1" class="table">
    <thead>
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Size</th>
            <th>Price</th>
            <th>Subtotal</th>
        </tr>
    </thead>
    <tbody>
        <c:set var="total" value="0"/>
        <c:forEach var="detail" items="${detailsList}">
            <c:set var="subtotal" value="${detail.quantity * detail.costPrice}" />
            <c:set var="total" value="${total + subtotal}" />
            <tr>
                <td>${detail.product.productID}</td>
                <td>${detail.product.productName}</td>
                <td>${detail.quantity}</td>
                <td><c:if test="${not empty detail.size}">${detail.size.size}</c:if></td>
                <td>$${detail.costPrice}</td>
                <td>$${subtotal}</td>
            </tr>
        </c:forEach>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="5" align="right"><strong>Total:</strong></td>
            <td><strong>$${total}</strong></td>
        </tr>
    </tfoot>
</table>

