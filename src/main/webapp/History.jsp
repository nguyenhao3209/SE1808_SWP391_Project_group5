<%-- 
    Document   : profile
    Created on : Feb 16, 2025, 8:15:10 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Profile</title>
        <!-- Th? vi?n Font Awesome ?? s? d?ng c?c icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

        <link rel="shortcut icon" type="image/x-icon" href="img/iconHome.webp" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css"><!-- comment -->

        <style>

            .container.edit-profile {
                max-width: 1200px;
                width: 100%;
                padding: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease-in-out;
                margin-top: 50px;
            }

            .container.edit-profile:hover {
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                transform: translateY(-5px);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                font-size: 28px;
                font-weight: 700;
                color: #ff7f50;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                font-size: 15px;
                color: #555;
            }

            input[type="text"],
            input[type="email"],
            input[type="file"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                background-color: #f9f9f9;
                color: #333;
                transition: border-color 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="file"]:focus {
                border-color: #007bff;
                outline: none;
            }

            .avatar-preview {
                display: block;
                margin: 20px auto;
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #ff7f50;
                box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
            }

            button[type="submit"], button[type="button"] {
                display: block;
                width: 100%;
                padding: 14px;
                background: linear-gradient(90deg, #b29f7d, #6e6e6e);
                color: white;
                border: none;
                border-radius: 50px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 10px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
            }

            button[type="submit"]:hover, button[type="button"]:hover {
                background: linear-gradient(90deg, #b29f7d, #6e6e6e);
                transform: translateY(-3px);
                box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
            }

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

    <body>
        <jsp:include page="common/header.jsp"/>
        <div style="margin-top: 120px;" class="container edit-profile">
            <!-- Hi?n th? th?ng b?o n?u profile ???c c?p nh?t th?nh c?ng -->
            <c:if test="${not empty sessionScope.successMessage}">
                <p class="success-message">${sessionScope.successMessage}</p>
            </c:if>

            <h2>History Orders</h2>
            <div class="filter-section row mb-3">
                <div class="col-md-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" id="searchInput" placeholder="Search by OrderID...">
                    </div>
                </div>
                <div class="col-md-2">
                    <select id="statusFilter" class="form-select">
                        <option value="">All</option>
                        <option value="Pending">Pending</option>
                        <option value="Completed">Completed</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <input type="number" id="minPrice" class="form-control" placeholder="Min Price">
                </div>
                <div class="col-md-2">
                    <input type="number" id="maxPrice" class="form-control" placeholder="Max Price">
                </div>
                <div class="col-md-2">
                    <input type="date" id="startDate" class="form-control" placeholder="Start Day">
                </div>
                <div class="col-md-2">
                    <input type="date" id="endDate" class="form-control" placeholder="End Day">
                </div>
            </div>



            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Name</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Total Amount</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="orders" items="${listorders}">
                        <tr>
                            <td>${orders.orderID}</td>
                            <td>${orders.customer.customerName}</td>
                            <td>${orders.createAt}</td>
                            <td class="order-status">${orders.status.trim()}</td>
                            <td>$${orders.totalPrice}</td>
                            <td>
                                <button class="btn btn-outline-primary view-order-btn d-flex align-items-center gap-1" 
                                        data-orderid="${orders.orderID}">
                                    <i class="fas fa-eye"></i> View
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <style>
                .view-order-btn {
                    padding: 5px 8px;
                    font-size: 12px;
                    border-radius: 5px;
                    height: 30px;
                }

                .view-order-btn:hover {
                    background-color: #007bff;
                    color: white;
                    transform: translateY(-2px);

                }
                .view-btn {
                    padding: 5px 10px;
                    font-size: 14px;
                    width: 50px;
                }

            </style>



        </div>
        <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderDetailModalLabel">Order Details</h5>
                    </div>
                    <div class="modal-body" id="orderDetailModalBody">
                        <!-- Nội dung Order Details sẽ được load vào đây -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-close">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="common/footer.jsp"/>
        <script>
            // Hi?n th? preview ?nh ngay sau khi ng??i d?ng ch?n file
            function previewAvatar(event) {
                const input = event.target;
                const reader = new FileReader();
                reader.onload = function () {
                    const avatarPreview = document.getElementById('avatarPreview');
                    avatarPreview.src = reader.result;  // G?n URL c?a ?nh preview v?o th? img
                };
                reader.readAsDataURL(input.files[0]);  // ??c file ?nh ?? ch?n
            }

            // ?n th?ng b?o sau 5 gi?y
            setTimeout(function () {
                const message = document.querySelector('.success-message');
                if (message) {
                    message.style.display = 'none';
                }
            }, 5000);  // ?n th?ng b?o sau 5 gi?y
        </script>
        <script>

            document.addEventListener("DOMContentLoaded", function () {
                console.log("Filter script loaded");

                const searchInput = document.getElementById("searchInput");
                const statusFilter = document.getElementById("statusFilter");
                const minPriceInput = document.getElementById("minPrice");
                const maxPriceInput = document.getElementById("maxPrice");
                const startDateInput = document.getElementById("startDate");
                const endDateInput = document.getElementById("endDate");

                function filterOrders() {
                    console.log("Filtering...");

                    const searchText = searchInput.value.trim().toLowerCase();
                    const selectedStatus = statusFilter.value.trim().toLowerCase();
                    const minPrice = minPriceInput.value ? parseFloat(minPriceInput.value) : 0;
                    const maxPrice = maxPriceInput.value ? parseFloat(maxPriceInput.value) : Infinity;
                    const startDate = startDateInput.value ? new Date(startDateInput.value) : null;
                    const endDate = endDateInput.value ? new Date(endDateInput.value) : null;

                    const tableRows = document.querySelectorAll("tbody tr");

                    tableRows.forEach(row => {
                        console.log("Checking row:", row);

                        const customerName = row.cells[0].textContent.trim().toLowerCase();
                        const status = row.cells[3].textContent.trim().toLowerCase();
                        const totalPrice = parseFloat(row.cells[4].textContent.replace("$", "")) || 0;
                        const orderDateText = row.cells[2].textContent.trim();
                        const orderDate = new Date(orderDateText);

                        const matchesSearch = searchText === "" || customerName.includes(searchText);
                        const matchesStatus = selectedStatus === "" || status === selectedStatus;
                        const matchesPrice = totalPrice >= minPrice && totalPrice <= maxPrice;
                        const matchesDate = (!startDate || orderDate >= startDate) && (!endDate || orderDate <= endDate);

                        row.style.display = (matchesSearch && matchesStatus && matchesPrice && matchesDate) ? "" : "none";
                    });
                }

                searchInput.addEventListener("input", filterOrders);
                statusFilter.addEventListener("change", filterOrders);
                minPriceInput.addEventListener("input", filterOrders);
                maxPriceInput.addEventListener("input", filterOrders);
                startDateInput.addEventListener("change", filterOrders);
                endDateInput.addEventListener("change", filterOrders);
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



        </script>
         <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
    </body>
</html>


