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
import static utils.PasswordUtils.checkPassword;

/**
 *
 * @author HaoNTCE180451
 */
public class StaffsDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public StaffsDAO() {
        super();
    }

    public Staffs loginWithEmailAndPassword(String email, String password) {
        Staffs staff = null;
        String query = "SELECT * FROM Staffs WHERE Email = ?";
        try {
            connection = new DBContext().connection;
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
                return staff;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        StaffsDAO staffDAO = new StaffsDAO();
        Staffs s = staffDAO.loginWithEmailAndPassword("nguyenhao6822@gmail.com", "1234567");
        System.out.println(s.toString());
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
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return staff;
}
}
