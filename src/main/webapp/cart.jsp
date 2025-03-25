<%-- 
    Document   : cart
    Created on : Feb 16, 2025, 9:56:01 PM
    Author     : HAO
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="./css/Cart.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
        <!-- Thư viện Font Awesome để sử dụng các icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/iconHome.webp" />
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
        <jsp:include page="common/header.jsp"/>
        <form style="margin-top: 100px;" id="cart-form" action="cart" method="POST">
            <div class="cart-container">
                <!-- Shopping Cart -->
                <div class="cart-left">
                    <h2>Your Shopping Cart</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>
                                    <input type="checkbox" id="select-all" title="Select All"> <!-- Nút Select All -->
                                </th>
                                <th>Item Info</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Action</th> <!-- Thêm cột Action -->
                            </tr>
                        </thead>
                        <tbody id="cart-items">
                            <c:forEach var="item" items="${sessionScope.cartList}">
                                <tr class="cart-item" data-id="${item.product.productID}" data-price="${item.product.price}" data-discount="${item.product.discountProduct}"   data-sizeStock="${item.productSizes.stockQuantity}" data-stock="${item.product.stockQuantity}"  data-category="${item.product.category.categoryName}">
                                    <td>
                                        <input type="checkbox" class="select-item" name="selectedItems" value="${item.cartID}">
                                    </td>
                                    <td>
                                        <div class="product-info">
                                            <c:if test="${item.product.category.categoryName eq 'Accessory'}">
                                                <img src="./img/${item.product.category.categoryName}/${item.product.getImageURL()}" alt="${item.product.productName}">
                                            </c:if>
                                            <c:if test="${item.product.category.categoryName ne 'Accessory'}">
                                                <img src="./img/${item.product.category.categoryName}/${item.product.brand}/${item.product.getImageURL()}" alt="${item.product.productName}">
                                            </c:if>
                                            <div class="product-details">
                                                <strong>${item.product.productName}</strong>
                                                <p style="margin-bottom: 0;">${item.product.category.categoryName}</p>
                                                <c:if test="${not empty item.productSizes}">
                                                    <p style="margin-bottom: 0;">${item.productSizes.size}</p>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="hidden" name="quantity_${item.cartID}" value="${item.quantity}" class="item-quantity">
                                        <div class="qty-container d-flex">
                                            <button type="button" class="qty-btn decrease">−</button>
                                            <input style="width: 50px;" type="text" name="quantity" class="qty-display mt-3" value="${item.quantity}">
                                            <button type="button" class="qty-btn increase">+</button>
                                        </div>
                                    </td>
                                    <td class="price">
                                        <c:if test="${item.product.discountProduct gt 0}">
                                            <span class="discounted-price">$<fmt:formatNumber value="${item.product.price - (item.product.price * item.product.discountProduct) / 100.0}" pattern="###,##0.00" /></span>
                                            <span class="original-price">$<fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" /></span>
                                            <span class="discount-percentage">(${item.product.discountProduct}% OFF)</span>
                                        </c:if>
                                        <c:if test="${item.product.discountProduct le 0}">
                                            <span class="discounted-price">$<fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" /></span>
                                        </c:if>
                                    </td>
                                    <td class="total">$<fmt:formatNumber value="${item.quantity * (item.product.price - (item.product.price * item.product.discountProduct) / 100.0)}" pattern="###,##0.00" /></td>
                                    <td>
                                        <!-- Icon Xóa -->
                                        <button style="background-color: white !important;" type="submit" name="action" value="remove_${item.cartID}" onclick="return confirmDelete(this);" class="btn-remove" title="Remove Item">
                                            <i style="color: #CE201F;" class="fa-solid fa-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Order Summary -->
                <div class="cart-right">
                    <h3>ORDER SUMMARY</h3>
                    <div class="summary-item">
                        <span>Items <span id="total-items">0</span></span>
                        <span>$<span id="subtotal">0</span></span>
                    </div>
                    <ul id="summary-list">
                        <!-- Danh sách sản phẩm được chọn sẽ hiển thị ở đây -->
                    </ul>
                    <div class="total-price">
                        <span>Total</span>
                        <span>$<span id="total">0</span></span>
                    </div>
                    <input type="hidden" name="action" value="update"/>
                    <button type="submit" class="checkout-btn">CHECKOUT</button>
                </div>
            </div>
        </form>
        <div id="notification" class="notification"></div>
        <jsp:include page="common/footer.jsp"/>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const selectAllCheckbox = document.getElementById("select-all");
                const cartItems = document.querySelectorAll(".cart-item");
                const totalItemsElement = document.getElementById("total-items");
                const subtotalElement = document.getElementById("subtotal");
                const totalElement = document.getElementById("total");
                const summaryList = document.getElementById("summary-list");

                function calculateTotal() {
                    let index = 0;
                    let subtotal = 0;
                    let totalItems = 0;
                    const selectedProducts = [];

                    cartItems.forEach(item => {
                        const checkbox = item.querySelector(".select-item");
                        const quantity = parseInt(item.querySelector(".qty-display").value);
                        const price = parseFloat(item.dataset.price);
                        const discount = parseFloat(item.dataset.discount) || 0;
                        const totalElement = item.querySelector(".total");
                        const productName = item.querySelector(".product-details strong").textContent;
                        const discountedPrice = price - (price * discount / 100);
                        const totalPrice = quantity * discountedPrice;
                        totalElement.textContent = `$` + totalPrice.toFixed(2);

                        if (checkbox.checked) {
                            subtotal += totalPrice;
                            totalItems += quantity;
                            selectedProducts.push(++index + `. ` + productName + ` (x` + quantity + `)`);
                        }
                    });

                    summaryList.innerHTML = selectedProducts.map(product => `<p>` + product + `</p>`).join("");
                    subtotalElement.textContent = subtotal.toFixed(2);
                    totalItemsElement.textContent = totalItems;
                    totalElement.textContent = subtotal.toFixed(2);
                }

                selectAllCheckbox.addEventListener("change", () => {
                    const isChecked = selectAllCheckbox.checked;
                    cartItems.forEach(item => item.querySelector(".select-item").checked = isChecked);
                    calculateTotal();
                });

                cartItems.forEach(item => {
                    const decreaseButton = item.querySelector(".decrease");
                    const increaseButton = item.querySelector(".increase");
                    const quantityDisplay = item.querySelector(".qty-display");
                    const quantityInput = item.querySelector(".item-quantity");
                    const stock = parseInt(item.dataset.stock);
                    const categoryName = item.dataset.category;
                    const sizeStock = parseInt(item.dataset.sizestock);

                    // Hàm kiểm tra giới hạn kho
                    function isWithinStockLimit(quantity) {
                        if (categoryName === 'Shoes' || categoryName === 'Clothes') {
                            return quantity <= sizeStock;
                        }
                        return quantity <= stock;
                    }

                    // Sự kiện nhấn nút giảm
                    decreaseButton.addEventListener("click", () => {
                        let quantity = parseInt(quantityDisplay.value);
                        if (quantity > 1) {
                            quantity--;
                            quantityDisplay.value = quantity;
                            quantityInput.value = quantity;
                            calculateTotal();
                        }
                    });

                    // Sự kiện nhấn nút tăng
                    increaseButton.addEventListener("click", () => {
                        let quantity = parseInt(quantityDisplay.value);
                        if (isWithinStockLimit(quantity + 1)) {
                            quantity++;
                            quantityDisplay.value = quantity;
                            quantityInput.value = quantity;
                            calculateTotal();
                        } else {
                            alert("Cannot add more. Stock limit reached!");
                        }
                    });

                    // Sự kiện nhập trực tiếp
                    quantityDisplay.addEventListener("input", () => {
                        // Loại bỏ tất cả các ký tự không phải là số
                        quantityDisplay.value = quantityDisplay.value.replace(/[^0-9]/g, '');

                        let quantity = parseInt(quantityDisplay.value);

                        // Nếu giá trị sau khi lọc là rỗng hoặc nhỏ hơn 1 thì đặt mặc định là 1
                        if (isNaN(quantity) || quantity <= 0) {
                            quantity = 1;
                            quantityDisplay.value = quantity;
                            alert("Please enter a valid number!");
                            return;
                        }

                        if (isWithinStockLimit(quantity)) {
                            quantityInput.value = quantity;
                        } else {
                            quantity = categoryName === 'Shoes' || categoryName === 'Clothes' ? sizeStock : stock;
                            quantityDisplay.value = quantity;
                            quantityInput.value = quantity;
                            alert("Cannot exceed stock limit!");
                        }
                        calculateTotal();
                    });

                    item.querySelector(".select-item").addEventListener("change", calculateTotal);
                });

                calculateTotal();
            });

        </script>
        <script>
            // Display notification dynamically
            function showNotification(message, type) {
                const notificationElement = document.getElementById('notification');
                notificationElement.textContent = message;
                notificationElement.className = `notification ${type}`;
                notificationElement.style.display = 'block';

                // Fade out after 3 seconds
                setTimeout(() => {
                    notificationElement.style.display = 'none';
                }, 3000);
            }

            // Trigger notification on page load if sessionScope variables exist
            window.onload = () => {
                const notification = "${sessionScope.notification}";
                const notificationType = "${sessionScope.notificationType}";

                if (notification && notificationType) {
                    showNotification(notification, notificationType);
                }
            };

            function confirmDelete(button) {
                const row = button.closest('.cart-item'); // Tìm hàng chứa sản phẩm
                const productName = row.querySelector(`.product-details strong`).textContent; // Lấy tên sản phẩm

                // Hiển thị thông báo xác nhận
                return confirm(`Are you sure you want to remove "` + productName + `" from your cart?`);
            }
            
            document.addEventListener("DOMContentLoaded", function () {
    const checkoutButton = document.querySelector(".checkout-btn");
    const cartForm = document.getElementById("cart-form");

    checkoutButton.addEventListener("click", function (event) {
        const selectedItems = document.querySelectorAll(".select-item:checked");

        if (selectedItems.length === 0) {
            event.preventDefault(); // Ngăn không cho gửi form
            alert("Please select at least one product before checking out!");
        }
    });
});

        </script>
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
        <c:remove var="notification" scope="session"/>
        <c:remove var="notificationType" scope="session"/>
    </body>
</html>