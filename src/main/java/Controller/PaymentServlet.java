package Controller;

import Models.Cart;
import Models.Orders;
import Models.Products;
import Models.Customers;
import Models.OrderDetails;
import Models.Vouchers;
import dal.CustomersDAO;
import dal.OrdersDAO;
import dal.ProductsDAO;
import dal.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import utils.Config;

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

                OrderDetails orderItem = null;
                if (item.getProduct().getCategory().getCategoryName().equals("Shoes") || item.getProduct().getCategory().getCategoryName().equals("Clothes")) {
                    orderItem = new OrderDetails(item.getProduct(),
                            item.getQuantity(),
                            item.getProduct().getFinalPrice(), item.getProductSizes());
                } else {
                    orderItem = new OrderDetails(item.getProduct(),
                            item.getQuantity(),
                            item.getProduct().getFinalPrice());
                }
                orderItemsList.add(orderItem);
            }
        }

        // Tạo Orders (status = "pending" tuỳ bạn)
        String address = request.getParameter("address");
        String phone = request.getParameter("phoneNumber");

        Orders order = new Orders(customer, "PENDING", paymentMethod, totalPrice);
        order.setPhone(phone);
        order.setAddress(address);
        order.setStatusDL("PENDING");
        Integer selectedVoucherID = (Integer) session.getAttribute("selectedVoucherID");
        if (selectedVoucherID != null) {
            VoucherDAO voucherDAO = new VoucherDAO();
            Vouchers v = voucherDAO.getVoucherById(selectedVoucherID);
            if (v != null) {
                OrdersDAO ordersDAO = new OrdersDAO();
                int usedCount = ordersDAO.getCountOrdersByUserVoucher(customer.getCustomerId(), selectedVoucherID);
                if (usedCount >= v.getMaxUsagePerUser()) {
                    // Người dùng đã xài đủ số lần
                    request.setAttribute("error", "You have reached the max usage for this voucher.");

                    request.setAttribute("availableVouchers", voucherDAO.getVouchersByPriceRange(totalPrice));

                    request.getRequestDispatcher("payment_method.jsp").forward(request, response);
                    return;
                }
                order.setVoucher(v);
            }
        }

        // Insert order + orderItems
        OrdersDAO orderDAO = new OrdersDAO();
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
        session.setAttribute("cartList", currentCart);
        // Tuỳ theo paymentMethod
        if (!"VNPay".equalsIgnoreCase(paymentMethod)) {
            // COD -> forward sang confirmation.jsp
            order.setStatus("PENDING");
            int orderId = orderDAO.insertOrder(order, orderItemsList);
            if (orderId == 0) {
                request.setAttribute("error", "Cannot create order. Please try again.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }
            request.setAttribute("paymentMethod", paymentMethod);
            request.getRequestDispatcher("confirmation.jsp").forward(request, response);
        } else {
            if (!paymentMethod.equals("VNPay")) {
                order.setStatus("PENDING");
                int orderId = orderDAO.insertOrder(order, orderItemsList);
                if (orderId == 0) {
                    request.setAttribute("error", "Cannot create order. Please try again.");
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    return;
                }
                request.getRequestDispatcher("confirmation.jsp").forward(request, response);
            } else {
                int orderId = orderDAO.insertOrder(order, orderItemsList);
                if (orderId == 0) {
                    request.setAttribute("error", "Cannot create order. Please try again.");
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    return;
                }
                // VNPay
                String vnp_Version = "2.1.0";
                String vnp_Command = "pay";
                String orderType = "other";
                long amount = totalPrice.multiply(BigDecimal.valueOf(2500000)).longValue();
                String bankCode = "NCB";

                String vnp_TxnRef = Config.getRandomNumber(8);
                String vnp_IpAddr = Config.getIpAddress(request);

                String vnp_TmnCode = Config.vnp_TmnCode;

                Map<String, String> vnp_Params = new HashMap<>();
                vnp_Params.put("vnp_Version", vnp_Version);
                vnp_Params.put("vnp_Command", vnp_Command);
                vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                vnp_Params.put("vnp_Amount", String.valueOf(amount));
                vnp_Params.put("vnp_CurrCode", "VND");

                vnp_Params.put("vnp_BankCode", bankCode);
                vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
                vnp_Params.put("vnp_OrderType", orderType);

                String locate = request.getParameter("language");
                if (locate != null && !locate.isEmpty()) {
                    vnp_Params.put("vnp_Locale", locate);
                } else {
                    vnp_Params.put("vnp_Locale", "vn");
                }
                String returnURL = Config.vnp_ReturnUrl + "?orderId=" + orderId;
                vnp_Params.put("vnp_ReturnUrl", returnURL);
                vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                String vnp_CreateDate = formatter.format(cld.getTime());
                vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                cld.add(Calendar.MINUTE, 15);
                String vnp_ExpireDate = formatter.format(cld.getTime());
                vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

                List fieldNames = new ArrayList(vnp_Params.keySet());
                Collections.sort(fieldNames);
                StringBuilder hashData = new StringBuilder();
                StringBuilder query = new StringBuilder();
                Iterator itr = fieldNames.iterator();
                while (itr.hasNext()) {
                    String fieldName = (String) itr.next();
                    String fieldValue = (String) vnp_Params.get(fieldName);
                    if ((fieldValue != null) && (fieldValue.length() > 0)) {
                        //Build hash data
                        hashData.append(fieldName);
                        hashData.append('=');
                        hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        //Build query
                        query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                        query.append('=');
                        query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                        if (itr.hasNext()) {
                            query.append('&');
                            hashData.append('&');
                        }
                    }
                }
                String queryUrl = query.toString();

                String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
                queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
                
                response.sendRedirect(paymentUrl);
            }
        }
    }
}
