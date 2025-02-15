<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="./CSS/Cart.css">
</head>
<body>

<div class="cart-container">
    <!-- LEFT: Shopping Cart -->
    <div class="cart-left">
        <h2>Your Shopping Cart</h2>
        <table>
            <thead>
                <tr>
                    <th>Select</th>
                    <th>Item Info</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody id="cart-items">
                <!-- Product 1 -->
                <tr class="cart-item" data-price="100">
                    <td><input type="checkbox" class="select-item"></td>
                    <td>
                        <div class="product-info">
                            <img src="track-suit.jpg" alt="Track Suit">
                            <div class="product-details">
                                <strong>TRACK SUIT</strong>
                                <p>Clothing</p>
                                <a href="#" class="delete-item">Delete</a>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="qty-container">
                            <button class="qty-btn decrease">−</button>
                            <span class="qty-display">3</span>
                            <button class="qty-btn increase">+</button>
                        </div>
                    </td>
                    <td class="price">£100</td>
                    <td class="total">£300</td>
                </tr>

                <!-- Product 2 -->
                <tr class="cart-item" data-price="67">
                    <td><input type="checkbox" class="select-item"></td>
                    <td>
                        <div class="product-info">
                            <img src="hoodie.jpg" alt="Hoodie">
                            <div class="product-details">
                                <strong>Hoodie</strong>
                                <p>Clothing</p>
                                <a href="#" class="delete-item">Delete</a>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="qty-container">
                            <button class="qty-btn decrease">−</button>
                            <span class="qty-display">3</span>
                            <button class="qty-btn increase">+</button>
                        </div>
                    </td>
                    <td class="price">£67</td>
                    <td class="total">£201</td>
                </tr>

                <!-- Product 3 -->
                <tr class="cart-item" data-price="59">
                    <td><input type="checkbox" class="select-item"></td>
                    <td>
                        <div class="product-info">
                            <img src="grey-hoodie.jpg" alt="Grey Hoodie">
                            <div class="product-details">
                                <strong>GREY HOODIE</strong>
                                <p>Clothing</p>
                                <a href="#" class="delete-item">Delete</a>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="qty-container">
                            <button class="qty-btn decrease">−</button>
                            <span class="qty-display">2</span>
                            <button class="qty-btn increase">+</button>
                        </div>
                    </td>
                    <td class="price">£59</td>
                    <td class="total">£118</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- RIGHT: Order Summary -->
    <div class="cart-right">
        <h3>ORDER SUMMARY</h3>
        <div class="summary-item">
            <span>Items <span id="total-items">0</span></span>
            <span>£<span id="subtotal">0</span></span>
        </div>
        <div class="summary-item">
            <span>Shipping</span>
            <select id="shipping">
                <option value="5">Standard delivery - £5.00</option>
                <option value="10">Express delivery - £10.00</option>
            </select>
        </div>
        <div class="promo-code">
            <label>Promo Code</label>
            <input type="text" id="promo-code" placeholder="Enter your code">
            <button id="apply-promo">APPLY</button>
        </div>
        <div class="total-price">
            <span>Total</span>
            <span>£<span id="total">0</span></span>
        </div>
        <button class="checkout-btn">CHECKOUT</button>
    </div>
</div>

<script>document.addEventListener("DOMContentLoaded", function () {
    const cartItems = document.querySelectorAll(".cart-item");
    const totalItemsElement = document.getElementById("total-items");
    const subtotalElement = document.getElementById("subtotal");
    const totalElement = document.getElementById("total");
    const shippingElement = document.getElementById("shipping");
    const promoInput = document.getElementById("promo-code");
    const applyPromoButton = document.getElementById("apply-promo");

    function updateCart() {
        let subtotal = 0;
        let totalItems = 0;

        cartItems.forEach(item => {
            let checkbox = item.querySelector(".select-item");
            if (checkbox.checked) {
                let quantity = parseInt(item.querySelector(".qty-display").textContent);
                let price = parseInt(item.dataset.price);
                let total = quantity * price;

                subtotal += total;
                totalItems += quantity;
            }
        });

        let shippingCost = parseInt(shippingElement.value);
        let total = subtotal + shippingCost;

        subtotalElement.textContent = subtotal;
        totalItemsElement.textContent = totalItems;
        totalElement.textContent = total;
    }

    cartItems.forEach(item => {
        let qtyDisplay = item.querySelector(".qty-display");
        let decreaseBtn = item.querySelector(".decrease");
        let increaseBtn = item.querySelector(".increase");
        let deleteBtn = item.querySelector(".delete-item");
        let checkbox = item.querySelector(".select-item");

        increaseBtn.addEventListener("click", () => {
            let qty = parseInt(qtyDisplay.textContent);
            qtyDisplay.textContent = qty + 1;
            updateCart();
        });

        decreaseBtn.addEventListener("click", () => {
            let qty = parseInt(qtyDisplay.textContent);
            if (qty > 1) {
                qtyDisplay.textContent = qty - 1;
                updateCart();
            }
        });

        deleteBtn.addEventListener("click", (e) => {
            e.preventDefault();
            item.remove();
            updateCart();
        });

        checkbox.addEventListener("change", updateCart);
    });

    shippingElement.addEventListener("change", updateCart);

    applyPromoButton.addEventListener("click", () => {
        let code = promoInput.value.trim();
        if (code === "DISCOUNT10") {
            let currentTotal = parseInt(totalElement.textContent);
            let discount = Math.floor(currentTotal * 0.10);
            totalElement.textContent = currentTotal - discount;
            alert("Promo code applied! 10% off.");
        } else {
            alert("Invalid promo code.");
        }
    });

    updateCart();
});
</script>
</body>
</html>
