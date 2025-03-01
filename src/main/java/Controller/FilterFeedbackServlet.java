/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Feedback;
import dal.ReviewsDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class FilterFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String productIdParam = request.getParameter("productId");
            String ratingParam = request.getParameter("rating");

            if (productIdParam == null || productIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing productId.");
                return;
            }

            int productId = Integer.parseInt(productIdParam);
            int rating = (ratingParam != null && !ratingParam.isEmpty()) ? Integer.parseInt(ratingParam) : 0;

            ReviewsDAO reviewsDAO = new ReviewsDAO();
            List<Feedback> filteredReviews;

            if (rating == 0) {
                filteredReviews = reviewsDAO.getReviewsByProductId(productId);
            } else {
                filteredReviews = reviewsDAO.getReviewsByProductIdAndRating(productId, rating);
            }

            request.setAttribute("reviewsList", filteredReviews);
            session.setAttribute("reviews", null);
            request.getRequestDispatcher("feedbackList.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters.");
        }
    }
}
