<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome (để có icon mũi tên) -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 30px;
        }
        .left-column, .right-column {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            flex: 1;
            min-width: 300px;
        }
        .left-column {
            flex: 2;
        }
        .right-column {
            flex: 1;
        }
        .invoice-title {
            font-size: 28px;
            font-weight: bold;
            color: #333333;
            margin-bottom: 20px;
        }
        .table th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            text-align: center;
            border: 1px solid #dee2e6;
        }
        .table td {
            vertical-align: middle;
            text-align: left;
            border: 1px solid #dee2e6;
        }
        .total-row {
            font-weight: bold;
        }
        .payment-method-title {
            font-size: 20px;
            margin-top: 20px;
            font-weight: bold;
        }
        .btn-submit {
            font-size: 16px;
            font-weight: bold;
            padding: 10px 20px;
        }
        .original-price {
            text-decoration: line-through;
            color: red;
            margin-right: 5px;
        }

        /* Shopee-style voucher bar */
        .voucher-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
        }
        .voucher-bar-left {
            display: flex;
            align-items: center;
        }
        .voucher-icon {
            width: 24px;
            height: 24px;
            margin-right: 8px;
        }
        .voucher-name {
            color: #ff5722; 
            font-size: 14px; 
            border: 1px solid #ff5722; 
            border-radius: 4px; 
            padding: 2px 6px; 
            margin-right: 6px;
        }
        .no-voucher {
            color: #999;
            border: none;
        }
        .discount-row {
            font-weight: normal;
        }

        /* =========== Tùy chỉnh bảng voucher =========== */
        .table-voucher thead th {
            color: #333; 
            text-transform: capitalize; /* Chỉ in hoa chữ cái đầu */
        }
        .table-voucher thead tr {
            background-color: #ffe7e0; /* Nhạt hơn, tông cam */
        }
        .table-voucher tbody tr:hover {
            background-color: #fff3e0; /* Hover cam nhạt */
        }

        /* Nút bo tròn */
        .btn-rounded {
            border-radius: 8px !important;
        }
    </style>
