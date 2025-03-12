/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Models.Staffs;
import dal.StaffsDAO;
import jakarta.servlet.RequestDispatcher;
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
import utils.PasswordUtils;

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

        // Kiểm tra session và quyền admin
        HttpSession session = request.getSession();

        // Lấy dữ liệu từ form
        String staffName = request.getParameter("staffName");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String address = request.getParameter("address");

        // Kiểm tra dữ liệu rỗng
        if (staffName.isEmpty() || password.isEmpty() || phone.isEmpty() || role.isEmpty()
                || email.isEmpty() || gender.isEmpty() || status.isEmpty() || address.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        // Kiểm tra số điện thoại hợp lệ
        if (!isValidPhone(phone)) {
            request.setAttribute("errorMessage", "Invalid phone number! Phone must start with 0 and have 10 digits.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        StaffsDAO staffDAO = new StaffsDAO();

        // Kiểm tra email đã tồn tại chưa
        if (staffDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        // Tạo nhân viên mới
        Staffs staff = new Staffs();
        staff.setStaffName(staffName);
        if (password != null && !password.isEmpty()) {
            staff.setPassword(PasswordUtils.hashPassword(password));
        }
        staff.setPhone(phone);
        staff.setRole(Staffs.Role.valueOf(role));
        staff.setEmail(email);
        staff.setGender(gender);
        staff.setStatus(Staffs.Status.valueOf(status));
        staff.setAddress(address);
        System.out.println(staff.toString());
        // Lưu nhân viên vào database
        staffDAO.addStaff(staff);

        response.sendRedirect("listStaffs");
    }

    private boolean isValidPhone(String phone) {
        return phone != null && phone.matches("0\\d{9}");
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
