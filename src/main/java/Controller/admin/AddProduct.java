/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Models.Category;
import Models.Products;
import dal.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author HuyLVQCE180656
 */
@MultipartConfig
@WebServlet(name = "AddProduct", urlPatterns = {"/addProduct"})
public class AddProduct extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProduct at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String stockQuantityStr = request.getParameter("stockQuantity");
            String brand = request.getParameter("brand");
            String categoryIDStr = request.getParameter("categoryID");
            String priceStr = request.getParameter("price");
            String discountProductStr = request.getParameter("discountProduct");
            // Xử lý ảnh upload
            String check_path = check_file(Integer.valueOf(categoryIDStr));
            Part filePart = request.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            String path_file_img = "img/" + check_path + "/" + brand;
            String uploadPath = getServletContext().getRealPath("") + File.separator + path_file_img;
            System.out.println("uploadPath: " + uploadPath);
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Kiểm tra giá trị null hoặc rỗng
            if (productName == null || productName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || stockQuantityStr == null || stockQuantityStr.trim().isEmpty()
                    || brand == null || brand.trim().isEmpty()
                    || categoryIDStr == null || categoryIDStr.trim().isEmpty()
                    || priceStr == null || priceStr.trim().isEmpty()) {

                request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher("admin/addProduct.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi dữ liệu
            int stockQuantity = Integer.parseInt(stockQuantityStr);
            int categoryID = Integer.parseInt(categoryIDStr);
            BigDecimal price = new BigDecimal(priceStr);
            BigDecimal discountProduct = (discountProductStr == null || discountProductStr.isEmpty())
                    ? BigDecimal.ZERO
                    : new BigDecimal(discountProductStr);

            // Tạo đối tượng sản phẩm
            Category category = new Category();
            category.setCategoryID(categoryID);

            Products product = new Products();
            product.setProductName(productName);
            product.setDescription(description);
            product.setStockQuantity(stockQuantity);
            product.setBrand(brand);
            product.setCategory(category);
            product.setPrice(price);
            product.setDiscountProduct(discountProduct);
            product.setImageURL(path_file_img + "/" + fileName); // Lưu đường dẫn ảnh

            // Thêm sản phẩm vào database
            ProductsDAO productDAO = new ProductsDAO();
            productDAO.addProduct(product);

            // Nếu không có lỗi, xem như thành công
            request.getSession().setAttribute("message", "Sản phẩm đã được thêm thành công!");
            response.sendRedirect("listProducts");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi hệ thống, vui lòng thử lại sau!");
            request.getRequestDispatcher("admin/addProduct.jsp").forward(request, response);
        }
    }

    public String check_file(int id_category) {
        String path = "";
        switch (id_category) {
            case 1:
                path = "Racket";
                break;
            case 2:
                path = "Shoes";
                break;
            case 3:
                path = "Clothes";
                break;
            case 4:
                path = "Bag";
                break;
            case 5:
                path = "Accesory";
                break;
            default:
                System.out.println("Default case: Không khớp");
                break;
        }
        return path;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