</head>
<body>
    <!-- Include header nếu cần -->
    <jsp:include page="common/header.jsp"/>

    <!-- Nếu cartList rỗng -->
    <c:if test="${empty sessionScope.cartList}">
        <p style="color:red;">Cart is empty</p>
    </c:if>

    <!-- HIỂN THỊ LỖI (NẾU CÓ) -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger mx-3" role="alert">
            ${error}
        </div>
    </c:if>

    <div class="container">
        <!-- LEFT COLUMN: Invoice -->
        <div class="left-column">
            <h1 class="invoice-title">Invoice Details</h1>
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Picture</th>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${sessionScope.cartList}">
                        <tr>
                            <td>
                                <img width="80px"
                                     src="./img/${item.product.category.categoryName}/${item.product.getImageURL()}"
                                     alt="${item.product.productName}">
                            </td>
                            <td>
                                ${item.product.productName}
                                <c:if test="${not empty item.productSizes}">
                                    (Size: ${item.productSizes.size})
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${item.product.discountProduct > 0}">
                                    <div class="product-price">
                                        <span class="original-price">
                                            <fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" />$
                                        </span><br/>
                                        <span class="product-price discounted-price text-success fw-bold">
                                            $<fmt:formatNumber 
                                                value="${String.format('%f', item.product.price * (1 - item.product.discountProduct / 100))}" 
                                                pattern="###,##0.00" />
                                        </span>
                                    </div>
                                </c:if>
                                <c:if test="${item.product.discountProduct le 0}">
                                    <div class="product-price">
                                        $<fmt:formatNumber value="${item.product.price}" pattern="###,##0.00" />
                                    </div>
                                </c:if>
                            </td>
                            <td>${item.quantity}</td>
                            <td>
                                $<fmt:formatNumber 
                                    value="${item.quantity * (item.product.price * (1 - item.product.discountProduct / 100))}" 
                                    pattern="###,##0.00" />
                            </td>
                        </tr>
                    </c:forEach>

                    <!-- Grand Total Row -->
                    <tr class="total-row">
                        <td colspan="3" class="text-end">Total Amount</td>
                        <td colspan="2">
                            $<fmt:formatNumber value="${sessionScope.brandTotal}" pattern="###,##0.00" />
                        </td>
                    </tr>

                    <!-- Discount Row (ẩn mặc định) -->
                    <tr id="discountRow" class="discount-row text-danger" style="display:none;">
                        <td colspan="3" class="text-end">Discount (<span id="discountPercent"></span>%)</td>
                        <td colspan="2">- $<span id="discountValue"></span></td>
                    </tr>

                    <!-- Final Amount Row (ẩn mặc định) -->
                    <tr id="finalTotalRow" class="total-row" style="display:none;">
                        <td colspan="3" class="text-end">Final Amount</td>
                        <td colspan="2" id="finalAmountCell"></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- RIGHT COLUMN: Customer Info + Payment Method -->
        <div class="right-column">
            <h3 class="payment-method-title">Customer Information</h3>
            <!-- Form Payment -->
            <form action="payment" method="post">
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th>Name</th>
                            <td>${sessionScope.user.customerName}</td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td>${sessionScope.user.email}</td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td>
                                <c:choose>
                                    <c:when test="${empty sessionScope.user.phone}">
                                        <input type="text" name="phoneNumber" class="form-control"
                                               placeholder="Enter your phone number" required>
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.user.phone}
                                        <input type="hidden" name="phoneNumber" value="${sessionScope.user.phone}">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td>
                                <c:choose>
                                    <c:when test="${empty sessionScope.user.address}">
                                        <input type="text" name="address" class="form-control"
                                               placeholder="Enter your address" required>
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.user.address}
                                        <input type="hidden" name="address" value="${sessionScope.user.address}">
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- Shopee-Style VOUCHER BAR -->
                <div class="mt-3">
                    <div class="voucher-bar" onclick="openVoucherModal()">
                        <!-- Bên trái: icon + text “Voucher” -->
                        <div class="voucher-bar-left">
                            <img src="img/voucher-icon.webp" alt="Voucher Icon" class="voucher-icon">
                            <span style="font-weight: bold; color: #333;">Voucher</span>
                        </div>
                        <!-- Bên phải: Tên voucher + mũi tên -->
                        <div style="display: flex; align-items: center;">
                            <!-- Mặc định: “No voucher” -->
                            <span id="voucherName" class="voucher-name no-voucher">No voucher</span>
                            <i class="fa fa-angle-right" style="color: #999;"></i>
                        </div>
                    </div>
                </div>

                <!-- MODAL hiển thị voucher -->
                <div class="modal fade" id="voucherModal" tabindex="-1" aria-labelledby="voucherModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="voucherModalLabel">Available Vouchers</h5>
                                <!-- Dấu X đóng modal -->
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">
                                <c:choose>
                                    <c:when test="${empty availableVouchers}">
                                        <p>No valid vouchers for your order.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Bảng voucher: radio buttons -->
                                        <table class="table table-voucher table-bordered align-middle">
                                            <thead>
                                                <tr>
                                                    <th>Code</th>
                                                    <th>Name</th>
                                                    <th>Discount (%)</th>
                                                    <th>Max Reducing</th>
                                                    <th>Expiry Date</th>
                                                    <th>Select</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="v" items="${availableVouchers}">
                                                    <tr>
                                                        <td>${v.code}</td>
                                                        <td>${v.name}</td>
                                                        <td>${v.discountPercentage}</td>
                                                        <td>$<fmt:formatNumber value="${v.maxReducing}" pattern="###,##0.00" /></td>
                                                        <td>${v.expiryDate}</td>
                                                        <td>
                                                            <!-- Radio => có thể bỏ chọn nhờ script toggle -->
                                                            <input type="radio" 
                                                                   name="selectedVoucher" 
                                                                   value="${v.code}"
                                                                   data-vname="${v.name}">
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="modal-footer">
                                <!-- Không có nút Close, chỉ nút Apply -->
                                <button type="button" 
                                        class="btn btn-primary btn-sm btn-rounded"
                                        onclick="applyVoucher()">Apply Voucher</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- KẾT THÚC PHẦN VOUCHER -->

                <h2 class="payment-method-title mt-4">Choose Payment Method</h2>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="cashOnDelivery" value="Cash_On_Delivery" checked>
                    <label class="form-check-label" for="cashOnDelivery">Cash on Delivery</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="VNPay">
                    <label class="form-check-label" for="paypal">VNPay</label>
                </div>

                <!-- Submit Button -->
                <div class="text-end mt-3">
                    <button type="submit" class="btn btn-primary btn-submit btn-rounded">Confirm & Pay</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Toast hiển thị ở góc phải trên (top-right) -->
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 9999">
        <div id="voucherToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <!-- Nội dung sẽ được thay đổi bằng JS -->
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <script>
    // Mở modal voucher
    function openVoucherModal() {
        let modalEl = document.getElementById('voucherModal');
        let modal = new bootstrap.Modal(modalEl);
        modal.show();
    }

    // Tạo tính năng toggle cho radio => cho phép bỏ chọn
    document.addEventListener('DOMContentLoaded', () => {
        let radios = document.getElementsByName('selectedVoucher');
        radios.forEach(radio => {
            radio.addEventListener('click', function() {
                // Nếu radio này đã checked trước đó => bỏ check
                if (this.oldChecked) {
                    this.checked = false;
                }
                // Reset oldChecked cho tất cả
                radios.forEach(r => r.oldChecked = false);
                // Đánh dấu oldChecked cho radio này
                this.oldChecked = this.checked;
            });
        });
    });

    // Hàm applyVoucher(): nếu không có radio nào được chọn => "NONE"
    function applyVoucher() {
        let radios = document.getElementsByName('selectedVoucher');
        let selectedCode = null;
        let selectedName = "No voucher";

        for (let r of radios) {
            if (r.checked) {
                selectedCode = r.value;
                selectedName = r.dataset.vname;
                break;
            }
        }

        // Nếu tất cả radio đều bỏ chọn => "NONE"
        if (!selectedCode) {
            selectedCode = "NONE";
        }

        let formData = new FormData();
        formData.append("voucherCode", selectedCode);

        fetch("CheckVoucherServlet", {
            method: "POST",
            body: formData
        })
        .then(resp => resp.json())
        .then(data => {
            if (data.success) {
                let discount = parseFloat(data.discount);
                let discountPercent = parseFloat(data.discountPercentage);
                let finalTotal = parseFloat(data.finalTotal);

                let vName = data.voucherName;
                let voucherNameSpan = document.getElementById('voucherName');
                voucherNameSpan.textContent = vName;
                voucherNameSpan.classList.remove('no-voucher');

                let discountRow = document.getElementById('discountRow');
                let discountPercentSpan = document.getElementById('discountPercent');
                let discountValueSpan = document.getElementById('discountValue');
                let finalRow = document.getElementById('finalTotalRow');
                let finalAmountCell = document.getElementById('finalAmountCell');

                if (discount > 0) {
                    discountRow.style.display = 'table-row';
                    discountPercentSpan.textContent = discountPercent.toFixed(0);
                    discountValueSpan.textContent = discount.toFixed(2);
                } else {
                    discountRow.style.display = 'none';
                }
                finalRow.style.display = 'table-row';
                finalAmountCell.textContent = "$" + finalTotal.toFixed(2);

                showVoucherToast("Voucher applied! Discount: $" + discount.toFixed(2));

                // Đóng modal
                let modalEl = document.getElementById('voucherModal');
                let modal = bootstrap.Modal.getInstance(modalEl);
                modal.hide();
            } else {
                alert(data.message);
            }
        })
        .catch(err => {
            console.error("Error applying voucher:", err);
            alert("Error applying voucher");
        });
    }

    // Hàm hiển thị Toast
    function showVoucherToast(msg) {
        let toastEl = document.getElementById('voucherToast');
        let toastBody = toastEl.querySelector('.toast-body');
        toastBody.textContent = msg;

        let toast = new bootstrap.Toast(toastEl, { delay: 2000 });
        toast.show();
    }
    </script>
</body>
</html>
