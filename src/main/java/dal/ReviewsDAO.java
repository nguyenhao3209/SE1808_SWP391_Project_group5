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
        CustomersDAO customersDAO = new CustomersDAO();
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback review = new Feedback();
                review.setFeedbackID(rs.getString("FeedbackID"));
                review.setCustomerID(rs.getString("CustomerID"));
                review.setProductID(rs.getInt("ProductID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                List<Reply> replies = getReplyByFeedback(review.getFeedbackID());
                review.setReplies(replies);
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public List<Reply> getReplyByFeedback(String feedbackID) {
        List<Reply> replies = new ArrayList<>();
        String query = "SELECT * FROM Reply WHERE FeedbackID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reply reply = new Reply();
                reply.setReplyID(rs.getInt("ReplyID"));
                reply.setCustomerID(rs.getString("CustomerID"));
                reply.setStaffID(rs.getString("StaffID"));
                reply.setFeedbackID(rs.getString("FeedbackID"));
                reply.setComment(rs.getString("Comment"));
                reply.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                replies.add(reply);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return replies;
    }

    public void addReview(Feedback newReview) {
        String query = "INSERT INTO Feedback (FeedbackID, CustomerID, ProductID, Rating, Comment, CreatedAt) VALUES (?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, newReview.getFeedbackID());
            ps.setString(2, newReview.getCustomerID());
            ps.setInt(3, newReview.getProductID());
            ps.setInt(4, newReview.getRating());
            ps.setString(5, newReview.getComment());
            ps.setObject(6, newReview.getCreatedAt());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateFeedback(Feedback f) {
        String sql = "UPDATE Feedback SET Comment = ? WHERE FeedbackID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, f.getComment());
            ps.setString(2, f.getFeedbackID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteFeedback(String feedbackID) {
        String sql = "DELETE FROM Feedback WHERE FeedbackID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, feedbackID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Feedback getFeedbackById(String feedbackID) {
        String query = "SELECT * FROM Feedback WHERE FeedbackID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback review = new Feedback();
                review.setFeedbackID(rs.getString("FeedbackID"));
                review.setCustomerID(rs.getString("CustomerID"));
                review.setProductID(rs.getInt("ProductID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                List<Reply> replies = getReplyByFeedback(review.getFeedbackID());
                review.setReplies(replies);
                return review;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isBought(String customerID, int productId) {
        String query = "SELECT * FROM OrderDetails OD LEFT JOIN Orders O ON O.OrderID = OD.OrderID WHERE O.CustomerID = ? AND OD.ProductID = ? AND O.Status = 'COMPLETED'";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customerID);
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

    public void addReply(Reply reply) {
        String sql = "INSERT INTO Reply (ReplyID, CustomerID, StaffID, FeedbackID, Comment, CreatedAt) VALUES (?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reply.getReplyID());
            ps.setString(2, reply.getCustomerID());
            ps.setString(3, reply.getStaffID());
            ps.setString(4, reply.getFeedbackID());
            ps.setString(5, reply.getComment());
            ps.setObject(6, reply.getCreatedAt());  // Ensure this is of type java.sql.Timestamp
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();  // You might want to use a logger instead for better exception handling
        }
    }

// Phương thức cập nhật reply
    public void updateReply(Reply reply) {
        String sql = "UPDATE Reply SET Comment = ? WHERE ReplyID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, reply.getComment());
            ps.setInt(2, reply.getReplyID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Phương thức xóa reply
    public void deleteReply(int replyID) {
        String sql = "DELETE FROM Reply WHERE ReplyID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy danh sách reply theo ID feedback
    public List<Reply> getRepliesByFeedbackId(String feedbackID) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.ReplyID, r.CustomerID, r.StaffID, r.FeedbackID, r.Comment, r.CreatedAt "
                + "FROM Reply r WHERE r.FeedbackID = ?";
        CustomersDAO customersDAO = new CustomersDAO();
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reply reply = mapResultSetToReply(rs);

                // Lấy thông tin khách hàng và thiết lập đối tượng Customers
                Customers customer = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                reply.setCustomers(customer);

                replies.add(reply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }

    // Phương thức lấy reply theo ID
    public Reply getReplyById(int replyID) {
        String sql = "SELECT r.ReplyID, r.CustomerID, r.StaffID, r.FeedbackID, r.Comment, r.CreatedAt "
                + "FROM Reply r WHERE r.ReplyID = ?";
        CustomersDAO customersDAO = new CustomersDAO();
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Reply reply = mapResultSetToReply(rs);

                // Lấy thông tin khách hàng và thiết lập đối tượng Customers
                Customers customer = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                reply.setCustomers(customer);

                return reply;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Phương thức kiểm tra xem một reply có tồn tại không
    public boolean doesReplyExist(int replyID) {
        String sql = "SELECT COUNT(*) FROM Reply WHERE ReplyID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Phương thức lấy danh sách reply theo ID người dùng
    public List<Reply> getRepliesByUserId(String customerID) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.ReplyID, r.CustomerID, r.StaffID, r.FeedbackID, r.Comment, r.CreatedAt "
                + "FROM Reply r WHERE r.CustomerID = ?";
        CustomersDAO customersDAO = new CustomersDAO();
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reply reply = mapResultSetToReply(rs);

                // Lấy thông tin khách hàng và thiết lập đối tượng Customers
                Customers customer = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                reply.setCustomers(customer);

                replies.add(reply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }

    // Phương thức lấy toàn bộ danh sách reply
    public List<Reply> getAllReplies() {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.ReplyID, r.CustomerID, r.StaffID, r.FeedbackID, r.Comment, r.CreatedAt FROM Reply r";
        CustomersDAO customersDAO = new CustomersDAO();
        try ( PreparedStatement ps = connection.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Reply reply = mapResultSetToReply(rs);

                // Lấy thông tin khách hàng và thiết lập đối tượng Customers
                Customers customer = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                reply.setCustomers(customer);

                replies.add(reply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }

    // Phương thức chuyển ResultSet thành đối tượng Reply
    private Reply mapResultSetToReply(ResultSet rs) throws SQLException {
        Reply reply = new Reply();
        reply.setReplyID(rs.getInt("ReplyID"));
        reply.setCustomerID(rs.getString("CustomerID"));
        reply.setStaffID(rs.getString("StaffID"));
        reply.setFeedbackID(rs.getString("FeedbackID"));
        reply.setComment(rs.getString("Comment"));
        reply.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
        return reply;
    }
}

