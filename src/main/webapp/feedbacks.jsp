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
    </head>
    <body>
        <h1>Customer Feedback</h1>
        <div class="reviews">
            <c:forEach var="feedback" items="${reviews}">
                <div class="review">
                    <div class="review-header">
                        <span class="username">${feedback.customerID}</span>
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
                        <form action="feedbacks-controller" method="post" id="editFeedbackForm${feedback.feedbackID}" class="reply-form" style="display: none">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="feedbackID" value="${feedback.feedbackID}">
                            <input type="hidden" name="productID" value="${productID}">
                            <textarea name="comment" rows="2" required>${feedback.comment}</textarea>
                            <button type="submit" class="btn-primary">Save Changes</button>
                        </form>
                        <c:if test="${sessionScope.user != null && feedback.customerID == sessionScope.user.customerID}">
                            <button class="btn-action" onclick="editFeedback('${feedback.feedbackID}')">Edit</button>
                            <button class="btn-action" onclick="deleteFeedback('${feedback.feedbackID}')">Delete</button>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${sessionScope.user != null && isBought}">
                <div class="review-form">
                    <form action="feedbacks-controller" method="post">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productID" value="${productID}">
                        <input type="hidden" name="customerID" value="${sessionScope.user.customerID}">
                        <textarea name="comment" rows="4" placeholder="Write your feedback here..." required></textarea>
                        <div class="star-rating">
                            <i class="fas fa-star" data-value="1"></i>
                            <i class="fas fa-star" data-value="2"></i>
                            <i class="fas fa-star" data-value="3"></i>
                            <i class="fas fa-star" data-value="4"></i>
                            <i class="fas fa-star" data-value="5"></i>
                        </div>
                        <input type="hidden" name="rating" id="rating-value" required>
                        <button type="submit" class="btn-primary">Submit Feedback</button>
                    </form>
                </div>
            </c:if>
        </div>
        
        <script>
            function editFeedback(id) {
                document.getElementById('editFeedbackForm' + id).style.display = 'block';
            }
            function deleteFeedback(id) {
                if (confirm("Are you sure you want to delete this feedback?")) {
                    window.location.href = "feedbacks-controller?action=delete&feedbackID=" + id + "&productID=${productID}";
                }
            }
            document.querySelectorAll('.star-rating .fa-star').forEach(star => {
                star.addEventListener('click', () => {
                    const rating = star.getAttribute('data-value');
                    document.getElementById('rating-value').value = rating;
                    document.querySelectorAll('.star-rating .fa-star').forEach(s => {
                        s.classList.remove('checked');
                        if (s.getAttribute('data-value') <= rating) {
                            s.classList.add('checked');
                        }
                    });
                });
            });
        </script>
    </body>
</html>
