/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Cart;
import Models.Category;
import Models.Customers;
import Models.ProductSizes;
import Models.Products;
import Models.Slider;
import Models.Specifications;
import Models.StockImport;
import java.math.BigDecimal;
import Models.StockImportDetails;
import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class ProductsDAO extends DBContext {

//     public List<String> getAllCategory() {
//        ArrayList<String> list = new ArrayList<>();
//        String sql = "select distinct c.CategoryName "
//                + "  FROM [dbo].[Products] p, Category c where c.CategoryID = p.CategoryID";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                list.add(rs.getString(1));
//            }
//            rs.close();
//            ps.close();
//        } catch (SQLException e) {
//            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
//        }
//        return list;
//    }
    public ProductsDAO() {
        super();
    }

    public List<Products> getAllProducts(int page_number) {
        List<Products> productList = new ArrayList<>();
//        String sql = "SELECT p.ProductID, p.ImageURL, p.ProductName, s.Size, p.Brand, p.Price, p.StockQuantity FROM Products p\n"
//                + "JOIN ProductSizes s ON p.ProductID = s.ProductID;";
        String sql = "select *from Products p  order by p.ProductID ASC OFFSET " + page_number + " ROWS\n"
                + "FETCH NEXT 20 ROWS ONLY;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products product = new Products(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        rs.getBigDecimal("Price"),
                        rs.getInt("StockQuantity"),
                        rs.getString("Brand"),
                        getCategoryByID(rs.getInt("CategoryID")),
                        null,
                        rs.getString("ImageURL"),
                        null,
                        null,
                        null
                );
                productList.add(product);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public void addProduct(Products product) {
        String sql = "INSERT INTO Products (ProductName, Description, StockQuantity, Brand, CategoryID, Price, DiscountPercent, ImageURL) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setInt(3, product.getStockQuantity());
            ps.setString(4, product.getBrand());
            ps.setInt(5, product.getCategory().getCategoryID());
            ps.setBigDecimal(6, product.getPrice());
            ps.setBigDecimal(7, product.getDiscountProduct() != null ? product.getDiscountProduct() : BigDecimal.ZERO);
            ps.setString(8, product.getImageURL());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Products product) {
        String sql = "UPDATE Products SET ProductName = ?, Description = ?, Brand = ?, CategoryID = ?, Price = ?, DiscountPercent = ?, ImageURL = ? WHERE ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setString(3, product.getBrand());
            ps.setInt(4, product.getCategory().getCategoryID());
            ps.setBigDecimal(5, product.getPrice());
            ps.setBigDecimal(6, product.getDiscountProduct() != null ? product.getDiscountProduct() : BigDecimal.ZERO);
            ps.setString(7, product.getImageURL());
            ps.setInt(8, product.getProductID());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProductById(int productId) {
        String sql = "DELETE FROM Products WHERE productID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi ra console để debug
        }
    }

//    public List<Products> searchProductsByName(String query, int page_number) {
//        List<Products> products = new ArrayList<>();
//        String sql = "SELECT * FROM Products WHERE ProductName LIKE ?";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, "%" + query + "%");
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Products product = new Products();
//                product.setProductID(rs.getInt("ProductID"));
//                product.setImageURL(rs.getString("ImageURL"));
//                product.setProductName(rs.getString("ProductName"));
//                product.setBrand(rs.getString("Brand"));
//                product.setPrice(rs.getBigDecimal("Price"));
//                
//                products.add(product);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return products;
//    }
    public List<Products> searchProductsByName(String query, int offset, int limit) {
        List<Products> products = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE ProductName LIKE ? "
                + "ORDER BY ProductID ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setInt(2, offset);
            ps.setInt(3, limit);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products();
                    product.setProductID(rs.getInt("ProductID"));
                    product.setImageURL(rs.getString("ImageURL"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setBrand(rs.getString("Brand"));
                    product.setPrice(rs.getBigDecimal("Price"));
                    product.setCategory(getCategoryByID(rs.getInt("CategoryID")));

                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Object[]> getTop8() {
        List<Object[]> productList = new ArrayList<>();
        String sql = "SELECT p.*, c.CategoryName FROM Category c\n"
                + "OUTER APPLY (\n"
                + "    SELECT TOP 8 * \n"
                + "    FROM Products p\n"
                + "    WHERE p.CategoryID = c.CategoryID\n"
                + "    ORDER BY p.DiscountPercent DESC\n"
                + ") p\n"
                + "WHERE p.DiscountPercent > 0\n"
                + "ORDER BY c.CategoryID, p.DiscountPercent DESC;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Object[] p = new Object[]{
                    rs.getInt("ProductID"),
                    rs.getString("ProductName"),
                    rs.getBigDecimal("Price"),
                    rs.getString("Brand"),
                    rs.getString("ImageURL"),
                    rs.getBigDecimal("DiscountPercent"),
                    rs.getString("CategoryName"),
                    rs.getInt("CategoryID")

                };
                productList.add(p);
            }
            System.out.println(productList.size());
        } catch (SQLException e) {

            System.out.println("error: " + e);
            e.printStackTrace();
        }
        return productList;
    }

    public int count_product() {
        String sql = "select count(*) from Products";
        int count = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countSearchResults(String searchQuery) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Products WHERE ProductName LIKE ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + searchQuery + "%");

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Category> getAllCategory() {
        ArrayList<Category> list = new ArrayList<>();
        String sql = "select * "
                + "  FROM Category c";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt(1), rs.getString(2), rs.getString(3)));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getAllBrand() {
        ArrayList<String> list = new ArrayList<>();
        String sql = "select distinct Brand "
                + "  FROM [dbo].[Products]";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
        }
        return list;
    }

    public ArrayList<Products> searchProductsWithFilters2(String keyword, String[] categories, String[] brands, String priceRange, int pageNumber, int pageSize) {
        ArrayList<Products> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT p.ProductID,\n"
                + "    p.ProductName,\n"
                + "    p.Price,\n"
                + "    p.StockQuantity,\n"
                + "    p.Brand,\n"
                + "    p.CategoryID,\n"
                + "    CAST(p.Description AS NVARCHAR(MAX)) AS Description, \n"
                + "    CAST(p.ImageURL AS NVARCHAR(MAX)) AS ImageURL, \n"
                + "    p.CreateAt,\n"
                + "    p.UpdateAt,\n"
                + "    p.DiscountPercent,\n"
                + "    COUNT(f.FeedbackID) AS FeedbackCount,\n"
                + "    AVG(f.Rating) AS AverageRating, c.CategoryName\n"
                + "FROM Products p LEFT JOIN Feedback f ON p.ProductID = f.ProductID left join Category c on c.CategoryID = p.CategoryID\n"
                + "WHERE p.ProductName LIKE ?"
        );

        // Add category filter
        if (categories != null && categories.length > 0) {
            sql.append(" AND p.CategoryID IN (");
            for (int i = 0; i < categories.length; i++) {
                sql.append("?");
                if (i < categories.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        // Add brand filter
        if (brands != null && brands.length > 0) {
            sql.append(" AND p.Brand IN (");
            for (int i = 0; i < brands.length; i++) {
                sql.append("?");
                if (i < brands.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        // Add price range filter
        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("low")) {
                sql.append(" AND p.Price < 150"); // Low price
            } else if (priceRange.equals("medium")) {
                sql.append(" AND p.Price BETWEEN 150 AND 300"); // Medium price
            } else if (priceRange.equals("high")) {
                sql.append(" AND p.Price > 300"); // High price
            }
        }

        // Add grouping and pagination
        sql.append(" GROUP BY p.ProductID, p.ProductName, p.Price, p.StockQuantity, p.Brand, p.CategoryID, CAST(p.Description AS NVARCHAR(MAX)), CAST(p.ImageURL AS NVARCHAR(MAX)),  p.CreateAt,\n"
                + "    p.UpdateAt, p.DiscountPercent, c.CategoryName");
        sql.append(" ORDER BY p.ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int index = 1;

            // Add keyword filter
            ps.setString(index++, "%" + keyword + "%");

            // Set categories
            if (categories != null && categories.length > 0) {
                for (String category : categories) {
                    ps.setString(index++, category);
                }
            }

            // Set brands
            if (brands != null && brands.length > 0) {
                for (String brand : brands) {
                    ps.setString(index++, brand);
                }
            }

            // Calculate offset for pagination
            int offset = (pageNumber - 1) * pageSize;
            ps.setInt(index++, offset);

            // Set page size
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductID(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setStockQuantity(rs.getInt("StockQuantity"));
                p.setBrand(rs.getString("Brand"));
                Category c = getCategoryByID(rs.getInt("CategoryID"));
                p.setCategory(c);
                p.setDescription(rs.getString("Description"));
                p.setImageURL(rs.getString("ImageURL"));
                p.setDiscountProduct(rs.getBigDecimal("DiscountPercent"));
                p.setNumberOfFeedbacks(rs.getInt("FeedbackCount"));
                p.setAvgRating(rs.getDouble("AverageRating"));
                list.add(p);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

//    public ArrayList<Products> searchProductsWithFilters(String keyword, String[] categories, String[] brands, String priceRange, int pageNumber, int pageSize) {
//        ArrayList<Products> list = new ArrayList<>();
//        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE ProductName LIKE ?");
//
//        // Thêm điều kiện lọc theo danh mục nếu có
//        if (categories != null && categories.length > 0) {
//            sql.append(" AND Category IN (");
//            for (int i = 0; i < categories.length; i++) {
//                sql.append("?");
//                if (i < categories.length - 1) {
//                    sql.append(",");
//                }
//            }
//            sql.append(")");
//        }
//
//        // Thêm điều kiện lọc theo thương hiệu nếu có
//        if (brands != null && brands.length > 0) {
//            sql.append(" AND Brand IN (");
//            for (int i = 0; i < brands.length; i++) {
//                sql.append("?");
//                if (i < brands.length - 1) {
//                    sql.append(",");
//                }
//            }
//            sql.append(")");
//        }
//
//        // Thêm điều kiện lọc theo giá
//        if (priceRange != null && !priceRange.isEmpty()) {
//            if (priceRange.equals("low")) {
//                sql.append(" AND Price < 150"); // Giá thấp
//            } else if (priceRange.equals("medium")) {
//                sql.append(" AND Price BETWEEN 150 AND 300"); // Giá tầm trung
//            } else if (priceRange.equals("high")) {
//                sql.append(" AND Price > 300"); // Giá cao
//            }
//        }
//
//        // Thêm phân trang với OFFSET và FETCH
//        sql.append(" ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
//        
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql.toString());
//            int index = 1;
//
//            // Thêm từ khóa tìm kiếm
//            ps.setString(index++, "%" + keyword + "%");
//
//            // Gán giá trị cho danh mục
//            if (categories != null && categories.length > 0) {
//                for (String category : categories) {
//                    ps.setString(index++, category);
//                }
//            }
//
//            // Gán giá trị cho thương hiệu
//            if (brands != null && brands.length > 0) {
//                for (String brand : brands) {
//                    ps.setString(index++, brand);
//                }
//            }
//
//            // Tính toán và gán giá trị cho OFFSET (vị trí bắt đầu của trang hiện tại)
//            int offset = (pageNumber - 1) * pageSize;
//            ps.setInt(index++, offset);
//
//            // Gán giá trị cho FETCH NEXT (số lượng sản phẩm mỗi trang)
//            ps.setInt(index++, pageSize);
//            
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Products p = new Products();
//                p.setProductID(rs.getInt("ProductID"));
//                p.setProductName(rs.getString("ProductName"));
//                p.setPrice(rs.getBigDecimal("Price"));
//                p.setStockQuantity(rs.getInt("StockQuantity"));
//                p.setBrand(rs.getString("Brand"));
//                p.setCategoryID(new Category(rs.getInt("CategoryID")));
//                p.setDescription(rs.getString("Description"));
//                p.setImageURL(rs.getString("ImageURL"));
//                list.add(p);
//            }
//            rs.close();
//            ps.close();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    public int getTotalProducts(String keyword, String[] categories, String[] brands, String priceRange) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products WHERE ProductName LIKE ?");

        // Tương tự như phần điều kiện lọc trong phương thức tìm kiếm
        if (categories != null && categories.length > 0) {
            sql.append(" AND CategoryID IN (");
            for (int i = 0; i < categories.length; i++) {
                sql.append("?");
                if (i < categories.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        if (brands != null && brands.length > 0) {
            sql.append(" AND Brand IN (");
            for (int i = 0; i < brands.length; i++) {
                sql.append("?");
                if (i < brands.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            if (priceRange.equals("low")) {
                sql.append(" AND Price < 150");
            } else if (priceRange.equals("medium")) {
                sql.append(" AND Price BETWEEN 150 AND 300");
            } else if (priceRange.equals("high")) {
                sql.append(" AND Price > 300");
            }
        }

        int total = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            int index = 1;

            // Gán giá trị cho từ khóa tìm kiếm
            ps.setString(index++, "%" + keyword + "%");

            // Gán giá trị cho danh mục
            if (categories != null && categories.length > 0) {
                for (String category : categories) {
                    ps.setString(index++, category);
                }
            }

            // Gán giá trị cho thương hiệu
            if (brands != null && brands.length > 0) {
                for (String brand : brands) {
                    ps.setString(index++, brand);
                }
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1); // Lấy giá trị COUNT từ kết quả truy vấn
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public ArrayList<String> getBrandByCategory(String category) {
        ArrayList<String> listBrand = new ArrayList<>();
        String sql = "SELECT DISTINCT Brand\n"
                + "FROM [dbo].[Products]\n"
                + "WHERE CategoryID = ?;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listBrand.add(rs.getString("Brand"));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
        }
        return listBrand;
    }

    public ArrayList<Cart> getCartByUserID(String userID) {
        ArrayList<Cart> cart = new ArrayList<>();
        String sql = "SELECT [CartID], [CustomerID], [ProductID], [SizeID], [Quantity], [CreatedAt] "
                + "FROM [Cart] WHERE CustomerID = ?";

        CustomersDAO cusDAO = new CustomersDAO();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Customers customer = cusDAO.getCustomerByID(rs.getString("CustomerID"));
                Products pro = getProductByID(rs.getInt("ProductID"));

                int sizeID = rs.getInt("SizeID");
                ProductSizes size = null;
                if (!rs.wasNull()) {
                    size = getProductSizeByID(sizeID);
                }

                if (pro.getCategory().getCategoryName().equals("Shoes")
                        || pro.getCategory().getCategoryName().equals("Clothes")) {
                    cart.add(new Cart(rs.getInt("CartID"), customer, pro, size, rs.getInt("Quantity")));
                } else {
                    cart.add(new Cart(rs.getInt("CartID"), customer, pro, rs.getInt("Quantity")));
                }
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cart;
    }

    public void updateCart(Cart item) {
        String sql = "UPDATE [dbo].[Cart]\n"
                + "   SET [Quantity] = ?\n"
                + " WHERE CartID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, item.getQuantity());
            ps.setInt(2, item.getCartID());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int getQuantityOfItemByUserID(String userID) {
        String sql = "SELECT COUNT(CartID) AS 'CountItems' FROM [dbo].[Cart] WHERE CustomerID = ?";
        int totalQuantity = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalQuantity = rs.getInt("CountItems");
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return totalQuantity;
    }

    public boolean removeItemOfCart(int itemID) {
        String sql = "DELETE FROM [dbo].[Cart]\n"
                + "      WHERE CartID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, itemID);

            ps.executeUpdate();
            ps.close();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public Products getProductById(int productId) {
        Products product = null; // Khai báo product trước try
        String sql = "SELECT ProductID, ProductName, Description, Brand, CategoryID, Price, DiscountPercent, ImageURL FROM Products WHERE ProductID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    product = new Products(); // Khởi tạo đối tượng nếu có dữ liệu
                    product.setProductID(rs.getInt("ProductID"));
                    product.setProductName(rs.getString("ProductName"));
                    product.setDescription(rs.getString("Description"));
                    product.setBrand(rs.getString("Brand"));

                    Category category = new Category();
                    category.setCategoryID(rs.getInt("CategoryID"));

                    // Gán category vào product
                    product.setCategory(category);

                    product.setPrice(rs.getBigDecimal("Price"));
                    product.setDiscountProduct(rs.getBigDecimal("DiscountPercent"));
                    product.setImageURL(rs.getString("ImageURL"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public Products getProductByID(int productId) {
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, p.StockQuantity, p.Brand, "
                + "p.CategoryID, CAST(p.Description AS NVARCHAR(MAX)) AS Description, "
                + "CAST(p.ImageURL AS NVARCHAR(MAX)) AS ImageURL, p.CreateAt, p.UpdateAt, "
                + "p.DiscountPercent, COUNT(f.FeedbackID) AS FeedbackCount, "
                + "COALESCE(AVG(f.Rating), 0) AS AverageRating, c.CategoryName "
                + "FROM Products p "
                + "LEFT JOIN Feedback f ON p.ProductID = f.ProductID "
                + "LEFT JOIN Category c ON c.CategoryID = p.CategoryID "
                + "WHERE p.ProductID = ? "
                + "GROUP BY p.ProductID, p.ProductName, p.Price, p.StockQuantity, p.Brand, "
                + "p.CategoryID, CAST(p.Description AS NVARCHAR(MAX)), CAST(p.ImageURL AS NVARCHAR(MAX)), "
                + "p.CreateAt, p.UpdateAt, p.DiscountPercent, c.CategoryName";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Products p = new Products();
                    p.setProductID(rs.getInt("ProductID"));
                    p.setProductName(rs.getString("ProductName"));
                    p.setPrice(rs.getBigDecimal("Price"));
                    p.setStockQuantity(rs.getInt("StockQuantity"));
                    p.setBrand(rs.getString("Brand"));

                    // Tạo Category từ dữ liệu truy vấn
                    Category c = new Category();
                    c.setCategoryID(rs.getInt("CategoryID"));
                    c.setCategoryName(rs.getString("CategoryName"));
                    p.setCategory(c);

                    p.setDescription(rs.getString("Description"));
                    p.setImageURL(rs.getString("ImageURL"));
                    p.setDiscountProduct(rs.getBigDecimal("DiscountPercent"));
                    p.setNumberOfFeedbacks(rs.getInt("FeedbackCount"));
                    p.setAvgRating(rs.getDouble("AverageRating")); // Đã xử lý null bằng COALESCE

                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Specifications> getSpecificationsByProductId(int productId) {
        ArrayList<Specifications> specifications = new ArrayList<>();
        String query = "SELECT * FROM Specifications WHERE ProductID = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                specifications.add(new Specifications(
                        rs.getInt("SpecificationID"),
                        getProductByID(rs.getInt("ProductID")),
                        rs.getString("Key"),
                        rs.getString("Value")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return specifications;
    }

    public Category getCategoryByID(int id) {
        String sql = "SELECT [CategoryID]\n"
                + "      ,[CategoryName]\n"
                + "      ,[Description]\n"
                + "  FROM [dbo].[Category]\n"
                + "  WHERE CategoryID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Category cat = new Category(rs.getInt("CategoryID"), rs.getString("CategoryName"), rs.getString("Description"));
                return cat;
            }
            rs.close();
            ps.close();

        } catch (SQLException e) {
        }
        return null;
    }

    public static void main(String[] args) {
        ProductsDAO proDAO = new ProductsDAO();
        ArrayList<Products> listP = proDAO.getAllStockProducts();
        for (Products products : listP) {
            System.out.println(products.getImportDate());
        }
    }

    public void insertToCart(Cart item) {
        String sql = "INSERT INTO [dbo].[Cart] "
                + "([CustomerID], [ProductID], [SizeID], [Quantity]) "
                + "VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, item.getCustomer().getCustomerId());
            ps.setInt(2, item.getProduct().getProductID());

            if (item.getProductSizes() != null) {
                ps.setInt(3, item.getProductSizes().getSizeID());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }

            ps.setInt(4, item.getQuantity());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Cart getCartByCartID(int cartID) {
        String sql = "SELECT [CartID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[ProductID]\n"
                + "      ,[SizeID]\n"
                + "      ,[Quantity]\n"
                + "      ,[CreatedAt]\n"
                + "  FROM [dbo].[Cart]\n"
                + "  WHERE CartID = ?";
        CustomersDAO uDAO = new CustomersDAO();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, cartID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Customers user = uDAO.getCustomerByID(rs.getString("CustomerID"));
                Products pro = getProductByID(rs.getInt("ProductID"));
                Cart cart = new Cart(user, pro, rs.getInt("Quantity"));
                return cart;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;

    }

    public ArrayList<ProductSizes> getSizesOfProductByID(int productId) {
        ArrayList<ProductSizes> productSizes = new ArrayList<>();
        String sql = "SELECT SizeID, Size, StockQuantity FROM ProductSizes WHERE ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int sizeId = rs.getInt("SizeID");
                String size = rs.getString("Size");
                int stockQuantity = rs.getInt("StockQuantity");
                ProductSizes psObj = new ProductSizes(sizeId, getProductByID(productId), size, stockQuantity);
                productSizes.add(psObj);
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return productSizes;
    }

    public ProductSizes getProductSizeByID(int sizeID) {

        String sql = "SELECT [SizeID], [ProductID], [Size], [StockQuantity] "
                + "FROM [dbo].[ProductSizes] WHERE SizeID = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, sizeID);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductSizes proSizes = new ProductSizes();
                    proSizes.setSizeID(rs.getInt("SizeID"));
                    proSizes.setProduct(getProductByID(rs.getInt("ProductID")));
                    proSizes.setSize(rs.getString("Size"));
                    proSizes.setStockQuantity(rs.getInt("StockQuantity"));
                    return proSizes;
                }
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public ArrayList<Slider> getAllSliders() {
        ArrayList<Slider> sliders = new ArrayList<>();
        String query = "SELECT SliderID, ProductID, ImageURL FROM Sliders";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int sliderID = rs.getInt("SliderID");
                int productID = rs.getInt("ProductID");
                String imageURL = rs.getString("ImageURL");

                Products product = getProductByID(productID);

                sliders.add(new Slider(sliderID, product, imageURL));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public ArrayList<StockImport> getAllStockImports() {
        StaffsDAO staffDAO = new StaffsDAO();
        ArrayList<StockImport> stockList = new ArrayList<>();
        String sql = "SELECT ImportID, StaffID, Supplier, ImportDate, TotalCost, Status FROM StockImport";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                StockImport stock = new StockImport();
                stock.setImportID(rs.getInt("ImportID"));
                stock.setStaff(staffDAO.getStaffByID(rs.getString("StaffID")));
                stock.setSupplier(rs.getString("Supplier"));
                stock.setImportDate(rs.getTimestamp("ImportDate"));
                stock.setTotalCost(rs.getBigDecimal("TotalCost"));
                stock.setStatus(rs.getString("Status"));
                stockList.add(stock);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stockList;
    }

    public ArrayList<StockImport> getFilteredStock(String fromDate, String toDate, String supplier, String staffName, String status) {
        ArrayList<StockImport> stockList = new ArrayList<>();
        StaffsDAO staffDAO = new StaffsDAO();
        String sql = "SELECT si.ImportID, si.ImportDate, si.TotalCost, si.Supplier, si.Status, s.StaffID, s.StaffName "
                + "FROM StockImport si "
                + "JOIN Staffs s ON si.StaffID = s.StaffID "
                + "WHERE 1=1";

        List<String> params = new ArrayList<>();

        if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND si.ImportDate >= ?";
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql += " AND si.ImportDate <= ?";
            params.add(toDate);
        }
        if (supplier != null && !supplier.isEmpty()) {
            sql += " AND si.Supplier LIKE ?";
            params.add("%" + supplier + "%");
        }
        if (staffName != null && !staffName.isEmpty()) {
            sql += " AND s.StaffName LIKE ?";
            params.add("%" + staffName + "%");
        }
        if (status != null && !status.isEmpty()) {
            sql += " AND si.Status = ?";
            params.add(status);
        }

        try ( PreparedStatement pstmt = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                pstmt.setString(i + 1, params.get(i));
            }

            try ( ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    StockImport stock = new StockImport();
                    stock.setImportID(rs.getInt("ImportID"));
                    stock.setImportDate(rs.getTimestamp("ImportDate"));
                    stock.setTotalCost(rs.getBigDecimal("TotalCost"));
                    stock.setSupplier(rs.getString("Supplier"));
                    stock.setStatus(rs.getString("Status"));  // Thêm dòng này để set trạng thái
                    stock.setStaff(staffDAO.getStaffByID(rs.getString("StaffID")));

                    stockList.add(stock);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching filtered stock: " + e.getMessage());
            e.printStackTrace();
        }

        return stockList;
    }

    public ArrayList<Products> getSearchProductToImport(String keyword) {
        ArrayList<Products> listProduct = new ArrayList<>();
        String sql = "SELECT ProductID, ProductName, Description, StockQuantity, Brand, CategoryID, Price, DiscountPercent, ImageURL "
                + "FROM Products "
                + "WHERE ProductName LIKE ? OR ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");

            // Kiểm tra nếu keyword là số thì mới set vào ProductID, ngược lại gán giá trị -1 để tránh lỗi
            try {
                ps.setInt(2, Integer.parseInt(keyword));
            } catch (NumberFormatException e) {
                ps.setInt(2, -1); // Không có sản phẩm nào có ID là -1
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProductID(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setStockQuantity(rs.getInt("StockQuantity"));
                p.setBrand(rs.getString("Brand"));
                p.setDescription(rs.getString("Description"));
                p.setImageURL(rs.getString("ImageURL"));
                p.setDiscountProduct(rs.getBigDecimal("DiscountPercent"));

                // Lấy danh mục từ ID
                Category c = getCategoryByID(rs.getInt("CategoryID"));
                p.setCategory(c);

                listProduct.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching filtered stock: " + e.getMessage());
            e.printStackTrace();
        }
        return listProduct;
    }

    public int addImportStock(String staffID, String supplier, BigDecimal totalCost, String status, String[] productIDs, String[] quantities, String[] size, String[] prices) {
        PreparedStatement importStmt = null;
        PreparedStatement detailStmt = null;
        ResultSet rs = null;
        int importID = 0;

        try {

            // 2️⃣ Chèn dữ liệu vào bảng StockImport
            String importSQL = "INSERT INTO StockImport (StaffID, Supplier, ImportDate, TotalCost, Status) VALUES (?, ?, GETDATE(), ?, ?) "
                    + "SELECT SCOPE_IDENTITY();";
            connection.setAutoCommit(false);
            importStmt = connection.prepareStatement(importSQL);
            importStmt.setString(1, staffID);
            importStmt.setString(2, supplier);
            importStmt.setBigDecimal(3, totalCost);
            importStmt.setString(4, status);

            rs = importStmt.executeQuery();
            if (rs.next()) {
                importID = rs.getInt(1);
            }
            String detailSQL = "INSERT INTO [dbo].[StockImportDetails]\n"
                    + "           ([ImportID]\n"
                    + "           ,[ProductID]\n"
                    + "           ,[Quantity]\n"
                    + "           ,[CostPrice]"
                    + "           ,[SizeID]) VALUES ( ?, ?, ?, ?, ?)";
            detailStmt = connection.prepareStatement(detailSQL);
            for (int i = 0; i < productIDs.length; i++) {
                detailStmt.setInt(1, importID);
                detailStmt.setInt(2, Integer.parseInt(productIDs[i]));
                detailStmt.setInt(3, Integer.parseInt(quantities[i]));
                detailStmt.setBigDecimal(4, new BigDecimal(prices[i]));
                // Lấy SizeID (nếu có)
                if (size[i] != null && !size[i].isEmpty()) {
                    detailStmt.setInt(5, Integer.parseInt(size[i]));
                    if (status.equals("Complete")) {
                        updateQuantityOfProductHavSizeAfterInventory(getProductByID(Integer.parseInt(productIDs[i])), getProductSizeByID(Integer.parseInt(size[i])), Integer.parseInt(quantities[i]));
                    }
                } else {
                    detailStmt.setNull(5, java.sql.Types.INTEGER);
                    if (status.equals("Complete")) {
                        updateQuantityOfProductAfterInventory(getProductByID(Integer.parseInt(productIDs[i])), Integer.parseInt(quantities[i]));
                    }
                }
                detailStmt.executeUpdate();
            }
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return importID;
    }

    public ProductSizes getSize(int productID, String size) {
        String sql = "SELECT * FROM ProductSizes WHERE ProductID = ? AND Size = ?";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ps.setString(2, size);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ProductSizes(rs.getInt("SizeID"), rs.getString("Size"), rs.getInt("StockQuantity"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving size: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public StockImport getStockImport(int importedID) {
        StaffsDAO staffDAO = new StaffsDAO();
        String sql = "SELECT [ImportID]\n"
                + "      ,[StaffID]\n"
                + "      ,[Supplier]\n"
                + "      ,[ImportDate]\n"
                + "      ,[TotalCost]\n"
                + "      ,[Status]\n"
                + "  FROM [dbo].[StockImport]"
                + "  WHERE ImportID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, importedID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StockImport stock = new StockImport();
                stock.setImportID(rs.getInt("ImportID"));
                stock.setStaff(staffDAO.getStaffByID(rs.getString("StaffID")));
                stock.setSupplier(rs.getString("Supplier"));
                stock.setImportDate(rs.getTimestamp("ImportDate"));
                stock.setTotalCost(rs.getBigDecimal("TotalCost"));
                return stock;
            }

        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<StockImportDetails> getAllDetailOfImported(int importedID) {
        ArrayList<StockImportDetails> importedDetailList = new ArrayList<>();
        String sql = "SELECT [ImportDetailID]\n"
                + "      ,[ImportID]\n"
                + "      ,[ProductID]\n"
                + "      ,[Quantity]\n"
                + "      ,[CostPrice]\n"
                + "      ,[SizeID]\n"
                + "  FROM [dbo].[StockImportDetails]\n"
                + "  WHERE ImportID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, importedID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StockImportDetails importDetails = new StockImportDetails();
                importDetails.setStockImport(getStockImport(rs.getInt("ImportID")));
                importDetails.setProduct(getProductByID(rs.getInt("ProductID")));
                importDetails.setQuantity(rs.getInt("Quantity"));
                importDetails.setCostPrice(rs.getBigDecimal("CostPrice"));
                importDetails.setSize(getProductSizeByID(rs.getInt("SizeID")));
                importedDetailList.add(importDetails);
            }

        } catch (Exception e) {
        }
        return importedDetailList;
    }

    public void insertProductFromExcel(int importID, String[] productIDs,
            String[] sizeIDs, int[] quantities, BigDecimal[] prices,
            String supplier, BigDecimal totalCost, String staffID) {
        PreparedStatement importStmt = null;
        PreparedStatement detailStmt = null;

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // 1️⃣ Cập nhật thông tin StockImport
            String importSQL = "UPDATE [dbo].[StockImport] "
                    + "SET StaffID = ?, Supplier = ?, TotalCost = ?, Status = ? "
                    + "WHERE ImportID = ?";
            importStmt = connection.prepareStatement(importSQL);
            importStmt.setString(1, staffID);
            importStmt.setString(2, supplier);
            importStmt.setBigDecimal(3, totalCost);
            importStmt.setString(4, "Completed");
            importStmt.setInt(5, importID);
            importStmt.executeUpdate();

            // 2️⃣ Cập nhật StockImportDetails
            String detailSQL = "UPDATE [dbo].[StockImportDetails] "
                    + "SET Quantity = ?, CostPrice = ?, SizeID = ? "
                    + "WHERE ImportID = ? AND ProductID = ?";
            detailStmt = connection.prepareStatement(detailSQL);

            for (int i = 0; i < productIDs.length; i++) {
                if (checkProudctInImported(importID, Integer.parseInt(productIDs[i]))) {
                    detailStmt.setInt(1, quantities[i]);
                    detailStmt.setBigDecimal(2, prices[i]);

                    // Kiểm tra SizeID
                    if (sizeIDs[i] != null && !sizeIDs[i].isEmpty()) {
                        detailStmt.setInt(3, Integer.parseInt(sizeIDs[i]));
                        updateQuantityOfProductHavSizeAfterInventory(getProductByID(Integer.parseInt(productIDs[i])), getProductSizeByID(Integer.parseInt(sizeIDs[i])), quantities[i]);
                    } else {
                        detailStmt.setNull(3, java.sql.Types.INTEGER);
                        updateQuantityOfProductAfterInventory(getProductByID(Integer.parseInt(productIDs[i])), quantities[i]);
                    }

                    detailStmt.setInt(4, importID);
                    detailStmt.setInt(5, Integer.parseInt(productIDs[i]));

                    detailStmt.executeUpdate();
                } else {
                    insertNewProductToImported(importID, Integer.parseInt(productIDs[i]), quantities[i], prices[i], sizeIDs[i]);
                }
            }
            connection.commit(); // Xác nhận transaction
            System.out.println("Stock import updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkProudctInImported(int importedID, int productID) {
        String sql = "SELECT [ImportDetailID]\n"
                + "      ,[ImportID]\n"
                + "      ,[ProductID]\n"
                + "      ,[Quantity]\n"
                + "      ,[CostPrice]\n"
                + "      ,[SizeID]\n"
                + "  FROM [dbo].[StockImportDetails]\n"
                + "  WHERE ImportID = ? AND ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, importedID);
            ps.setInt(2, productID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }

        } catch (Exception e) {
        }
        return false;
    }

    public void insertNewProductToImported(int importedID, int productID, int quantity, BigDecimal price, String sizeID) {
        String detailSQL = "INSERT INTO [dbo].[StockImportDetails]\n"
                + "           ([ImportID]\n"
                + "           ,[ProductID]\n"
                + "           ,[Quantity]\n"
                + "           ,[CostPrice]"
                + "           ,[SizeID]) VALUES ( ?, ?, ?, ?, ?)";
        try {
            PreparedStatement detailStmt = connection.prepareStatement(detailSQL);
            detailStmt.setInt(1, importedID);
            detailStmt.setInt(2, productID);
            detailStmt.setInt(3, quantity);
            detailStmt.setBigDecimal(4, price);
            // Lấy SizeID (nếu có)
            if (sizeID != null && !sizeID.isEmpty()) {
                detailStmt.setInt(5, Integer.parseInt(sizeID));
            } else {
                detailStmt.setNull(5, java.sql.Types.INTEGER);
            }
            detailStmt.executeUpdate();
        } catch (Exception e) {
        }

    }

    public void updateQuantityOfProductAfterInventory(Products product, int quantity) {
        String sql = "UPDATE [dbo].[Products]\n"
                + "   SET [StockQuantity] = ?\n"
                + " WHERE ProductID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int quantityNew = product.getStockQuantity() + quantity;
            ps.setInt(1, quantityNew);
            ps.setInt(2, product.getProductID());
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void updateQuantityOfProductHavSizeAfterInventory(Products product, ProductSizes sizeP, int quantity) {
        String sql = "UPDATE [dbo].[ProductSizes]\n"
                + "   SET [StockQuantity] = ?\n"
                + " WHERE [ProductID] = ? AND SizeID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int quantityNew = sizeP.getStockQuantity() + quantity;
            ps.setInt(1, quantityNew);
            ps.setInt(2, product.getProductID());
            ps.setInt(3, sizeP.getSizeID());
            ps.executeUpdate();
            updateQuantityOfProductAfterInventory(product, quantity);
        } catch (Exception e) {
        }
    }

    public void updateImportStatus(int importID, String status) {
        String sql = "UPDATE [dbo].[StockImport] SET Status = ? WHERE ImportID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, importID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Products> getAllStockProducts() {
        ArrayList<Products> productList = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Brand, p.StockQuantity, p.ImageURL, si.ImportDate "
                + "FROM Products p "
                + "LEFT JOIN StockImportDetails sid ON p.ProductID = sid.ProductID "
                + "LEFT JOIN StockImport si ON sid.ImportID = si.ImportID";

        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Products product = new Products(
                        rs.getInt("ProductID"),
                        rs.getString("ProductName"),
                        getCategoryByID(rs.getInt("CategoryID")),
                        rs.getString("Brand"),
                        rs.getInt("StockQuantity"),
                        rs.getTimestamp("ImportDate"),
                        rs.getString("ImageURL")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public ArrayList<Products> getStockProducts(int page, int recordsPerPage) {
        ArrayList<Products> productList = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null!");
            return productList;
        }

        String sql = "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Brand, p.StockQuantity, p.ImageURL, si.ImportDate "
                + "FROM Products p "
                + "LEFT JOIN StockImportDetails sid ON p.ProductID = sid.ProductID "
                + "LEFT JOIN StockImport si ON sid.ImportID = si.ImportID "
                + "ORDER BY p.ProductID, si.ImportDate DESC " // Ưu tiên ngày nhập mới nhất trước
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            int offset = (page - 1) * recordsPerPage;
            ps.setInt(1, offset);
            ps.setInt(2, recordsPerPage);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int productId = rs.getInt("ProductID");

                    // Kiểm tra xem ProductID đã có trong danh sách chưa
                    boolean exists = false;
                    for (Products p : productList) {
                        if (p.getProductID() == productId) {
                            exists = true;
                            break;
                        }
                    }

                    if (!exists) { // Chỉ thêm nếu chưa tồn tại
                        Products product = new Products(
                                productId,
                                rs.getString("ProductName"),
                                getCategoryByID(rs.getInt("CategoryID")),
                                rs.getString("Brand"),
                                rs.getInt("StockQuantity"),
                                rs.getTimestamp("ImportDate"),
                                rs.getString("ImageURL")
                        );

                        productList.add(product);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public int getTotalProducts() {
        int total = 0;

        if (connection == null) {
            System.err.println("Database connection is null!");
            return total;
        }

        String sql = "SELECT COUNT(*) FROM Products";

        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public ArrayList<Products> getStockProducts(int page, int recordsPerPage, String keyword, String sortStock, String sortDate, String brand, Integer categoryID) {
        ArrayList<Products> productList = new ArrayList<>();

        if (connection == null) {
            System.err.println("Database connection is null!");
            return productList;
        }

        StringBuilder sql = new StringBuilder(
                "SELECT p.ProductID, p.ProductName, p.CategoryID, p.Brand, p.StockQuantity, p.ImageURL, "
                + "(SELECT MAX(si.ImportDate) FROM StockImportDetails sid "
                + " JOIN StockImport si ON sid.ImportID = si.ImportID "
                + " WHERE sid.ProductID = p.ProductID) AS LatestImportDate "
                + "FROM Products p WHERE 1=1 "
        );

        // Lọc theo từ khóa
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (p.ProductID LIKE ? OR p.ProductName LIKE ?) ");
        }

        // Lọc theo Brand
        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND p.Brand = ? ");
        }

        // Lọc theo CategoryID
        if (categoryID != null && categoryID > 0) {
            sql.append("AND p.CategoryID = ? ");
        }

        // Sắp xếp theo số lượng tồn kho hoặc ngày nhập
        if (sortStock != null && (sortStock.equals("asc") || sortStock.equals("desc"))) {
            sql.append("ORDER BY p.StockQuantity ").append(sortStock).append(" ");
        } else if (sortDate != null && (sortDate.equals("asc") || sortDate.equals("desc"))) {
            sql.append("ORDER BY LatestImportDate ").append(sortDate).append(" ");
        } else {
            sql.append("ORDER BY p.ProductID ");
        }

        // Phân trang
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try ( PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            // Truyền giá trị lọc vào câu lệnh SQL
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
                ps.setString(paramIndex++, "%" + keyword + "%");
            }

            if (brand != null && !brand.trim().isEmpty()) {
                ps.setString(paramIndex++, brand);
            }

            if (categoryID != null && categoryID > 0) {
                ps.setInt(paramIndex++, categoryID);
            }

            // Truyền giá trị phân trang
            int offset = (page - 1) * recordsPerPage;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, recordsPerPage);

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Products product = new Products(
                            rs.getInt("ProductID"),
                            rs.getString("ProductName"),
                            getCategoryByID(rs.getInt("CategoryID")),
                            rs.getString("Brand"),
                            rs.getInt("StockQuantity"),
                            rs.getTimestamp("LatestImportDate"),
                            rs.getString("ImageURL")
                    );
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

}
