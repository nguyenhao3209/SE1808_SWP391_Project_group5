/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Staffs.Status;
import Models.Staffs.Role;
import Models.Staffs;
import Models.Staffs.Gender;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tien
 */
public class StaffsDAO extends DBContext {

    PreparedStatement ps = null;
    ResultSet rs = null;

    public StaffsDAO() {
        super();
    }

    public List<Staffs> getAllStaffs() {
//        ArrayList<Staffs> list = new ArrayList<>();
//        String sql = "select * "
//                + "  FROM Staffs";
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                list.add(new Staffs(rs.getInt(0), rs.getString(1), rs.getString(2), rs.getString(3), tolenExpiry, rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9), supervisor, rs.getString(11), rs.getString(12), hireDate));
//            }
//            rs.close();
//            ps.close();
//        } catch (SQLException e) {
//            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
//        }
//        return list;
        return null;
    }

    public Staffs getStaffByID(String id) {
//        Staffs staffs = null;
//        String query = "SELECT * FROM Customers WHERE Email = ?";
//        try {
//            connection = new DBContext().connection;
//            ps = connection.prepareStatement(query);
//            ps.setString(1, id);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                staffs = new Staffs();
//                staffs.setStaffID(rs.getString("StaffID"));
//                staffs.setStaffName(rs.getString("CustomerName"));
//                staffs.setEmail(rs.getString("Email"));
//                staffs.setPhone(rs.getString("Phone"));
//                staffs.setAddress(rs.getString("Address"));
//                staffs.setRole(Role.valueOf(rs.getString("Role")));
//                staffs.setStatus(Status.valueOf(rs.getString("Status")));
//                staffs.setAvatar(rs.getString("Avatar"));
//                staffs.setGender(Gender.valueOf(rs.getString("Gender")));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return staffs;
        return null;
    }

}
