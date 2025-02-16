/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Cart;
import Models.Orders;
import Models.Products;
import Models.Customers;
import Models.OrderDetails;
import dal.CustomersDAO;
import dal.OrdersDAO;
import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;

/**
 *
 * @author Haontce180451
 */
public class PaymentServlet extends HttpServlet {

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
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        //BuyNow
        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("user");
        ArrayList<Cart> newList = new ArrayList<>();
        String productID = request.getParameter("selectedItems");
        String quantity = request.getParameter("quantity");
        BigDecimal brandTotal = BigDecimal.ZERO;

        ProductsDAO proDAO = new ProductsDAO();
        Products pro = proDAO.getProductByID(Integer.parseInt(productID));

        if (productID != null && quantity != null) {
            brandTotal = pro.getFinalPrice().multiply(BigDecimal.valueOf(Integer.parseInt(quantity)));
            Cart cart = new Cart(customer, pro, Integer.parseInt(quantity));
            newList.add(cart);
            session.setAttribute("cartList", newList);
            session.setAttribute("brandTotal", brandTotal);
        }
        request.getRequestDispatcher("payment_method.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String paymentMethod = request.getParameter("paymentMethod");
        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("user");
        ProductsDAO proDAO = new ProductsDAO();
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        if (phoneNumber != null) {
            customer.setPhone(phoneNumber);
        }
        if (email != null) {
            customer.setEmail(email);
        }
        CustomersDAO uDAO = new CustomersDAO();
        if (phoneNumber != null || email != null) {
            uDAO.updateUser(customer);
        }

        ArrayList<Cart> currentCart = (ArrayList<Cart>) session.getAttribute("currentCart");
        BigDecimal totalPrice = BigDecimal.ZERO;

        ArrayList<OrderDetails> orderItemsList = new ArrayList<>();
        if (currentCart != null) {
            for (Cart item : currentCart) {

                BigDecimal itemTotal = item.getProduct().getFinalPrice().multiply(BigDecimal.valueOf(item.getQuantity()));

                totalPrice = totalPrice.add(itemTotal);
                // Tạo đối tượng OrderItems
                OrderDetails orderItem = new OrderDetails(item.getProduct(), item.getQuantity(), item.getProduct().getFinalPrice());
                orderItemsList.add(orderItem);
                proDAO.removeItemOfCart(item.getCartID());
            }
        }

        // Lưu đơn hàng và danh sách OrderItems vào cơ sở dữ liệu
        if (!orderItemsList.isEmpty()) {
            Orders order = new Orders(customer, "pending", paymentMethod, totalPrice); // Tạo đối tượng Orders
            OrdersDAO orderDAO = new OrdersDAO();
            orderDAO.insertOrder(order, orderItemsList); // Lưu Orders và OrderItems
        }

        session.setAttribute("currentCart", currentCart);
        session.setAttribute("user", customer);
        session.setAttribute("selectedPaymentMethod", paymentMethod);
        int quantityTotal = proDAO.getQuantityOfItemByUserID(customer.getCustomerId());
        session.setAttribute("quantityTotal", quantityTotal);
        // Chuyển hướng đến trang confirmation.jsp
        request.setAttribute("paymentMethod", paymentMethod);
        request.getRequestDispatcher("confirmation.jsp").forward(request, response);
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
