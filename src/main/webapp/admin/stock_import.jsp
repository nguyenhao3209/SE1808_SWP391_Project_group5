<%-- 
    Document   : stock_import
    Created on : Feb 23, 2025, 2:59:16 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Admin</a></li>
                            <li>Import Stock</li>
                        </ul>
                    </div>    

                    <div class="row">
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Import Stock</h4>
                                </div>
                                <div class="widget-inner">
                                    <form class="edit-profile m-b30">
                                        <div class="form-group row">
                                            <div class="col-sm-10 ml-auto">
                                                <h3>1. Stock Import Information</h3>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">Staff Name</label>
                                            <div class="col-sm-7">
                                                <input class="form-control" type="hidden" name="staffId" value="${sessionScope.user.staffID}" readonly>
                                            <input class="form-control" type="text" name="staffName" value="${sessionScope.user.staffName}" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Supplier</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" name="supplier" placeholder="Enter Supplier Name">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Import Date</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="date" name="importDate">
                                        </div>
                                    </div>

                                    <div class="seperator"></div>

                                    <div class="form-group row">
                                        <div class="col-sm-10 ml-auto">
                                            <h3>2. Stock Import Details</h3>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Product</label>
                                        <div class="col-sm-7">
                                            <c:if test="${not empty session.product}">
                                                <input class="form-control" type="hidden" name="productID" value="${sessionScope.product.productID}" readonly>
                                                <input class="form-control" type="text" name="productName" value="${sessionScope.product.productName}" readonly>
                                            </c:if>
                                            <c:if test="${empty session.product}">
                                                <input class="form-control" type="hidden" id="productID" name="productID">
                                                <input class="form-control" type="text" id="searchProduct" name="productName" placeholder="Search Product Name">
                                                <div id="productResults" class="dropdown-menu"></div>
                                                <a href="create_product.jsp" class="btn btn-link">Create New Product</a>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="form-group row" id="sizeGroup" style="display: none;">
                                        <label class="col-sm-2 col-form-label">Size</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" id="size" name="size" placeholder="Enter Size">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Quantity</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="number" name="quantity" placeholder="Enter Quantity">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Cost Price</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="number" name="costPrice" placeholder="Enter Cost Price">
                                        </div>
                                    </div>

                                    <div class="seperator"></div>

                                    <div class="form-group row">
                                        <div class="col-sm-10 ml-auto">
                                            <h3>3. Total Cost</h3>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Total Cost</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" id="totalCost" name="totalCost" readonly>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <div class="col-sm-10 ml-auto">
                                            <h3>4. Confirm & Save</h3>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-7">
                                            <button type="submit" class="btn btn-primary">Save Import</button>
                                            <button type="reset" class="btn btn-secondary">Cancel</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
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
        <script>
            $(document).ready(function () {
                $("#searchProduct").on("input", function () {
                    let query = $(this).val();
                    if (query.length > 2) {
                        $.ajax({
                            url: "SearchProductServlet",
                            type: "GET",
                            data: {keyword: query},
                            success: function (data) {
                                let results = JSON.parse(data);
                                let dropdown = "";
                                results.forEach(product => {
                                    dropdown += `<div class='dropdown-item' data-id='${product.productID}' data-name='${product.productName}'>${product.productName}</div>`;
                                });
                                $("#productResults").html(dropdown).show();
                            }
                        });
                    } else {
                        $("#productResults").hide();
                    }
                });
                $(document).on("click", ".dropdown-item", function () {
                    let productID = $(this).data("id");
                    let productName = $(this).data("name");
                    $("#productID").val(productID);
                    $("#searchProduct").val(productName);
                    $("#productResults").hide();
                });
                function calculateTotalCost() {
                    let quantity = parseFloat($("#quantity").val()) || 0;
                    let costPrice = parseFloat($("#costPrice").val()) || 0;
                    let totalCost = quantity * costPrice;
                    $("#totalCost").val(totalCost.toFixed(2));
                }

                $("#quantity, #costPrice").on("input", calculateTotalCost);
            });

            $(document).ready(function () {
                $(document).on("click", ".dropdown-item", function () {
                    let productID = $(this).data("id");
                    let productName = $(this).data("name");
                    let category = $(this).data("category");
                    $("#productID").val(productID);
                    $("#searchProduct").val(productName);
                    if (category === "Shoes" || category === "Clothes") {
                        $("#sizeGroup").show();
                    } else {
                        $("#sizeGroup").hide();
                    }
                    $("#productResults").hide();
                });
            });
        </script>
    </body>
</html>
