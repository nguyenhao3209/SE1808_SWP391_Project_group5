package Controller;

import Models.Vouchers;
import dal.VoucherDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.google.gson.JsonObject;

@WebServlet(name = "CheckVoucherServlet", urlPatterns = {"/CheckVoucherServlet"})
@MultipartConfig // Nếu bạn dùng FormData để gửi "voucherCode" thì cần @MultipartConfig
public class CheckVoucherServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession();

        // Lấy tổng tiền hiện tại (brandTotal) từ session
        BigDecimal brandTotal = (BigDecimal) session.getAttribute("brandTotal");
        if (brandTotal == null) {
            brandTotal = BigDecimal.ZERO;
        }

        String voucherCode = request.getParameter("voucherCode");
        JsonObject json = new JsonObject();

        // ===== Xử lý trường hợp "NONE" => người dùng bỏ chọn voucher =====
        if ("NONE".equalsIgnoreCase(voucherCode)) {
            json.addProperty("success", true);
            json.addProperty("message", "No voucher applied");
            // Discount = 0, finalTotal = brandTotal
            json.addProperty("discount", "0");
            json.addProperty("discountPercentage", "0");
            json.addProperty("finalTotal", brandTotal.toString());
            json.addProperty("voucherName", "No voucher");

            // Lưu vào session để PaymentServlet biết user không dùng voucher
            session.setAttribute("selectedVoucherID", null);  // Không dùng voucher

            response.getWriter().print(json.toString());
            return;
        }

        // Nếu voucherCode rỗng => báo lỗi
        if (voucherCode == null || voucherCode.trim().isEmpty()) {
            json.addProperty("success", false);
            json.addProperty("message", "No voucher code provided");
            response.getWriter().print(json.toString());
            return;
        }

        // Lấy voucher từ DB theo voucherCode
        VoucherDAO voucherDAO = new VoucherDAO();
        Vouchers v = voucherDAO.getVoucherByCode(voucherCode);
        if (v == null) {
            json.addProperty("success", false);
            json.addProperty("message", "Voucher not found");
            response.getWriter().print(json.toString());
            return;
        }

        // ===== Kiểm tra tính hợp lệ =====
        boolean valid = true;
        String msg = "";

        // 1) Voucher phải active
        if (!v.isIsActive()) {
            valid = false;
            msg = "Voucher is inactive";
        }
        // 2) Chưa hết hạn
        if (valid && !checkNotExpired(v.getExpiryDate())) {
            valid = false;
            msg = "Voucher expired";
        }
        // 3) brandTotal >= minOrderValue
        if (valid && brandTotal.compareTo(v.getMinOrderValue()) < 0) {
            valid = false;
            msg = "Order not enough for this voucher";
        }
        // 4) usageCount < quantity
        if (valid && v.getUsageCount() >= v.getQuantity()) {
            valid = false;
            msg = "Voucher out of usage";
        }
        // 5) user is used
        
        

        // Nếu bất kỳ điều kiện nào không thỏa => báo lỗi
        if (!valid) {
            json.addProperty("success", false);
            json.addProperty("message", msg);
            response.getWriter().print(json.toString());
            return;
        }

        // ===== Tính discount với RoundingMode =====
        BigDecimal discountCalc = brandTotal
                .multiply(v.getDiscountPercentage())
                // Chỉ định 2 chữ số thập phân, làm tròn HALF_UP
                .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

        // Nếu vượt quá maxReducing => lấy maxReducing
        if (discountCalc.compareTo(v.getMaxReducing()) > 0) {
            discountCalc = v.getMaxReducing();
        }

        // Tính finalTotal = brandTotal - discountCalc
        BigDecimal finalTotal = brandTotal.subtract(discountCalc);
        if (finalTotal.compareTo(BigDecimal.ZERO) < 0) {
            finalTotal = BigDecimal.ZERO;
        }

        // == Không tăng usageCount ở đây! ==
        // Thay vào đó, lưu voucherID vào session
        session.setAttribute("selectedVoucherID", v.getVoucherID());

        // ===== Trả kết quả JSON cho client =====
        json.addProperty("success", true);
        json.addProperty("discount", discountCalc.toString());
        json.addProperty("discountPercentage", v.getDiscountPercentage().toString());
        json.addProperty("finalTotal", finalTotal.toString());
        json.addProperty("voucherName", v.getName());
        response.getWriter().print(json.toString());
    }

    /**
     * Kiểm tra voucher còn hạn hay không.
     * Trả về true nếu expiryDate >= thời điểm hiện tại (chưa hết hạn).
     */
    private boolean checkNotExpired(String expiryDateStr) {
        if (expiryDateStr == null || expiryDateStr.trim().isEmpty()) {
            return false;
        }
        try {
            // Nếu có dấu chấm => cắt bỏ phần .xxx
            if (expiryDateStr.contains(".")) {
                expiryDateStr = expiryDateStr.substring(0, expiryDateStr.indexOf("."));
            }
            // Thay space thành 'T': "2025-03-01 00:00:00" => "2025-03-01T00:00:00"
            String iso = expiryDateStr.replace(" ", "T");

            LocalDateTime expiry = LocalDateTime.parse(
                    iso,
                    DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")
            );

            // Voucher còn hạn nếu expiry >= now => !expiry.isBefore(now)
            return !expiry.isBefore(LocalDateTime.now());

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
