/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class DBContext {
     protected Connection connection;

    public DBContext() {
        try {
            String user = "sa";
            String pass = "123456";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=SE1808_SWP391_Group5;trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
  public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=SE1808_SWP391_Group5;encrypt=false;trustServerCertificate=true";
        String user = "sa";
        String pass = "123456";

        try {
            // Tải driver SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Tạo kết nối
            Connection connection = DriverManager.getConnection(url, user, pass);

            if (connection != null) {
                System.out.println("Kết nối thành công!");
                connection.close();
            } else {
                System.out.println("Kết nối thất bại!");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("Driver không tìm thấy.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối.");
            e.printStackTrace();
        }
    }
}
