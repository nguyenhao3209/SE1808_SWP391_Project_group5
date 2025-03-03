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
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;
import java.nio.file.Paths;

/**
 *
 * @author HuyLVQCE180656
 */
@MultipartConfig
@WebServlet(name = "EditProduct", urlPatterns = {"/editProduct"})
public class EditProduct extends HttpServlet {

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
            out.println("<title>Servlet EditProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProduct at " + request.getContextPath() + "</h1>");
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
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null) {
            int productId = Integer.valueOf(productIdStr);
            ProductsDAO productDAO = new ProductsDAO();
            Products product = productDAO.getProductById(productId);

            if (product != null) {
                System.out.println("p: "+product.getCategory().getCategoryID());
                request.setAttribute("product", product);
                request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("listProducts");
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
            String productIdStr = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String brand = request.getParameter("brand");
            String categoryIDStr = request.getParameter("categoryId");
            String priceStr = request.getParameter("price");
            String discountProductStr = request.getParameter("discountProduct");

            // Kiểm tra dữ liệu rỗng
            if (productName == null || productName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || brand == null || brand.trim().isEmpty()
                    || categoryIDStr == null || categoryIDStr.trim().isEmpty()
                    || priceStr == null || priceStr.trim().isEmpty()) {
                request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
                return;
            }

            // Chuyển đổi dữ liệu
            int productId = Integer.parseInt(productIdStr);
            int categoryID = Integer.parseInt(categoryIDStr);
            BigDecimal price = new BigDecimal(priceStr);
            BigDecimal discountProduct = (discountProductStr == null || discountProductStr.isEmpty())
                    ? BigDecimal.ZERO
                    : new BigDecimal(discountProductStr);

            // Xử lý ảnh upload
            String check_path = check_file(categoryID);
            Part filePart = request.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String path_file_img = "img/" + check_path + "/" + brand;
            String uploadPath = getServletContext().getRealPath("") + File.separator + path_file_img;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Kiểm tra ảnh cũ nếu không upload ảnh mới
            String imagePath;
            ProductsDAO productDAO = new ProductsDAO();
            if (fileName != null && !fileName.isEmpty()) {
                imagePath = path_file_img + "/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            } else {
                Products existingProduct = productDAO.getProductByID(productId);
                imagePath = existingProduct.getImageURL();
            }

            // Tạo đối tượng sản phẩm
            Category category = new Category();
            category.setCategoryID(categoryID);

            Products product = new Products();
            product.setProductID(productId);
            product.setProductName(productName);
            product.setDescription(description);
            product.setBrand(brand);
            product.setCategory(category);
            product.setPrice(price);
            product.setDiscountProduct(discountProduct);
            product.setImageURL(imagePath);

            // Cập nhật sản phẩm vào database
            productDAO.updateProduct(product);

            // Chuyển hướng về trang danh sách sản phẩm
            request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
            response.sendRedirect("listProducts");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi hệ thống, vui lòng thử lại sau!");
            request.getRequestDispatcher("admin/editProduct.jsp").forward(request, response);
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
