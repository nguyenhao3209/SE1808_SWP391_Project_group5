/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Staffs;
import dal.StaffsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HuyLVQCE180656
 */
@WebServlet(name = "AddStaff", urlPatterns = {"/addStaff"})
public class AddStaff extends HttpServlet {

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
            out.println("<title>Servlet StaffController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffController at " + request.getContextPath() + "</h1>");
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
        String staffName = request.getParameter("staffName");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String hireDateString = request.getParameter("hireDate");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String address = request.getParameter("address");
        String action = request.getParameter("action"); // Lấy hành động từ request

        // Kiểm tra session và quyền admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null
                || !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Nếu admin nhấn "Add New Staff", chuyển đến trang thêm nhân viên
        if ("addStaff".equals(action)) {
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        // Kiểm tra và chuyển đổi hireDate
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date hireDate = null;
        try {
            hireDate = (Date) dateFormat.parse(hireDateString);
        } catch (ParseException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Ngày tuyển dụng không hợp lệ.");
            response.sendRedirect("addStaff.jsp");
            return;
        }

        // Tạo đối tượng Staffs mới thay vì lấy từ session
        Staffs staff = new Staffs();
        staff.setStaffName(staffName);
        staff.setPhone(phone);
        staff.setRole(role);
        staff.setHireDate(hireDate);
        staff.setEmail(email);
        staff.setGender(gender);
        staff.setStatus(status);
        staff.setAddress(address);

        // Thêm nhân viên vào database
        StaffsDAO staffDAO = new StaffsDAO();
        staffDAO.addStaff(staff);

        // Đặt thông báo thành công vào session
        session.setAttribute("successMessage", "Nhân viên đã được thêm thành công!");

        // Chuyển hướng về trang danh sách nhân viên
        response.sendRedirect("listStaff.jsp");
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
