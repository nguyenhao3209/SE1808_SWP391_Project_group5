/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Models.Cart;
import Models.Customers;
import Models.ProductSizes;
import Models.Products;
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
public class AddToCartServlet extends HttpServlet {

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
            out.println("<title>Servlet AddToCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if ("addToCart".equals(action)) {
            addToCart(request, response);
        } else if ("buyNow".equals(action)) {
            buyNow(request, response);
        }

    }

    private void buyNow(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        ProductsDAO proDAO = new ProductsDAO();

        Customers user = (Customers) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("errorMessage", "You need to log in to buy products.");
            response.sendRedirect("login");
            return;
        }

        String productID = request.getParameter("productId");
        String sizeID = request.getParameter("sizeID");
        String quantityStr = request.getParameter("quantity");

        if (productID == null || quantityStr == null || productID.isEmpty() || quantityStr.isEmpty()) {
            session.setAttribute("notification", "Invalid product or quantity. Please try again.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect("productDetails?id=" + productID);
            return;
        }

        try {
            int quantity = Integer.parseInt(quantityStr);
            if (quantity <= 0) {
                session.setAttribute("notification", "Quantity must be greater than zero.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect("productDetails?id=" + productID);
                return;
            }

            Products product = proDAO.getProductByID(Integer.parseInt(productID));
            ProductSizes productSize = null;

            if (product != null && sizeID != null && !sizeID.isEmpty()) {
                productSize = proDAO.getProductSizeByID(Integer.parseInt(sizeID));
            }

            if (product != null) {
                BigDecimal brandTotal = product.getFinalPrice().multiply(BigDecimal.valueOf(quantity));

                ArrayList<Cart> newList = new ArrayList<>();
                Cart cart = new Cart(user, product, productSize, quantity);
                newList.add(cart);

                session.setAttribute("cartList", newList);
                session.setAttribute("brandTotal", brandTotal);
                session.setAttribute("user", user);

                request.getRequestDispatcher("payment_method.jsp").forward(request, response);
            } else {
                session.setAttribute("notification", "Product not found!");
                session.setAttribute("notificationType", "error");
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid quantity or size format.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect("productDetails?id=" + productID);
        } catch (Exception e) {
            session.setAttribute("notification", "An error occurred. Please try again.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect("home");
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String categoryName = request.getParameter("categoryName");
        String size = request.getParameter("sizeID");
        HttpSession session = request.getSession();
        ProductsDAO proDAO = new ProductsDAO();
        Customers user = (Customers) session.getAttribute("user");
        if (user == null) {
            session.setAttribute("errorMessage", "You need to log in to add products to your cart.");
            response.sendRedirect("login");
            return;
        }
        String productID = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");

        if (productID == null || quantityStr == null || productID.isEmpty() || quantityStr.isEmpty()) {
            session.setAttribute("notification", "Invalid product information. Please try again.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect("productDetails?id=" + productID);
            return;
        }

        try {
            int quantity = Integer.parseInt(quantityStr);
            if (quantity <= 0) {
                session.setAttribute("notification", "Quantity must be greater than zero.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect("productDetails?id=" + productID);
                return;
            }
            Products pro = null;
            ProductSizes proSize = null;
            if ((categoryName.equals("Shoes") || categoryName.equals("Clothes")) && size != null) {
                pro = proDAO.getProductByID(Integer.parseInt(productID));
                proSize = proDAO.getProductSizeByID(Integer.parseInt(size));
            } else {
                pro = proDAO.getProductByID(Integer.parseInt(productID));
            }
            if (pro != null) {
                ArrayList<Cart> itemsList = proDAO.getCartByUserID(user.getCustomerId());
                boolean itemExisted = false;
                int cartID = -1;

                if (itemsList != null) {
                    for (Cart cart : itemsList) {
                        if (cart.getProduct().getProductID() == pro.getProductID()) {
                            itemExisted = true;
                            cartID = cart.getCartID();
                            break;
                        }
                    }
                }
                if (!itemExisted) {
                    Cart item = new Cart(user, pro, proSize, quantity);
                    proDAO.insertToCart(item);
                } else {
                    Cart existingItem = proDAO.getCartByCartID(cartID);
                    int newQuantity = existingItem.getQuantity() + quantity;
                    proDAO.updateCart(new Cart(cartID, user, pro, newQuantity));
                }
                int quantityTotal = proDAO.getQuantityOfItemByUserID(user.getCustomerId());
                session.setAttribute("quantityTotal", quantityTotal);

                session.setAttribute("notification", pro.getProductName() + " added to cart successfully!");
                session.setAttribute("notificationType", "success");
                response.sendRedirect("productDetails?id=" + productID);
            } else {
                session.setAttribute("notification", "Failed to add item to cart.");
                session.setAttribute("notificationType", "error");
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("notification", "Invalid quantity format.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect("productDetails?id=" + productID);
        } catch (Exception e) {
            session.setAttribute("notification", "An error occurred. Please try again.");
            session.setAttribute("notificationType", "error");
            response.sendRedirect("home");
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
