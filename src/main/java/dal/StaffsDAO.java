/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Models.Staffs;
import java.sql.Connection;

/**
 *
 * @author HuyLVQCE180656
 */
public class StaffsDAO {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public void addStaff(Staffs staff) {
        String sql = "INSERT INTO Staff (staffName, phone, role, hireDate, email, gender, status, address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, staff.getStaffName());
            ps.setString(2, staff.getPhone());
            ps.setString(3, staff.getRole());
            ps.setDate(4, staff.getHireDate());
            ps.setString(5, staff.getEmail());
            ps.setString(6, staff.getGender());
            ps.setString(7, staff.getStatus());
            ps.setString(8, staff.getAddress());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
