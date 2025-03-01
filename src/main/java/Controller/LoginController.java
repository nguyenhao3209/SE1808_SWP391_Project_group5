
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
import Models.Staffs;
import dal.StaffsDAO;

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
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String rememberMe = request.getParameter("rememberMe");

            CustomersDAO customersDAO = new CustomersDAO();
            StaffsDAO staffsDAO = new StaffsDAO();

            Customers user = customersDAO.loginWithEmailAndPassword(email, password);
            Staffs staff = staffsDAO.loginWithEmailAndPassword(email, password);

            // Kiểm tra nếu có user hoặc staff hợp lệ
            if (user != null || staff != null) {
                boolean isActive = (user != null && user.getStatus() == Customers.Status.ACTIVE)
                        || (staff != null && staff.getStatus() == Staffs.Status.ACTIVE);

                if (isActive) {
                    HttpSession session = request.getSession();

                    // Xử lý "Remember Me"
                    if ("on".equals(rememberMe)) {
                        Cookie emailCookie = new Cookie("email", email);
                        Cookie passwordCookie = new Cookie("password", password);

                        emailCookie.setMaxAge(7 * 24 * 60 * 60);
                        emailCookie.setPath("/");
                        passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                        passwordCookie.setPath("/");
                        response.addCookie(emailCookie);
                        response.addCookie(passwordCookie);
                    } else {
                        Cookie emailCookie = new Cookie("email", "");
                        Cookie passwordCookie = new Cookie("password", "");
                        passwordCookie.setMaxAge(0);
                        passwordCookie.setPath("/");
                        emailCookie.setMaxAge(0);
                        emailCookie.setPath("/");
                        response.addCookie(emailCookie);
                        response.addCookie(passwordCookie);
                    }

                    // Điều hướng dựa vào vai trò người dùng
                    if ("ADMIN".equalsIgnoreCase(user.getRole().toString())) {
                        response.sendRedirect("dashboard");
                    } else {
                        response.sendRedirect("home.jsp");
                    } else {
                        session.setAttribute("user", staff);
                        response.sendRedirect("dashboard");
                    }

                } else {
                    request.setAttribute("errorMessage", "Your account has been locked.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
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
