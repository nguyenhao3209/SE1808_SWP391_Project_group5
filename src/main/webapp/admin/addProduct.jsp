<%-- 
    Document   : addProduct
    Created on : Feb 28, 2025, 2:24:07 PM
    Author     : HuyLVQCE180656
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

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

        <!-- header start -->
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
            <!-- header end -->
            <!-- Left sidebar menu start -->
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>
        <!-- Left sidebar menu end -->
        <!--Main container start -->
        <main class="ttr-wrapper">
            <div class="container-fluid">
                <div class="db-breadcrumb">
                    <h4 class="breadcrumb-title">Add New Product</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Add Product</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Add New Product</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="addProduct m-b30" method="POST" action="addProduct" enctype="multipart/form-data">
                                    <div class="col-sm-10 ml-auto">
                                        <h4>1. Product Information</h4>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Product Name</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" name="productName" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Description</label>
                                        <div class="col-sm-7">
                                            <textarea class="form-control" name="description" required></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Brand</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" name="brand" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Category</label>
                                        <div class="col-sm-7">
                                            <select class="form-control" name="categoryID" required id="categorySelect" onchange="toggleSizeInputs()">
                                                <option value="">Select Category</option>
                                                <option value="1">Racket</option>
                                                <option value="2">Shoes</option>
                                                <option value="3">Clothes</option>
                                                <option value="4">Bag</option>
                                                <option value="5">Accessory</option>
                                            </select>
                                        </div>
                                    </div>
                                    <!-- Size Selection (Chỉ hiển thị nếu category != Accessory) -->
                                    <div id="sizeInputs" style="display: none;">
                                        <div class="form-group row">
                                            <label class="col-sm-2 col-form-label">Sizes</label>
                                            <div class="col-sm-7">
                                                <div id="sizeContainer">
                                                    <div class="row size-entry">
                                                        <div class="col-sm-10">
                                                            <input class="form-control" type="text" name="sizes[]" placeholder="Enter size">
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <button type="button" class="btn btn-danger" onclick="removeSize(this)">X</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" class="btn btn-primary mt-2" onclick="addSize()">+ Add Size</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Price</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="number" step="0.01" name="price" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Discount Percent</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="number" step="0.01" name="discountProduct" value="0">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Upload Image</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="file" name="imageFile" accept="image/*" required>
                                        </div>
                                    </div>
                                    <div class="col-sm-10 ml-auto">
                                        <h4>2. Specifications</h4>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Specifications</label>
                                        <div class="col-sm-7">
                                            <div id="specificationsContainer">
                                                <div class="row spec-entry">
                                                    <div class="col-sm-5">
                                                        <input class="form-control" type="text" name="specNames[]" placeholder="Specification Name" required>
                                                    </div>
                                                    <div class="col-sm-5">
                                                        <input class="form-control" type="text" name="specValues[]" placeholder="Specification Value" required>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <button type="button" class="btn btn-danger" onclick="removeSpecification(this)">X</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <button type="button" class="btn btn-primary mt-2" onclick="addSpecification()">+ Add Specification</button>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-7">
                                            <button type="submit" class="btn">Add Product</button>
                                            <button type="reset" class="btn-secondry" onclick="window.history.back()">Cancel</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script>
            function toggleSizeInputs() {
                var category = document.getElementById("categorySelect").value;
                var sizeInputs = document.getElementById("sizeInputs");

                sizeInputs.style.display = (category !== "1" && category !== "5" && category !== "") ? "block" : "none";
            }

            function addSize() {
                var container = document.getElementById("sizeContainer");

                var newEntry = document.createElement("div");
                newEntry.classList.add("row", "size-entry", "mt-2");

                newEntry.innerHTML = `
            <div class="col-sm-10">
                <input class="form-control" type="text" name="sizes[]" placeholder="Enter size" required>
            </div>
            <div class="col-sm-2">
                <button type="button" class="btn btn-danger" onclick="removeEntry(this)">X</button>
            </div>
        `;

                container.appendChild(newEntry);
            }

            function addSpecification() {
                var container = document.getElementById("specificationsContainer");

                var newEntry = document.createElement("div");
                newEntry.classList.add("row", "spec-entry", "mt-2");

                newEntry.innerHTML = `
            <div class="col-sm-5">
                <input class="form-control" type="text" name="specNames[]" placeholder="Specification Name" required>
            </div>
            <div class="col-sm-5">
                <input class="form-control" type="text" name="specValues[]" placeholder="Specification Value" required>
            </div>
            <div class="col-sm-2">
                <button type="button" class="btn btn-danger" onclick="removeEntry(this)">X</button>
            </div>
        `;

                container.appendChild(newEntry);
            }

            function removeEntry(button) {
                var entry = button.closest(".row");
                if (entry) {
                    entry.remove();
                }
            }
        </script>

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
