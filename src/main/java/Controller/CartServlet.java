/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Models.Cart;
import Models.Customers;
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
import java.util.Arrays;

/**
 *
 * @author Haontce180451
 */
public class CartServlet extends HttpServlet {
   
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
            out.println("<title>Servlet CartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath () + "</h1>");
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
         HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("user");
        if (customer == null) {
            session.setAttribute("cartList", null);
            session.setAttribute("errorMessage", "You need to log in to add products to your cart.");
            response.sendRedirect("login");
        } else {
            ProductsDAO productDao = new ProductsDAO();
            ArrayList<Cart> cart = productDao.getCartByUserID(customer.getCustomerId());
            session.setAttribute("cartList", cart);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
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
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("update".equals(action)) {
            updateCart(request, response);
        } else if (action.startsWith("remove")) {
            removeItemOfCart(request, response, action);
        } 
    }
    
     private void removeItemOfCart(HttpServletRequest request, HttpServletResponse response, String msg) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductsDAO proDAO = new ProductsDAO();

        try {
            String[] w = msg.split("_");
            if (w.length == 2) {
                int itemID = Integer.parseInt(w[1]);
                boolean isRemoved = proDAO.removeItemOfCart(itemID);
                if (isRemoved) {
                    session.setAttribute("success", "Item removed successfully!");
                } else {
                    session.setAttribute("error", "Item removal failed. Item may not exist.");
                }
            } else {
                session.setAttribute("error", "Invalid ID format!");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid ID! Please provide a valid numeric ID.");
            e.printStackTrace();
        } catch (Exception e) {
            session.setAttribute("error", "An error occurred while removing the item. Please try again.");
            e.printStackTrace();
        }

        // Redirect to the cart page
        response.sendRedirect("./cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Cart> currentCart = (ArrayList<Cart>) session.getAttribute("cartList");
        ArrayList<Cart> newList = new ArrayList<>();
        ProductsDAO productDAO = new ProductsDAO();
        BigDecimal brandTotal = BigDecimal.ZERO;
        Customers customer = (Customers) session.getAttribute("user");
        if (currentCart != null) {
            for (Cart item : currentCart) {
                String quantityOfItem = request.getParameter("quantity_" + item.getCartID());
                if (quantityOfItem != null) {
                    int newQuantity = Integer.parseInt(quantityOfItem);
                    item.setQuantity(newQuantity);
                }

                String[] selectedItems = request.getParameterValues("selectedItems");
                System.out.println("Selected Items: " + Arrays.toString(selectedItems));
                if (selectedItems != null) {
                    for (String selectedId : selectedItems) {
                        if (selectedId.equals(String.valueOf(item.getCartID()))) {
                            item.setSelected(true);
                            productDAO.updateCart(item);
                            break;
                        }
                    }
                } else {
                    item.setSelected(false);
                }

                if (item.isSelected()) {
                    BigDecimal itemTotal = item.getProduct().getFinalPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                    brandTotal = brandTotal.add(itemTotal);
                    newList.add(item);
                }
            }

            session.setAttribute("cartList", newList);
            session.setAttribute("brandTotal", brandTotal);
        }
        int quantityTotal = productDAO.getQuantityOfItemByUserID(customer.getCustomerId());
        session.setAttribute("quantityTotal", quantityTotal);
        request.getRequestDispatcher("payment_method.jsp").forward(request, response);
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
