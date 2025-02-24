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
import utils.PasswordUtils;

/**
 *
 * @author HuyLVQCE180656
 */
@WebServlet(name = "EditStaff", urlPatterns = {"/editStaff"})
public class EditStaff extends HttpServlet {

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
            out.println("<title>Servlet EditStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditStaff at " + request.getContextPath() + "</h1>");
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
        String staffId = request.getParameter("staffId");
        if (staffId != null) {
            StaffsDAO staffDAO = new StaffsDAO();
            Staffs staff = staffDAO.getStaffById(staffId);

            // Debug xem staff có null không
            System.out.println("Editing Staff: " + (staff != null ? staff.getStaffName() : "null"));

            if (staff != null) {
                request.setAttribute("staff", staff);
                request.getRequestDispatcher("editStaff.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("listStaffs.jsp"); // Nếu staffId không hợp lệ, quay về danh sách
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

        String staffId = request.getParameter("staffId").trim();
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

            request.getSession().setAttribute("errorMessage", "All fields are required!");
            response.sendRedirect("editStaff.jsp?staffId=" + staffId);
            return;
        }

        StaffsDAO staffDAO = new StaffsDAO();
        Staffs staff = staffDAO.getStaffById(staffId);

        if (staff == null) {
            session.setAttribute("errorMessage", "Staff not found!");
            response.sendRedirect("listStaffs.jsp");
            return;
        }

        // Kiểm tra email trùng lặp
        if (!staff.getEmail().equals(email) && staffDAO.isEmailExists(email)) {
            request.setAttribute("staff", staff);
            session.setAttribute("errorMessage", "Email already exists!");
            request.getRequestDispatcher("editStaff.jsp").forward(request, response);
            return;
        }

        staff.setStaffName(staffName);
        if (passWord != null && !passWord.isEmpty()) {
            staff.setPassword(PasswordUtils.hashPassword(passWord));
        }
        staff.setPhone(phone);
        staff.setRole(role);
        staff.setEmail(email);
        staff.setGender(gender);
        staff.setStatus(status);
        staff.setAddress(address);

        staffDAO.updateStaff(staff);

        session.setAttribute("successMessage", "Edited successfully!");
        response.sendRedirect("listStaffs.jsp");
        return;
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
