/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Customers;
import Models.News;
import Models.Slider;
import Models.Staffs;
import dal.NewsDAO;
import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Haontce180451
 */
public class HomeServlet extends HttpServlet {

    private NewsDAO newsDAO;

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
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
            newsDAO = new NewsDAO();
            HttpSession session = request.getSession();
            ProductsDAO productDAO = new ProductsDAO();
            Object user = session.getAttribute("user");

            if (user instanceof Staffs) {
                session.removeAttribute("user");
                // Xử lý logic cho nhân viên
            }
            // Lấy danh sách slider
            ArrayList<Slider> slide = productDAO.getAllSliders();
            session.setAttribute("slides", slide);

            // Lấy danh mục sản phẩm được chọn từ request
            String categoryID = request.getParameter("categoryID");

            // Nếu categoryID null, mặc định lấy danh mục đầu tiên (VD: Racket - ID = 1)
            List<Object[]> saleList;
            if (categoryID == null) {
                categoryID = "1"; // Mặc định chọn danh mục đầu tiên
            }
            saleList = productDAO.getTop8();
            ArrayList<News> newsList = newsDAO.getNewsList();

            session.setAttribute("newsList", newsList);
            session.setAttribute("saleList", saleList);
            session.setAttribute("check_click_category", categoryID); // Lưu trạng thái danh mục đã chọn

            request.getRequestDispatcher("home.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println("Lỗi chuyển đổi categoryID: " + e.getMessage());
            response.sendRedirect("error.jsp");
        } catch (ServletException | IOException e) {
            System.out.println("Lỗi trong HomeController: " + e);
            response.sendRedirect("error.jsp");
        }
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
        doGet(request, response);
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
