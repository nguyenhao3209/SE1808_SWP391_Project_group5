/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Controller.ProductSizeServlet;
import Models.Category;
import Models.ProductSizes;
import Models.Products;
import Models.Specifications;
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
import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
            List<ProductSizes> sizes = productDAO.getSizesOfProductByID(productId);
            List<Specifications> specs = productDAO.getSpecificationsByProductId(productId);

            if (product != null) {
                request.setAttribute("product", product);
                request.setAttribute("sizes", sizes);
                request.setAttribute("specs", specs);
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
            String categoryIDStr = request.getParameter("categoryID");
            String priceStr = request.getParameter("price");
            String discountProductStr = request.getParameter("discountProduct");
            ProductsDAO productDAO = new ProductsDAO();

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

            boolean hasSize = (categoryID == 2 || categoryID == 3);

            if (hasSize) {
                String[] sizeIDs = request.getParameterValues("sizeIDs[]"); // Mảng ID của size còn lại trong form
                String[] sizes = request.getParameterValues("sizes[]"); // Mảng giá trị size

                ArrayList<ProductSizes> existingSizeIDs = productDAO.getSizesOfProductByID(productId); // Lấy danh sách sizeID từ DB

                // Xóa các size không còn trong form
                for (ProductSizes dbSizeID : existingSizeIDs) {
                    boolean stillExists = false;
                    if (sizeIDs != null) {
                        for (String formSizeID : sizeIDs) {
                            if (formSizeID != null && !formSizeID.isEmpty() && dbSizeID.getSizeID() == Integer.parseInt(formSizeID)) {
                                stillExists = true;
                                break;
                            }
                        }
                    }
                    if (!stillExists) {
                        productDAO.deleteProductSize(dbSizeID.getSizeID()); // Xóa size không còn trong form
                    }
                }

                // Cập nhật size cũ hoặc thêm mới
                if (sizes != null) {
                    for (int i = 0; i < sizes.length; i++) {
                        String newSize = sizes[i];

                        if (sizeIDs != null && i < sizeIDs.length && sizeIDs[i] != null && !sizeIDs[i].isEmpty()) {
                            int sizeID = Integer.parseInt(sizeIDs[i]);
                            productDAO.updateProductSizes(productId, sizeID, newSize);
                        } else {
                            productDAO.addProductSize(productId, newSize);
                        }
                    }
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

            // Kiểm tra ảnh cũ nếu không upload ảnh mới
            String imagePath;
            if (fileName != null && !fileName.isEmpty()) {
                imagePath = path_file_img + "/" + fileName;
                filePart.write(uploadPath + File.separator + fileName);
            } else {
                Products existingProduct = productDAO.getProductById(productId);
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
            // Nếu category không phải Accessory, thêm từng size vào bảng ProductSize

            // Xử lý Specifications
            String[] specIDs = request.getParameterValues("specIDs[]"); // Mảng ID của specifications còn lại trong form
            String[] specNames = request.getParameterValues("specNames[]"); // Mảng tên specifications
            String[] specValues = request.getParameterValues("specValues[]"); // Mảng giá trị specifications

            ArrayList<Specifications> existingSpecIDs = productDAO.getSpecificationsByProductId(productId); // Lấy danh sách SpecificationID từ DB

            // Xóa các specifications không còn trong form
            for (Specifications dbSpecID : existingSpecIDs) {
                boolean stillExists = false;
                if (specIDs != null) {
                    for (String formSpecID : specIDs) {
                        if (formSpecID != null && !formSpecID.isEmpty() && dbSpecID.getSpecificationID() == Integer.parseInt(formSpecID)) {
                            stillExists = true;
                            break;
                        }
                    }
                }
                if (!stillExists) {
                    productDAO.deleteProductSpecification(dbSpecID.getSpecificationID()); // Xóa specification không còn trong form
                }
            }

            // Cập nhật specification cũ hoặc thêm mới
            if (specNames != null && specValues != null) {
                for (int i = 0; i < specNames.length; i++) {
                    String specName = specNames[i];
                    String specValue = specValues[i];

                    if (specIDs != null && i < specIDs.length && specIDs[i] != null && !specIDs[i].isEmpty()) {
                        int specID = Integer.parseInt(specIDs[i]);
                        productDAO.updateSpecifications(productId, specName, specValue);
                    } else {
                        productDAO.addProductSpecifications(productId, specName, specValue);
                    }
                }
            }

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
