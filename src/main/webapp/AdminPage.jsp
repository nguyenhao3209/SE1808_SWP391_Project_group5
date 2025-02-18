<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            /* General Styles */
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }
            h1, h2 {
                color: #343a40;
                margin-bottom: 20px;
            }

            /* Menu Styles */
            .menu-list {
                background-color: #343a40;
                padding: 15px 0;
                margin-bottom: 20px;
            }
            .menu-list a {
                color: white;
                text-decoration: none;
                padding: 10px 20px;
                display: inline-block;
                transition: background-color 0.3s, transform 0.3s;
            }
            .menu-list a:hover, .menu-list a.active {
                background-color: #007bff;
                border-radius: 5px;
                transform: translateY(-2px);
            }

            /* Updated Search Bar Styles */
            .search-container {
                max-width: 800px;
                margin: 0 auto 20px;
                text-align: center;
            }

            .search-bar {
                position: relative;
                width: 100%;
                max-width: 400px;
                margin: 0 auto;
            }

            .search-bar input[type="text"] {
                width: 100%;
                padding: 10px 15px 10px 45px; /* Padding trái để chứa icon */
                border: 1px solid #ddd;
                border-radius: 20px;
                font-size: 16px;
                outline: none;
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            .search-bar input[type="text"]:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }

            .search-bar button {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #007bff;
                font-size: 18px;
                cursor: pointer;
            }

            .search-bar button i {
                font-size: 18px;
            }

            .search-bar button:hover {
                color: #0056b3;
            }
            /* Suggestions Styles */
            .suggestions {
                position: absolute;
                background-color: white;
                border-radius: 4px;
                width: 350px;
                z-index: 10;
                max-height: 300px;
                overflow-y: auto;
            }
            .suggestion-item {
                border: 1px solid #ccc;
                padding: 8px;
                cursor: pointer;
            }
            .suggestion-item:hover {
                background-color: #f0f0f0;
            }

            /* Table Styles */
            .viewUser th, .viewUser td {
                text-align: center;
                vertical-align: middle;
                padding: 10px;
            }
            .viewUser th {
                background-color: #343a40;
                color: white;
                text-transform: uppercase;
            }
            .viewUser tbody tr:hover {
                background-color: #f0f8ff;
            }

            /* Overlay & Modal Styles */
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
            }
            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                width: 80%;
                max-width: 800px;
                max-height: 80vh;
                overflow-y: auto;
                position: relative;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }
            .close-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                cursor: pointer;
                font-size: 24px;
                color: #333;
                font-weight: bold;
                transition: color 0.3s;
            }
            .close-btn:hover {
                color: #ff0000;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <!-- Main Content -->
        <div class="container">
            <div class="search-container mt-5 mb-3">
                <div class="search-bar">
                    <input type="text" id="search-input--user" placeholder="Search for users..." aria-label="Search users" onkeyup="filterUsers()"/>
                    <button aria-label="Search button"><i class="fas fa-search"></i></button>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-center">View Customers</h1>
                    <table class="table table-bordered table-hover viewUser">
                        <thead class="thead-dark">
                            <tr>
                                <th>User ID</th>
                                <th>User Name</th>
                                <th>View Profile</th>
                                <th>View Order</th>
                            </tr>
                        </thead>
                        <tbody id="userTableBody">
                            <c:forEach var="user" items="${sessionScope.listUser}">
                                <tr class="user-row">
                                    <td>${user.customerId}</td>
                                    <td>${user.customerName}</td>
                                    <td><a href="#" onclick="submitProfileForm('<c:out value="${user.customerId}" />')" class="viewProfile">View Profile</a></td>
                                    <!-- Form ẩn -->
                            <form id="profileForm" method="post" action="admin"><input type="hidden" name="customerId" id="hiddenCustomerId"></form>
                            <td><a href="#" onclick="openOrderDetails(${user.customerId})" class="viewOrderDetail">View Order Detail</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div id="overlay" class="overlay" style="display: none;" onclick="closeModalOutside(event)">
                    <div id="modalContent" class="modal-content" onclick="event.stopPropagation();">
                        <span class="close-btn" onclick="closeModal()">×</span>
                        <div id="modalBody">
                            <!-- Nội dung sẽ được chèn vào đây bằng AJAX -->
                        </div>
                    </div>
                </div>

                <!-- JavaScript -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <script>
                            // Filter users by input
                            function filterUsers() {
                                const input = document.getElementById("search-input--user").value.toLowerCase();
                                const rows = document.querySelectorAll("#userTableBody .user-row");
                                rows.forEach(row => {
                                    const userName = row.cells[1].textContent.toLowerCase();
                                    row.style.display = userName.includes(input) ? "" : "none";
                                });
                            }

                            // Open Order Details modal
                            function openOrderDetails(customerId) {
                                $.ajax({
                                    url: 'orderDetail',
                                    method: 'GET',
                                    data: {userid: customerId},
                                    success: function (response) {
                                        document.getElementById('modalBody').innerHTML = response;
                                        document.getElementById('overlay').style.display = 'flex';
                                    },
                                    error: function () {
                                        alert('Failed to load order details.');
                                    }
                                });
                            }


                            function submitProfileForm(customerId) {
                                if (!customerId) {
                                    alert("User ID is missing!");
                                    return;
                                }

                                // Đặt giá trị customerId vào input ẩn
                                document.getElementById("hiddenCustomerId").value = customerId;

                                // Gửi form bằng POST
                                document.getElementById("profileForm").submit();
                            }

                            // Đóng modal khi nhấn vào nút đóng
                            function closeModal() {
                                document.getElementById('overlay').style.display = 'none';
                                document.getElementById('modalBody').innerHTML = '';
                            }

                            // Đóng modal khi nhấn ra bên ngoài modal
                            function closeModalOutside(event) {
                                if (event.target.id === 'overlay') {
                                    closeModal();
                                }
                            }
                            // Close modal
                            function closeModal() {
                                document.getElementById('overlay').style.display = 'none';
                                document.getElementById('modalBody').innerHTML = '';
                            }
                </script>
            </div>
        </div>
    </body>
</html>
