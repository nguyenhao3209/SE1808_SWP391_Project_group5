<%-- 
    Document   : editProduct
    Created on : Mar 1, 2025, 8:41:54 PM
    Author     : HuyLVQCE180656
--%>

<%@page import="Models.Products"%>
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
        <title>Edit Product </title>

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
                    <h4 class="breadcrumb-title">Edit Product</h4>
                    <ul class="db-breadcrumb-list">
                        <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                        <li>Edit Product</li>
                    </ul>
                </div>
                <div class="row">
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Edit Product</h4>
                            </div>
                            <div class="widget-inner">
                                <form class="editProduct m-b30" method="POST" action="editProduct" enctype="multipart/form-data">
                                    <input type="hidden" class="form-control" name="productId" value="${product.productID}" required>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Product Name</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" name="productName" value="${product.productName}" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Description</label>
                                        <div class="col-sm-7">
                                            <textarea class="form-control" name="description" required>${product.description}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Brand</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="text" name="brand" value="${product.brand}" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Category</label>
                                        <div class="col-sm-7">
                                            <!--disabled="true"-->
                                            <select class="form-control" name="categoryID">
                                                <option value="1" ${product.category.categoryID == 1 ? "selected" : ""}>Racket</option>
                                                <option value="2" ${product.category.categoryID == 2 ? "selected" : ""}>Shoes</option>
                                                <option value="3" ${product.category.categoryID == 3 ? "selected" : ""}>Clothes</option>
                                                <option value="4" ${product.category.categoryID == 4 ? "selected" : ""}>Bag</option>
                                                <option value="5" ${product.category.categoryID == 5 ? "selected" : ""}>Accessory</option>
                                            </select>
                                        </div>
                                    </div>
                                    <c:if test="${product.category.categoryName eq 'Shoes' || product.category.categoryName eq 'Clothes'}">
                                        <div id="sizeInputs">
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label">Sizes</label>
                                                <div class="col-sm-7">
                                                    <div id="sizeContainer">
                                                        <c:forEach var="size" items="${sizes}">
                                                            <div class="row size-entry mt-2">
                                                                <div class="col-sm-10">
                                                                    <input type="hidden" name="sizeIDs[]" value="${size.sizeID}">
                                                                    <input class="form-control" type="text" name="sizes[]" value="${size.size}">
                                                                </div>
                                                                <div class="col-sm-2">
                                                                    <button type="button" class="btn btn-danger" onclick="removeEntry(this)">X</button>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>

                                                    <button type="button" class="btn btn-primary mt-2" onclick="addSize()">+ Add Size</button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Price</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="number" step="0.01" name="price" value="${product.price}" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Discount Percent</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="number" step="0.01" name="discountProduct" value="${product.discountProduct}" required>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Current Image</label>
                                        <div class="col-sm-7 text-center"> <!-- Căn giữa bằng Bootstrap -->
                                            <c:if test="${product.category.categoryName eq 'Accessory'}">
                                                <img src="./img/${product.category.categoryName}/${product.getImageURL()}">
                                            </c:if>
                                            <c:if test="${product.category.categoryName ne 'Accessory'}">
                                                <img src="./img/${product.category.getCategoryName()}/${product.brand}/${product.imageURL}">
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Upload New Image</label>
                                        <div class="col-sm-7">
                                            <input class="form-control" type="file" name="imageFile" accept="image/*">
                                            <input type="hidden" name="oldImageURL" value="${product.imageURL}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">Specifications</label>
                                        <div class="col-sm-7">
                                            <div id="specificationsContainer">
                                                <c:forEach var="spec" items="${specs}">
                                                    <div class="row spec-entry mt-2">
                                                        <div class="col-sm-5">
                                                             <input type="hidden" name="specIDs[]" value="${spec.specificationID}"> <!-- Hidden field -->
                                                            <input class="form-control" type="text" name="specNames[]" value="${spec.key}" required>
                                                        </div>
                                                        <div class="col-sm-5">
                                                            <input class="form-control" type="text" name="specValues[]" value="${spec.value}" required>
                                                        </div>
                                                        <div class="col-sm-2">
                                                            <button type="button" class="btn btn-danger" onclick="removeEntry(this)">X</button>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <button type="button" class="btn btn-primary mt-2" onclick="addSpecification()">+ Add Specification</button>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-7">
                                            <button type="submit" class="btn" >Update</button>
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
