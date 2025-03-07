package dal;

import Models.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * CategoryDAO với các chức năng:
 * - getAllCategories()
 * - getCategoryById(int id)
 * - insertCategory(Category c)
 * - updateCategory(Category c)
 * 
 * Kế thừa DBContext để sử dụng biến 'connection' do DBContext quản lý.
 */
public class CategoryDAO extends DBContext {

    /**
     * Lấy danh sách toàn bộ Category
     * @return List<Category>
     */
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT CategoryID, CategoryName, Description FROM Category";
        try (PreparedStatement st = connection.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                c.setDescription(rs.getString("Description"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy Category theo ID
     * @param id ID của Category
     * @return Category hoặc null nếu không tìm thấy
     */
    public Category getCategoryById(int id) {
        String sql = "SELECT CategoryID, CategoryName, Description "
                   + "FROM Category WHERE CategoryID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category();
                    c.setCategoryID(rs.getInt("CategoryID"));
                    c.setCategoryName(rs.getString("CategoryName"));
                    c.setDescription(rs.getString("Description"));
                    return c;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Thêm mới Category
     * @param category Đối tượng Category (bỏ qua ID nếu cột ID là auto-increment)
     */
    public void insertCategory(Category category) {
        String sql = "INSERT INTO Category (CategoryName, Description) VALUES (?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật Category
     * @param category Đối tượng Category (cần có ID hợp lệ)
     */
    public void updateCategory(Category category) {
        String sql = "UPDATE Category SET CategoryName = ?, Description = ? WHERE CategoryID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.setInt(3, category.getCategoryID());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
