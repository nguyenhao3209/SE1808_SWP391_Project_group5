package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Models.News;
import Models.Staffs;
import java.time.LocalDateTime;

public class NewsDAO extends DBContext {

    public News getNewsById(int id) {
        String sql = "SELECT n.NewsID, n.Author, n.Title, n.Content, n.PublishedDate, n.FilePath, n.ImageURL, s.StaffID, s.StaffName, s.Email "
                   + "FROM News n "
                   + "JOIN Staffs s ON n.StaffID = s.StaffID "
                   + "WHERE n.NewsID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    News news = new News();
                    news.setNewsID(rs.getInt("NewsID"));
                    news.setAuthor(rs.getString("Author"));
                    news.setTitle(rs.getString("Title"));
                    news.setContent(rs.getString("Content"));
                    news.setPublishedDate(rs.getObject("PublishedDate", LocalDateTime.class));
                    news.setFilePath(rs.getString("FilePath"));
                    news.setImage(rs.getString("ImageURL"));

                    // Setting the Staff object
                    Staffs staff = new Staffs();
                    staff.setStaffID(rs.getString("StaffID"));
                    staff.setStaffName(rs.getString("StaffName"));
                    staff.setEmail(rs.getString("Email"));
                    news.setStaff(staff);

                    return news;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addNews(String staffID, String author, String title, String content, LocalDateTime publishedDate, String filePath, String imageURL) throws SQLException {
        String sql = "INSERT INTO News (StaffID, Author, Title, Content, PublishedDate, FilePath, ImageURL) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staffID);
            stmt.setString(2, author);
            stmt.setString(3, title);
            stmt.setString(4, content);
            stmt.setObject(5, publishedDate);
            stmt.setString(6, filePath);
            stmt.setString(7, imageURL);
            stmt.executeUpdate();
        }
    }

    public void deleteNewsById(int newsId) throws SQLException {
        String sql = "DELETE FROM News WHERE NewsID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, newsId);
            stmt.executeUpdate();
        }
    }

    public void updateNewsById(int newsId, String staffID, String author, String title, String content, LocalDateTime publishedDate, String filePath, String imageURL) throws SQLException {
        String sql = "UPDATE News SET StaffID = ?, Author = ?, Title = ?, Content = ?, PublishedDate = ?, FilePath = ?, ImageURL = ? WHERE NewsID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, staffID);
            stmt.setString(2, author);
            stmt.setString(3, title);
            stmt.setString(4, content);
            stmt.setObject(5, publishedDate);
            stmt.setString(6, filePath);
            stmt.setString(7, imageURL);
            stmt.setInt(8, newsId);
            stmt.executeUpdate();
        }
    }

    public List<News> getNewsList() {
        List<News> newsList = new ArrayList<>();
        String sql = "SELECT n.NewsID, n.Author, n.Title, n.Content, n.PublishedDate, n.FilePath, n.ImageURL, s.StaffID, s.StaffName, s.Email "
                   + "FROM News n "
                   + "JOIN Staffs s ON n.StaffID = s.StaffID";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News news = new News();
                news.setNewsID(rs.getInt("NewsID"));
                news.setAuthor(rs.getString("Author"));
                news.setTitle(rs.getString("Title"));
                news.setContent(rs.getString("Content"));
                news.setPublishedDate(rs.getObject("PublishedDate", LocalDateTime.class));
                news.setFilePath(rs.getString("FilePath"));
                news.setImage(rs.getString("ImageURL"));

                Staffs staff = new Staffs();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                news.setStaff(staff);

                newsList.add(news);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newsList;
    }
}
