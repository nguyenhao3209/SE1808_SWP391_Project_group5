/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Models.Products;
import dal.ProductsDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HuyLVQCE180656
 */
@WebServlet(name = "ListProducts", urlPatterns = {"/listProducts"})
public class ListProducts extends HttpServlet {

    int count_page = 0;
//    int startPage = 1;
//    int endPage = 0;

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
            out.println("<title>Servlet ListProducts</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListProducts at " + request.getContextPath() + "</h1>");
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
        ProductsDAO productsDAO = new ProductsDAO();
        int count_item = productsDAO.count_product();
//        count_page = (int) Math.ceil((double) count_item / 20);
        count_page = (int) count_item / 20;

        // Lấy tham số page từ request (mặc định là 1 nếu không có)
        String pageParam = request.getParameter("page");
//        String page_number_aram = request.getParameter("page_number");
        int currentPage;
        int page_number;
        try {
            currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
//             page_number = (page_number_aram != null) ? Integer.parseInt(page_number_aram) : 0;
        } catch (NumberFormatException e) {
            currentPage = 1; // Mặc định là trang 1 nếu `page` không hợp lệ
//            page_number=0;
        }
        if (currentPage == 1) {
            page_number = 0;
        } else {
            page_number = currentPage * 20;
        }

        // Tính toán phạm vi trang hiển thị
        int totalPages = count_page;
        int pageGroupSize = 10; // Số trang hiển thị mỗi lần
        int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

        // Gửi thông tin đến JSP
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        List<Products> productList = productsDAO.getAllProducts(page_number);

        request.setAttribute("productList", productList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/listProducts.jsp");
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

}
