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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <!-- Xoá hoặc sửa dòng dưới nếu không tồn tại error-404.html -->
        <!-- <link rel="icon" href="../error-404.html" type="image/x-icon" /> -->
        <link rel="shortcut icon" type="image/x-icon" href="img/iconAdmin.webp" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Voucher Management</title>

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
            /* Tạo khoảng cách giữa nút Edit và Delete */
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
                    <h4 class="breadcrumb-title">Voucher Management</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Voucher Management</li>
                    </ul>
                </div>
                <!-- Button to Add New Voucher -->
                <a href="admin/voucher-form.jsp" class="btn btn-success mb-3">Add New Voucher</a>
                <!-- Content Row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Manage Vouchers</h4>
                            </div>
                            <div class="widget-inner">
                                <!-- NỘI DUNG CHÍNH: DANH SÁCH VOUCHER -->
                                <div class="container-fluid ">
                                    <!-- Button to Add New Voucher -->
                                    <!-- CHỈNH SỬA: Dùng Servlet action=add thay vì gọi trực tiếp voucher-form.jsp -->


                                    <!-- Display Voucher List -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Description</th>
                                                    <th>Discount %</th>
                                                    <th>Max Reducing</th>
                                                    <th>Code</th>
                                                    <th>Quantity</th>
                                                    <th>Expiry Date</th>
                                                    <th>Is Active</th>
                                                    <th>Min Order Value</th>
                                                    <th>Max Usage/User</th>
                                                    <th>Usage Count</th>
                                                    <th>Image</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Nếu danh sách voucher rỗng, hiển thị thông báo -->
                                                <c:choose>
                                                    <c:when test="${not empty voucherList}">
                                                        <c:forEach var="v" items="${voucherList}">
                                                            <tr>
                                                                <td>${v.voucherID}</td>
                                                                <td>${v.name}</td>
                                                                <td>${v.description}</td>
                                                                <td>${v.discountPercentage}</td>
                                                                <td>${v.maxReducing}</td>
                                                                <td>${v.code}</td>
                                                                <td>${v.quantity}</td>
                                                                <td>${v.expiryDate}</td>
                                                                <td>${v.isActive}</td>
                                                                <td>${v.minOrderValue}</td>
                                                                <td>${v.maxUsagePerUser}</td>
                                                                <td>${v.usageCount}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${not empty v.imageURL}">
                                                                            <img src="${v.imageURL}" 
                                                                                 alt="Voucher Image" 
                                                                                 width="80" 
                                                                                 height="80" />
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            No image
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <div style="display: flex; flex-direction: row; align-items: center;">
                                                                        <a href="VoucherServlet?action=edit&id=${v.voucherID}"
                                                                           class="btn mr-1">
                                                                             <i class="fas fa-pen"></i>
                                                                        </a>
                                                                        <a href="VoucherServlet?action=delete&id=${v.voucherID}"
                                                                           class="btn"
                                                                           onclick="return confirm('Are you sure you want to delete this voucher?');">
                                                                            <i class="fas fa-trash"></i>
                                                                        </a>
                                                                    </div>
                                                                </td>

                                                            </tr>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <tr>
                                                            <!-- colspan = 14 để khớp với số cột ở <thead> -->
                                                            <td colspan="14" class="text-center">
                                                                No vouchers found.
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
