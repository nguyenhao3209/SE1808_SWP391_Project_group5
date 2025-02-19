/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Models.Reply;
import dal.ReplyDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
@WebServlet(name="ReplyServlet", urlPatterns={"/replyServlet"})
public class ReplyServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        switch (action) {
            case "delete":
                deleteReply(request, response);
                break;
            default:
                response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
                break;
        }
    }}
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        switch (action) {
            case "add":
                addReply(request, response);
                break;
            case "edit":
                editReply(request, response);
                break;
            default:
                response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
                break;
        }
    }

    private void addReply(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String feedbackID = request.getParameter("reviewId");
        String customerID = request.getParameter("customerID");
        String comment = request.getParameter("comment");

        if (customerID == null || customerID.isEmpty() || feedbackID == null || feedbackID.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        ReplyDAO replyDao = new ReplyDAO();
        Reply newReply = new Reply();
        newReply.setFeedbackID(Integer.parseInt(feedbackID));
        newReply.setCustomerId(customerID);
        newReply.setComment(comment);

        replyDao.addReply(newReply);

        response.sendRedirect("productDetails?id=" +  request.getParameter("productID"));
    }

    private void editReply(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String replyId = request.getParameter("replyId");
        String comment = request.getParameter("comment");

        if (replyId == null || replyId.isEmpty()) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        ReplyDAO replyDao = new ReplyDAO();
        Reply reply = replyDao.getReplyById(Integer.parseInt(replyId));

        if (reply != null) {
            reply.setComment(comment);
            replyDao.updateReply(reply);
        }

        response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
    }

    private void deleteReply(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String replyId = request.getParameter("replyId");

        if (replyId == null || replyId.isEmpty()) {
            response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
            return;
        }

        ReplyDAO replyDao = new ReplyDAO();
        Reply reply = replyDao.getReplyById(Integer.parseInt(replyId));

        if (reply != null) {
            replyDao.deleteReply(Integer.parseInt(replyId));
        }

        response.sendRedirect("productDetails?id=" + request.getParameter("productID"));
    
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
