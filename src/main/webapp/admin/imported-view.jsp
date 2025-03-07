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
        <style>
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                display: flex;
                background-color: rgba(0, 0, 0, 0.5);
                align-items: center;
                justify-content: center;
            }
            .modal-content {
                background-color: #fff;
                padding: 20px;
                width: 60%;
                max-width: 600px;
                border-radius: 10px;
                position: relative;
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            }
            .close {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 24px;
                cursor: pointer;
            }
        </style>
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>

            <main class="ttr-wrapper">
                <h1>Imported invoices</h1>
                <div id="details-modal" class="modal">
                    <div class="modal-content">
                        <span id="close-modal" class="close">&times;</span>
                        <h2>Import Details</h2>
                        <div id="details-modal-body">
                            <!-- Dữ liệu chi tiết sẽ hiển thị ở đây -->
                        </div>
                    </div>
                </div>
                <!-- Filter Form -->
                <form id="filter-form" method="POST" action="viewImported" onsubmit="return validateDateRange()">
                    <label for="fromDate">From Date:</label>
                    <input type="date" id="fromDate" name="fromDate">

                    <label for="toDate">To Date:</label>
                    <input type="date" id="toDate" name="toDate">
                    <br/>
                    <label for="supplier">Supplier:</label>
                    <input type="text" id="supplier" name="supplier" placeholder="Enter supplier name">

                    <label for="staffName">Staff Name:</label>
                    <input type="text" id="staffName" name="staffName" placeholder="Enter staff name">
                    <br/>
                    <div>
                        <label for="status">Status:</label>
                        <select id="status" name="status">
                            <option value="">--Select Status--</option>
                            <option value="Pending">Pending</option>
                            <option value="Completed">Completed</option>
                            <option value="Cancelled">Cancelled</option>
                        </select>
                    </div>
                    <button type="submit">Apply</button>
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
                            <th>Status</th>
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
                            <td>${stock.status}</td>
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
                    document.addEventListener("DOMContentLoaded", function () {
                        $("#details-modal").hide();
                        $(".view-details").on("click", function () {
                            let importID = $(this).data("id");
                            // AJAX request to fetch the import details
                            $.ajax({
                                url: "viewImportedDetails",
                                type: "GET",
                                data: {importID: importID},
                                success: function (response) {
                                    $("#details-modal-body").html(response);
                                    $("#details-modal").fadeIn(); // Show modal with fade-in effect
                                },
                                error: function () {
                                    alert("Error fetching details. Please try again.");
                                }
                            });
                        });

                        // Close modal when clicking on close button
                        $("#close-modal").on("click", function () {
                            $("#details-modal").fadeOut(); // Hide modal
                        });

                        // Close modal when clicking outside of it
                        $("#details-modal").on("click", function (event) {
                            if ($(event.target).is("#details-modal")) {
                                $("#details-modal").fadeOut(); // Hide modal
                            }
                        });
                    });
        </script>
    </body>
</html>
