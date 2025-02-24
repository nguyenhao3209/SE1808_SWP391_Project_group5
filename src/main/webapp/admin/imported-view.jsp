<%-- 
    Document   : stock-view
    Created on : Feb 23, 2025, 8:17:20 PM
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
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/images/favicon.png" />

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

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>

            <main class="ttr-wrapper">
                <h1>Imported invoices</h1>
                <!-- Filter Form -->
                <form id="filter-form" method="POST" action="viewImported" onsubmit="return validateDateRange()">
                    <label for="fromDate">From Date:</label>
                    <input type="date" id="fromDate" name="fromDate">

                    <label for="toDate">To Date:</label>
                    <input type="date" id="toDate" name="toDate">

                    <label for="supplier">Supplier:</label>
                    <input type="text" id="supplier" name="supplier" placeholder="Enter supplier name">

                    <label for="staffName">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName" placeholder="Enter staff name">

                    <button type="submit">Search</button>
                </form>

                <!-- Table for Stock Import -->
                <table border="1" class="table">
                    <thead>
                        <tr>
                            <th>Import ID</th>
                            <th>Staff ID</th>
                            <th>Supplier</th>
                            <th>Import Date</th>
                            <th>Total Cost</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="stock" items="${stockList}">
                        <tr>
                            <td>${stock.importID}</td>
                            <td>${stock.staff.staffID}</td>
                            <td>${stock.supplier}</td>
                            <td>${stock.importDate}</td>
                            <td>${stock.totalCost}</td>
                            <td>
                                <button class="view-details" data-id="${stock.importID}">View Details</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
                    function validateDateRange() {
                        let fromDate = document.getElementById("fromDate").value;
                        let toDate = document.getElementById("toDate").value;
                        if (fromDate && toDate && fromDate > toDate) {
                            alert("From Date cannot be greater than To Date!");
                            return false;
                        }
                        return true;
                    }
        </script>
    </body>
</html>
