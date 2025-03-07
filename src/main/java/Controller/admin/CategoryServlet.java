package Controller.admin;

import Models.Category;
import dal.CategoryDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/CategoryServlet"})
public class CategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";  // Mặc định hiển thị danh sách
        }

        switch (action) {
            case "list":
                listCategories(request, response);
                break;
            case "createForm":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                listCategories(request, response);
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
                createCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    /**
     * Hiển thị danh sách Category
     */
    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> list = categoryDAO.getAllCategories();
        request.setAttribute("categoryList", list);
        // Forward sang JSP hiển thị danh sách, ví dụ: category-list.jsp
        request.getRequestDispatcher("admin/category-list.jsp").forward(request, response);
    }

    /**
     * Hiển thị form tạo mới Category
     */
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chỉ đơn giản forward sang JSP form
        request.getRequestDispatcher("admin/category-form.jsp").forward(request, response);
    }

    /**
     * Tạo mới Category (xử lý form gửi lên)
     */
    private void createCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy dữ liệu từ form
        String name = request.getParameter("categoryName");
        String description = request.getParameter("description");

        // Tạo đối tượng Category
        Category c = new Category();
        c.setCategoryName(name);
        c.setDescription(description);

        // Gọi DAO để insert
        categoryDAO.insertCategory(c);

        // Sau khi thêm xong, quay lại danh sách
        response.sendRedirect("CategoryServlet?action=list");
    }

    /**
     * Hiển thị form edit Category
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Category category = categoryDAO.getCategoryById(id);

            if (category == null) {
                // Nếu không tìm thấy, chuyển về list kèm thông báo
                request.setAttribute("errorMessage", "Category not found!");
                listCategories(request, response);
                return;
            }

            request.setAttribute("category", category);
            // Forward sang JSP form để edit, có thể dùng chung category-form.jsp
            // hoặc tạo riêng category-edit.jsp
            request.getRequestDispatcher("admin/category-form.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // ID không hợp lệ
            request.setAttribute("errorMessage", "Invalid Category ID!");
            listCategories(request, response);
        }
    }

    /**
     * Cập nhật Category (xử lý form edit)
     */
    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("categoryID"));
            String name = request.getParameter("categoryName");
            String description = request.getParameter("description");

            // Lấy category cũ (nếu cần check)
            Category oldC = categoryDAO.getCategoryById(id);
            if (oldC == null) {
                request.setAttribute("errorMessage", "Category not found!");
                listCategories(request, response);
                return;
            }

            // Gán lại thông tin
            oldC.setCategoryName(name);
            oldC.setDescription(description);

            // Gọi DAO cập nhật
            categoryDAO.updateCategory(oldC);

            // Quay lại danh sách
            response.sendRedirect("CategoryServlet?action=list");
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Category ID!");
            listCategories(request, response);
        }
    }
}
