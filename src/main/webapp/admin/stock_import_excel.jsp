<%-- 
    Document   : stock_import_excel
    Created on : Mar 5, 2025, 4:15:40 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

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
    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>

            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Import Stock</h4>
                    </div>

                    <div class="widget-box">
                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">Import Excel</label>
                            <div class="col-sm-7">
                                <form action="readExcel" method="POST" enctype="multipart/form-data">
                                    <input type="file" name="file" class="form-control" accept=".xls,.xlsx" required>
                                    <button type="submit" class="btn btn-success mt-2">
                                        <i class="fas fa-file-excel"></i> Import from Excel
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                <c:if test="${not empty productList}">
                    <h2>Confirm Imported Excel Data</h2>
                    <!-- Form gửi dữ liệu lên Servlet -->
                    <form action="stockImport" method="POST">
                        <input type="hidden" name="supplier" value="${supplier}">
                        <input type="hidden" name="personInCharge" value="${personInCharge}">

                        <table border="1">
                            <thead>
                                <tr>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Size</th>
                                    <th>Quantity</th>
                                    <th>Actual Price</th>
                                    <th>Actual Total Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${productList}">
                                    <tr>
                                        <td><input type="hidden" name="productID[]" value="${detail.product.productID}">${detail.product.productID}</td>
                                        <td><input type="hidden" name="productName[]" value="${detail.product.productName}">${detail.product.productName}</td>
                                        <td>
                                            <input type="hidden" name="sizeID[]" value="${not empty detail.size ? detail.size.sizeID : ""}">
                                            ${not empty detail.size ? detail.getSize().getName() : 'N/A'}
                                        </td>
                                        <td><input type="hidden" name="quantity[]" value="${detail.quantity}" readonly>${detail.quantity}</td>
                                        <td><input type="hidden" step="0.01" name="price[]" value="${detail.costPrice}" required>$${detail.costPrice}</td>
                                        <td>$${detail.costPrice * detail.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <input type="hidden" name="totalCost" value="${estimatedTotalCost}" readonly>
                        <input type="hidden" name="supplier" value="${supplier}" readonly>
                        <input type="hidden" name="importID" value="${importID}" readonly>
                        <input type="hidden" name="staffID" value="${staffID}" readonly>
                        <h4 style="color: red;">Total Cost: $${estimatedTotalCost}</h4>
                        <h4>Supplier: ${supplier}</h4>
                        <h4>Person in charge: ${personInCharge}</h4>
                        <h4>Staff ID: ${staffID}</h4>

                        <button type="submit" name="action" value="accept" class="btn btn-primary">Accept</button>
                        <button type="submit" name="action" value="cancel" class="btn btn-primary">Cancel</button>
                    </form>
                </c:if>
            </div>    
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


    </body>
</html>
