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
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container-fluid {
                padding: 20px;
            }

            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }

            .db-breadcrumb {
                margin-bottom: 20px;
            }

            .db-breadcrumb-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .db-breadcrumb-list li {
                display: inline;
                margin-right: 5px;
            }

            .db-breadcrumb-list li a {
                text-decoration: none;
                color: #333;
            }

            .db-breadcrumb-list li a:hover {
                text-decoration: underline;
            }

            /* Form Styles */
            form {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: 0 auto;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            textarea,
            input[type="file"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }

            textarea {
                resize: vertical;
                height: 150px;
            }

            input[type="file"] {
                padding: 5px;
            }

            .btn {
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

            .btn:hover {
                background-color: #0056b3;
            }

            /* Image Preview Styles */
            img {
                max-width: 100%;
                height: auto;
                margin-bottom: 10px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            /* Responsive Styles */
            @media (max-width: 768px) {
                form {
                    padding: 15px;
                }

                input[type="text"],
                textarea,
                input[type="file"] {
                    font-size: 14px;
                }

                .btn {
                    width: 100%;
                }
            }
        </style>
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
                            <li>Update News</li>
                        </ul>
                    </div>
                </div>
                <div>
                    <h1>Update News</h1>
                    <form action="update-news" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="newsID" value="${news.newsID}">
                    <div class="form-group">
                        <label for="staffID">Staff ID:</label>
                        <input type="text" name="staffID" id="staffID" value="${news.staff.staffID}" readonly>
                    </div>

                        <div class="form-group">
                            <label for="author">Author:</label>
                            <input type="text" name="author" id="author" value="${news.author}" readonly>
                        </div>

                        <div class="form-group">
                            <label for="title">Title:</label>
                            <input type="text" name="title" id="title" value="${news.title}" required>
                        </div>

                        <div class="form-group">
                            <label for="content">Content:</label>
                            <textarea name="content" id="content" required>${news.content}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="image">Image:</label>
                            <c:if test="${not empty news.image}">
                                <p>Current Image: ${news.image}</p>
                            </c:if>
                            <input type="file" name="image" id="image" accept="image/*">
                        </div>

                        <div class="form-group">
                            <label for="filePath">File DOCX:</label>
                            <c:if test="${not empty news.filePath}">
                                <p>Current File: ${news.filePath}</p>
                            </c:if>
                            <input type="file" name="filePath" id="filePath" accept=".docx">
                        </div>

                        <button type="submit" class="btn">Update News</button>
                </form>
            </div>
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