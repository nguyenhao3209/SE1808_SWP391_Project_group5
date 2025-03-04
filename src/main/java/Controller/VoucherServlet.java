package Controller;

import dal.VoucherDAO;
import Models.Vouchers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class VoucherServlet extends HttpServlet {

    private VoucherDAO voucherDAO = new VoucherDAO();
    private static final String UPLOAD_DIR = "img/vouchers"; // Thư mục lưu ảnh

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
            case "add":
                showAddForm(request, response);
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
            case "create":
                createVoucher(request, response);
                break;
            case "update":
                updateVoucher(request, response);
                break;
            default:
                listVouchers(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách voucher
     */
    private void listVouchers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("voucherList", voucherDAO.getAllVouchers());
        // Forward đến trang danh sách voucher trong dashboard
        request.getRequestDispatcher("admin/voucher-list.jsp").forward(request, response);
    }

    /**
     * Hiển thị form thêm mới (Add)
     * Không set "voucher" => JSP hiểu là đang tạo mới
     */
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/voucher-form.jsp").forward(request, response);
    }

    /**
     * Hiển thị form edit (Edit)
     * Có set "voucher" => JSP hiểu là đang chỉnh sửa
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int voucherID = Integer.parseInt(request.getParameter("id"));
            Vouchers voucher = voucherDAO.getVoucherById(voucherID);

            if (voucher == null) {
                request.setAttribute("errorMessage", "Voucher không tồn tại!");
                request.getRequestDispatcher("admin/voucher-form.jsp").forward(request, response);
                return;
            }
            request.setAttribute("voucher", voucher);
            request.getRequestDispatcher("admin/voucher-form.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ!");
            request.getRequestDispatcher("admin/voucher-form.jsp").forward(request, response);
        }
    }

    /**
     * Xử lý Tạo voucher (action=create)
     * Admin nhập ExpiryDate dạng "yyyy-MM-ddTHH:mm:ss"
     */
    private void createVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy các trường từ form
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        BigDecimal maxReducing = new BigDecimal(request.getParameter("maxReducing"));
        String code = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Lấy ExpiryDate từ <input type="datetime-local">
        String expiryDate = request.getParameter("expiryDate");
        if (expiryDate != null && !expiryDate.isEmpty()) {
            expiryDate = expiryDate.replace("T", " "); // "2025-03-01T15:30:00" => "2025-03-01 15:30:00"
        } else {
            expiryDate = null;
        }

        boolean isActive = (request.getParameter("isActive") != null);
        BigDecimal minOrderValue = new BigDecimal(request.getParameter("minOrderValue"));
        int maxUsagePerUser = Integer.parseInt(request.getParameter("maxUsagePerUser"));
        int usageCount = 0; // Mặc định 0 khi tạo mới

        // Upload file ảnh
        Part filePart = request.getPart("imageFile");
        String imageURL = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String realPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            File savedFile = new File(uploadDir, fileName);
            filePart.write(savedFile.getAbsolutePath());
            imageURL = UPLOAD_DIR + "/" + fileName;
        }

        // Tạo đối tượng Vouchers
        Vouchers newVoucher = new Vouchers(
                0,
                name,
                description,
                discountPercentage,
                maxReducing,
                code,
                quantity,
                expiryDate,
                isActive,
                minOrderValue,
                maxUsagePerUser,
                usageCount,
                imageURL
        );

        // Gọi DAO để thêm voucher
        voucherDAO.insertVoucher(newVoucher);

        // Quay về danh sách
        response.sendRedirect("VoucherServlet?action=list");
    }

    /**
     * Xử lý Cập nhật voucher (action=update)
     * Admin chỉnh sửa ExpiryDate tương tự
     */
    private void updateVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int voucherID = Integer.parseInt(request.getParameter("voucherID"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal discountPercentage = new BigDecimal(request.getParameter("discountPercentage"));
        BigDecimal maxReducing = new BigDecimal(request.getParameter("maxReducing"));
        String code = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Lấy ExpiryDate
        String expiryDate = request.getParameter("expiryDate");
        if (expiryDate != null && !expiryDate.isEmpty()) {
            expiryDate = expiryDate.replace("T", " ");
        } else {
            expiryDate = null;
        }

        boolean isActive = (request.getParameter("isActive") != null);
        BigDecimal minOrderValue = new BigDecimal(request.getParameter("minOrderValue"));
        int maxUsagePerUser = Integer.parseInt(request.getParameter("maxUsagePerUser"));
        int usageCount = Integer.parseInt(request.getParameter("usageCount"));

        // Lấy voucher cũ
        Vouchers oldVoucher = voucherDAO.getVoucherById(voucherID);
        if (oldVoucher == null) {
            response.sendRedirect("VoucherServlet?action=list&error=NotFound");
            return;
        }

        // Upload ảnh mới nếu có
        Part filePart = request.getPart("imageFile");
        String imageURL = oldVoucher.getImageURL();
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String realPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            File savedFile = new File(uploadDir, fileName);
            filePart.write(savedFile.getAbsolutePath());
            imageURL = UPLOAD_DIR + "/" + fileName;
        }

        // Tạo đối tượng voucher mới
        Vouchers updatedVoucher = new Vouchers(
                voucherID,
                name,
                description,
                discountPercentage,
                maxReducing,
                code,
                quantity,
                expiryDate,
                isActive,
                minOrderValue,
                maxUsagePerUser,
                usageCount,
                imageURL
        );

        // Cập nhật DB
        voucherDAO.updateVoucher(updatedVoucher);

        // Quay về danh sách
        response.sendRedirect("VoucherServlet?action=list");
    }

    /**
     * Xóa voucher
     */
    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        voucherDAO.deleteVoucher(id);
        response.sendRedirect("VoucherServlet?action=list");
    }
}
