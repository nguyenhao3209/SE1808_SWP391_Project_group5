<%-- 
    Document   : newsDetailManagement
    Created on : Mar 3, 2025, 9:54:37 PM
    Author     : LENOVO
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News Management</title>
        <link rel="stylesheet" href="assets/css/style.css"> <!-- Thay thế CSS của template -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

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


    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
            <!-- header end -->
            <!-- Left sidebar menu start -->
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>
            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">News Management</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>List News</li>
                            <li>News Detail</li>
                        </ul>
                    </div>
                </div>
                <div class="container">
                    <h1 class="text-center">${news.title}</h1>
                <div class="news-content">
                    <img src="${news.image}" alt="${news.title}" />
                    <p><strong>Author:</strong> ${news.author}</p>
                    <p><strong>Email:</strong> ${news.staff.email}</p>
                    <c:forEach var="content" items="${newsDetail}">
                        <p>${content}</p>
                    </c:forEach>
                </div>
                <a href="news-management" class="back-link"><i class="bi bi-arrow-left"></i> Back to News List</a>
            </div>

            <!-- Bootstrap JS -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
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