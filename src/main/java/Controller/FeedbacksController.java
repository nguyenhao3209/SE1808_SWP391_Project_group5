/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.ReviewsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Models.Feedback;

@WebServlet(name = "FeedbacksController", urlPatterns = {"/feedbacks-controller"})
public class FeedbacksController extends HttpServlet {

    private final ReviewsDAO reviewsDAO = new ReviewsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String productID = request.getParameter("productID");

        if (action == null) {
            response.sendRedirect("productsDetail?id=" + productID);
            return;
        }

        switch (action) {
            case "add":
                addFeedback(request, response);
                break;
            case "edit":
                editFeedback(request, response);
                break;
            case "delete":
                deleteFeedback(request, response);
                break;
            default:
                response.sendRedirect("productsDetail?id=" + productID);
                break;
        }
    }

    private void addFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("productID");
        String customerID = request.getParameter("customerID");
        String comment = request.getParameter("comment");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Feedback feedback = new Feedback();
        feedback.setProductID(Integer.parseInt(productID));
        feedback.setCustomerID(customerID);
        feedback.setRating(rating);
        feedback.setComment(comment);

        reviewsDAO.addReview(feedback);
        response.sendRedirect("productsDetail?id=" + productID);
    }

    private void editFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String feedbackID = request.getParameter("feedbackID");
        String comment = request.getParameter("comment");
        
        Feedback feedback = reviewsDAO.getFeedbackById(feedbackID);
        if (feedback != null) {
            feedback.setComment(comment);
            reviewsDAO.updateFeedback(feedback);
        }

        response.sendRedirect("productsDetail?id=" + request.getParameter("productID"));
    }

    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String feedbackID = request.getParameter("feedbackID");
        
        if (feedbackID != null && !feedbackID.isEmpty()) {
            reviewsDAO.deleteFeedback(feedbackID);
        }
        
        response.sendRedirect("productsDetail?id=" + request.getParameter("productID"));
    }
}
