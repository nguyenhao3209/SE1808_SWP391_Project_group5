<%-- 
    Document   : listStaffs.jsp
    Created on : Feb 24, 2025, 1:38:14 PM
    Author     : HuyLVQCE180656
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/user-profile.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:35 GMT -->
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
        <link rel="shortcut icon" type="image/x-icon" href="img/iconAdmin.webp" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>Staffs Management </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">



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
        <jsp:include page="../admin/common/header.jsp"/>
        <jsp:include page="../admin/common/sidebar.jsp"/>

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Staff Management</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Staff Management</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Staff Management</h4>
                            </div>
                            <div class="widget-inner">
                                <div class="container-fluid">
                                    <h2>Staffs Management</h2>

                                    <!-- Search Input -->
                                    <div class="form-group">
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="searchInput" placeholder="Search staff by ID, Name, CetizenID...">
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label for="genderFilter"></label>

                                                <select id="gendersFilter" class="form-control"  onchange="handleGenderChange(this)">
                                                    <option value="All" selected="true">All Genders</option>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="statusFilter"></label>
                                                <select id="statusFilter" class="form-control" onchange="handleStatusChange(this)">
                                                    <option value="All" selected="true">All Status</option>
                                                    <option value="Active">Active</option>
                                                    <option value="Inactive">Inactive</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Staffs Table -->
                                    <div class="table-responsive">
                                        <table id="staffTable" class="table table-striped table-bordered">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th>Staff ID</th>
                                                    <th>Staff Name</th>
                                                    <th>Email</th>
                                                    <th>Phone</th>
                                                    <th>Citizen ID</th>
                                                    <th>Gender</th>
                                                    <th>Status</th>
                                                    <th>Address</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody id="staffTableBody" >
                                                <c:choose>
                                                    <c:when test="${empty staffList}">
                                                        <tr>
                                                            <td colspan="8" class="text-center">List is empty.</td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="staff" items="${staffList}">
                                                            <tr>
                                                                <td>${staff.staffID}</td>
                                                                <td>${staff.staffName}</td>
                                                                <td>${staff.email}</td>
                                                                <td>${staff.phone}</td>
                                                                <td>${staff.citizenID}</td>
                                                                <td>${staff.gender}</td>
                                                                <td>${staff.status}</td>
                                                                <td>${staff.address}</td>
                                                                <td>
                                                                    <a href="editStaff?staffId=${staff.staffID}" class="btn btn-warning btn-sm">Edit</a>
                                                                    <a href="deleteStaff?staffId=${staff.staffID}" class="btn btn-danger btn-sm"
                                                                       onclick="return confirm('Are you sure you want to delete?');">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Add new staff button -->
                                    <a href="admin/addStaff.jsp" class="btn btn-primary">Add new Staff</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script type="text/javascript">
                function handleGenderChange(selectElement) {
                    console.log("Selected value:", selectElement.value);
                    $.ajax({
                        url: "./selectStaffGenders",
                        type: "GET",
                        data: {select: selectElement.value},
                        success: function (data) {
                            console.log(data);
                            var row = document.getElementById("staffTableBody");
                            row.innerHTML = data;
                        },
                        error: function (xhr) {
                            console.error("Error fetching data:", xhr);
                        },
                    });
                }
                function handleStatusChange(selectElement) {
                    console.log("Selected value:", selectElement.value);
                    $.ajax({
                        url: "./selectStaffGenders",
                        type: "GET",
                        data: {selectStatus: selectElement.value},
                        success: function (data) {
                            console.log(data);
                            var row = document.getElementById("staffTableBody");
                            row.innerHTML = data;
                        },
                        error: function (xhr) {
                            console.error("Error fetching data:", xhr);
                        },
                    });
                }
                document.addEventListener("DOMContentLoaded", function () {
                    const searchInput = document.getElementById("searchInput");
                    const tbody = document.getElementById("staffTableBody");

                    function fetchFilteredData() {
                        const keyword = searchInput.value.trim().toLowerCase();

                        $.ajax({
                            url: "searchStaffs",
                            type: "GET",
                            data: {keyword: keyword},
                            success: function (data) {
                                tbody.innerHTML = data;
                            },
                            error: function (xhr, status, error) {
                                console.error("Error fetching staff data:", xhr.responseText);
                            }
                        });
                    }

                    // Gán sự kiện lắng nghe
                    searchInput.addEventListener("input", function () {
                        fetchFilteredData();
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