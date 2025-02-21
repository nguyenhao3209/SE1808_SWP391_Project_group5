/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Models.Staffs;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author HuyLVQCE180656
 */
public class StaffsDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public String createStaffID() {
        try {
            String sql = "SELECT StaffID FROM Staffs";
            try ( PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
                int maxNumber = 0;
                while (rs.next()) {
                    String id = rs.getString(1);
                    if (id != null) {
                        int number = extractStaffNumber(id);
                        if (number > maxNumber) {
                            maxNumber = number;
                        }
                    }
                }
                return String.format("ST%04d", maxNumber + 1);
            }
        } catch (Exception e) {
            System.out.println("Error in createStaffID: " + e.getMessage());
        }
        return null;
    }

    private int extractStaffNumber(String id) {
        Pattern pattern = Pattern.compile("ST(\\d+)");
        Matcher matcher = pattern.matcher(id);
        if (matcher.matches()) {
            return Integer.parseInt(matcher.group(1));
        }
        throw new IllegalArgumentException("Invalid StaffID format: " + id);
    }

    public void addStaff(Staffs staff) {

        // Gọi method để tạo StaffID
        String staffID = createStaffID();
        staff.setStaffID(staffID);

        String sql = "INSERT INTO Staffs (StaffID, StaffName, Password, Phone, Role, Email, Gender, Status, Address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getStaffID());
            ps.setString(2, staff.getStaffName());
            ps.setString(3, staff.getPassword());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getRole());
            ps.setString(6, staff.getEmail());
            ps.setString(7, staff.getGender());
            ps.setString(8, staff.getStatus());
            ps.setString(9, staff.getAddress());

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Staff added successfully with ID: " + staffID);
            } else {
                System.out.println("Failed to add staff.");
            }
        } catch (SQLException e) {
            System.out.println("Error while adding staff: " + e.getMessage());
        }
    }

    public boolean isEmailExists(String email) {

        String sql = "SELECT COUNT(*) FROM Staffs WHERE Email = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Email already exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Staffs getStaffById(String staffId) {
        Staffs staff = null;
        String sql = "SELECT StaffName, Password, Phone, Role, Email, Gender, Status, Address FROM Staffs WHERE StaffID = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                staff = new Staffs(rs.getString("StaffName"), rs.getString("Email"), rs.getString("Password"), rs.getString("Phone"), rs.getString("Gender"), rs.getString("Address"), rs.getString("Role"), rs.getString("Status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    public boolean updateStaff(Staffs staff) {
        String sql = "UPDATE Staffs SET StaffName=?, Password=?, Phone=?, Role=?, Email=?, Gender=?, Status=?, Address=? WHERE StaffId=?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getRole());
            ps.setString(5, staff.getEmail());
            ps.setString(6, staff.getGender());
            ps.setString(7, staff.getStatus());
            ps.setString(8, staff.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteStaffById(String staffId) {
        String sql = "DELETE FROM Staffs WHERE StaffId = ?";
        boolean isDeleted = false;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staffId);

            int rowsAffected = ps.executeUpdate();
            // Kiểm tra số dòng bị ảnh hưởng
            if (rowsAffected > 0) {
                isDeleted = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isDeleted; // Trả về true nếu xóa thành công, false nếu không
    }
}
