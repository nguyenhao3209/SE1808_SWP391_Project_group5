/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Customers;
import dal.CustomersDAO;
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
@WebServlet(name = "ResetPassword", urlPatterns = {"/resetPassword"})
public class ResetPassword extends HttpServlet {
    private CustomersDAO userDao = new CustomersDAO();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ResetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");

        // Kiểm tra token có hợp lệ không
        if (userDao.isTokenValid(token)) {
            // Token hợp lệ, chuyển đến trang đặt lại mật khẩu
            request.setAttribute("token", token); // Truyền token để xử lý ở form đặt lại mật khẩu
            request.getRequestDispatcher("reset_password.jsp").forward(request, response);
        } else {
            // Token không hợp lệ hoặc hết hạn
            request.setAttribute("error", "The reset token has expired or is invalid.");
            request.getRequestDispatcher("error.jsp").forward(request, response); // Điều hướng tới trang lỗi
        }

// Cái này đang test thử của forget_and reset_pass nha
//        String token = request.getParameter("token");
//
//        // Kiểm tra token có hợp lệ không
//        if (userDao.isTokenValid(token)) {
//            // Token hợp lệ, chuyển đến trang đặt lại mật khẩu
//            request.setAttribute("token", token); // Truyền token để xử lý ở form đặt lại mật khẩu
//            request.getRequestDispatcher("forgot_and_reset_password.jsp").forward(request, response);  // Điều hướng đến trang hợp nhất
//        } else {
//            // Token không hợp lệ hoặc hết hạn
//            request.setAttribute("errorMessage", "The reset token has expired or is invalid.");
//            request.getRequestDispatcher("forgot_and_reset_password.jsp").forward(request, response); // Điều hướng về trang hợp nhất với thông báo lỗi
//        }
//    }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("password");

        // Kiểm tra token và tìm người dùng
        Customers user = userDao.getUserByResetToken(token);
        if (user != null) {
            // Cập nhật mật khẩu mới
            userDao.updatePassword(user.getCustomerId(), newPassword);

            // Hiển thị thông báo thành công
            request.setAttribute("message", "Password has been updated successfully. Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response); // Điều hướng về trang login
        } else {
            request.setAttribute("error", "The token is invalid or has expired.");
            request.getRequestDispatcher("error.jsp").forward(request, response); // Điều hướng về trang lỗi
        }

        // Cái này đang test thử của forget_and reset_pass nha
//        String token = request.getParameter("token");
//        String newPassword = request.getParameter("password");
//
//        // Kiểm tra token và tìm người dùng
//        User user = userDao.getUserByResetToken(token);
//        if (user != null) {
//            // Cập nhật mật khẩu mới
//            userDao.updatePassword(user.getUserId(), newPassword);
//
//            // Hiển thị thông báo thành công
//            request.setAttribute("successMessage", "Password has been updated successfully. Please log in.");
//            request.getRequestDispatcher("login.jsp").forward(request, response); // Điều hướng về trang login
//        } else {
//            request.setAttribute("errorMessage", "The token is invalid or has expired.");
//            request.getRequestDispatcher("forgot_and_reset_password.jsp").forward(request, response); // Điều hướng về trang hợp nhất với thông báo lỗi
//        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
