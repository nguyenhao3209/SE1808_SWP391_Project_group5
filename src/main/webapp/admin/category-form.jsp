<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
        <title>Category Form</title>

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

        <!-- CSS tùy chỉnh -->
        <style>
            .mb-3 {
                margin-bottom: 1rem;
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
                        <li>Category Form</li>
                    </ul>
                </div>

                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <!-- Xác định đang Edit hay Create -->
                                <c:set var="isEdit" value="${not empty category}" />
                                <h4>
                                    <c:choose>
                                        <c:when test="${isEdit}">Edit Category</c:when>
                                        <c:otherwise>Add New Category</c:otherwise>
                                    </c:choose>
                                </h4>
                            </div>
                            <div class="widget-inner">
                                <!-- Thông báo lỗi nếu có -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">${errorMessage}</div>
                                </c:if>

                                <!-- Form: dùng cùng 1 form cho cả Create lẫn Edit -->
                                <form action="CategoryServlet" method="post">
                                    <!-- Xác định action gửi lên servlet -->
                                    <c:choose>
                                        <c:when test="${isEdit}">
                                            <input type="hidden" name="action" value="update" />
                                            <input type="hidden" name="categoryID" value="${category.categoryID}" />
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="create" />
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- Category Name -->
                                    <div class="mb-3">
                                        <label class="form-label">Category Name</label>
                                        <input type="text" class="form-control" name="categoryName" required
                                               value="${isEdit ? category.categoryName : ''}">
                                    </div>

                                    <!-- Description -->
                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3">
                                            <c:out value='${isEdit ? category.description : ""}'/>
                                        </textarea>
                                    </div>

                                    <!-- Submit Button -->
                                    <button type="submit" class="btn btn-primary">
                                        <c:choose>
                                            <c:when test="${isEdit}">Update</c:when>
                                            <c:otherwise>Add</c:otherwise>
                                        </c:choose>
                                        Category
                                    </button>
                                    <a href="CategoryServlet?action=list" class="btn btn-secondary">Cancel</a>
                                </form>
                                <!-- End Form -->
                            </div>
                            <!-- END .widget-inner -->
                        </div>
                        <!-- END .widget-box -->
                    </div>
                </div>
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
