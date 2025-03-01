/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Contact;
import Models.Customers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public List<Contact> searchContactWithPaging(String txtSearch, Integer pageIndex, Integer pageSize) {
        List<Contact> list = new ArrayList<>();
        String query = "select f.*, c.CustomerName from Contacts f\n"
                + "left join Customers c on f.CustomerID = c.CustomerID\n"
                + "where ? = '' or f.Subject like ?";
        if (pageIndex != null && pageSize != null) {
            query += " ORDER BY f.ContactID desc OFFSET\n"
                    + "                    (?*?-?) ROWS FETCH NEXT ? ROWS ONLY";
        }
        try {
            ps = connection.prepareStatement(query);//nem cau lenh query sang sql
            ps.setString(1, txtSearch);
            ps.setString(2, "%" + txtSearch + "%");
            if (pageIndex != null && pageSize != null) {
                ps.setInt(3, pageIndex);
                ps.setInt(4, pageSize);
                ps.setInt(5, pageSize);
                ps.setInt(6, pageSize);
            }
            rs = ps.executeQuery();//chay cau lenh query, nhan ket qua tra ve
            while (rs.next()) {

                Customers cus = new Customers();
                cus.setCustomerId(rs.getString(2));
                cus.setCustomerName(rs.getString(7));
                Contact c = new Contact(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        Contact.Status.valueOf(rs.getString(5)),
                        rs.getTimestamp(6), cus);

                list.add(c);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public Contact getContactById(String id) {
        String query = "select f.*, c.CustomerName, c.Email,c.Avatar from Contacts f\n"
                + "left join Customers c on f.CustomerID = c.CustomerID\n"
                + "where f.ContactID = ?";
        try {
            ps = connection.prepareStatement(query);//nem cau lenh query sang sql
            ps.setString(1, id);
            rs = ps.executeQuery();//chay cau lenh query, nhan ket qua tra ve
            while (rs.next()) {

                Customers cus = new Customers();
                cus.setCustomerId(rs.getString(2));
                cus.setCustomerName(rs.getString(7));
                cus.setEmail(rs.getString(8));
                cus.setAvatar(rs.getString(9));
                Contact c = new Contact(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        Contact.Status.valueOf(rs.getString(5)),
                        rs.getTimestamp(6), cus);

                return c;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateContact(Contact c) {
        String sql = "UPDATE Contacts set Status = ? where ContactID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, c.getStatus().name());
            ps.setInt(2, c.getContactId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
