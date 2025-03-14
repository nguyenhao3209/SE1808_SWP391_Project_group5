<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="shortcut icon" type="image/x-icon" href="img/iconAdmin.webp" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Category Management</title>

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

        <!-- CSS tùy chỉnh để chỉnh màu chữ và khoảng cách nút -->
        <style>
            /* Đổi màu chữ tiêu đề bảng thành trắng */
            .table.table-bordered thead.table-dark th {
                color: #fff !important;
            }
            /* Tạo khoảng cách giữa nút Edit và Delete (nếu sau này thêm Delete) */
            .btn-edit {
                margin-right: 8px;
            }
        </style>
    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header + Sidebar (chỉnh lại đường dẫn nếu cần) -->
        <jsp:include page="common/header.jsp" />
        <jsp:include page="common/sidebar.jsp" />

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <!-- Breadcrumb -->
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Category Management</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Category Management</li>
                    </ul>
                </div>

                <!-- Button to Add New Category -->
                <!-- Gọi Servlet hiển thị form create: CategoryServlet?action=createForm -->
                <a href="CategoryServlet?action=createForm" class="btn btn-success mb-3">Add New Category</a>

                <!-- Content Row -->
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Manage Categories</h4>
                            </div>
                            <div class="widget-inner">
                                <!-- NỘI DUNG CHÍNH: DANH SÁCH CATEGORY -->
                                <div class="container">
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Category Name</th>
                                                    <th>Description</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Nếu danh sách category rỗng, hiển thị thông báo -->
                                                <c:choose>
                                                    <c:when test="${not empty categoryList}">
                                                        <c:forEach var="c" items="${categoryList}">
                                                            <tr>
                                                                <td>${c.categoryID}</td>
                                                                <td>${c.categoryName}</td>
                                                                <td>${c.description}</td>
                                                                <td>
                                                                    <!-- Ở đây chỉ có nút Edit, chưa có delete -->
                                                                    <a href="CategoryServlet?action=edit&id=${c.categoryID}"
                                                                       class="btn btn-warning btn-sm btn-edit">
                                                                        Edit
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <!-- colspan = 4 để khớp với số cột ở <thead> -->
                                                            <td colspan="4" class="text-center">
                                                                No categories found.
                                                            </td>
                                                        </tr>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- END TABLE -->
                                </div>
                                <!-- END .container -->
                            </div>
                            <!-- END .widget-inner -->
                        </div>
                        <!-- END .widget-box -->
                    </div>
                </div>
                <!-- End Content Row -->
            </div>
            <!-- End container-fluid -->

            <div class="ttr-overlay"></div>
        </main>
        <!-- main end -->

        <!-- External JavaScripts (dùng chung với dashboard) -->
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
