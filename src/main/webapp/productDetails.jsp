<%-- 
    Document   : productDetails
    Created on : Feb 17, 2025, 9:56:01 PM
    Author     : HAO
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${product.productName}</title>
        <link rel="stylesheet" href="css/product.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
        <!-- Thư viện Font Awesome để sử dụng các icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/iconHome.webp" />
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
    </head>

    <body>
        <jsp:include page="./common/header.jsp"/>

        <div class="container mt-5">
            <!-- Hình ảnh sản phẩm -->
            <div class="product-gallery">
                <div class="main-image">
                    <c:if test="${product.category.categoryName eq 'Accessory'}">
                        <img src="./img/${product.category.categoryName}/${product.getImageURL()}" alt="${product.productName}">
                    </c:if>
                    <c:if test="${product.category.categoryName ne 'Accessory'}">
                        <img src="./img/${product.category.categoryName}/${product.brand}/${product.getImageURL()}" alt="${product.productName}">
                    </c:if>
                </div>
            </div>

            <!-- Thông tin sản phẩm -->
            <div class="product-info">
                <h2>${product.productName}</h2>
                <div class="rating">
                    ${product.getAvgRating()} <span>(${product.getNumberOfFeedbacks()} reviews)</span>
                </div>
                <p>
                    <c:if test="${product.discountProduct gt 0}">
                        <span class="discounted-price">$<fmt:formatNumber value="${product.price - (product.price * product.discountProduct) / 100.0}" pattern="###,##0.00" /></span>
                        <span class="original-price">$<fmt:formatNumber value="${product.price}" pattern="###,##0.00" /></span>
                        <span class="discount-percentage">(${product.discountProduct}% OFF)</span>
                    </c:if>
                    <c:if test="${product.discountProduct  le 0}">
                        <span class="discounted-price">$<fmt:formatNumber value="${product.price}" pattern="###,##0.00" /></span>
                    </c:if>
                </p>
                <p class="product-description">${product.description}</p>

                <form action="addToCart" method="post">
                    <!-- Chọn dung tích -->
                    <c:if test="${product.category.categoryName eq 'Shoes' || product.category.categoryName eq 'Clothes'}">
                        <div class="size-selector">
                            <label for="size">Size:</label>
                            <select id="size" name="sizeID">
                                <c:forEach var="spec" items="${productSizes}">
                                    <option value="${spec.sizeID}">${spec.size}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:if>

                    <!-- Chọn số lượng -->
                    <div class="quantity-selector">
                        <button type="button" class="qty-btn decrease">–</button>
                        <input type="text" name="quantity" class="qty-display" value="1" readonly>
                        <button type="button" class="qty-btn increase">+</button>
                    </div>

                    <!-- Gửi dữ liệu đến Servlet -->
                    <input type="hidden" name="categoryName" value="${product.category.categoryName}">
                    <input type="hidden" name="productId" value="${product.productID}">
                    <input type="hidden" name="productName" value="${product.productName}">

                    <div class="row mt-3">
                        <div class="col-6">
                            <button type="submit" name="action" value="addToCart" class="btn btn-primary w-100"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                        </div>
                        <div class="col-6">
                            <button type="submit" name="action" value="buyNow" class="btn btn-danger w-100"><i class="fa-solid fa-cart-shopping"></i> Buy Now</button>
                        </div>
                    </div>
                </form>

                <c:if test="${not empty specifications}">
                    <div class="product-feature">
                        <table>
                            <thead>
                                <tr>
                                    <th>Feature</th>
                                    <th>Details</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="spec" items="${specifications}">
                                    <c:if test="${spec.key ne 'Size'}">
                                        <tr>
                                            <td><strong>${spec.key}</strong></td>
                                            <td>${spec.value}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
        <jsp:include page="feedbacks.jsp"/>

        <div id="notification" class="notification"></div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const quantityInput = document.querySelector(".qty-display");
                const increaseBtn = document.querySelector(".increase");
                const decreaseBtn = document.querySelector(".decrease");

                function updateQuantity(value) {
                    let quantity = parseInt(quantityInput.value) + value;
                    if (quantity < 1)
                        quantity = 1;
                    quantityInput.value = quantity;
                }

                increaseBtn.addEventListener("click", () => updateQuantity(1));
                decreaseBtn.addEventListener("click", () => updateQuantity(-1));
            });

            function changeImage(imgElement) {
                document.getElementById("main-product-image").src = imgElement.src;
            }
            document.addEventListener("DOMContentLoaded", function () {
                const addToCartBtn = document.querySelector(".add-to-cart");
                const buyNowBtn = document.querySelector(".buy-now");

                addToCartBtn.addEventListener("click", function () {
                    alert("🛒 Added to cart successfully!");
                    // TODO: Gọi AJAX để thêm vào giỏ hàng
                });

                buyNowBtn.addEventListener("click", function () {
                    alert("⚡ Redirecting to checkout...");
                    window.location.href = "checkout.jsp"; // Điều hướng đến trang thanh toán
                });
            });

        </script>
        <script>
            function showNotification(message, type) {
                const notificationElement = document.getElementById('notification');
                notificationElement.textContent = message;
                notificationElement.className = `notification` + ` ` + type;
                notificationElement.style.display = 'block';
                // Fade out after 3 seconds
                setTimeout(() => {
                    notificationElement.style.display = 'none';
                }, 3000);
            }

            window.onload = () => {
                const notification = '<c:out value="${sessionScope.notification}" escapeXml="true" />';
                const notificationType = '<c:out value="${sessionScope.notificationType}" escapeXml="true" />';

                if (notification && notificationType) {
                    showNotification(notification, notificationType);
                }
            };

        </script>
        <c:remove var="notification" scope="session" />
        <c:remove var="notificationType" scope="session" />
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
    </body>
    <jsp:include page="common/footer.jsp"/>

</html>
