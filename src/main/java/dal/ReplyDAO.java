package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Models.Reply;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class ReplyDAO extends DBContext {

    // Phương thức thêm reply
    public void addReply(Reply reply) {
        String sql = "INSERT INTO Reply (FeedbackID, CustomerID, Comment, CreatedAt) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reply.getFeedbackID());
            ps.setString(2, reply.getCustomerId());
            ps.setString(3, reply.getComment());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức cập nhật reply
    public void updateReply(Reply reply) {
        String sql = "UPDATE Reply SET Comment = ? WHERE ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy danh sách reply theo ID feedback
    public List<Reply> getRepliesByFeedbackId(int feedbackID) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.ReplyID, r.FeedbackID, r.CustomerID, r.Comment, r.CreatedAt " +
                     "FROM Reply r WHERE r.FeedbackID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, feedbackID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reply reply = mapResultSetToReply(rs);
                replies.add(reply);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }

    // Phương thức lấy reply theo ID
    public Reply getReplyById(int replyID) {
        String sql = "SELECT r.ReplyID, r.FeedbackID, r.CustomerID, r.Comment, r.CreatedAt " +
                     "FROM Reply r WHERE r.ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, replyID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToReply(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Phương thức kiểm tra xem một reply có tồn tại không
    public boolean doesReplyExist(int replyID) {
        String sql = "SELECT COUNT(*) FROM Reply WHERE ReplyID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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
        String sql = "SELECT r.ReplyID, r.FeedbackID, r.CustomerID, r.Comment, r.CreatedAt " +
                     "FROM Reply r WHERE r.UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reply reply = mapResultSetToReply(rs);
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
        String sql = "SELECT r.ReplyID, r.FeedbackID, r.CustomerID, r.Comment, r.CreatedAt FROM Reply r";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Reply reply = mapResultSetToReply(rs);
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
        reply.setFeedbackID(rs.getInt("FeedbackID"));
        reply.setCustomerId(rs.getString("CustomerID"));
        reply.setComment(rs.getString("Comment"));
        reply.setCreatedAt(rs.getTimestamp("CreatedAt"));
        return reply;
    }
}
