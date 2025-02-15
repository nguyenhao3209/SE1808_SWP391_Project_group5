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

import Models.Customers;

/**
 *
 * @author CE180220_TranMinhKhanh
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        // Kiểm tra nếu cookie tồn tại và tự động điền email/password vào form
        Cookie[] cookies = request.getCookies();
        String email = "";
        String password = "";

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("email".equals(cookie.getName())) {
                    email = cookie.getValue();
                }
                if ("password".equals(cookie.getName())) {
                    password = cookie.getValue();
                }
            }
        }

        // Đặt thuộc tính cho request để hiển thị trên form
        request.setAttribute("email", email);
        request.setAttribute("password", password);

        // Chuyển hướng về trang đăng nhập
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try {
            // Lấy thông tin đăng nhập từ form
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String rememberMe = request.getParameter("rememberMe");

            // Kiểm tra thông tin người dùng trong database
            CustomersDAO udao = new CustomersDAO();
            Customers user = udao.loginWithEmailAndPassword(email, password);

            if (user != null) {
                // Kiểm tra trạng thái tài khoản
                if (user.getStatus() == Customers.Status.ACTIVE) {
                    // Tạo session và lưu thông tin người dùng
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);

                    // Đăng nhập thành công, kiểm tra "Remember me"
                    if ("on".equals(rememberMe)) {
                        // Tạo cookie cho email và password
                        Cookie emailCookie = new Cookie("email", email);
                        Cookie passwordCookie = new Cookie("password", password);

                        // Đặt thời gian sống cho cookie (7 ngày)
                        emailCookie.setMaxAge(7 * 24 * 60 * 60);
                        passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                        emailCookie.setPath("/");
                        passwordCookie.setPath("/");

                        // Gửi cookie về trình duyệt
                        response.addCookie(emailCookie);
                        response.addCookie(passwordCookie);
                    } else {
                        // Nếu không chọn "Remember me", xóa cookie nếu tồn tại
                        Cookie emailCookie = new Cookie("email", "");
                        Cookie passwordCookie = new Cookie("password", "");
                        emailCookie.setMaxAge(0);
                        passwordCookie.setMaxAge(0);
                        emailCookie.setPath("/");
                        passwordCookie.setPath("/");
                        response.addCookie(emailCookie);
                        response.addCookie(passwordCookie);
                    }

                    // Điều hướng dựa vào vai trò người dùng
                    if ("ADMIN".equalsIgnoreCase(user.getRole().toString())) {
                        response.sendRedirect("admin");
                    } else {
                        response.sendRedirect("home.jsp");
                    }
                } else {
                    // Nếu tài khoản bị khóa (INACTIVE)
                    request.setAttribute("errorMessage", "Your account has been locked.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Sai email hoặc mật khẩu
                request.setAttribute("errorMessage", "Incorrect email or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
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
