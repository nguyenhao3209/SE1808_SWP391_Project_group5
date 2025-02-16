/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Cart;
import Models.Category;
import Models.Customers;
import Models.Products;
import java.math.BigDecimal;
import java.sql.Date;
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
            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
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
        ArrayList<Cart> cart = new ArrayList();
        String sql = "SELECT [CartID]\n"
                + "      ,[CustomerID]\n"
                + "      ,[CreatedAt]\n"
                + "      ,[ProductID]\n"
                + "      ,[Quantity]\n"
                + "  FROM [dbo].[Cart]\n"
                + "  WHERE CustomerID = ?";
        CustomersDAO cusDAO = new CustomersDAO();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Customers customer = cusDAO.getCustomerByID(rs.getString("CustomerID"));
                Products pro = getProductByID(rs.getInt("ProductID"));
                cart.add(new Cart(rs.getInt("CartID"), customer, rs.getDate("CreatedAt"), pro, rs.getInt("Quantity")));
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

    public Products getProductByID(int productId) {
        String sql = "SELECT [ProductID]\n"
                + "      ,[ProductName]\n"
                + "      ,[Description]\n"
                + "      ,[StockQuantity]\n"
                + "      ,[Brand]\n"
                + "      ,[CategoryID]\n"
                + "      ,[Price]\n"
                + "      ,[DiscountPercent]\n"
                + "      ,[ImageURL]\n"
                + "      ,[CreateAt]\n"
                + "      ,[UpdateAt]\n"
                + "  FROM [dbo].[Products]\n"
                + "  WHERE ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("ProductID");
                String name = rs.getString("ProductName");
                String description = rs.getString("Description");
                int stockQuantity = rs.getInt("StockQuantity");
                String brand = rs.getString("Brand");
                Category category = getCategoryByID(rs.getInt("CategoryID"));
                BigDecimal price = rs.getBigDecimal("Price");
                BigDecimal discount = rs.getBigDecimal("DiscountPercent");
                String imageUrl = rs.getString("ImageURL");
                Date created_at = rs.getDate("CreateAt");
                Date updated_at = rs.getDate("UpdateAt");
                Products product = new Products(id, name, price, stockQuantity, brand, category, description, imageUrl, created_at, updated_at, discount);
                return product;
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
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
    }
}
