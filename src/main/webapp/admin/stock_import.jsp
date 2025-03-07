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
        <style>
            .size-container {
                display: flex;
                align-items: center;
                gap: 8px; /* Khoảng cách giữa nút và dropdown */
            }

            .size-info {
                min-width: 80px; /* Giữ kích thước cố định để tránh layout thay đổi */
                text-align: center;
                font-weight: bold;
            }

            .size-dropdown {
                display: none;
                min-width: 80px; /* Giữ kích thước cố định */
            }

            .select-size {
                padding: 4px 8px;
                font-size: 12px;
                white-space: nowrap; /* Ngăn chữ bị xuống dòng */
            }

        </style>
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
                        <div class="wc-title">
                            <h4>Import Stock</h4>
                        </div>
                        <div class="widget-inner">
                            <div class="form-group row">
                                <div class="col-sm-2 bg-success btn-link p-1 text-center border-2 border-5">
                                    <a href="admin/stock_import_excel.jsp" class="text-white">Import from excel</a>
                                </div>
                            </div>
                            <form action="saveStockImport" method="POST">
                                <div class="form-group row">
                                    <label class="col-sm-2 col-form-label">Staff Name</label>
                                    <div class="col-sm-7">
                                        <input class="form-control" type="hidden" name="staffId" value="${sessionScope.user.staffID}" required="" readonly>
                                    <input class="form-control" type="text" name="staffName" value="${sessionScope.user.staffName}" required="" readonly>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Supplier</label>
                                <div class="col-sm-7">
                                    <input class="form-control" type="text" name="supplier" placeholder="Enter Supplier Name" required="">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Products</label>
                                <div class="col-sm-7">
                                    <input class="form-control" type="hidden" id="productID" name="productID">
                                    <input class="form-control" type="text" id="searchProduct" name="productName" placeholder="Search Product Name" autocomplete="off">
                                    <div id="productResults" class="dropdown-menu" style="width: 100%; display: none;"></div>
                                    <a href="admin/addProduct.jsp" class="btn btn-link">Create New Product</a>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">Selected Products</label>
                                <div class="col-sm-10">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Size</th>
                                                <th>Import Quantity</th>
                                                <th>Price($)</th>
                                                <th>Total Price($)</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody id="selectedProducts">
                                            <!-- Selected products will be added here -->

                                        </tbody>
                                        <tr>
                                            <td colspan="6" class="text-right"><strong>Total Cost($):</strong></td>
                                            <td id="displayTotalCost">0.00</td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>

                            <div class="form-group row btn-container">
                                <input type="hidden" name="totalCost" id="totalCost" value=""/>
                                <button type="submit" name="action" value="saveNow" id="saveNow" class="btn btn-primary m-1" disabled>Inventory. Now</button>
                                <button type="submit" name="action" value="export" id="exportExcel" class="btn btn-primary m-1" disabled>Export to Excel</button>
                                <button type="reset" class="btn btn-secondary m-1">Cancel</button>
                            </div>
                        </form>
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
                $("#searchProduct").keyup(function () {
                    let keyword = $(this).val();
                    if (keyword.length >= 1) {
                        $.ajax({
                            url: "searchProductToImport",
                            type: "GET",
                            data: {keyword: keyword},
                            success: function (data) {
                                if (data.trim().length > 0) {
                                    $("#productResults").html(data).show();
                                } else {
                                    $("#productResults").hide();
                                }
                            }
                        });
                    } else {
                        $("#productResults").hide();
                    }
                });

                $(document).on("click", ".select-btn", function () {
                    let productID = $(this).data("id");
                    let productName = $(this).data("name");
                    let category = $(this).data("category");
                    let stockQuantity = $(this).data("quantity");
                    addSelectedProduct(productID, productName, category, stockQuantity);
                });
            });

            function addSelectedProduct(id, name, category, stockQuantity) {
                let sizeCell = "";
                let hiddenSizeInput = `<input type="hidden" name="size[]" value="">`; // Mặc định lưu rỗng

                if (category === "Shoes" || category === "Clothes") {
                    sizeCell = `
                <div class="size-container">
                <select class="form-control size-dropdown">
                    <option selected disabled>Select Size</option>
                </select><br/>
                <input type="hidden" name="size[]" class="size-name">
                <button type='button' class='btn btn-info btn-sm select-size' data-id="` + id + `">Select</button>
                </div>
                `;
                    hiddenSizeInput = ""; // Nếu có size, không cần input ẩn lưu rỗng
                }

                let rowIndex = $("#selectedProducts tr").length + 1;

                let row = `<tr>
                <td>` + rowIndex + `</td>
                <td>` + id + `</td>
                <td>` + name + `</td>
                <td>` + sizeCell + `</td>
                <td><input type="number" class="form-control quantity-input" name="quantities[]" value="1" min="1" required></td>
                <td><input type="number" class="form-control price-input" name="prices[]" value="0" min="0" step="0.01" required></td>
                <td class="total-price">0</td>
                <td>
                    <button type='button' class='btn btn-danger btn-sm remove-product'><i class="fas fa-trash"></i></button>
                </td>
                <input type="hidden" name="productIDs[]" value="` + id + `">
                <input type="hidden" name="productNames[]" value="` + name + `">
                ` + hiddenSizeInput + `
                </tr>`;

                $("#selectedProducts").append(row);
                $("#searchProduct").val("");
                $("#productResults").hide();
                checkExportButton();
            }

            $(document).on("click", ".select-size", function () {
                let row = $(this).closest("tr");
                let dropdown = row.find(".size-dropdown");
                let inputSize = row.find(".size-name");
                let productID = $(this).data("id");

                dropdown.empty();

                $.ajax({
                    url: "productSize",
                    type: "GET",
                    data: {productId: productID},
                    success: function (data) {
                        if (Array.isArray(data) && data.length > 0) {
                            let options = "<option selected disabled>Select Size</option>";
                            data.forEach(s => {
                                options += `<option value="` + s.sizeID + `">` + s.size + `</option>`;
                            });

                            dropdown.html(options).show();
                        } else {
                            alert("No sizes available for this product.");
                        }
                    },
                    error: function () {
                        alert("Error fetching sizes. Please try again.");
                    }
                });
            });
            $(document).on("change", ".size-dropdown", function () {
                let row = $(this).closest("tr");
                let selectedSize = $(this).val();
                row.find(".size-name").val(selectedSize);
            });
            $(document).on("click", ".remove-product", function () {
                $(this).closest("tr").remove();
                updateTotalCost();
                checkExportButton();
            });

            $(document).on("input", ".price-input", function () {
                this.value = this.value.replace(/[^0-9.]/g, ''); // Chỉ cho phép số và dấu chấm
            });
            $(document).on("input", ".quantity-input, .price-input", function () {
                let row = $(this).closest("tr");
                let quantity = parseFloat(row.find(".quantity-input").val()) || 0;
                let price = parseFloat(row.find(".price-input").val()) || 0;
                let total = quantity * price;

                row.find(".total-price").text(total.toFixed(2));
                updateTotalCost();
            });

            function updateTotalCost() {
                let totalCost = 0;
                $(".total-price").each(function () {
                    totalCost += parseFloat($(this).text()) || 0;
                });
                $("#totalCost").val(totalCost.toFixed(2));
                $("#displayTotalCost").text(totalCost.toFixed(2)); // Hiển thị trên giao diện
            }
            function checkExportButton() {
                if ($("#selectedProducts tr").length > 0) {
                    $("#exportExcel").prop("disabled", false);
                    $("#saveNow").prop("disabled", false);
                } else {
                    $("#exportExcel").prop("disabled", true);
                    $("#saveNow").prop("disabled", true);
                }
            }
        </script>
    </body>
</html>
