<%-- 
    Document   : ListSearch
    Created on : Mar 4, 2025, 12:52:03 AM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .table-container {
                max-height: 400px; /* Giới hạn chiều cao bảng */
                overflow-y: auto;  /* Tạo thanh cuộn dọc nếu danh sách quá dài */
                border: 1px solid #ccc;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }
            thead {
                position: sticky;
                top: 0;
                color: white;
                z-index: 2; /* Đảm bảo header nằm trên cùng */
            }
            img {
                width: 50px;
                height: auto;
            }
            .select-btn {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 3px;
            }
            .select-btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${not empty productList}">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>ID</th>
                                <th>Product Name</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Stock</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${productList}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${product.category.categoryName eq 'Accessory'}">
                                                <img src="./img/${product.category.categoryName}/${product.getImageURL()}" alt="${product.productName}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="./img/${product.category.categoryName}/${product.brand}/${product.getImageURL()}" alt="${product.productName}">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${product.productID}</td>
                                    <td>${product.productName}</td>
                                    <td>${product.category.categoryName}</td>
                                    <td>${product.brand}</td>
                                    <td>${product.stockQuantity}</td>
                                    <td>
                                        <button type="button" class="select-btn" data-id="${product.productID}" data-name="${product.productName}" data-category="${product.category.categoryName}" data-brand="${product.brand}" data-quantity="${product.stockQuantity}">Select</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results">No products found.</div>
            </c:otherwise>
        </c:choose>

        <script>
            
        </script>
    </body>
</html>
