<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="./CSS/Cart.css">
    </head>
    <body>
         <jsp:include page="common/header.jsp"/>
        <form id="cart-form" action="cart" method="POST">
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
                                <tr class="cart-item" data-id="${item.product.productID}" data-price="${item.product.price}" data-stock="${item.product.stockQuantity}">
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
                                                <p>${item.product.category.categoryName}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="hidden" name="quantity_${item.cartID}" value="${item.quantity}" class="item-quantity">
                                        <div class="qty-container">
                                            <button type="button" class="qty-btn decrease">−</button>
                                            <span class="qty-display">${item.quantity}</span>
                                            <button type="button" class="qty-btn increase">+</button>
                                        </div>
                                    </td>
                                    <td class="price">${item.product.price}</td>
                                    <td class="total"><fmt:formatNumber value="${item.quantity * item.product.price}" pattern="###,##0.00" /></td>
                                    <td>
                                        <!-- Icon Xóa -->
                                        <button type="submit" name="action" value="remove_${item.cartID}" class="btn-remove" title="Remove Item">
                                            ✖
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const selectAllCheckbox = document.getElementById("select-all"); // Checkbox Select All
                const cartItems = document.querySelectorAll(".cart-item"); // Các dòng sản phẩm
                const totalItemsElement = document.getElementById("total-items");
                const subtotalElement = document.getElementById("subtotal");
                const totalElement = document.getElementById("total");
                const summaryList = document.getElementById("summary-list");
                let discount = 0;

                // Hàm tính toán tổng tiền và hiển thị danh sách sản phẩm
                function calculateTotal() {
                    let index = 0;
                    let subtotal = 0;
                    let totalItems = 0;
                    let selectedProducts = []; // Danh sách các sản phẩm đã chọn

                    cartItems.forEach(item => {
                        const checkbox = item.querySelector(".select-item");
                        const quantityInput = item.querySelector(".item-quantity");
                        const quantity = parseInt(quantityInput.value);
                        const price = parseFloat(item.dataset.price);
                        const totalElement = item.querySelector(".total");
                        const productName = item.querySelector(".product-details strong").textContent.trim();

                        // Tính tổng tiền của từng sản phẩm và hiển thị
                        const totalPrice = quantity * price;
                        totalElement.textContent = totalPrice.toFixed(2); // Hiển thị giá tổng từng sản phẩm

                        if (checkbox.checked) {
                            subtotal += totalPrice;
                            totalItems += quantity;
                            let productInfo = ++index + `. ` + productName + `   (x` + quantity + `)`;
                            selectedProducts.push(productInfo); // Lưu tên sản phẩm và số lượng
                        }
                    });

                    // Xóa danh sách sản phẩm cũ trong "Order Summary"
                    summaryList.innerHTML = "";

                    // Hiển thị các sản phẩm đã chọn trong "Order Summary"
                    selectedProducts.forEach(product => {
                        const p = document.createElement("p");
                        p.textContent = product; // Hiển thị tên sản phẩm và số lượng
                        summaryList.appendChild(p);
                    });

                    // Cập nhật tổng tiền và số lượng
                    let total = subtotal - (subtotal * discount) / 100;
                    subtotalElement.textContent = subtotal.toFixed(2);
                    totalItemsElement.textContent = totalItems;
                    totalElement.textContent = total.toFixed(2);
                }

                // Xử lý sự kiện "Select All"
                selectAllCheckbox.addEventListener("change", function () {
                    const isChecked = selectAllCheckbox.checked; // Trạng thái của Select All
                    cartItems.forEach(item => {
                        const checkbox = item.querySelector(".select-item");
                        checkbox.checked = isChecked; // Đặt trạng thái checkbox theo Select All
                    });
                    calculateTotal(); // Tính lại tổng khi thay đổi trạng thái checkbox
                });

                // Xử lý sự kiện thay đổi trạng thái checkbox trong từng sản phẩm
                cartItems.forEach(item => {
                    const checkbox = item.querySelector(".select-item");
                    checkbox.addEventListener("change", function () {
                        // Nếu bất kỳ checkbox nào bị bỏ chọn, bỏ chọn Select All
                        if (!checkbox.checked) {
                            selectAllCheckbox.checked = false;
                        }
                        // Nếu tất cả checkbox đều được chọn, chọn Select All
                        const allChecked = Array.from(cartItems).every(item => item.querySelector(".select-item").checked);
                        if (allChecked) {
                            selectAllCheckbox.checked = true;
                        }
                        calculateTotal();
                    });
                });

                // Các sự kiện tăng/giảm số lượng
                cartItems.forEach(item => {
                    const decreaseButton = item.querySelector(".decrease");
                    const increaseButton = item.querySelector(".increase");
                    const quantityDisplay = item.querySelector(".qty-display");
                    const quantityInput = item.querySelector(".item-quantity");

                    // Lấy stock quantity từ data attribute
                    const stockQuantity = parseInt(item.dataset.stock);

                    decreaseButton.addEventListener("click", () => {
                        let quantity = parseInt(quantityDisplay.textContent);
                        if (quantity > 1) {
                            quantity--;
                            quantityDisplay.textContent = quantity;
                            quantityInput.value = quantity;
                            calculateTotal();
                        }
                    });

                    increaseButton.addEventListener("click", () => {
                        let quantity = parseInt(quantityDisplay.textContent);

                        // Kiểm tra nếu số lượng chưa vượt quá stock
                        if (quantity < stockQuantity) {
                            quantity++;
                            quantityDisplay.textContent = quantity;
                            quantityInput.value = quantity;
                            calculateTotal();
                        } else {
                            alert("Cannot add more. Stock limit reached!");
                        }
                    });
                });

                calculateTotal(); // Gọi hàm tính toán khi tải trang
            });

        </script>
    </body>
</html>
