<%-- 
    Document   : feedbackList
    Created on : Feb 27, 2025, 12:59:38 AM
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            .no-reviews-meme {
                text-align: center;
                padding: 20px;
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                margin: 20px 0;
                font-size: 18px;
                color: #6c757d;
            }

            .no-reviews-meme p {
                margin: 0;
                font-weight: bold;
            }

            .no-reviews-meme i {
                font-size: 24px;
                margin-bottom: 10px;
                color: #6c757d;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${empty reviewsList}">
                <div class="no-reviews-meme">
                    <i class="fas fa-comment-slash"></i>
                    <p>There are no reviews for this product.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="feedback" items="${reviewsList}">
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
            </c:otherwise>
        </c:choose>
    </body>
</html>