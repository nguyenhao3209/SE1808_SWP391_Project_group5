<%-- 
    Document   : stock-view
    Created on : Mar 6, 2025, 3:43:23 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />
        <base href="${pageContext.request.contextPath}/">
        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="img/iconAdmin.webp" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Stock management</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">
        <style>
            .filters {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-bottom: 15px;
            }

            .filters input,
            .filters select {
                padding: 5px;
                font-size: 14px;
                color: black !important;
                background-color: white !important;
                border: 1px solid #ccc !important;
                cursor: pointer !important;
            }

            /* Khi focus hoặc hover vào select */
            .filters select:focus,
            .filters select:hover {
                color: black !important;
                background-color: white !important;
                border: 1px solid #000 !important; /* Viền đen để nhìn rõ */
                outline: none !important;
            }

            /* Chắc chắn các option cũng là màu đen */
            .filters select option {
                color: black !important;
                background-color: white !important;
            }
        </style>

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>
            <main class="ttr-wrapper">
                <div class="container">
                    <h2 class="my-4">Stock Management</h2>
                    <div class="filters">
                        <input type="text" id="searchKeyword" placeholder="Search by ID or Name">

                        <select id="categoryFilter">
                            <option value="">Filter by Category</option>
                        <c:forEach var="category" items="${categoryList}">
                            <option value="${category.categoryID}">${category.categoryName}</option>
                        </c:forEach>
                    </select>

                    <select id="brandFilter">
                        <option value="">Filter by Brand</option>
                        <c:forEach var="brand" items="${brandList}">
                            <option value="${brand}">${brand}</option>
                        </c:forEach>
                    </select>

                    <select id="sortStock">
                        <option value="">Sort by Quantity</option>
                        <option value="asc">Ascending</option>
                        <option value="desc">Descending</option>
                    </select>

                    <select id="sortDate">
                        <option value="">Sort by Import Date</option>
                        <option value="asc">Oldest First</option>
                        <option value="desc">Newest First</option>
                    </select>
                </div>

                <div style="height: 800px;" id="stockTableContainer">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Image</th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Brand</th>
                                <th>Quantity</th>
                                <th>Import Date</th>
                            </tr>
                        </thead>
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
                                    <td>
                                        <input type="number" class="update-stock-input" data-id="${stock.productID}" value="${stock.stockQuantity}" min="0">
                                        <button class="update-stock-btn btn btn-sm btn-primary" data-id="${stock.productID}">Update</button>
                                    </td>
                                    <td>${stock.importDate}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-center">
                    <c:if test="${totalPages > 1}">
                        <nav>
                            <ul class="pagination" id="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link pagination-link" href="#" data-page="${currentPage - 1}">&laquo;</a>
                                    </li>
                                </c:if>

                                <c:forEach begin="${(currentPage - 2) > 1 ? currentPage - 2 : 1}" 
                                           end="${(currentPage + 2) < totalPages ? currentPage + 2 : totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link pagination-link" href="#" data-page="${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link pagination-link" href="#" data-page="${currentPage + 1}">&raquo;</a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </div>

            </div>
        </main>
        <!-- External JavaScripts -->
        <script src="admin/assets/js/jquery.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="admin/assets/vendors/masonry/masonry.js"></script>
        <script src="admin/assets/vendors/masonry/filter.js"></script>
        <script src="admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="admin/assets/vendors/scroll/scrollbar.min.js"></script>
        <script src="admin/assets/js/functions.js"></script>
        <script src="admin/assets/vendors/chart/chart.min.js"></script>
        <script src="admin/assets/js/admin.js"></script>
        <script src="admin/assets/vendors/calendar/moment.min.js"></script>
        <script src="admin/assets/vendors/calendar/fullcalendar.js"></script>
        <script src="admin/assets/vendors/switcher/switcher.js"></script>
        <script>
            function fetchFilteredData(page = 1) {
                let keyword = $("#searchKeyword").val().trim();
                let sortStock = $("#sortStock").val();
                let sortDate = $("#sortDate").val();
                let categoryID = $("#categoryFilter").val();
                let brand = $("#brandFilter").val();

                $.ajax({
                    url: "stockProductsPagination",
                    type: "GET",
                    data: {page, keyword, sortStock, sortDate, categoryID, brand},
                    success: function (data) {
                        $("#stockTableContainer").html($(data).find("#stockTableContainer").html());
                        $("#pagination").html($(data).find("#pagination").html());
                    },
                    error: function (xhr, status, error) {
                        console.error("Error:", xhr.responseText);
                    }
                });
            }

            $(document).ready(function () {
                let debounceTimer;

                $("#searchKeyword").on("input", function () {
                    clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => fetchFilteredData(), 500);
                });

                $("#sortStock, #sortDate, #categoryFilter, #brandFilter").on("change", function () {
                    fetchFilteredData();
                });

                $(document).on("click", ".pagination-link", function (e) {
                    e.preventDefault();
                    let page = $(this).data("page");
                    fetchFilteredData(page);
                });
            });

            $(document).ready(function () {
                $(document).on("click", ".update-stock-btn", function () {
                    let productID = $(this).data("id");
                    let newQuantity = $(this).siblings(".update-stock-input").val();

                    if (newQuantity < 0 || isNaN(newQuantity)) {
                        alert("Số lượng không hợp lệ!");
                        return;
                    }

                    $.ajax({
                        url: "updateStock",
                        type: "POST",
                        data: {productID, newQuantity},
                        success: function (response) {
                            if (response.success) {
                                alert("Update successfully!");
                                fetchFilteredData(); // Làm mới bảng sau khi cập nhật
                            } else {
                                alert("Failled!");
                            }
                        },
                        error: function (xhr) {
                            alert("Error equirment!");
                            console.error(xhr.responseText);
                        }
                    });
                });
            });

        </script>
    </body>
</html>