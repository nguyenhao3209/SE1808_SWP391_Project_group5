
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Badminton Shop - Product</title>
 
        
        <!-- Thư viện Font Awesome để sử dụng các icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        
               	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

       <link rel="stylesheet" type="text/css" href="css/normalize.css">
	<link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
	<link rel="stylesheet" type="text/css" href="css/vendor.css">
	<link rel="stylesheet" type="text/css" href="style.css">
        
        <style>

            .search-container {
                max-width: 800px; /* Set a maximum width for the search container */
                margin: 0 auto; /* Center the container */
            }

            /* Search Bar Styles */
            .search-bar {
                display: flex; /* Flexbox for alignment */
                justify-content: center; /* Center the content */
                margin: 50px 0 10px 0; /* Top and bottom margins */
            }

            .search-bar input[type="text"] {
                width: 100%; /* Width of input */
                padding: 15px; /* Padding for input */
                border: 2px solid #ddd; /* Border color */
                border-radius: 30px; /* Rounded corners */
                font-size: 16px; /* Font size */
                outline: none; /* Remove default outline */
                transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Transition effects */
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            }

            .search-bar input[type="text"]:focus {
                border-color: #007bff; /* Change border color on focus */
                box-shadow: 0 4px 20px rgba(0, 123, 255, 0.2); /* Enhanced shadow on focus */
            }

            .search-bar button {
                padding: 15px 30px; /* Padding for button */
                background-color: #007bff; /* Button background color */
                color: white; /* Text color */
                border: none; /* No border */
                border-radius: 30px; /* Rounded corners */
                margin-left: -80px; /* Overlap input */
                cursor: pointer; /* Pointer cursor */
                transition: background-color 0.3s ease, transform 0.3s ease; /* Transition effects */
                display: flex; /* Flexbox for button */
                align-items: center; /* Center icon vertically */
                gap: 10px; /* Space between icon and text */
                box-shadow: 0 4px 10px rgba(0, 123, 255, 0.3); /* Shadow for button */
            }

            .search-bar button:hover {
                background-color: #0056b3; /* Darker background on hover */
                transform: translateY(-3px); /* Move button up on hover */
                box-shadow: 0 6px 15px rgba(0, 86, 179, 0.5); /* Stronger shadow on hover */
            }

            .search-bar button i {
                font-size: 18px; /* Icon size */
            }

            /* Suggestions Dropdown */
            .suggestions {
                position: absolute; /* Positioned absolutely */
                background-color: white; /* Background color */
                border: 1px solid #ccc; /* Border */
                border-radius: 4px; /* Rounded corners */
                width: 800px; /* Full width relative to parent */
                z-index: 10; /* Stack above other elements */
                max-height: 300px; /* Maximum height */
                overflow-y: auto; /* Scroll if needed */
            }

            /* Suggestion Items */
            .suggestion-item {
                padding: 8px; /* Padding for items */
                cursor: pointer; /* Pointer cursor */
            }

            /* Hover state for suggestion items */
            .suggestion-item:hover {
                background-color: #f0f0f0; /* Highlight on hover */
            }




            h1{
                text-align: center;
                color: rosybrown;
                font-weight: bold;
            }

            /* General container styling */
            .container.menu {
                width: 100%; /* Make sure the container takes full width */
                text-align: center; /* Center the list items */
                padding: 10px 0; /* Add some padding for space */
                background-color: #f8f8f8; /* Optional: background color for container */
            }

            /* Navigation styling */
            .nav.navbar-nav {
                list-style: none; /* Remove bullets from list */
                padding: 0;
                margin: 0;
                display: flex; /* Display list items in a row */
                justify-content: space-around; /* Align items centrally */
                flex-direction: row;
                width: 100%;
            }

            .nav {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            .nav li {
                display: inline; /* Hiển thị danh sách theo hàng ngang */
                margin-right: 20px; /* Khoảng cách giữa các mục */
            }

            .nav a {
                text-decoration: none; /* Bỏ gạch chân cho các liên kết */
                color: black; /* Màu chữ mặc định */
                padding: 5px 10px; /* Thêm khoảng cách xung quanh chữ */
            }

            /* List items styling */
            .nav.navbar-nav li {
                margin: 0 15px; /* Add some margin between list items */
            }

            /* Link styling */
            .nav.navbar-nav li a {
                text-decoration: none; /* Remove underline */
                color: #333; /* Link text color */
                font-size: 16px; /* Font size for links */
                font-weight: bold; /* Make the text bold */
                padding: 10px 15px; /* Add padding around links */
                display: block; /* Make links block-level elements */
                transition: color 0.3s ease; /* Smooth transition for hover effect */
            }

            /* Active item styling */
            .nav.navbar-nav li.active a {
                color: #007bff; /* Different color for active link */
            }

            /* Hover effect */
            .nav.navbar-nav li a:hover {
                color: #007bff; /* Color change on hover */
            }

            /* SẢN PHẨM */

            /* Style cho container */
            .container {
                position: relative;
                width: 100%;
                overflow: hidden;
            }

            /* Style cho container chứa các sản phẩm */
            .product-container {
                overflow-x: auto;
                scroll-behavior: smooth;
                padding: 10px;
                transition: opacity 0.3s ease;
            }

            /* Ẩn scrollbar mặc định */
            .product-container::-webkit-scrollbar {
                display: none;
            }

            /* Style cho từng sản phẩm */
            .product-card {
                flex: 0 0 auto;
                margin: 0 10px;
                width: 200px; /* Độ rộng của mỗi sản phẩm */
                height: 370px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px; /* Bo góc cho sản phẩm */
                transition: transform 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng chuyển động */
                background-color: #fff; /* Màu nền cho sản phẩm */
                position: relative; /* Để hiển thị badge lên trên ảnh */
            }

            .product-image {
                width: 100%;
                height: auto;
                overflow: hidden;
                position: relative;
            }

            .product-image img {
                width: 100%;
                display: block;
            }

            .discount-badge {
                position: absolute;
                top: 10px; /* Đặt badge ở góc trên */
                left: 10px;
                background-color: red;
                color: white;
                padding: 5px 10px;
                font-size: 14px;
                font-weight: bold;
                border-radius: 50%;
                z-index: 1; /* Đảm bảo badge xuất hiện trên hình ảnh */
            }

            .product-details {
                text-align: center;
                margin-top: 10px;
            }

            .product-price {
                font-size: 18px;
                color: #333;
            }

            .original-price {
                color: #999;
                margin-right: 10px;
            }

            .discounted-price {
                color: #e60000;
                font-weight: bold;
            }

            .product-image{
                height: 200px;
                width: 200px;
                display: flex;
            }
            /* Style cho hình ảnh sản phẩm */
            .product-image img {
                width: 200px; /* Đảm bảo hình ảnh chiếm toàn bộ chiều rộng */
                height: 200px;
                height: auto; /* Để chiều cao tự động */
                border-top-left-radius: 8px; /* Bo góc cho hình ảnh */
                border-top-right-radius: 8px; /* Bo góc cho hình ảnh */
            }
            .product-details {
                padding: 10px; /* Khoảng cách bên trong */
            }

            /* Style cho tên sản phẩm */
            .product-name {
                font-size: 16px; /* Kích thước chữ cho tên sản phẩm */
                font-weight: bold; /* Đậm cho tên sản phẩm */
                margin-bottom: 5px; /* Khoảng cách dưới tên sản phẩm */
            }

            /* Style cho giá sản phẩm */
            .product-price {
                font-size: 14px; /* Kích thước chữ cho giá sản phẩm */
                color: #e67e22; /* Màu cho giá sản phẩm */
                margin-bottom: 10px; /* Khoảng cách dưới giá sản phẩm */
            }
            .product-button {
                background-color: #3498db; /* Màu nền cho nút */
                color: #fff; /* Màu chữ cho nút */
                border: none; /* Không có đường viền */
                border-radius: 5px; /* Bo góc cho nút */
                padding: 10px 15px; /* Khoảng cách bên trong */
                cursor: pointer; /* Hiển thị con trỏ khi hover */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền */
            }

            .product-button:hover {
                background-color: #2980b9; /* Màu nền khi hover */
            }

            .product-container.active {
                display: flex;
                opacity: 1;
            }

            /* Style cho nút cuộn */
            .scroll-button {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                width: 40px;
                height: 40px;
                background-color: rgba(0, 0, 0, 0.5);
                color: #fff;
                border: none;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            /* Hiển thị nút cuộn khi di chuột vào container */
            .container:hover .scroll-button {
                opacity: 1;
            }

            /* Nút cuộn bên trái */
            .scroll-button.left {
                left: 10px;
            }

            /* Nút cuộn bên phải */
            .scroll-button.right {
                right: 10px;
            }

            /* Tăng kích thước sản phẩm khi di chuột vào */
            .product-card:hover {
                transform: scale(1.05); /* Phóng to sản phẩm khi hover */
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Tăng độ đổ bóng khi hover */
            }
            .filter-form {
                width: 300px;
                background-color: #f1f1f1;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .filter-form h3 {
                font-size: 16px;
                margin-bottom: 10px;
                color: #333;
            }

            .filter-form label {
                display: block;
                margin-bottom: 5px;
                font-size: 14px;
            }

            .filter-form input[type="checkbox"],
            .filter-form input[type="radio"] {
                margin-right: 10px;
            }

            .filter-form input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            .filter-form button {
                padding: 10px;
                width: 100%;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }

            .filter-form button:hover {
                background-color: #0056b3;
            }
            @keyframes slide-animation {
                0% {
                    transform: translateX(0);
                }
                20% {
                    transform: translateX(0);
                }
                25% {
                    transform: translateX(-100%);
                }
                45% {
                    transform: translateX(-100%);
                }
                50% {
                    transform: translateX(-200%);
                }
                70% {
                    transform: translateX(-200%);
                }
                75% {
                    transform: translateX(-300%);
                }
                100% {
                    transform: translateX(0);
                }
            }
            </style>
    </head>
    <body>
        <jsp:include page="common/header.jsp"/>
        <div class="page-content bg-white">
            <div class="content-block">
                <!-- About Us -->
                <div class="section-area section-sp1">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-3 col-md-4 col-sm-12 m-b30">
                                <div class="widget courses-search-bx placeani">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <input name="keyword" type="text" class="form-control" placeholder="Search ...">
                                        </div>
                                    </div>
                                </div>
                                <div class="widget widget_archive">
                                    <h5 class="widget-title style-1">All Category</h5>
                                    <ul>
                                        <c:forEach items="${categoryList}" var="c">
                                            <label><input type="checkbox" name="category" value="${c.categoryID}"> ${c.categoryName}</label>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="widget widget_archive">
                                    <h5 class="widget-title style-1">All Brand</h5>
                                    <ul>
                                        <c:forEach items="${brandList}" var="c">
                                            <label><input type="checkbox" name="brand" value="${c}"> ${c}</label></c:forEach>
                                        </ul>
                                    </div>
                                    <div class="widget widget_archive">
                                        <h5 class="widget-title style-1">Price</h5>
                                        <ul>
                                            <label><input type="radio" name="priceRange" value="all" checked> All</label>
                                            <label><input type="radio" name="priceRange"  value="low"> Under 150$</label>
                                            <label><input type="radio" name="priceRange" value="medium"> 150$ - 300$</label>
                                            <label><input type="radio" name="priceRange" value="high"> Over 300$</label>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-9 col-md-8 col-sm-12">
                                    <div class="row" id="productList">
                                    <c:forEach var="product" items="${productsList}">
                                        <div class="col-md-6 col-lg-4 col-sm-6 m-b30">
                                            <div class="cours-bx">
                                                <div class="action-box">
                                                    <c:choose>
                                                        <c:when test="${product.getCategoryID().getCategoryName() ne 'Accessory'}">
                                                            <img src="./img/${product.getCategoryID().getCategoryName()}/${product.brand}/${product.imageURL}" alt="${product.productName}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="./img/${product.getCategoryID().getCategoryName()}/${product.imageURL}" alt="${product.productName}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <a href="productsDetail?id=${product.productID}" class="btn">Show Detail</a>
                                                </div>
                                                <div class="info-bx text-center">
                                                    <h5><a href="productsDetail?id=${product.productID}">${product.productName}</a></h5>
                                                    <span>${product.getCategoryID().getCategoryName()} - ${product.brand}</span>
                                                </div>
                                                <div class="cours-more-info">
                                                    <div class="review">
                                                        <span>${product.numberOfFeedbacks} Review</span>
                                                        <ul class="cours-star">
                                                            <li class="active">${product.avgRating}<i class="fa fa-star"></i></li>
                                                        </ul>
                                                    </div>
                                                    <div class="price">
                                                        <c:if test="${product.getDiscountProduct() > 0}">
                                                            <del style="color: red;text-align: center;margin-right: 35px">$${String.format('%.2f', product.price)}</del> <!-- Original Price -->
                                                            <h5 style="color: black;text-align: center">$${String.format('%.2f', product.price * (1 - product.getDiscountProduct() / 100.0))}</h5> <!-- Discounted Price -->
                                                        </c:if>
                                                        <c:if test="${product.getDiscountProduct() <= 0}">
                                                            <div style="text-align: center; margin-top: 15px"> <!-- Center the regular price -->
                                                                <h5 style="color: black;">$${String.format('%.2f', product.price)}</h5> <!-- Regular Price -->
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <script>
                                        function addToCart(event, productID, quantity) {
                                            event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ a

                                            // Tạo đối tượng form để gửi yêu cầu POST đến servlet
                                            const form = document.createElement('form');
                                            form.method = 'POST';
                                            form.action = 'AddToCartServlet'; // Đường dẫn đến servlet

                                            // Tạo input ẩn để gửi productID
                                            const productInput = document.createElement('input');
                                            productInput.type = 'hidden';
                                            productInput.name = 'productId';
                                            productInput.value = productID;
                                            form.appendChild(productInput);

                                            // Tạo input ẩn để gửi quantity
                                            const quantityInput = document.createElement('input');
                                            quantityInput.type = 'hidden';
                                            quantityInput.name = 'quantity';
                                            quantityInput.value = quantity;
                                            form.appendChild(quantityInput);

                                            // Thêm form vào body và gửi nó
                                            document.body.appendChild(form);
                                            form.submit();
                                        }
                                    </script>
                                    <div class="col-lg-12 m-b20">
                                        <div class="pagination-bx rounded-sm gray clearfix">
                                            <ul class="pagination">
                                                <c:if test="${pageNumber > 1}">
                                                    <li>
                                                        <a href="javascript:void(0)" data-page="${pageNumber-1}" class="pagination-link">&laquo;</a>
                                                    </li>
                                                </c:if>

                                                <c:forEach var="i" begin="${totalPages < 9 ? 1 : pageNumber}" end="${pageNumber + 9 > totalPages ? totalPages : pageNumber + 9 }">
                                                    <li class="${i == pageNumber ? 'active' : ''}">
                                                        <a href="javascript:void(0)" data-page="${i}" class="pagination-link">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <c:if test="${pageNumber < totalPages}">
                                                    <li>
                                                        <a href="javascript:void(0)" data-page="${pageNumber+1}" class="pagination-link">&raquo;</a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </div>

<!--         Container chứa icon Zalo 
        <div class="zalo-container" id="zaloContainer">
            <a href="https://zalo.me/0968020458" target="_blank" class="zalo-icon">
                <img src="./img/zalo-logo.png" alt="Zalo">
            </a>
        </div>
         contact area END -->

<jsp:include page="common/footer.jsp" />
	<script src="js/jquery-1.11.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
		crossorigin="anonymous"></script>
	<script src="js/plugins.js"></script>
	<script src="js/script.js"></script>
        <script>
                                        function loadProducts(page) {
                                            let searchQuery = $("input[name='keyword']").val();
                                            let categories = [];
                                            let brands = [];
                                            let priceRange = $("input[name='priceRange']:checked").val();

                                            // Collect selected categories
                                            $("input[name='category']:checked").each(function () {
                                                categories.push($(this).val());
                                            });

                                            // Collect selected brands
                                            $("input[name='brand']:checked").each(function () {
                                                brands.push($(this).val());
                                            });

                                            // Send AJAX request to servlet
                                            $.ajax({
                                                url: "ProductFilterServlet",
                                                type: "GET",
                                                data: {
                                                    keyword: searchQuery,
                                                    categories: categories,
                                                    brands: brands,
                                                    priceRange: priceRange,
                                                    pageNumber: page || 1
                                                },
                                                success: function (data) {
                                                    // Update product list with the response data
                                                    $('#productList').html(data);
                                                },
                                                error: function (xhr, status, error) {
                                                    console.error("AJAX Error: ", status, error);
                                                }
                                            });
                                        }
                                        // Bắt sự kiện click vào các nút phân trang
                                        $(document).on('click', '.pagination-link', function () {
                                            var page = $(this).data('page'); // Lấy số trang từ thuộc tính data-page
                                            if (page) {
                                                loadProducts(page); // Gọi hàm loadProducts với số trang
                                            }
                                        });
                                        $(document).ready(function () {
                                            $("input[type='text'], input[type='checkbox'], input[type='radio']").on('input change', function () {
                                                loadProducts();
                                            });
                                        });
        </script>

    </body>
</html>
