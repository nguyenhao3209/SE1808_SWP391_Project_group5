<%-- 
    Document   : listProducts.jsp
    Created on : Feb 26, 2025, 10:02:07 PM
    Author     : HuyLVQCE180656
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
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

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Products Management</title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">



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



    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"/>
        <jsp:include page="../admin/common/sidebar.jsp"/>

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Products Management</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Products Management</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Products Management</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="container">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h2>Products Management</h2>
                                        <form action="adminSearchProduct" method="GET" class="d-flex">
                                            <input type="text" class="form-control me-2" name="searchQuery" id="searchInput" 
                                                   placeholder="Search by product name..." value="${searchQuery}" style="width: 400px;">
                                            <button type="submit" class="btn btn-primary">Search</button>
                                        </form>
                                    </div>

                                    <div class="table-responsive">
                                        <table id="productTable" class="table table-striped table-bordered text-center">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th style="width: 10%;">Product ID</th>
                                                    <th style="width: 15%;">Image</th>
                                                    <th>Product Name</th>
                                                    <th style="width: 10%;">Brand</th>
                                                    <th style="width: 10%;">Price</th>
                                                    <th style="width: 18%;">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="productTableBody">
                                                <c:choose>
                                                    <c:when test="${empty productList}">
                                                        <tr>
                                                            <td colspan="6" class="text-center">List is empty.</td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="product" items="${productList}">
                                                            <tr>
                                                                <td class="align-middle">${product.productID}</td>
                                                                <td class="align-middle">
                                                                    <c:if test="${product.category.categoryName eq 'Accessory'}">
                                                                        <img src="./img/${product.category.categoryName}/${product.getImageURL()}" alt="${product.productName}">
                                                                    </c:if>
                                                                    <c:if test="${product.category.categoryName ne 'Accessory'}">
                                                                         <img src="./img/${product.category.getCategoryName()}/${product.brand}/${product.imageURL}" alt="${product.productName}">
                                                                    </c:if>
                                                                </td>
                                                                <td class="align-middle">${product.productName}</td>
                                                                <td class="align-middle">${product.brand}</td>
                                                                <td class="align-middle">${product.price} $</td>
                                                                <td class="align-middle">
                                                                    <a href="editProduct?productId=${product.productID}" class="btn btn-warning btn-sm">Edit</a>
                                                                    <a href="deleteProduct?productId=${product.productID}" class="btn btn-danger btn-sm"
                                                                       onclick="return confirm('Are you sure you want to delete?');">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <ul class="pagination mb-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a href="adminSearchProduct?searchQuery=${searchQuery}&page=${currentPage - 1}" class="page-link">&laquo;</a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="page" begin="${startPage}" end="${endPage}">
                                            <li class="page-item ${page == currentPage ? 'active' : ''}">
                                                <a href="adminSearchProduct?searchQuery=${searchQuery}&page=${page}" class="page-link">${page}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a href="adminSearchProduct?searchQuery=${searchQuery}&page=${currentPage + 1}" class="page-link">&raquo;</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <div class="ttr-overlay"></div>

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
    </body>
</html>
