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
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        switch (action) {
            case "add":
                addFeedback(request, response);
                break;
            case "edit":
                editFeedback(request, response);
                break;
            default:
                response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
                break;
        }
    }

    private void addFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String productID = request.getParameter("productID");
        String customerID = request.getParameter("customerId");
        String comment = request.getParameter("comment");
        String rating = request.getParameter("rating");

        ReviewsDAO dao = new ReviewsDAO();
        Feedback newReply = new Feedback();
        newReply.setRating(Integer.parseInt(rating));
        newReply.setProductID(Integer.parseInt(productID));
        newReply.setCustomerId(customerID);
        newReply.setComment(comment);

        dao.addReview(newReply);

        response.sendRedirect("productDetails?id=" + productID);
        return;
    }

    private void editFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String feedbackId = request.getParameter("feedbackID");
        String productId = request.getParameter("productID");
        String comment = request.getParameter("comment");

        if (feedbackId == null || feedbackId.isEmpty()) {
            response.sendRedirect("productDetails?id=" + productId);
            return;
        }

        ReviewsDAO dao = new ReviewsDAO();
        Feedback reply = dao.getFeedbackById(Integer.parseInt(feedbackId));

        if (reply != null) {
            reply.setComment(comment);
            dao.updateFeedback(reply);
        }

        // Chuyển hướng sau khi xử lý xong
        response.sendRedirect("productDetails?id=" + productId);
    }

    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String feedbackId = request.getParameter("feedbackID");

        if (feedbackId == null || feedbackId.isEmpty()) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        ReviewsDAO dao = new ReviewsDAO();
        Feedback reply = dao.getFeedbackById(Integer.parseInt(feedbackId));

        if (reply != null) {
            dao.deleteFeedback(Integer.parseInt(feedbackId));
        }

        response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        switch (action) {
            case "delete":
                deleteFeedback(request, response);
                break;
            default:
                response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
                break;
        }
    }
}
