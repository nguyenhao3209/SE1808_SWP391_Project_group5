/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.CustomersDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import Models.Customers;

/**
 *
 * @author CE180220_TranMinhKhanh
 */
@WebServlet(name = "CodeSecurityController", urlPatterns = {"/code"})
public class CodeSecurityController extends HttpServlet {

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
            out.println("<title>Servlet CodeSecurityController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CodeSecurityController at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Kiểm tra nếu cookie "code" tồn tại để so sánh với mã từ người dùng
            Cookie[] cookies = request.getCookies();
            String codeCookie = "";  // Biến lưu giá trị mã code từ cookie
            String tokenCookie = ""; // Biến lưu giá trị mã token từ cookie
            if (cookies != null) {  // Kiểm tra xem có cookie nào không
                for (Cookie cookie : cookies) {  // Duyệt qua tất cả các cookie
                    if ("code".equals(cookie.getName())) {  // Tìm cookie có tên "code"
                        codeCookie = cookie.getValue();  // Lấy giá trị của cookie "code"
                    }
                    if ("token".equals(cookie.getName())) {  // Tìm cookie có tên "token"
                        tokenCookie = cookie.getValue();  // Lấy giá trị của cookie "token"
                    }
                }
            }

            // Lấy mã code từ tham số request (người dùng nhập)
            String code = request.getParameter("code");
            // Kiểm tra nếu mã code từ cookie khớp với mã code người dùng nhập
            if (!codeCookie.equals("") && codeCookie.equals(code)) {
                // Chuyển hướng đến trang "resetPassword" với tham số token nếu mã khớp
                response.sendRedirect("resetPassword?token=" + tokenCookie);
            } else {
                // Nếu mã không khớp hoặc mã đã hết hạn, hiển thị thông báo lỗi
                request.setAttribute("error", "Incorrect or expired code.");
                request.getRequestDispatcher("code-security.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Xử lý ngoại lệ, in ra thông tin lỗi nếu có vấn đề xảy ra
            e.printStackTrace();
        }

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
