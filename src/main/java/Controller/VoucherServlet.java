package Controller;

import dal.VoucherDAO;
import java.math.BigDecimal;
import Models.Vouchers;
import com.fasterxml.jackson.core.io.BigDecimalParser;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VoucherServlet", urlPatterns = {"/VoucherServlet"})
public class VoucherServlet extends HttpServlet {

    private VoucherDAO voucherDAO = new VoucherDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    if (action == null) {
        action = "list";
    }
    switch (action) {
        case "list":
            listVouchers(request, response);
            break;
        case "edit":
            showEditForm(request, response);
            break;
        case "delete":
            deleteVoucher(request, response);
            break;
        default:
            listVouchers(request, response);
            break;
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "insert":
                insertVoucher(request, response);
                break;
            case "update":
                updateVoucher(request, response);
                break;
            default:
                listVouchers(request, response);
                break;
        }
    }

    private void listVouchers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vouchers> list = voucherDAO.getAllVouchers();
        request.setAttribute("voucherList", list);
        request.getRequestDispatcher("voucher-list.jsp").forward(request, response);
    }

private void showEditForm(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int voucherID = Integer.parseInt(request.getParameter("id"));
        VoucherDAO voucherDAO = new VoucherDAO();
        Vouchers voucher = voucherDAO.getVoucherById(voucherID);  // Đảm bảo dùng đúng tên hàm

        if (voucher == null) {
            request.setAttribute("errorMessage", "Voucher không tồn tại!");
            request.getRequestDispatcher("voucher-edit.jsp").forward(request, response);
            return;
        }

        request.setAttribute("voucher", voucher);
        request.getRequestDispatcher("voucher-edit.jsp").forward(request, response);
    } catch (NumberFormatException e) {
        request.setAttribute("errorMessage", "ID không hợp lệ!");
        request.getRequestDispatcher("voucher-edit.jsp").forward(request, response);
    }
}


    private void insertVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Kiểm tra các tham số có tồn tại và không null trước khi chuyển đổi
        String voucherIDStr = request.getParameter("voucherID");
        int voucherID = (voucherIDStr != null && !voucherIDStr.isEmpty()) ? Integer.parseInt(voucherIDStr) : 0; // Hoặc sử dụng giá trị mặc định khác

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        BigDecimal maxReducing = new BigDecimal(request.getParameter("maxReducing"));
        String code = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String expiryDate = request.getParameter("expiryDate");

        // Kiểm tra nếu các thông tin quan trọng còn thiếu
        if (name == null || description == null || code == null || expiryDate == null || quantity <= 0) {
            // Thêm logic xử lý thông báo lỗi nếu thiếu dữ liệu quan trọng
            response.sendRedirect("VoucherServlet?action=list&error=missingData");
            return;
        }

        Vouchers newVoucher = new Vouchers(voucherID, name, description, discountPercentage, maxReducing, code, quantity, expiryDate);
        if (voucherDAO.insertVoucher(newVoucher)) {
            response.sendRedirect("VoucherServlet?action=list");
        } else {
            // Xử lý trường hợp không insert thành công
            response.sendRedirect("VoucherServlet?action=list&error=insertFailed");
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int voucherID = Integer.parseInt(request.getParameter("voucherID"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        BigDecimal maxReducing = new BigDecimal(request.getParameter("maxReducing"));
        String code = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String expiryDate = request.getParameter("expiryDate");
        Vouchers newVoucher = new Vouchers(voucherID, name, description, discountPercentage, maxReducing, code, quantity, expiryDate);
        voucherDAO.updateVoucher(newVoucher);
        response.sendRedirect("VoucherServlet?action=list");
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        voucherDAO.deleteVoucher(id);
        response.sendRedirect("VoucherServlet?action=list");
    }
}
