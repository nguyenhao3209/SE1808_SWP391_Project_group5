package Controller;

import Models.Cart;
import Models.Customers;
import dal.ProductsDAO;
import dal.VoucherDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        if ("update".equals(action)) {
            updateCart(request, response);
        } else if (action.startsWith("remove")) {
            removeItemOfCart(request, response, action);
        }
    }

    private void removeItemOfCart(HttpServletRequest request, HttpServletResponse response, String msg)
            throws ServletException, IOException {
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

        response.sendRedirect("./cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        ArrayList<Cart> currentCart = (ArrayList<Cart>) session.getAttribute("cartList");
        ArrayList<Cart> newList = new ArrayList<>();
        ProductsDAO productDAO = new ProductsDAO();
        BigDecimal brandTotal = BigDecimal.ZERO;
        Customers customer = (Customers) session.getAttribute("user");

        if (currentCart != null) {
            for (Cart item : currentCart) {
                // Lấy quantity
                String quantityOfItem = request.getParameter("quantity_" + item.getCartID());
                if (quantityOfItem != null) {
                    int newQuantity = Integer.parseInt(quantityOfItem);
                    item.setQuantity(newQuantity);
                }

                // Kiểm tra selectedItems
                String[] selectedItems = request.getParameterValues("selectedItems");
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

                // Nếu item selected -> cộng vào brandTotal
                if (item.isSelected()) {
                    BigDecimal itemTotal = item.getProduct().getFinalPrice()
                            .multiply(BigDecimal.valueOf(item.getQuantity()));
                    brandTotal = brandTotal.add(itemTotal);
                    newList.add(item);
                }
            }

            session.setAttribute("cartList", newList);
            session.setAttribute("brandTotal", brandTotal);
        }

        if (customer != null) {
            int quantityTotal = productDAO.getQuantityOfItemByUserID(customer.getCustomerId());
            session.setAttribute("quantityTotal", quantityTotal);
        }

        // Lấy danh sách voucher phù hợp
        VoucherDAO voucherDAO = new VoucherDAO();
        request.setAttribute("availableVouchers", voucherDAO.getVouchersByPriceRange(brandTotal));

        // Forward sang payment_method.jsp
        request.getRequestDispatcher("payment_method.jsp").forward(request, response);
    }
}
