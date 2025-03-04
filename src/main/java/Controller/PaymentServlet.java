package Controller;

import Models.Cart;
import Models.Orders;
import Models.Customers;
import Models.OrderDetails;
import Models.Products;
import Models.Vouchers;
import dal.CustomersDAO;
import dal.OrdersDAO;
import dal.ProductsDAO;
import dal.VoucherDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class PaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không xử lý GET
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("user");
        if (customer == null) {
            // Chưa đăng nhập
            response.sendRedirect("login");
            return;
        }

        // Lấy paymentMethod: "Cash_On_Delivery" or "VNPay"
        String paymentMethod = request.getParameter("paymentMethod");

        // Cập nhật phone, email nếu user nhập
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");
        if (phoneNumber != null) {
            customer.setPhone(phoneNumber);
        }
        if (email != null) {
            customer.setEmail(email);
        }
        // Lưu DB
        CustomersDAO uDAO = new CustomersDAO();
        uDAO.updateUser(customer);

        // Lấy cartList
        ArrayList<Cart> currentCart = (ArrayList<Cart>) session.getAttribute("cartList");
        BigDecimal totalPrice = BigDecimal.ZERO;

        ArrayList<OrderDetails> orderItemsList = new ArrayList<>();
        ProductsDAO proDAO = new ProductsDAO();

        if (currentCart != null) {
            for (Cart item : currentCart) {
                BigDecimal itemTotal = item.getProduct().getFinalPrice()
                        .multiply(BigDecimal.valueOf(item.getQuantity()));
                totalPrice = totalPrice.add(itemTotal);

                OrderDetails orderItem = new OrderDetails(item.getProduct(),
                        item.getQuantity(),
                        item.getProduct().getFinalPrice());
                orderItemsList.add(orderItem);
            }
        }

        // Tạo Orders (status = "pending" tuỳ bạn)
        Orders order = new Orders(customer, "pending", paymentMethod, totalPrice);

        // == Xử lý voucher (nếu có) ==
        Integer selectedVoucherID = (Integer) session.getAttribute("selectedVoucherID");
        if (selectedVoucherID != null) {
            // Kiểm tra voucher
            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers v = voucherDAO.getVoucherById(selectedVoucherID);
            if (v != null) {
                // Kiểm tra maxUsagePerUser
                OrdersDAO ordersDAO = new OrdersDAO();
                int usedCount = ordersDAO.getCountOrdersByUserVoucher(customer.getCustomerId(), selectedVoucherID);
                if (usedCount >= v.getMaxUsagePerUser()) {
                    // Người dùng đã xài đủ số lần
                    request.setAttribute("error", "You have reached the max usage for this voucher.");
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    return;
                }
                // Gán voucherID vào order
                order.setVoucher(v);
            }
        }

        // Insert order + orderItems
        OrdersDAO orderDAO = new OrdersDAO();
        int orderId = orderDAO.insertOrder(order, orderItemsList);
        if (orderId == 0) {
            request.setAttribute("error", "Cannot create order. Please try again.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Xoá item trong DB, set cartList = null
        if (currentCart != null) {
            for (Cart item : currentCart) {
                proDAO.removeItemOfCart(item.getCartID());
            }
        }
        session.setAttribute("cartList", null);

        // == Cập nhật usageCount, quantity sau khi insertOrder thành công ==
        if (selectedVoucherID != null) {
            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers v = voucherDAO.getVoucherById(selectedVoucherID);
            if (v != null) {
                // Tăng usageCount
                v.setUsageCount(v.getUsageCount() + 1);
                // Nếu muốn giảm quantity
                v.setQuantity(v.getQuantity() - 1);

                voucherDAO.updateVoucher(v);
            }
        }
        // Xoá session voucher
        session.removeAttribute("selectedVoucherID");

        // Cập nhật quantityTotal
        int quantityTotal = proDAO.getQuantityOfItemByUserID(customer.getCustomerId());
        session.setAttribute("quantityTotal", quantityTotal);

        // Tuỳ theo paymentMethod
        if (!"VNPay".equalsIgnoreCase(paymentMethod)) {
            // COD -> forward sang confirmation.jsp
            request.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("confirmation.jsp").forward(request, response);
        } else {
            // Xử lý VNPay
            // ...
            // (Ví dụ rút gọn, tuỳ logic cổng thanh toán)
            String paymentUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?...";
            response.sendRedirect(paymentUrl);
        }
    }
}
