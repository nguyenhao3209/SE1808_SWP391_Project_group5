/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Models.Category;
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
 * @author CE180220_Trần Minh Khánh
 */
@WebServlet(name="SearchServlet", urlPatterns={"/searchServlet"})
public class SearchServlet extends HttpServlet {
   
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
            out.println("<title>Servlet SearchServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath () + "</h1>");
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
        // Lấy các tham số từ form tìm kiếm
        String keyword = request.getParameter("keyword") == null ? "" : request.getParameter("keyword");
        String[] categories = request.getParameterValues("category");
        String[] brands = request.getParameterValues("brand");
        String priceRange = request.getParameter("priceRange");

        String pageNumberStr = request.getParameter("pageNumber");
        // Xử lý giá trị mặc định nếu không có tham số phân trang
        int pageNumber = (pageNumberStr == null || pageNumberStr.isEmpty()) ? 1 : Integer.parseInt(pageNumberStr);

        // Gọi ProductsDAO để lấy danh sách sản phẩm theo các tiêu chí lọc
        ProductsDAO productsDAO = new ProductsDAO();
        ArrayList<Products> productsList = productsDAO.searchProductsWithFilters2(keyword, categories, brands, priceRange, pageNumber, 9);

        // Đặt danh sách sản phẩm vào request để hiển thị trên trang JSP
        request.setAttribute("productsList", productsList);

        // Lấy tổng số sản phẩm để tính tổng số trang
        int totalProducts = productsDAO.getTotalProducts(keyword, categories, brands, priceRange);
        int totalPages = (int) Math.ceil((double) totalProducts / 9); // Tính tổng số trang

        //get category and brand list
        List<Category> categoryList = productsDAO.getAllCategory();
        List<String> brandList = productsDAO.getAllBrand();
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("brandList", brandList);
        
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);

        // Chuyển tiếp đến trang JSP để hiển thị kết quả
        RequestDispatcher dispatcher = request.getRequestDispatcher("searchResult.jsp");
        dispatcher.forward(request, response);
    
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
