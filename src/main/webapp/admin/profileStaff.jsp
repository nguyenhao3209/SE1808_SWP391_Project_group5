<%-- 
    Document   : profileStaff
    Created on : Mar 14, 2025, 5:17:18 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Profile</title>

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
             .success-message {
                font-size: 18px; /* T?ng k?ch th??c font ch? */
                padding: 15px 30px; /* T?ng padding ?? c? th?m kho?ng tr?ng b?n trong */
                margin: 20px auto; /* ??t margin tr?n v? d??i */
                background-color: #28a745;
                color: white;
                border-radius: 8px;
                font-weight: 600;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                z-index: 1000; /* ??m b?o hi?n th? tr?n c?ng */
                position: relative; /* ??m b?o hi?n th? c?ng v?i b?ng */
                width: 100%; /* ??t chi?u r?ng b?ng v?i b?ng */
                max-width: none; /* Kh?ng gi?i h?n chi?u r?ng */
                text-align: center;
                display: block; /* ??m b?o th?ng b?o chi?m ??y ?? kh?ng gian */
                box-sizing: border-box; /* ??m b?o padding kh?ng l?m t?ng k?ch th??c t?ng th? */
            }

        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"/>
        <jsp:include page="../admin/common/sidebar.jsp"/>

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <c:if test="${not empty sessionScope.successMessage}">
                <p class="success-message">${sessionScope.successMessage}</p>
            </c:if>

            <h2 class="mb-4">Edit Profile</h2>

            <form action="profileStaff" method="post" enctype="multipart/form-data" class="p-4 border rounded shadow-sm bg-light">
                <div class="mb-3">
                    <label for="staffName" class="form-label">Staff Name</label>
                    <input type="text" name="staffName" class="form-control" value="${sessionScope.user.staffName}" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="${sessionScope.user.email}" readonly>
                </div>

                <div class="mb-3">
                    <label for="gender" class="form-label">Gender</label>
                    <select name="gender" class="form-select">
                        <option value="Male" ${sessionScope.user.gender eq 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${sessionScope.user.gender eq 'Female' ? 'selected' : ''}>Female</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}" required>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" value="${sessionScope.user.address}" required>
                </div>

                <!-- Hiển thị avatar hiện tại -->
                <div class="mb-3 text-center">
                    <img src="${sessionScope.user.avatar}" id="avatarPreview" class="avatar-preview rounded-circle img-thumbnail" alt="Current Avatar" style="width: 150px; height: 150px;">
                </div>

                <div class="mb-3">
                    <label for="avatar" class="form-label">Change Avatar</label>
                    <input type="file" name="avatar" class="form-control" id="avatar" accept="image/*" onchange="previewAvatar(event)">
                </div>

                <button type="submit" class="btn btn-primary">Save Changes</button>
            </form>

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
    </body>
</html>
