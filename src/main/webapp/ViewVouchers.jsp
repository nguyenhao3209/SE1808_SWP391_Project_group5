<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- Bootstrap 4.5.2 CSS -->
        <link rel="stylesheet" 
              href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <title>Your Vouchers</title>
    </head>
    <body>
        <!-- Include header (chỉnh lại đường dẫn nếu cần) -->
        <jsp:include page="common/header.jsp" />

        <div class="container mt-4">
            <h2 class="text-center mb-4">Your Exclusive Vouchers</h2>

            <!-- Nếu danh sách voucher rỗng, hiển thị thông báo -->
            <c:choose>
                <c:when test="${empty vouchers}">
                    <p>No vouchers found.</p>
                </c:when>
                <c:otherwise>
                    <!-- Bọc tất cả voucher trong .voucher-list -->
                    <div class="voucher-list">
                        <c:forEach var="voucher" items="${vouchers}">
                            <!-- Mỗi voucher hiển thị 1 hàng ngang -->
                            <div class="d-flex align-items-center justify-content-between p-3 mb-3 border rounded"
                                 style="cursor: pointer;"
                                 data-toggle="modal"
                                 data-target="#voucherModal${voucher.voucherID}">
                                <!-- Hình + Thông tin cơ bản -->
                                <div class="d-flex align-items-center">
                                    <!-- Kiểm tra imageURL rỗng thì dùng placeholder -->
                                    <img src="${empty voucher.imageURL ? 'images/voucher-placeholder.jpg' : voucher.imageURL}"
                                         alt="Voucher Image"
                                         class="img-fluid"
                                         style="width: 80px; height: 80px; object-fit: cover; margin-right: 15px;">
                                    <div>
                                        <h5 class="mb-2">${voucher.name}</h5>
                                        <p class="mb-1">
                                            <strong>Valid until:</strong> ${voucher.expiryDate}
                                        </p>
                                        <p class="mb-1">${voucher.description}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal hiển thị chi tiết cho voucher này -->
                            <div class="modal fade"
                                 id="voucherModal${voucher.voucherID}"
                                 tabindex="-1"
                                 role="dialog"
                                 aria-labelledby="voucherModalLabel${voucher.voucherID}"
                                 aria-hidden="true">

                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="voucherModalLabel${voucher.voucherID}">
                                                ${voucher.name}
                                            </h5>
                                            <!-- Nút X để đóng modal -->
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="text-center mb-3">
                                                <img src="${empty voucher.imageURL ? 'images/voucher-placeholder.jpg' : voucher.imageURL}"
                                                     alt="Voucher Image"
                                                     style="width: 120px; height: 120px; object-fit: cover;">
                                            </div>
                                            <p><strong>Name:</strong> ${voucher.name}</p>
                                            <p><strong>Description:</strong> ${voucher.description}</p>
                                            <p><strong>Expiry Date:</strong> ${voucher.expiryDate}</p>
                                            <p>
                                                <strong>Discount:</strong> 
                                                <!-- Nếu muốn format discountPercentage -->
                                                <fmt:formatNumber value="${voucher.discountPercentage}" pattern="##0.##"/>%
                                            </p>
                                            <p>
                                                <strong>Max Reducing:</strong> $
                                                <fmt:formatNumber value="${voucher.maxReducing}" pattern="###,##0.00"/>
                                            </p>
                                            <p><strong>Quantity:</strong> ${voucher.quantity}</p>
                                            <p><strong>Code:</strong> ${voucher.code}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Kết thúc modal -->
                        </c:forEach>
                    </div>
                    <!-- Kết thúc .voucher-list -->
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Bootstrap 4 JS: jQuery, Popper, Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
