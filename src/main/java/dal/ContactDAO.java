/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Contact;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class ContactDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public void createContact(Contact c) {
        String sql = "INSERT INTO Contacts (CustomerID, Subject, Message, Status, CreatedAt) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, c.getCustomerId());
            ps.setString(2, c.getSubject());
            ps.setString(3, c.getMessage());
            ps.setString(4, c.getStatus().name());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
