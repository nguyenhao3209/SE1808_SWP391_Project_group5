<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <title>EduChamp : Edit Voucher</title>

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
        
        <!-- Nếu muốn thêm CSS tùy chỉnh cho form, đặt ở đây -->
        <style>
            /* Ví dụ: Tăng độ rộng form, căn giữa nhãn, ... */
            .form-label {
                font-weight: 600;
            }
        </style>
    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header + Sidebar (tương tự voucher-list.jsp) -->
        <jsp:include page="common/header.jsp" />
        <jsp:include page="common/sidebar.jsp" />

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <!-- Breadcrumb -->
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Voucher Management</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Edit Voucher</li>
                    </ul>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Edit Voucher</h4>
                            </div>
                            <div class="widget-inner">
                                <!-- NỘI DUNG CHÍNH: FORM EDIT VOUCHER -->
                                <div class="container">
                                    <!-- Kiểm tra voucher có tồn tại không -->
                                    <c:choose>
                                        <c:when test="${empty voucher}">
                                            <div class="alert alert-danger">
                                                Voucher không tồn tại!
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Xử lý format ExpiryDate -->
                                            <c:set var="expiryDateValue" value="" />
                                            <c:if test="${not empty voucher.expiryDate}">
                                                <!-- DB lưu "yyyy-MM-dd HH:mm:ss", thay " " => "T" để hiển thị lên input datetime-local -->
                                                <c:set var="expiryDateValue" value="${fn:replace(voucher.expiryDate, ' ', 'T')}"/>
                                            </c:if>

                                            <!-- enctype để form hỗ trợ upload file -->
                                            <form action="VoucherServlet" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="voucherID" value="${voucher.voucherID}">

                                                <!-- Name -->
                                                <div class="mb-3">
                                                    <label class="form-label">Name</label>
                                                    <input type="text" 
                                                           class="form-control" 
                                                           name="name"
                                                           value="${voucher.name}" 
                                                           required>
                                                </div>

                                                <!-- Description -->
                                                <div class="mb-3">
                                                    <label class="form-label">Description</label>
                                                    <textarea class="form-control" 
                                                              name="description" 
                                                              rows="3" 
                                                              required><c:out value="${voucher.description}"/></textarea>
                                                </div>

                                                <!-- Discount Percentage -->
                                                <div class="mb-3">
                                                    <label class="form-label">Discount Percentage (%)</label>
                                                    <input type="number" 
                                                           class="form-control" 
                                                           name="discountPercentage" 
                                                           step="0.01"
                                                           value="${voucher.discountPercentage}" 
                                                           required>
                                                </div>

                                                <!-- Max Reducing -->
                                                <div class="mb-3">
                                                    <label class="form-label">Max Reducing</label>
                                                    <input type="number" 
                                                           class="form-control" 
                                                           name="maxReducing" 
                                                           step="0.01"
                                                           value="${voucher.maxReducing}" 
                                                           required>
                                                </div>

                                                <!-- Code -->
                                                <div class="mb-3">
                                                    <label class="form-label">Code</label>
                                                    <input type="text" 
                                                           class="form-control" 
                                                           name="code"
                                                           value="${voucher.code}" 
                                                           required>
                                                </div>

                                                <!-- Quantity -->
                                                <div class="mb-3">
                                                    <label class="form-label">Quantity</label>
                                                    <input type="number" 
                                                           class="form-control" 
                                                           name="quantity" 
                                                           min="1"
                                                           value="${voucher.quantity}" 
                                                           required>
                                                </div>

                                                <!-- Expiry Date + Time -->
                                                <div class="mb-3">
                                                    <label class="form-label">Expiry Date & Time</label>
                                                    <!-- step='1' để cho phép chọn đến giây -->
                                                    <input type="datetime-local" 
                                                           class="form-control" 
                                                           name="expiryDate" 
                                                           step="1"
                                                           value="${expiryDateValue}" 
                                                           required>
                                                </div>

                                                <!-- IsActive -->
                                                <div class="mb-3">
                                                    <label class="form-label">Is Active</label>
                                                    <select class="form-select" name="isActive">
                                                        <option value="true"  
                                                            <c:if test="${voucher.isActive}">selected</c:if>>
                                                            Active
                                                        </option>
                                                        <option value="false" 
                                                            <c:if test="${not voucher.isActive}">selected</c:if>>
                                                            Inactive
                                                        </option>
                                                    </select>
                                                </div>

                                                <!-- Min Order Value -->
                                                <div class="mb-3">
                                                    <label class="form-label">Min Order Value</label>
                                                    <input type="number" 
                                                           class="form-control" 
                                                           name="minOrderValue" 
                                                           step="0.01"
                                                           value="${voucher.minOrderValue}">
                                                </div>

                                                <!-- Max Usage Per User -->
                                                <div class="mb-3">
                                                    <label class="form-label">Max Usage Per User</label>
                                                    <input type="number" 
                                                           class="form-control" 
                                                           name="maxUsagePerUser"
                                                           value="${voucher.maxUsagePerUser}">
                                                </div>

                                                <!-- Usage Count -->
                                                <div class="mb-3">
                                                    <label class="form-label">Usage Count</label>
                                                    <input type="number" 
                                                           class="form-control" 
                                                           name="usageCount"
                                                           value="${voucher.usageCount}">
                                                </div>

                                                <!-- Upload File -->
                                                <div class="mb-3">
                                                    <label class="form-label">Voucher Image</label>
                                                    <input type="file" 
                                                           class="form-control" 
                                                           name="imageFile" 
                                                           accept="image/*">
                                                    <c:if test="${not empty voucher.imageURL}">
                                                        <div class="mt-2">
                                                            <p>Current Image:</p>
                                                            <img src="${voucher.imageURL}" 
                                                                 alt="Current Voucher Image"
                                                                 style="width: 150px; height: auto;">
                                                        </div>
                                                    </c:if>
                                                </div>

                                                <!-- Submit -->
                                                <button type="submit" class="btn btn-primary">
                                                    Save Changes
                                                </button>
                                                <a href="VoucherServlet?action=list" 
                                                   class="btn btn-secondary">
                                                    Cancel
                                                </a>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <!-- END .container -->
                            </div>
                            <!-- END .widget-inner -->
                        </div>
                        <!-- END .widget-box -->
                    </div>
                </div>
                <!-- End Content Row -->
            </div>
            <!-- End container-fluid -->

            <div class="ttr-overlay"></div>
        </main>
        <!-- main end -->

        <!-- External JavaScripts (dùng chung với dashboard) -->
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
