/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin;

import Models.StockImport;
import Models.StockImportDetails;
import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author Haontce180451
 */
public class ViewImportedDetails extends HttpServlet {
   
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
            out.println("<title>Servlet ViewImportedDetails</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewImportedDetails at " + request.getContextPath () + "</h1>");
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
        String importIDParam = request.getParameter("importID");

        if (importIDParam == null || importIDParam.trim().isEmpty()) {
            response.getWriter().write("<p style='color:red;'>Invalid Import ID.</p>");
            return;
        }

        int importID;
        try {
            importID = Integer.parseInt(importIDParam);
        } catch (NumberFormatException e) {
            response.getWriter().write("<p style='color:red;'>Invalid Import ID format.</p>");
            return;
        }
        ProductsDAO proDAO = new ProductsDAO();
        StockImport stockImport = proDAO.getStockImport(importID);
        ArrayList<StockImportDetails> stockImportDetailsList = proDAO.getAllDetailOfImported(importID);

        if (stockImport == null) {
            response.getWriter().write("<p style='color:red;'>Import not found.</p>");
            return;
        }
        request.setAttribute("detailsList", stockImportDetailsList);
        request.setAttribute("stockImport", stockImport);
        request.getRequestDispatcher("admin/view-imported-details.jsp").forward(request, response);
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
        processRequest(request, response);
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
