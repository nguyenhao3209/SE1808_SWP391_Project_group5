/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Arrays;

/**
 *
 * @author Haontce180451
 */
public class StockImportServlet extends HttpServlet {

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
            out.println("<title>Servlet StockImportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StockImportServlet at " + request.getContextPath() + "</h1>");
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

        try {

            String action = request.getParameter("action"); // Lấy giá trị của nút bấm
            String importIDStr = request.getParameter("importID");

            if (importIDStr == null) {
                request.setAttribute("error", "Missing import ID!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            ProductsDAO proDAO = new ProductsDAO();
            int importID = Integer.parseInt(importIDStr.split("\\.")[0]);

            if ("cancel".equals(action)) {
                // Nếu nhấn Cancel, cập nhật trạng thái nhập hàng thành "Canceled"
                proDAO.updateImportStatus(importID, "Canceled");
                response.sendRedirect("admin/stock_import_excel.jsp");
                return;
            }
            String[] productIDs = request.getParameterValues("productID[]");
            String[] sizeIDs = request.getParameterValues("sizeID[]");
            String[] quantitiesStr = request.getParameterValues("quantity[]");
            String[] pricesStr = request.getParameterValues("price[]");
            String supplier = request.getParameter("supplier");
            String totalCostStr = request.getParameter("totalCost");
            String staffID = request.getParameter("staffID");
            System.out.println("productID: " + Arrays.toString(productIDs));
            System.out.println("sizeID: " + Arrays.toString(sizeIDs));
            System.out.println("quantity: " + Arrays.toString(quantitiesStr));
            System.out.println("price: " + Arrays.toString(pricesStr));
            System.out.println("supplier: " + supplier);
            System.out.println("totalCost: " + totalCostStr);
            System.out.println("staffID: " + staffID);
            if (productIDs == null || sizeIDs == null || quantitiesStr == null || pricesStr == null
                    || supplier == null || totalCostStr == null || staffID == null || importIDStr == null) {
                request.setAttribute("error", "Missing required parameters!");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            int[] quantities = new int[quantitiesStr.length];
            BigDecimal[] prices = new BigDecimal[pricesStr.length];

            for (int i = 0; i < quantitiesStr.length; i++) {
                quantities[i] = Integer.parseInt(quantitiesStr[i].trim());
                prices[i] = new BigDecimal(pricesStr[i].trim());
            }

            BigDecimal totalCost = new BigDecimal(totalCostStr.trim());

            // Debug log
            System.out.println("Import ID: " + importID);
            System.out.println("Supplier: " + supplier);
            System.out.println("Total Cost: " + totalCost);
            System.out.println("Products to import: " + productIDs.length);

            // Gọi DAO để lưu vào database
            proDAO.insertProductFromExcel(importID, productIDs, sizeIDs, quantities, prices, supplier, totalCost, staffID);

            response.sendRedirect("admin/stock_import_excel.jsp?success=true");
        } catch (Exception e) {
            request.setAttribute("error", "Error processing stock import: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
