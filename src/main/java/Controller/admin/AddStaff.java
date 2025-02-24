/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userRole") == null
                || !"ADMIN".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String staffName = request.getParameter("staffName").trim();
        String passWord = request.getParameter("passWord").trim();
        String phone = request.getParameter("phone").trim();
        String role = request.getParameter("role").trim();
        String email = request.getParameter("email").trim();
        String gender = request.getParameter("gender").trim();
        String status = request.getParameter("status").trim();
        String address = request.getParameter("address").trim();

        if (staffName == null || staffName.isEmpty()
                || passWord == null || passWord.isEmpty()
                || phone == null || phone.isEmpty()
                || role == null || role.isEmpty()
                || gender == null || gender.isEmpty()
                || status == null || status.isEmpty()
                || address == null || address.isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        StaffsDAO staffDAO = new StaffsDAO();

        // Kiểm tra xem email đã tồn tại chưa
        if (staffDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        // Tạo nhân viên mới
        Staffs staff = new Staffs();
        staff.setStaffName(staffName);
        staff.setPassword(PasswordUtils.hashPassword(passWord)); 
        staff.setPhone(phone);
        staff.setRole(role);
        staff.setEmail(email);
        staff.setGender(gender);
        staff.setStatus(status);
        staff.setAddress(address);

        try {
            staffDAO.addStaff(staff);
            request.setAttribute("successMessage", "Staff added successfully!");
            request.getRequestDispatcher("listStaffs.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
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
