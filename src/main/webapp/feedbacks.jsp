<%-- 
    Document   : feedbacks
    Created on : Feb 18, 2025, 9:39:14 AM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Feedback</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    </head>
            <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                /*        background: linear-gradient(135deg, #f5f7fa, #c3cfe2);*/
                color: #333;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
                font-size: 2.5rem;
                margin-bottom: 30px;
                font-weight: 600;
            }

            .filter-section {
                text-align: center;
                margin-bottom: 20px;
            }

            .filter-section label {
                font-size: 1rem;
                color: #333;
                margin-right: 10px;
            }

            .filter-section select {
                padding: 8px 12px;
                border-radius: 8px;
                border: 1px solid #ddd;
                font-size: 1rem;
                background-color: #fff;
                cursor: pointer;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .filter-section select:hover {
                border-color: #6a11cb;
                box-shadow: 0 0 8px rgba(106, 17, 203, 0.2);
            }

            .filter-section select:focus {
                outline: none;
                border-color: #6a11cb;
                box-shadow: 0 0 12px rgba(106, 17, 203, 0.3);
            }

            .reviews {
                max-width: 800px;
                margin: 0 auto;
            }

            .review {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .review:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            }

            .review-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .username {
                font-weight: 600;
                color: #333;
                font-size: 1.1rem;
            }

            .rating {
                color: #FFD700;
            }

            .rating .fa-star {
                cursor: pointer;
                font-size: 18px;
                color: #ddd;
                transition: color 0.3s ease;
            }

            .rating .fa-star.checked {
                color: #FFD700;
            }

            .review-body {
                margin-bottom: 15px;
            }

            .review-body p {
                margin: 0;
                line-height: 1.6;
                color: #555;
            }

            .btn-action {
                background: linear-gradient(135deg, #6a11cb, #2575fc);
                color: white;
                border: none;
                padding: 8px 16px;
                height: 30px;
                border-radius: 25px;
                cursor: pointer;
                margin-right: 10px;
                transition: background 0.3s ease, transform 0.3s ease;
                font-size: 0.9rem;
            }

            .btn-action:hover {
                background: linear-gradient(135deg, #2575fc, #6a11cb);
                transform: scale(1.05);
            }

            .reply-form {
                margin-top: 15px;
            }

            .reply-form textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                resize: vertical;
                margin-bottom: 10px;
                font-family: 'Poppins', sans-serif;
                font-size: 0.9rem;
            }

            .btn-minhanh {
                background: linear-gradient(135deg, #6a11cb, #2575fc);
                color: white;
                border: none;
                height: 30px;
                padding: 8px 16px;
                border-radius: 25px;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.3s ease;
                font-size: 0.9rem;
            }

            .btn-minhanh:hover {
                background: linear-gradient(135deg, #2575fc, #6a11cb);
                transform: scale(1.05);
            }

            .review-replies {
                margin-top: 15px;
                padding-left: 20px;
                border-left: 2px solid #6a11cb;
            }

            .reply {
                background: #f8f9fa;
                padding: 10px;
                border-radius: 8px;
                margin-bottom: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .reply p {
                margin: 0;
                line-height: 1.6;
                color: #555;
            }

            .star-rating {
                margin-bottom: 15px;
            }

            .star-rating .fa-star {
                cursor: pointer;
                font-size: 24px;
                color: #ddd;
                transition: color 0.3s ease;
            }

            .star-rating .fa-star.checked {
                color: #FFD700;
            }

            .review-form {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 30px;
            }

            .review-form textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 8px;
                resize: vertical;
                margin-bottom: 10px;
                font-family: 'Poppins', sans-serif;
                font-size: 0.9rem;
            }

            /* Thông báo khi không có đánh giá phù hợp */
            .no-reviews-message {
                text-align: center;
                color: #ff4d4d;
                font-size: 1.2rem;
                margin-top: 20px;
                display: none; /* Ẩn ban đầu */
            }

            .error-message {
                color: red;
                font-size: 0.9rem;
                margin-bottom: 10px;
                display: none;
            }
        </style>
    <body>
        <h1>Customer Feedback</h1>

        <!-- Filter Section -->
        <div class="filter-section">
            <label for="rating-filter">Filter by Rating:</label>
            <select id="rating-filter" onchange="filterFeedbacks()">
                <option value="0">All Ratings</option>
                <option value="1">1 Star</option>
                <option value="2">2 Stars</option>
                <option value="3">3 Stars</option>
                <option value="4">4 Stars</option>
                <option value="5">5 Stars</option>
            </select>
        </div>

        <div class="reviews">
            <!-- Thông báo khi không có đánh giá phù hợp -->
            <div class="no-reviews-message"></div>
            <div id="feedbackList">
                <c:if test="${not empty sessionScope.reviews}">
                    <c:forEach var="feedback" items="${reviews}">
                        <div class="review" data-rating="${feedback.rating}">
                            <div class="review-header">
                                <strong> <span class="username">${feedback.user.customerName}</span></strong><br/>
                                <span class="rating">
                                    <i class="fas fa-star ${feedback.rating >= 1 ? 'checked' : ''}"></i>
                                    <i class="fas fa-star ${feedback.rating >= 2 ? 'checked' : ''}"></i>
                                    <i class="fas fa-star ${feedback.rating >= 3 ? 'checked' : ''}"></i>
                                    <i class="fas fa-star ${feedback.rating >= 4 ? 'checked' : ''}"></i>
                                    <i class="fas fa-star ${feedback.rating >= 5 ? 'checked' : ''}"></i>
                                </span>
                            </div>
                            <div class="review-body">
                                <p>${feedback.comment}</p>
                                <form action="feedbacks-controller" method="post" id="editFeedbackForm${feedback.reviewID}" class="reply-form" style="display: none">
                                    <input type="hidden" name="action" value="edit">
                                    <input type="hidden" name="feedbackID" value="${feedback.reviewID}">
                                    <input type="hidden" name="productID" value="${feedback.productID}">
                                    <textarea name="comment" rows="2" required>${feedback.comment}</textarea>
                                    <button type="submit" class="btn-minhanh">Save Changes</button>
                                </form>
                                <c:if test="${sessionScope.user != null && feedback.user.customerId == sessionScope.user.customerId}">
                                    <button class="btn-action" onclick="editFeedback('${feedback.reviewID}')">Edit</button>
                                    <button class="btn-action" onclick="deleteFeedback('${feedback.reviewID}')">Delete</button>
                                </c:if>
                            </div>

                            <!-- Hiển thị danh sách reply -->
                            <div class="review-replies">
                                <c:forEach var="reply" items="${feedback.replies}">
                                    <div class="reply">
                                        <p><strong>${reply.user.customerName}:</strong> ${reply.comment}</p>

                                        <!-- Form chỉnh sửa reply -->
                                        <form action="replyServlet" method="post" id="editReplyForm${reply.replyID}" class="reply-form" style="display: none">
                                            <input type="hidden" name="action" value="edit">
                                            <input type="hidden" name="replyId" id="editReplyId" value="${reply.replyID}">
                                            <input type="hidden" name="productID" value="${product.productID}">
                                            <textarea name="comment" id="editReplyComment" rows="2" required>${reply.comment}</textarea>
                                            <button type="submit" class="btn-minhanh" name="action" value="edit">Save Changes</button>
                                        </form>

                                        <!-- Nút chỉnh sửa và xóa reply -->
                                        <c:if test="${sessionScope.user != null && reply.user.customerId == sessionScope.user.customerId}">
                                            <button class="btn-action" onclick="editReply(${reply.replyID}, `${reply.comment}`)">Edit</button>
                                            <button class="btn-action" onclick="deleteReply(${reply.replyID})">Delete</button>
                                        </c:if>
                                    </div>
                                </c:forEach>

                                <!-- Form để thêm reply -->
                                <c:if test="${sessionScope.user != null}">
                                    <form action="replyServlet" method="post" class="reply-form">
                                        <input type="hidden" name="reviewId" value="${feedback.reviewID}">
                                        <input type="hidden" name="customerID" value="${sessionScope.user.customerId}">
                                        <input type="hidden" name="productID" value="${product.productID}">
                                        <textarea name="comment" rows="2" placeholder="Write your reply here..." required></textarea>
                                        <button type="submit" class="btn-minhanh" name="action" value="add">Reply</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>

            </div>

            <c:if test="${sessionScope.user != null && isBought}">
                <div class="review-form">
                    <form action="feedbacks-controller" method="post" onsubmit="return validateRating()">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productID" value="${product.productID}">
                        <input type="hidden" name="customerId" value="${sessionScope.user.customerId}">
                        <textarea name="comment" rows="4" placeholder="Write your feedback here..." required></textarea>
                        <div class="star-rating">
                            <i class="fas fa-star" data-value="1"></i>
                            <i class="fas fa-star" data-value="2"></i>
                            <i class="fas fa-star" data-value="3"></i>
                            <i class="fas fa-star" data-value="4"></i>
                            <i class="fas fa-star" data-value="5"></i>
                        </div>
                        <input type="hidden" name="rating" id="rating-value" required>
                        <div class="error-message" style="color: red; display: none;">Please select a rating before submitting your feedback.</div>
                        <button type="submit" class="btn-minhanh">Submit Feedback</button>
                    </form>
                </div>
            </c:if>
        </div>

        <script>
            // Xử lý đổi màu sao khi click
            document.querySelectorAll('.star-rating .fa-star').forEach(star => {
                star.addEventListener('click', () => {
                    const rating = star.getAttribute('data-value'); // Lấy giá trị rating
                    document.getElementById('rating-value').value = rating; // Cập nhật giá trị rating vào input ẩn

                    // Đổi màu sao được chọn
                    document.querySelectorAll('.star-rating .fa-star').forEach(s => {
                        if (s.getAttribute('data-value') <= rating) {
                            s.classList.add('checked'); // Thêm class checked cho sao được chọn
                        } else {
                            s.classList.remove('checked'); // Xóa class checked cho sao không được chọn
                        }
                    });
                });
            });

            // Hàm chỉnh sửa feedback
            function editFeedback(id) {
                document.getElementById('editFeedbackForm' + id).style.display = 'block';
            }

            // Hàm xóa feedback
            function deleteFeedback(id) {
                if (confirm("Are you sure you want to delete this feedback?")) {
                    window.location.href = "feedbacks-controller?action=delete&feedbackID=" + id + "&productID=${product.productID}";
                }
            }

            // Hàm chỉnh sửa reply
            function editReply(id, comment) {
                document.getElementById('editReplyForm' + id).style.display = 'block';
            }

            // Hàm xóa reply
            function deleteReply(id) {
                if (confirm("Are you sure you want to delete this reply?")) {
                    window.location.href = "replyServlet?action=delete&replyId=" + id + "&productID=" + `${product.productID}`;
                }
            }
            if (!hasMatchingReview && selectedRating !== 0) {
                noReviewsMessage.textContent = `No reviews found with ${selectedRating} star(s).`;
                noReviewsMessage.style.display = 'block';
            } else {
                noReviewsMessage.style.display = 'none';
            }
            // Hàm validate rating trước khi submit feedback
            function validateRating() {
                const ratingValue = document.getElementById('rating-value').value;
                const errorMessage = document.querySelector('.error-message');

                if (!ratingValue) {
                    errorMessage.style.display = 'block';
                    return false; // Ngăn form được submit
                } else {
                    errorMessage.style.display = 'none';
                    return true; // Cho phép form được submit
                }
            }


        </script>


        <script>
            $(document).ready(function () {
                $('#rating-filter').change(function () {
                    var selectedRating = $(this).val();
                    var productId = "${product.productID}"; // Đảm bảo lấy đúng ID từ JSP

                    $.ajax({
                        url: 'filter-feedback',
                        type: 'GET',
                        data: {
                            productId: productId, // Đảm bảo thống nhất với Servlet
                            rating: selectedRating
                        },
                        dataType: 'html',
                        success: function (response) {
                            $('#feedbackList').html(response);
                        },
                        error: function () {
                            $('#feedbackList').html('<p class="error">Error loading review.</p>');
                        }
                    });
                });
            });
        </script>


    </body>
</html>