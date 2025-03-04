/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Models.Feedback;
import Models.Reply;
import Models.Customers;

public class ReviewsDAO extends DBContext {

    // Lấy danh sách đánh giá cho một sản phẩm dựa trên ProductID
    public List<Feedback> getReviewsByProductId(int productId) {
        List<Feedback> reviews = new ArrayList<>();
        String query = "SELECT * FROM Feedback WHERE ProductID = ?";
        CustomersDAO userDAO = new CustomersDAO();
        try (
                 PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers u = userDAO.getUserByID(rs.getString("CustomerID"));

                Feedback review = new Feedback();
                review.setReviewID(rs.getInt("FeedbackID"));
                review.setUser(u);
                review.setProductID(rs.getInt("ProductID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getDate("CreatedAt"));
                List<Reply> replys = getReplyByFeedback(review.getReviewID());
                review.setReplies(replys);
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public List<Reply> getReplyByFeedback(int id) {
        List<Reply> reviews = new ArrayList<>();
        String query = "SELECT * FROM Reply WHERE FeedbackID = ?";
        CustomersDAO userDAO = new CustomersDAO();
        try (
                 PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                Reply review = new Reply();
                review.setReplyID(rs.getInt("ReplyID"));
                Customers u = userDAO.getUserByID(rs.getString("CustomerID"));
                review.setUser(u);
                review.setFeedbackID(rs.getInt("feedbackID"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getDate("CreatedAt"));
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // Lấy tên người dùng từ userID
    public String getUsernameById(String customerID) {
        String username = null;
        String query = "SELECT CustomerName FROM Customers WHERE CustomerID = ?"; // Câu lệnh SQL để lấy tên người dùng
        try (
                 PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customerID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                username = rs.getString("CustomerName");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return username;
    }

    // Thêm đánh giá mới
    public void addReview(Feedback newReview) {
        String query = "INSERT INTO [dbo].[Feedback]\n"
                + "           ([CustomerID]\n"
                + "           ,[ProductID]\n"
                + "           ,[Rating]\n"
                + "           ,[Comment]\n"
                + "           ,[CreatedAt])\n"
                + "     VALUES\n"
                + "          (?,?,?,?,CURRENT_TIMESTAMP)";
        try (
                 PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, newReview.getCustomerId());
            ps.setInt(2, newReview.getProductID());
            ps.setInt(3, newReview.getRating());
            ps.setString(4, newReview.getComment());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Phương thức cập nhật Feedback
    public void updateFeedback(Feedback f) {
        String sql = "UPDATE Feedback SET Comment = ? WHERE FeedbackID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, f.getComment());
            ps.setInt(2, f.getReviewID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức xóa reply
    public void deleteFeedback(int id) {
        String sql = "DELETE FROM Feedback WHERE FeedbackID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Feedback getFeedbackById(int productId) {
        String query = "SELECT * FROM Feedback WHERE FeedbackID = ?";
        CustomersDAO userDAO = new CustomersDAO();
        try (
                 PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers u = userDAO.getUserByID(rs.getString("CustomerID"));

                Feedback review = new Feedback();
                review.setReviewID(rs.getInt("FeedbackID"));
                review.setUser(u);
                review.setProductID(rs.getInt("ProductID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getDate("CreatedAt"));
                List<Reply> replys = getReplyByFeedback(review.getReviewID());
                review.setReplies(replys);
                return review;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Feedback> getReviewsByProductIdAndRating(int productId, int rating) {
        List<Feedback> reviews = new ArrayList<>();
        String query = "SELECT * FROM Feedback WHERE ProductID = ? AND Rating = ?";
        CustomersDAO userDAO = new CustomersDAO();
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ps.setInt(2, rating);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers u = userDAO.getUserByID(rs.getString("CustomerID"));

                Feedback review = new Feedback();
                review.setReviewID(rs.getInt("FeedbackID"));
                review.setUser(u);
                review.setProductID(rs.getInt("ProductID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getDate("CreatedAt"));
                List<Reply> replys = getReplyByFeedback(review.getReviewID());
                review.setReplies(replys);
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public boolean isBought(String customerId, int productId) {
        String query = "select * from OrderDetails OD\n"
                + "              left join [Orders] O on O.OrderID = OD.OrderID\n"
                + "               where O.CustomerID = ? and OD.ProductID = ? and O.Status = 'COMPLETED'";
        try {

            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, customerId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        Feedback obj = new Feedback();
        ReviewsDAO rdao = new ReviewsDAO();
        List<Feedback> fb = rdao.getReviewsByProductId(2);
        for (Feedback feedback : fb) {
            System.out.println(feedback.getComment());
        }
    }

}
