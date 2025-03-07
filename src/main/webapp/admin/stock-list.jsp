<%-- 
    Document   : stock-list
    Created on : Mar 6, 2025, 4:58:45 PM
    Author     : HAO
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Danh sách sản phẩm -->
<tbody id="stockTableBody">
    <c:forEach var="stock" items="${stockList}">
        <tr>
            <td>
                <c:if test="${stock.category.categoryName eq 'Accessory'}">
                    <img width="50px" src="./img/${stock.category.categoryName}/${stock.getImageURL()}" alt="${stock.productName}">
                </c:if>
                <c:if test="${stock.category.categoryName ne 'Accessory'}">
                    <img width="50px" src="./img/${stock.category.categoryName}/${stock.brand}/${stock.getImageURL()}" alt="${stock.productName}">
                </c:if>
            </td>
            <td>${stock.productID}</td>
            <td>${stock.productName}</td>
            <td>${stock.category.categoryName}</td>
            <td>${stock.brand}</td>
            <td>${stock.stockQuantity}</td>
            <td>${stock.importDate}</td>
        </tr>
    </c:forEach>
</tbody>

<!-- Phân trang -->
<nav id="pagination">
    <ul class="pagination">
        <!-- Nút Previous -->
        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link pagination-link" href="#" data-page="${currentPage - 1}">Previous</a>
        </li>

        <!-- Danh sách trang -->
        <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${i == currentPage ? 'active' : ''}">
                <a class="page-link pagination-link" href="#" data-page="${i}">${i}</a>
            </li>
        </c:forEach>

        <!-- Nút Next -->
        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link pagination-link" href="#" data-page="${currentPage + 1}">Next</a>
        </li>
    </ul>
</nav>

