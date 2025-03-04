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

        <!-- PAGE TITLE HERE ============================================= -->
        <title>
            <c:choose>
                <c:when test="${not empty voucher}">Edit Voucher</c:when>
                <c:otherwise>Add New Voucher</c:otherwise>
            </c:choose>
        </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">

        <!-- Nếu cần tùy chỉnh thêm CSS cho form -->
        <style>
            .form-label {
                font-weight: 600;
            }
        </style>
    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <!-- Header + Sidebar -->
        <jsp:include page="common/header.jsp" />
        <jsp:include page="common/sidebar.jsp" />

        <!-- Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <!-- Breadcrumb -->
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">
                        <c:choose>
                            <c:when test="${not empty voucher}">Edit Voucher</c:when>
                            <c:otherwise>Add New Voucher</c:otherwise>
                        </c:choose>
                    </h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <c:choose>
                            <c:when test="${not empty voucher}">
                                <li>Edit Voucher</li>
                            </c:when>
                            <c:otherwise>
                                <li>Add New Voucher</li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>
                                    <c:choose>
                                        <c:when test="${not empty voucher}">Edit Voucher</c:when>
                                        <c:otherwise>Add New Voucher</c:otherwise>
                                    </c:choose>
                                </h4>
                            </div>
                            <div class="widget-inner">
                                <!-- Xác định đang Edit hay Create -->
                                <c:set var="isEdit" value="${not empty voucher}" />

                                <!-- Nếu voucher có expiryDate, thay ' ' => 'T' để hiển thị datetime-local -->
                                <c:set var="expiryDateValue" value="" />
                                <c:if test="${isEdit and not empty voucher.expiryDate}">
                                    <c:set var="expiryDateValue" value="${fn:replace(voucher.expiryDate, ' ', 'T')}"/>
                                </c:if>

                                <!-- Thông báo lỗi nếu có -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger">${errorMessage}</div>
                                </c:if>

                                <!-- FORM -->
                                <form action="VoucherServlet" method="post" enctype="multipart/form-data">
                                    <!-- Xác định action để Servlet biết -->
                                    <input type="hidden" name="action"
                                           value="<c:choose>
                                                      <c:when test='${isEdit}'>update</c:when>
                                                      <c:otherwise>create</c:otherwise>
                                                  </c:choose>" />

                                    <!-- Khi Edit, cần voucherID -->
                                    <c:if test="${isEdit}">
                                        <input type="hidden" name="voucherID" value="${voucher.voucherID}" />
                                    </c:if>

                                    <!-- Voucher Name -->
                                    <div class="mb-3">
                                        <label class="form-label">Voucher Name</label>
                                        <input type="text" class="form-control" name="name" required
                                               value="${isEdit ? voucher.name : ''}">
                                    </div>

                                    <!-- Description -->
                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3" required>
                                            <c:out value="${isEdit ? voucher.description : ''}"/>
                                        </textarea>
                                    </div>

                                    <!-- Discount Percentage -->
                                    <div class="mb-3">
                                        <label class="form-label">Discount Percentage (%)</label>
                                        <input type="number" class="form-control" name="discountPercentage"
                                               step="1" required
                                               value="${isEdit ? voucher.discountPercentage : ''}">
                                    </div>

                                    <!-- Max Reducing -->
                                    <div class="mb-3">
                                        <label class="form-label">Max Reducing</label>
                                        <input type="number" class="form-control" name="maxReducing" required
                                               value="${isEdit ? voucher.maxReducing : ''}">
                                    </div>

                                    <!-- Voucher Code -->
                                    <div class="mb-3">
                                        <label class="form-label">Voucher Code</label>
                                        <input type="text" class="form-control" name="code" required
                                               value="${isEdit ? voucher.code : ''}">
                                    </div>

                                    <!-- Quantity -->
                                    <div class="mb-3">
                                        <label class="form-label">Quantity</label>
                                        <input type="number" class="form-control" name="quantity" required
                                               value="${isEdit ? voucher.quantity : ''}">
                                    </div>

                                    <!-- Expiry Date + Time -->
                                    <div class="mb-3">
                                        <label class="form-label">Expiry Date & Time</label>
                                        <input type="datetime-local" class="form-control" name="expiryDate"
                                               step="1" required
                                               value="${expiryDateValue}">
                                    </div>

                                    <!-- IsActive -->
                                    <div class="mb-3">
                                        <label class="form-label">Is Active</label>
                                        <select class="form-select" name="isActive">
                                            <option value="true"
                                                <c:if test="${isEdit and voucher.isActive}">selected</c:if>>
                                                Active
                                            </option>
                                            <option value="false"
                                                <c:if test="${isEdit and not voucher.isActive}">selected</c:if>>
                                                Inactive
                                            </option>
                                        </select>
                                    </div>

                                    <!-- Min Order Value -->
                                    <div class="mb-3">
                                        <label class="form-label">Min Order Value</label>
                                        <input type="number" step="0.01" class="form-control"
                                               name="minOrderValue"
                                               value="${isEdit ? voucher.minOrderValue : ''}">
                                    </div>

                                    <!-- Max Usage Per User -->
                                    <div class="mb-3">
                                        <label class="form-label">Max Usage Per User</label>
                                        <input type="number" class="form-control"
                                               name="maxUsagePerUser"
                                               value="${isEdit ? voucher.maxUsagePerUser : ''}">
                                    </div>

                                    <!-- Usage Count -->
                                    <div class="mb-3">
                                        <label class="form-label">Usage Count</label>
                                        <input type="number" class="form-control" name="usageCount"
                                               value="${isEdit ? voucher.usageCount : ''}">
                                    </div>

                                    <!-- Upload File -->
                                    <div class="mb-3">
                                        <label class="form-label">Voucher Image</label>
                                        <input type="file" class="form-control" name="imageFile" accept="image/*">
                                        <c:if test="${isEdit and not empty voucher.imageURL}">
                                            <div class="mt-2">
                                                <p>Current Image:</p>
                                                <img src="${voucher.imageURL}" alt="Current Voucher Image"
                                                     style="width: 150px; height: auto;">
                                            </div>
                                        </c:if>
                                    </div>

                                    <!-- Submit Button -->
                                    <button type="submit" class="btn btn-primary">
                                        <c:choose>
                                            <c:when test="${isEdit}">Update</c:when>
                                            <c:otherwise>Add</c:otherwise>
                                        </c:choose>
                                        Voucher
                                    </button>
                                    <a href="VoucherServlet?action=list" class="btn btn-secondary">Cancel</a>
                                </form>
                                <!-- END FORM -->
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
