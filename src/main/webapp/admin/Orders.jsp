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

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="img/iconAdmin.webp" />


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
            .filter-section .form-control, .filter-section {
                min-width: 180px;
                margin-right: 4px;
            }

            .filter-section button {
                margin-left: 4px;
            }

            .filter-section {
                margin-bottom: 16px;
            }
        </style>

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
                        <h4 class="breadcrumb-title">Orders Management</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Orders Management</li>
                        </ul>
                    </div>
                    <div class="content-wrapper">
                        <div class="content-header">
                            <h3>Orders Management</h3>

                        </div>

                        <div class="content-body">
                            <form method="POST" action="OrdersServlet">
                                <div class="filter-section d-flex flex-wrap gap-2 align-items-center">
                                    <input type="text" class="form-control w-auto" name="search" placeholder="Search by Customer Name...">
                                    <select name="status" class="w-auto">
                                        <option value="">All</option>
                                        <option value="Pending">Pending</option>
                                        <option value="Completed">Completed</option>
                                    </select>
                                    <input style="width: 140px !important;" type="number" class="form-control w-auto" name="minPrice" placeholder="Min Price">
                                    <input style="width: 140px !important;" type="number" class="form-control w-auto" name="maxPrice" placeholder="Max Price">
                                    <input type="date" class="form-control w-auto" name="startDate" placeholder="Start Day">
                                    <input type="date" class="form-control w-auto" name="endDate" placeholder="End Day">
                                    <select name="statusDL" class="w-auto">
                                        <option value="">All</option>
                                        <option value="PACK">Pack</option>
                                        <option value="Completed">Completed</option>
                                        <option value="PENDING">Pending</option>
                                        <option value="Cancelled">Cancelled</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary">Filter</button>
                                </div>

                            </form>

                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Customer Name</th>
                                        <th>Phone</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Total Amount</th>
                                        <th>StatusDL</th>
                                        <th>Actions</th>

                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="orders" items="${orders}">
                                    <tr>
                                        <td>${orders.orderID}</td>
                                        <td>${orders.customer.customerName}</td>
                                        <td>${orders.phone}</td>
                                        <td>${orders.createAt}</td>
                                        <td class="order-status">${orders.status.trim()}</td>
                                        <td>$${orders.totalPrice}</td>
                                        <td>${orders.statusDL}</td>
                                        <td>
                                            <button class="btn btn-primary view-order-btn" data-orderid="${orders.orderID}">
                                                View
                                            </button>
                                            <c:if test="${orders.statusDL ne 'COMPLETED' and orders.statusDL ne 'CANCELLED'}">
                                                <button class="btn btn-primary update-order-btn" data-orderid="${orders.orderID}">
                                                    Update
                                                </button>
                                            </c:if>
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
                                <h5 class="modal-title" id="orderDetailModalLabel">Order Details</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="window.location.href = 'OrdersServlet'"></button>
                            </div>
                            <div class="modal-body" id="orderDetailModalBody">
                                <!-- Nội dung Order Details sẽ được load vào đây -->
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="window.location.href = 'OrdersServlet'">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>


                document.addEventListener("DOMContentLoaded", function () {
                    const searchInput = document.getElementById("searchInput");
                    //const statusFilter = document.getElementById("statusFilter");
                    const statusFilter = document.querySelector(".filter-section select[placeholder='Status']");
                    const minPriceInput = document.querySelector(".filter-section input[placeholder='Min Price']");
                    const maxPriceInput = document.querySelector(".filter-section input[placeholder='Max Price']");
                    const startDateInput = document.querySelector(".filter-section input[placeholder='Start Day']");
                    const endDateInput = document.querySelector(".filter-section input[placeholder='End Day']");

                    function parseDate(dateString) {
                        // Chuyển từ định dạng dd/MM/yyyy hoặc yyyy-MM-dd thành Date object
                        let parts = dateString.split("/");
                        if (parts.length === 3) {
                            return new Date(parts[2], parts[1] - 1, parts[0]); // dd/MM/yyyy
                        }
                        return new Date(dateString); // yyyy-MM-dd
                    }

                    function filterOrders() {
                        const searchText = searchInput.value.trim().toLowerCase();
                        const selectedStatus = statusFilter.value.trim().toLowerCase();
                        const minPrice = minPriceInput.value ? parseFloat(minPriceInput.value) : 0;
                        const maxPrice = maxPriceInput.value ? parseFloat(maxPriceInput.value) : Infinity;
                        const startDate = startDateInput.value ? new Date(startDateInput.value) : null;
                        const endDate = endDateInput.value ? new Date(endDateInput.value) : null;

                        const tableRows = document.querySelectorAll("tbody tr");

                        tableRows.forEach(row => {
                            const customerName = row.cells[1].textContent.trim().toLowerCase();
                            const status = row.cells[4].textContent.trim().toLowerCase();
                            const totalPrice = parseFloat(row.cells[5].textContent.replace("$", "")) || 0;

                            // Chuyển đổi ngày trong bảng thành Date object
                            const orderDateText = row.cells[3].textContent.trim();
                            const orderDate = parseDate(orderDateText);
                            const validOrderDate = !isNaN(orderDate.getTime());

                            const matchesSearch = searchText === "" || customerName.includes(searchText);
                            const matchesStatus = selectedStatus === "" || status === selectedStatus;
                            const matchesPrice = totalPrice >= minPrice && totalPrice <= maxPrice;
                            const matchesDate = (!startDate || (validOrderDate && orderDate >= startDate)) &&
                                    (!endDate || (validOrderDate && orderDate <= endDate));

                            row.style.display = (matchesSearch && matchesStatus && matchesPrice && matchesDate) ? "" : "none";
                        });
                    }

                    searchInput.addEventListener("input", filterOrders);
                    statusFilter.addEventListener("change", filterOrders);
                    minPriceInput.addEventListener("input", filterOrders);
                    maxPriceInput.addEventListener("input", filterOrders);
                    startDateInput.addEventListener("change", filterOrders);
                    endDateInput.addEventListener("change", filterOrders);

                    filterOrders();
                });


                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelectorAll(".view-order-btn").forEach(button => {
                        button.addEventListener("click", function () {
                            let orderID = this.getAttribute("data-orderid");

                            fetch("OrderDetailServlet?orderID=" + orderID)
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
                    document.querySelectorAll(".update-order-btn").forEach(button => {
                        button.addEventListener("click", function () {
                            let orderID = this.getAttribute("data-orderid");

                            fetch("OrderUpdateServlet?orderID=" + orderID)
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
