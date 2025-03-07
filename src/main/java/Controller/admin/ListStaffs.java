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
import java.util.List;

/**
 *
 * @author HuyLVQCE180656
 */
@WebServlet(name = "ListStaffs", urlPatterns = {"/listStaffs", "/selectStaffGenders", "/selectStaffStatus"})
public class ListStaffs extends HttpServlet {

    StaffsDAO staffDAO = new StaffsDAO();
    List<Staffs> staffList = null;

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
            out.println("<title>Servlet ListStaffs</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListStaffs at " + request.getContextPath() + "</h1>");
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

        try {

            staffList = staffDAO.getAllStaffs("all", "all");
            String uri = request.getRequestURI();
            if (uri.contains("selectStaffGenders")) {
                this.selectStaffGenders(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("errorMessage", "Error retrieving voucher data.");
        }

        request.setAttribute("staffList", staffList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listStaffs.jsp");
        dispatcher.forward(request, response);
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

        processRequest(request, response);
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

    protected void selectStaffGenders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        String gender = request.getParameter("select");
        String status = request.getParameter("selectStatus");

        try ( PrintWriter out = response.getWriter()) {
            if (gender == null) {
                gender = "all";
            }
            if (status == null) {
                status = "all";
            }
            staffList = staffDAO.getAllStaffs(gender, status);
            if (staffList.isEmpty()) {
                out.println(" <tr>\n"
                        + "                                                            <td colspan=\"8\" class=\"text-center\">List is empty.</td>\n"
                        + "                                                        </tr>");
                return;
            }
            for (Staffs st : staffList) {
                out.println("<tr>\n"
                        + "    <td>" + st.getStaffID() + "</td>\n"
                        + "    <td>" + st.getStaffName() + "</td>\n"
                        + "    <td>" + st.getEmail() + "</td>\n"
                        + "    <td>" + st.getPhone() + "</td>\n"
                        + "    <td>" + st.getGender() + "</td>\n"
                        + "    <td>" + st.getStatus() + "</td>\n"
                        + "    <td>" + st.getAddress() + "</td>\n"
                        + "    <td>\n"
                        + "        <a href=\"editStaff?staffId=" + st.getStaffID() + "\" class=\"btn btn-warning btn-sm\">Edit</a>\n"
                        + "        <a href=\"deleteStaff?staffId=" + st.getStaffID() + "\" class=\"btn btn-danger btn-sm\"\n"
                        + "           onclick=\"return confirm('Are you sure you want to delete?');\">Delete</a>\n"
                        + "    </td>\n"
                        + "</tr>");
            }
        } catch (Exception e) {
            System.out.println("Error in selectStaffGenders: " + e);
        }

        return;
    }

}
