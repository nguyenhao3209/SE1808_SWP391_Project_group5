/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Customers;
import dal.CustomersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
@WebServlet(name = "UpdateProfile", urlPatterns = {"/updateProfile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5, // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UpdateProfile extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfile at " + request.getContextPath() + "</h1>");
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

        // Lấy thông tin từ form
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Lấy session hiện tại (false để không tạo session mới nếu không tồn tại)
        HttpSession session = request.getSession(false);

        // Kiểm tra session và đối tượng User
        if (session == null || session.getAttribute("user") == null) {
            // Chuyển hướng về trang đăng nhập nếu session hết hạn hoặc không có user
            response.sendRedirect("login.jsp");
            return;
        }

        Customers user = (Customers) session.getAttribute("user");

        // Cập nhật thông tin người dùng
        user.setCustomerName(userName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);

        // Kiểm tra xem người dùng có tải ảnh mới lên không
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {  // Kiểm tra có file tải lên và có kích thước hợp lệ
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (fileName != null && !fileName.isEmpty()) {
                String avatarPath = "uploads/" + fileName;
                String uploadPath = getServletContext().getRealPath("/") + "uploads";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // Tạo thư mục nếu chưa tồn tại
                }
                filePart.write(getServletContext().getRealPath("/") + avatarPath);
                user.setAvatar(avatarPath);
            }
        }

        // Cập nhật thông tin người dùng trong database
        CustomersDAO userDAO = new CustomersDAO();
        userDAO.updateCustomer(user);

        // Cập nhật lại session sau khi thông tin người dùng đã thay đổi
        session.setAttribute("user", user);

        // Đặt thông báo thành công vào session
        session.setAttribute("successMessage", "Profile updated successfully!");

        // Điều hướng về trang profile sau khi cập nhật
        response.sendRedirect("profile.jsp");

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
