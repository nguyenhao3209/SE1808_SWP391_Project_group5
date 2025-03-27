<%-- 
    Document   : editStaff.jsp
    Created on : Feb 24, 2025, 1:42:37 PM
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
        <title>Edit Staff</title>

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

        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Edit Staff</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Edit Staff</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Update Staff Information</h4>
                            </div>
                            <div class="widget-inner">
                                <form action="editStaff" method="post" class="form-horizontal">
                                    <input type="hidden" name="staffId" value="${staff.staffID}">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="staffName">Full Name</label>
                                                <input type="text" class="form-control" name="staffName" value="${staff.staffName}" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="password">Password</label>
                                                <input type="password" class="form-control" name="password" value="${staff.password}" required>
                                            </div>
                                            <br/>
                                            <div class="form-group">
                                                <label for="phone">Phone</label>
                                                <input type="text" pattern="\d{10}" class="form-control" value="${staff.phone}" name="phone" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="role">Role</label>
                                                <select name="role" class="form-control" required>
                                                    <option value="ADMIN">Admin</option>
                                                    <option value="STAFF">Staff</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="email">Email</label>
                                                <input type="email" class="form-control" name="email" value="${staff.email}" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label for="citizenID">Citizen ID: </label>
                                                <input type="text" class="form-control" name="citizenID" id="citizenID" value="${staff.citizenID}" required onblur="checkCitizenID()">
                                                <small id="citizenIDError" class="text-danger"></small>
                                                <br/>
                                            </div>
                                            <div class="form-group">
                                                <label for="gender">Gender</label>
                                                <select name="gender" class="form-control" required>
                                                    <option value="Male">Male</option>
                                                    <option value="Female">Female</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label for="status">Status</label>
                                                <select name="status" class="form-control" required>
                                                    <option value="ACTIVE">Active</option>
                                                    <option value="INACTIVE">Inactive</option>
                                                </select>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="form-group col-lg-12">
                                        <label for="address">Address</label>
                                        <input type="text" class="form-control" name="address" required>
                                    </div>
                                    <div class="form-actions text-center">
                                        <button type="submit" class="btn btn-primary">Update</button>
                                        <button type="button" class="btn btn-secondary" onclick="window.history.back()">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script>
            function checkCitizenID() {
                const citizenID = document.getElementById("citizenID").value.trim();
                const staffID = document.getElementById("staffId").value.trim();
                if (!/^\d{12}$/.test(citizenID)) {
                    document.getElementById("citizenIDError").innerText = "Citizen ID must be 12 digits.";
                    return;
                } else {
                    document.getElementById("citizenIDError").innerText = null;
                }

                $.ajax({
                    url: "checkCitizenID",
                    type: "POST",
                    data: {citizenID: citizenID, staffID: staffID},
                    success: function (response) {
                        try {
                            const data = typeof response === "string" ? JSON.parse(response) : response;

                            if (data.status === "exists") {
                                document.getElementById("citizenIDError").innerText = "Citizen ID already exists.";
                            } else if (data.status === "invalid") {
                                document.getElementById("citizenIDError").innerText = "Invalid Citizen ID.";
                            } else if (data.status === "not_exists") {
                                document.getElementById("citizenIDError").innerText = null;
                                document.getElementById("address").value = data.address + `, `;
                            } else {
                                document.getElementById("citizenIDError").innerText = "An unexpected error occurred.";
                            }
                        } catch (e) {
                            console.error("Error parsing JSON response:", e);
                            document.getElementById("citizenIDError").innerText = "Error parsing response.";
                        }
                    },
                    error: function () {
                        document.getElementById("citizenIDError").innerText = "Error checking Citizen ID.";
                    }
                });
            }

        </script>
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
