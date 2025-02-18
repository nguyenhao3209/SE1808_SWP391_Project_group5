/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Customers;
import Models.Customers.Role;
import Models.Customers.Status;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 *
 * @author tien
 */
public class UserDAO extends DBContext{
    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public ArrayList<Customers> getAllCustomer() {
        ArrayList<Customers> list = new ArrayList<>();
        String sql = "SELECT [CustomerID]\n"
                + "      ,[CustomerName]\n"
                + "      ,[Email]\n"
                + "      ,[Password]\n"
                + "      ,[Phone]\n"
                + "      ,[Address]\n"
                + "      ,[Role]\n"
                + "      ,[Status]\n"
                + "      ,[PasswordRecoveryToken]\n"
                + "      ,[TokenExpiry]\n"
                + "      ,[Avatar]\n"
                + "  FROM [dbo].[Customers]";
        try {
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                if (rs.getString("Role").equals("USER")) {
                    Customers cus = new Customers(rs.getString("CustomerID"), rs.getString("CustomerName"), rs.getString("Email"), rs.getString("Password"), rs.getString("Phone"), rs.getString("Address"), Role.USER, Status.ACTIVE, rs.getString("PasswordRecoveryToken"), LocalDateTime.MIN, rs.getString("Avatar"));
                    list.add(cus);
                }
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
        }
        return list;
    }
    public Customers getCustomerByID(String id) {
        Customers user = null;
        String query = "SELECT * FROM Customers WHERE CustomerID = ?";
        try {
            connection = new DBContext().connection;
            ps = connection.prepareStatement(query);
            ps.setString(1, id);
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
