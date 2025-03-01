<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Management</title>
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
        <!-- Sidebar -->
        <!-- header start -->
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
            <!-- header end -->
            <!-- Left sidebar menu start -->
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>
            <!-- Left sidebar menu end -->

            <!-- Main Content -->
            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">>Customers Management</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>>Customers Management</li>
                        </ul>
                    </div>
                    <div class="content-wrapper">
                        <div class="content-header">
                            <h3>Customers Management</h3>

                        </div>

                        <div class="content-body">
                            <div class="filter-section">
                                <input type="text" class="form-control" id="searchInput" placeholder="Search by Customer Name...">



                            </div>

                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Customers ID</th>
                                        <th>Customer Name</th>
                                        <th>View Profile</th>
                                        <th>View Orders</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${sessionScope.listUser}">
                                    <tr>
                                        <td>${user.customerId}</td>
                                        <td>${user.customerName}</td>

                                        <td>
                                            <button class="btn btn-primary view-order-btn" data-orderid="${user.customerId}">
                                                View                                           
                                        </td>
                                        <td>
                                            <button class="btn btn-primary view-orders-btn" data-orderid="${user.customerId}">
                                                View                                           
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="orderDetailModalLabel">Customers Management</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body" id="orderDetailModalBody">
                                <!-- Nội dung Order Details sẽ được load vào đây -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

                <script>


                    document.addEventListener("DOMContentLoaded", function () {
                        const searchInput = document.getElementById("searchInput");

                        function filterOrders() {
                            const searchText = searchInput.value.trim().toLowerCase();

                            const tableRows = document.querySelectorAll("tbody tr");

                            tableRows.forEach(row => {
                                const customerName = row.cells[1].textContent.trim().toLowerCase();


                                const matchesSearch = searchText === "" || customerName.includes(searchText);

                                row.style.display = (matchesSearch) ? "" : "none";
                            });
                        }

                        searchInput.addEventListener("input", filterOrders);


                    });


                    document.addEventListener("DOMContentLoaded", function () {
                        document.querySelectorAll(".view-order-btn").forEach(button => {
                            button.addEventListener("click", function () {
                                let customerId = this.getAttribute("data-orderid");

                                fetch("CustomerProfile?customerId=" + customerId)
                                        .then(response => response.text()) // Đảm bảo response là HTML
                                        .then(data => {
                                            document.getElementById("orderDetailModalBody").innerHTML = data;
                                            let orderDetailModal = new bootstrap.Modal(document.getElementById("orderDetailModal"));
                                            orderDetailModal.show();
                                        })
                                        .catch(error => console.error("Error:", error));
                            });
                        });
                    });

                    document.addEventListener("DOMContentLoaded", function () {
                        document.querySelectorAll(".view-orders-btn").forEach(button => {
                            button.addEventListener("click", function () {
                                let customerId = this.getAttribute("data-orderid");

                                fetch("CustomerOrders?customerId=" + customerId)
                                        .then(response => response.text()) // Đảm bảo response là HTML
                                        .then(data => {
                                            document.getElementById("orderDetailModalBody").innerHTML = data;
                                            let orderDetailModal = new bootstrap.Modal(document.getElementById("orderDetailModal"));
                                            orderDetailModal.show();
                                        })
                                        .catch(error => console.error("Error:", error));
                            });
                        });
                    });



                </script>


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
