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
import java.util.List;

/**
 *
 * @author HuyLVQCE180656
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/searchServlet"})
public class SearchServlet extends HttpServlet {

    private static final int ITEMS_PER_PAGE = 20;

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
            out.println("<title>Servlet SearchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet at " + request.getContextPath() + "</h1>");
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
        String searchInput = request.getParameter("searchQuery");

        // Nếu không có input, mặc định là rỗng để tránh lỗi truy vấn
        if (searchInput == null) {
            searchInput = "";
        }

        // Đếm tổng số sản phẩm tìm thấy
        int count_item = productsDAO.countSearchResults(searchInput);
        int totalPages = (int) Math.ceil((double) count_item / ITEMS_PER_PAGE); // Tổng số trang

        // Lấy trang hiện tại từ request (mặc định là trang 1)
        String pageParam = request.getParameter("page");
        int currentPage;
        try {
            currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        // Đảm bảo `currentPage` không vượt quá tổng số trang
        if (currentPage < 1) {
            currentPage = 1;
        }
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        // Tính OFFSET (số sản phẩm cần bỏ qua)
        int offset = (currentPage - 1) * ITEMS_PER_PAGE;

        // Xác định phạm vi trang hiển thị (hiển thị tối đa 10 trang liên tiếp)
        int pageGroupSize = 10;
        int startPage = ((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

        // Gọi hàm tìm kiếm sản phẩm có phân trang
        List<Products> searchResult = productsDAO.searchProductsByName(searchInput, offset, ITEMS_PER_PAGE);

        // Gửi dữ liệu đến JSP
        request.setAttribute("searchQuery", searchInput);
        request.setAttribute("productList", searchResult);
        request.setAttribute("startPage", startPage);
        request.setAttribute("endPage", endPage);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

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
