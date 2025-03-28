/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Customers;
import Models.Staffs;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import static utils.PasswordUtils.checkPassword;

/**
 *
 * @author HaoNTCE180451
 */
public class StaffsDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public List<Staffs> getAllStaffs(String gender, String status) {
        List<Staffs> staffs = new ArrayList<>();
        String sql = "SELECT StaffID, StaffName, Email, Phone, Gender, Status, Address, CitizenID FROM Staffs Where [Status] != 'DELETED' AND Role != 'ADMIN'";
        if (!gender.equalsIgnoreCase("all")) {
            sql = sql + " and Gender =" + "'" + gender + "'";
        }
        if (!status.equalsIgnoreCase("all")) {
            sql = sql + " and Status =" + "'" + status + "'";
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staffs staff = new Staffs();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(rs.getString("Gender"));
                staff.setStatus(Staffs.Status.valueOf(rs.getString("Status")));
                staff.setAddress(rs.getString("Address"));
                staff.setCitizenID(rs.getString("CitizenID"));

                staffs.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffs;
    }

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

        String sql = "INSERT INTO Staffs (StaffID, StaffName, Password, Phone, Role, Email, Gender, Status, Address, CitizenID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getStaffID());
            ps.setString(2, staff.getStaffName());
            ps.setString(3, staff.getPassword());
            ps.setString(4, staff.getPhone());
            ps.setString(5, staff.getRole().toString());
            ps.setString(6, staff.getEmail());
            ps.setString(7, staff.getGender());
            ps.setString(8, staff.getStatus().toString());
            ps.setString(9, staff.getAddress());
            ps.setString(10, staff.getCitizenID());

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
        String sql = "SELECT StaffID, StaffName, Password, Phone, Role, Email, Gender, Status, Address, CitizenID FROM Staffs WHERE StaffID = ?";

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staffId);
            rs = ps.executeQuery();

            if (rs.next()) {
                staff = new Staffs();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setRole(Staffs.Role.valueOf(rs.getString("Role")));
                staff.setEmail(rs.getString("Email"));
                staff.setGender(rs.getString("Gender"));
                staff.setStatus(Staffs.Status.valueOf(rs.getString("Status")));
                staff.setAddress(rs.getString("Address"));
                staff.setCitizenID(rs.getString("CitizenID"));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public void updateStaff(Staffs staff) {
        String sql = "UPDATE Staffs SET StaffName=?, Password=?, Phone=?, Role=?, Email=?, Gender=?, Status=?, Address=?, CitizenID = ? WHERE StaffID=?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getPassword());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getRole().toString());
            ps.setString(5, staff.getEmail());
            ps.setString(6, staff.getGender());
            ps.setString(7, staff.getStatus().toString());
            ps.setString(8, staff.getAddress());
            ps.setString(9, staff.getCitizenID());
            ps.setString(10, staff.getStaffID());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateStaffProfile(Staffs staff) {
        String sql = "UPDATE Staffs SET StaffName=?, Phone=?, Email=?, Gender=?, Address=?, Avatar=? WHERE StaffID=? ";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getPhone());
            ps.setString(3, staff.getEmail());
            ps.setString(4, staff.getGender());
            ps.setString(5, staff.getAddress());
            ps.setString(6, staff.getAvatar());
            ps.setString(7, staff.getStaffID());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean deleteStaffById(String staffId) {
        String sql = "UPDATE [dbo].[Staffs]\n"
                + "   SET [Status] = 'DELETED'\n"
                + " WHERE [StaffID] = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi SQL ra console để debug
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public Staffs getStaffByID(String staffID) {
        Staffs staff = new Staffs();
        String sql = "SELECT [StaffID]\n"
                + "      ,[StaffName]\n"
                + "      ,[Email]\n"
                + "      ,[Avatar]\n"
                + "      ,[TokenExpiry]\n"
                + "      ,[Password]\n"
                + "      ,[Phone]\n"
                + "      ,[Gender]\n"
                + "      ,[Address]\n"
                + "      ,[Role]\n"
                + "      ,[SupervisorID]\n"
                + "      ,[Status]\n"
                + "      ,[PasswordRecoveryToken]\n"
                + "      ,[HireDate]\n"
                + "      ,[CitizenID]\n"
                + "  FROM [dbo].[Staffs]\n"
                + "  WHERE StaffID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, staffID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                staff = new Staffs();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setTokenExpiry(rs.getTimestamp("TokenExpiry"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(rs.getString("Gender"));
                staff.setAddress(rs.getString("Address"));
                staff.setRole(Staffs.Role.valueOf(rs.getString("Role")));
                staff.setSupervisor(getStaffByID("SupervisorID"));
                staff.setStatus(Staffs.Status.valueOf(rs.getString("Status")));
                staff.setPasswordRecoveryToken(rs.getString("PasswordRecoveryToken"));
                staff.setHireDate(rs.getTimestamp("HireDate"));
                staff.setCitizenID(rs.getString("CitizenID"));
                return staff;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
        }
        return null;
    }

    public Staffs loginWithEmailAndPassword(String email, String password) {
        Staffs staff = null;
        String query = "SELECT * FROM Staffs WHERE Email = ? AND Status != 'DELETED'";
        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                String hashedPassword = rs.getString("Password");
                if (checkPassword(password, hashedPassword)) {
                    staff = new Staffs();
                    staff.setStaffID(rs.getString("StaffID"));
                    staff.setStaffName(rs.getString("StaffName"));
                    staff.setEmail(rs.getString("Email"));
                    staff.setAvatar(rs.getString("Avatar"));
                    staff.setPassword(rs.getString("Password"));
                    staff.setPhone(rs.getString("Phone"));
                    staff.setAddress(rs.getString("Address"));
                    staff.setRole(Staffs.Role.valueOf(rs.getString("Role")));
                    staff.setStatus(Staffs.Status.valueOf(rs.getString("Status")));
                    staff.setGender(rs.getString("Gender"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return staff;
    }

    public static void main(String[] args) {
        StaffsDAO staffDAO = new StaffsDAO();
        ArrayList<Staffs> s = staffDAO.getSearchStaffs("Thanh H");
        for (Staffs staffs : s) {
            System.out.println(staffs.toString());
        }
    }

    public Staffs getStaffByEmail(String email) {
        Staffs staff = null;
        String query = "SELECT * FROM Staffs WHERE Email = ?";
        try {
            connection = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                staff = new Staffs();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setTokenExpiry(rs.getTimestamp("TokenExpiry"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(rs.getString("Gender"));
                staff.setAddress(rs.getString("Address"));
                staff.setRole(Staffs.Role.valueOf(rs.getString("Role")));
                staff.setSupervisor(getStaffByID(rs.getString("SupervisorID")));
                staff.setStatus(Staffs.Status.valueOf(rs.getString("Status")));
                staff.setPasswordRecoveryToken(rs.getString("PasswordRecoveryToken"));
                staff.setHireDate(rs.getTimestamp("HireDate"));
                staff.setCitizenID(rs.getString("CitizenID"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    public boolean checkCitizenIDExists(String citizenID, String staffID) {
        String query = "SELECT COUNT(*) FROM Staffs WHERE CitizenID = ?";
        if (staffID != null && !staffID.isEmpty()) {
            query += " AND StaffID = ?";
        }
        try ( PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, citizenID);
            if (staffID != null && !staffID.isEmpty()) {
                stmt.setString(2, staffID);
            }
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Staffs> getSearchStaffs(String keyword) {
        ArrayList<Staffs> staffList = new ArrayList<>();
        String sql = "SELECT [StaffID], [StaffName], [Email], [Avatar], [TokenExpiry], [Password], [Phone], [Gender], [Address], [Role], [SupervisorID], [Status], [PasswordRecoveryToken], [HireDate], [CitizenID] "
                + "FROM [dbo].[Staffs] "
                + "WHERE Role != 'ADMIN' AND StaffID LIKE ? OR StaffName LIKE ? OR CitizenID LIKE ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Sử dụng ký tự '%' để tìm kiếm bất kỳ vị trí nào
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Staffs staff = new Staffs();
                staff.setStaffID(rs.getString("StaffID"));
                staff.setStaffName(rs.getString("StaffName"));
                staff.setEmail(rs.getString("Email"));
                staff.setAvatar(rs.getString("Avatar"));
                staff.setTokenExpiry(rs.getTimestamp("TokenExpiry"));
                staff.setPassword(rs.getString("Password"));
                staff.setPhone(rs.getString("Phone"));
                staff.setGender(rs.getString("Gender"));
                staff.setAddress(rs.getString("Address"));
                staff.setRole(Staffs.Role.valueOf(rs.getString("Role")));
                staff.setStatus(Staffs.Status.valueOf(rs.getString("Status")));
                staff.setPasswordRecoveryToken(rs.getString("PasswordRecoveryToken"));
                staff.setHireDate(rs.getTimestamp("HireDate"));
                staff.setCitizenID(rs.getString("CitizenID"));

                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return staffList;
    }
}
