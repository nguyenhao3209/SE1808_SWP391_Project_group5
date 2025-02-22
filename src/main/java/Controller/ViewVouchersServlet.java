package Controller;

import dal.VoucherDAO;
import Models.Vouchers;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ViewVouchersServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy danh sách các voucher từ database
        VoucherDAO voucherDAO = new VoucherDAO();
        List<Vouchers> vouchers = null;
        
        try {
            vouchers = voucherDAO.getAllVouchers();
        } catch (Exception e) {
            // Xử lý lỗi nếu có sự cố trong việc lấy dữ liệu
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving voucher data.");
        }

        // Chuyển dữ liệu vouchers sang JSP
        request.setAttribute("vouchers", vouchers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewVouchers.jsp");
        dispatcher.forward(request, response);
    }
}
