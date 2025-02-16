
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import Models.Customers;
import Models.Customers.Role;
import Models.Customers.Status;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import static utils.PasswordUtils.checkPassword;
import static utils.PasswordUtils.hashPassword;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class CustomersDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public Customers loginWithEmailAndPassword(String email, String password) {
        Customers user = null;
        String query = "SELECT * FROM Customers WHERE Email = ? ";
        try {
            connection = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Lấy mật khẩu mã hóa từ cơ sở dữ liệu
                String hashedPassword = rs.getString("Password");
                // Kiểm tra mật khẩu người dùng nhập vào
                if (checkPassword(password, hashedPassword)) {
                    user = new Customers();
                    user.setCustomerId(rs.getString("CustomerID"));
                    user.setCustomerName(rs.getString("CustomerName"));
                    user.setEmail(rs.getString("Email"));
                    user.setAvatar(rs.getString("Avatar"));
                    user.setPassword(rs.getString("Password"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAddress(rs.getString("Address"));
                    user.setRole(Role.valueOf(rs.getString("Role")));
                    user.setStatus(Status.valueOf(rs.getString("Status")));

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean emailExists(String email) {
        String query = "SELECT COUNT(*) FROM Customers WHERE Email = ?";
        try ( PreparedStatement ps = new DBContext().connection.prepareStatement(query)) {
            ps.setString(1, email);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //Method tạo CustomerID
//    public String createCustomerID() {
//        String cus = "CU";
//        int numberOfCustomer = 0;
//        String sql = "SELECT Count([CustomerID]) AS numberOfCustomer\n"
//                + "  FROM [dbo].[Customers]";
//        try {
//            ps = connection.prepareStatement(sql);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                numberOfCustomer = rs.getInt("numberOfCustomer") + 1;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return String.format("%s%04d", cus, numberOfCustomer);
//    }

    //get next customerId to create new customer
    public String createCustomerID() {
        try {
            String sql = "SELECT CustomerID FROM Customers";
            try ( PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
                int maxNumber = 0;
                while (rs.next()) {
                    String id = rs.getString(1);
                    if (id != null) {
                        int number = extractNumber(id);
                        if (number > maxNumber) {
                            maxNumber = number;
                        }
                    }
                }
                return String.format("CU%04d", maxNumber + 1);
            }
        } catch (Exception e) {
            System.out.println("Error function getNextCustomerId: " + e.getMessage());
        }
        return null;
    }

    //get number id max
    private int extractNumber(String id) {
        Pattern pattern = Pattern.compile("CU(\\d+)");
        Matcher matcher = pattern.matcher(id);
        if (matcher.matches()) {
            return Integer.parseInt(matcher.group(1));
        }
        throw new IllegalArgumentException("Invalid ID format: " + id);
    }

    public void registerUser(Customers user) {
        System.out.println(user.toString());

        // Gọi method để tạo CustomerID
        String customerID = createCustomerID();
        user.setCustomerId(customerID);

        String sql = "INSERT INTO Customers (CustomerID, CustomerName, Email, Password, Phone, Address, Role, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, user.getCustomerId());
            ps.setString(2, user.getCustomerName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole().name());
            ps.setString(8, user.getStatus().name());

            ps.executeUpdate();
            System.out.println("User registered successfully with ID: " + customerID);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Customers getUserByEmail(String email) {
        Customers user = null;
        String query = "SELECT * FROM Customers WHERE Email = ?";
        try {
            connection = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                user = new Customers();
                user.setCustomerId(rs.getString("CustomerID"));
                user.setCustomerName(rs.getString("CustomerName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setRole(Role.valueOf(rs.getString("Role")));
                user.setStatus(Status.valueOf(rs.getString("Status")));
                user.setAvatar(rs.getString("Avatar"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updatePassword(String customerId, String newPassword) {
        String sql = "UPDATE Customers SET Password = ? WHERE CustomerID = ?";
        try ( PreparedStatement ps = new DBContext().connection.prepareStatement(sql)) {
            String hashedPassword = hashPassword(newPassword);
            ps.setString(1, hashedPassword);
            ps.setString(2, customerId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Lưu token khôi phục mật khẩu và thời gian hết hạn của token
    public void saveResetToken(String email, String token, LocalDateTime expiryTime) {
        String sql = "UPDATE Customers SET PasswordRecoveryToken = ?, TokenExpiry = ? WHERE Email = ?";
        try ( PreparedStatement ps = new DBContext().connection.prepareStatement(sql)) {
            ps.setString(1, token);
            ps.setString(2, expiryTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))); // Định dạng thời gian
            ps.setString(3, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Kiểm tra tính hợp lệ của token (thời gian hết hạn)
    public boolean isTokenValid(String token) {
        String sql = "SELECT TokenExpiry FROM Customers WHERE PasswordRecoveryToken = ?";
        try ( PreparedStatement ps = new DBContext().connection.prepareStatement(sql)) {
            ps.setString(1, token);
            rs = ps.executeQuery();
            if (rs.next()) {
                LocalDateTime tokenExpiry = rs.getTimestamp("TokenExpiry").toLocalDateTime();
                return tokenExpiry.isAfter(LocalDateTime.now()); // Token vẫn còn hiệu lực
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Token hết hạn hoặc không hợp lệ
    }

    // Lấy người dùng qua token khôi phục mật khẩu
    public Customers getUserByResetToken(String token) {
        Customers user = null;
        String query = "SELECT * FROM Customers WHERE PasswordRecoveryToken = ?";
        try ( PreparedStatement ps = new DBContext().connection.prepareStatement(query)) {
            ps.setString(1, token);
            rs = ps.executeQuery();
            if (rs.next()) {
                user = new Customers();
                user.setCustomerId(rs.getString("CustomerID"));
                user.setCustomerName(rs.getString("CustomerName"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setRole(Role.valueOf(rs.getString("Role")));
                user.setStatus(Status.valueOf(rs.getString("Status")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;

    }
}

