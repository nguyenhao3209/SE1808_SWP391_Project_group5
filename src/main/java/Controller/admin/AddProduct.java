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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HuyLVQCE180656
 */
@MultipartConfig
@WebServlet(name = "AddProduct", urlPatterns = {"/addProduct"})
public class AddProduct extends HttpServlet {

    List<String> sizeList = null;

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
            String brand = request.getParameter("brand");
            String categoryIDStr = request.getParameter("categoryID");
            String priceStr = request.getParameter("price");
            String discountProductStr = request.getParameter("discountProduct");

            // Chuyển đổi dữ liệu
            int categoryID = Integer.parseInt(categoryIDStr);
            BigDecimal price = new BigDecimal(priceStr);
            BigDecimal discountProduct = (discountProductStr == null || discountProductStr.isEmpty())
                    ? BigDecimal.ZERO
                    : new BigDecimal(discountProductStr);

            boolean hasSize = !(categoryID == 1 || categoryID == 5);
            List<String> sizeList = new ArrayList<>();

            if (hasSize) {
                String[] sizes = request.getParameterValues("sizes[]");

                if (sizes == null) {
                    request.setAttribute("message", "Vui lòng nhập đầy đủ kích thước!");
                    request.getRequestDispatcher("admin/addProduct.jsp").forward(request, response);
                    return;
                }

                for (int i = 0; i < sizes.length; i++) {
                    sizeList.add(sizes[i].trim());
                }
            }

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
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Kiểm tra thông tin bắt buộc
            if (productName == null || productName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || brand == null || brand.trim().isEmpty()) {

                request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher("admin/addProduct.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng sản phẩm
            Category category = new Category();
            category.setCategoryID(categoryID);

            Products product = new Products();
            product.setProductName(productName);
            product.setDescription(description);
            product.setBrand(brand);
            product.setCategory(category);
            product.setPrice(price);
            product.setDiscountProduct(discountProduct);
            product.setImageURL(fileName); // Lưu đường dẫn ảnh

            // Thêm sản phẩm vào database và lấy productID
            ProductsDAO productDAO = new ProductsDAO();
            int productID = productDAO.addProduct(product);
            // Nếu category không phải Accessory, thêm từng size vào bảng ProductSize
            if (hasSize) {
                for (int i = 0; i < sizeList.size(); i++) {
                    productDAO.addProductSize(productID, sizeList.get(i));
                }
            }

            // Xử lý Specifications
            List<String> specNames = new ArrayList<>();
            List<String> specValues = new ArrayList<>();

            String[] specNameArray = request.getParameterValues("specNames[]");
            String[] specValueArray = request.getParameterValues("specValues[]");

            if (specNameArray != null && specValueArray != null && specNameArray.length == specValueArray.length) {
                for (int i = 0; i < specNameArray.length; i++) {
                    productDAO.addProductSpecifications(productID, specNameArray[i], specValueArray[i]);
                }
            }

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
                path = "Accessory";
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
