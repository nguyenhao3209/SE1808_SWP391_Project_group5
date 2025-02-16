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
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.UUID;
import utils.MailService;
import utils.PasswordUtils;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
@WebServlet(name="ForgotPassword", urlPatterns={"/forgotPassword"})
public class ForgotPassword extends HttpServlet {
   private CustomersDAO userDao = new CustomersDAO();
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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPassword</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPassword at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

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
              String email = request.getParameter("email");

        Customers user = userDao.getUserByEmail(email);
        if (user != null) {
            // Tạo token reset mật khẩu
            String token = UUID.randomUUID().toString();

            // Tạo thời gian hết hạn cho token (ví dụ token hết hạn sau 1 giờ)
            LocalDateTime expiryTime = LocalDateTime.now().plusHours(1);

            // Lưu token và thời gian hết hạn vào cơ sở dữ liệu
            userDao.saveResetToken(email, token, expiryTime);

            //gen a code
            String code = PasswordUtils.generateSimplePassword(8);
            // Tạo cookie cho code
            Cookie codeCookie = new Cookie("code", code);
            Cookie tokenCookie = new Cookie("token", token);

            // Đặt thời gian sống cho cookie (60ph)
            codeCookie.setMaxAge(60 * 60);//60ph
            tokenCookie.setMaxAge(60 * 60);//1h

            // Gửi cookie về trình duyệt
            response.addCookie(codeCookie);
            response.addCookie(tokenCookie);

            // Gửi email với đường dẫn khôi phục mật khẩu (code gửi email)
            String resetLink = "http://localhost:8080/SP25_SE1808_SWP391_Project_G5/resetPassword?token=" + token;
            MailService.sendMail(email, "Password Reset", "Click on the following link to reset your password: " + resetLink + " or using code " + code);

            // Thông báo thành công và điều hướng về trang thông báo thành công
            request.setAttribute("message", "An email has been sent to your address. Please check your email to reset your password.");
            request.getRequestDispatcher("code-security.jsp").forward(request, response);  // Điều hướng sau khi xử lý
        } else {
            // Email không tồn tại, thông báo lỗi
            request.setAttribute("error", "Email does not exist in the system.");
            request.getRequestDispatcher("forget-password.jsp").forward(request, response);  // Điều hướng sau khi xử lý
        }

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
