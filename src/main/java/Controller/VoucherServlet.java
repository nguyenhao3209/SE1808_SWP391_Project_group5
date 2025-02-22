package Controller;

import dal.VoucherDAO;
import Models.Vouchers;
import java.io.IOException;
import java.math.BigDecimal;
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
        if (action == null) {
            action = "";
        }
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
            Vouchers voucher = voucherDAO.getVoucherById(voucherID);

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

        // KHÔNG lấy voucherID, DB sẽ tự sinh (IDENTITY)
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        BigDecimal maxReducing = new BigDecimal(request.getParameter("maxReducing"));
        String code = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String expiryDate = request.getParameter("expiryDate");

        // Tạo voucher với ID = 0 hoặc constructor bỏ ID
        Vouchers newVoucher = new Vouchers(
            0,  // DB sẽ tự sinh ID
            name,
            description,
            discountPercentage,
            maxReducing,
            code,
            quantity,
            expiryDate
        );

        boolean inserted = voucherDAO.insertVoucher(newVoucher);
        if (inserted) {
            response.sendRedirect("VoucherServlet?action=list");
        } else {
            response.sendRedirect("VoucherServlet?action=list&error=insertFailed");
        }
    }

    private void updateVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Khi update, cần voucherID
        int voucherID = Integer.parseInt(request.getParameter("voucherID"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        BigDecimal maxReducing = new BigDecimal(request.getParameter("maxReducing"));
        String code = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String expiryDate = request.getParameter("expiryDate");

        Vouchers updatedVoucher = new Vouchers(
            voucherID, 
            name,
            description,
            discountPercentage,
            maxReducing,
            code,
            quantity,
            expiryDate
        );

        voucherDAO.updateVoucher(updatedVoucher);
        response.sendRedirect("VoucherServlet?action=list");
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        voucherDAO.deleteVoucher(id);
        response.sendRedirect("VoucherServlet?action=list");
    }
}
