<%-- 
    Document   : tabbar
    Created on : Feb 22, 2025, 2:49:54 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Sidebar</title>
        <link rel="stylesheet" href="./css/tabbar.css">
        <style>
            /* Sidebar chính */
            .sidebar {
                width: 250px;
                background: #2C3E50;
                position: fixed;
                height: 100vh;
                left: 0;
                top: 0;
                padding: 10px 15px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease;
            }

            .sidebar.closed {
                transform: translateX(-100%);
            }

            /* Header */
            .sidebar-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-bottom: 10px;
                border-bottom: 2px solid #ccc;
                color: white;
            }

            .sidebar-header h2 {
                font-size: 18px;
                font-weight: bold;
            }

            /* Nút menu toggle */
            .menu-toggle {
                background: none;
                border: none;
                font-size: 22px;
                color: white;
                cursor: pointer;
            }

            /* Danh sách menu */
            .nav-list {
                list-style: none;
                padding: 0;
                margin: 10px 0;
            }

            .nav-list li {
                padding: 12px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                border-bottom: 1px solid #555;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                transition: background 0.3s ease;
            }

            .nav-list li:hover {
                background: #1A252F;
            }

            /* Badge thông báo */
            .badge {
                background: red;
                color: white;
                padding: 2px 8px;
                font-size: 12px;
                border-radius: 50%;
            }

            /* Cấu trúc submenu */
            .has-submenu {
                position: relative;
            }

            /* Menu con */
            .submenu {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                width: 100%;
                background: #34495E;
                list-style: none;
                padding: 0;
                margin: 0;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
                z-index: 10;
            }

            .submenu li {
                padding: 10px 15px;
                font-size: 14px;
                color: white;
                border-bottom: 1px solid #2C3E50;
                display: block;
                text-align: left;
                white-space: nowrap;
            }

            .submenu li:hover {
                background: #1A252F;
            }

            /* Khi mở submenu */
            .has-submenu.open .submenu {
                display: block;
            }

        </style>
    </head>
    <body>

        <div class="sidebar">
            <div class="sidebar-header">
                <h2>BADMINTON</h2>
                <button class="menu-toggle">&#9776;</button>
            </div>

            <ul class="nav-list">
                <p>Statistic</p>
                <li>Statistic management</li>
                <p>Products & Orders</p>
                <li class="has-submenu">
                    <span>Products management ▼</span>
                    <ul class="submenu">
                        <li>View Products</li>
                        <li>Add Product</li>
                    </ul>
                </li>
                
                <li>Stock management</li>

                <li>
                    Orders management 
                    <span class="badge">1</span>
                </li>
                <p>Users</p>
                <li>Customers management</li>
                
                <li class="has-submenu">
                    <span>Staffs management ▼</span>
                    <ul class="submenu">
                        <li>View Staff</li>
                        <li>Add Staff</li>
                    </ul>
                </li>
                <p>Discounts</p>
                <li class="has-submenu">
                    <span>Vouchers management ▼</span>
                    <ul class="submenu">
                        <li>View Vouchers</li>
                        <li>Add Voucher</li>
                    </ul>
                </li>

                <li class="has-submenu">
                    <span>News management ▼</span>
                    <ul class="submenu">
                        <li>View News</li>
                        <li>Add News</li>
                    </ul>
                </li>

                <li>Contact management</li>
            </ul>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Xử lý submenu
                const submenus = document.querySelectorAll(".has-submenu > span");

                submenus.forEach(menu => {
                    menu.addEventListener("click", function () {
                        let parent = this.parentElement;
                        let submenu = parent.querySelector(".submenu");

                        // Kiểm tra nếu submenu đang mở thì đóng lại
                        if (parent.classList.contains("open")) {
                            parent.classList.remove("open");
                        } else {
                            // Đóng tất cả submenu khác trước khi mở
                            document.querySelectorAll(".has-submenu").forEach(item => item.classList.remove("open"));
                            parent.classList.add("open");
                        }
                    });
                });

                // Toggle sidebar mở/đóng
                const menuToggle = document.querySelector(".menu-toggle");
                const sidebar = document.querySelector(".sidebar");

                menuToggle.addEventListener("click", function () {
                    sidebar.classList.toggle("closed");
                });
            });
        </script>
    </body>
</html>
