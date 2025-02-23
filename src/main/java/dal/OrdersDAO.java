/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.OrderDetails;
import Models.Orders;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HaoNTCE180451
 */
public class OrdersDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public OrdersDAO() {
        super();
    }

    public int insertOrder(Orders order, ArrayList<OrderDetails> orderItemsList) {
        int orderId = 0;
        String orderSql = "INSERT INTO [dbo].[Orders] (CustomerID, TotalPrice, Status, PaymentMethod) "
                + "VALUES (?, ?, ?, ?); SELECT SCOPE_IDENTITY();";

        String orderItemSql = "INSERT INTO [dbo].[OrderDetails] (OrderID, ProductID, Price, Quantity) "
                + "VALUES (?, ?, ?, ?)";

        String updateStockSql = "UPDATE [dbo].[Products] SET StockQuantity = StockQuantity - ? WHERE ProductID = ?";

        try {

            PreparedStatement psOrder = connection.prepareStatement(orderSql);
            psOrder.setString(1, order.getCustomer().getCustomerId());
            psOrder.setBigDecimal(2, order.getTotalPrice());
            psOrder.setString(3, order.getStatus());
            psOrder.setString(4, order.getPaymentMethod());

            ResultSet rs = psOrder.executeQuery();
            if (rs.next()) {
                orderId = rs.getInt(1); // Lấy ID của đơn hàng vừa chèn
            } else {
                throw new SQLException("Không lấy được Order ID sau khi chèn.");
            }
            PreparedStatement psOrderItem = connection.prepareStatement(orderItemSql);
            PreparedStatement psUpdateStock = connection.prepareStatement(updateStockSql);

            for (OrderDetails item : orderItemsList) {
                psOrderItem.setInt(1, orderId);
                psOrderItem.setInt(2, item.getProduct().getProductID());
                psOrderItem.setBigDecimal(3, item.getPrice());
                psOrderItem.setInt(4, item.getQuantity());

                psUpdateStock.setInt(1, item.getQuantity());
                psUpdateStock.setInt(2, item.getProduct().getProductID());
                psOrderItem.executeUpdate();
                psUpdateStock.executeUpdate();
            }
            psOrder.close();
            psOrderItem.close();
            psUpdateStock.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public void updateStatusPayment(Orders o) {
        String sql = "UPDATE Orders set Status = ? where OrderID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, o.getStatus());
            ps.setInt(2, o.getOrderID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Double> getMonthlyRevenueByYear(int year) {
        List<Double> list = new ArrayList<>();
        String query = "WITH Months AS (\n"
                + "    SELECT 1 AS Month\n"
                + "    UNION ALL SELECT 2\n"
                + "    UNION ALL SELECT 3\n"
                + "    UNION ALL SELECT 4\n"
                + "    UNION ALL SELECT 5\n"
                + "    UNION ALL SELECT 6\n"
                + "    UNION ALL SELECT 7\n"
                + "    UNION ALL SELECT 8\n"
                + "    UNION ALL SELECT 9\n"
                + "    UNION ALL SELECT 10\n"
                + "    UNION ALL SELECT 11\n"
                + "    UNION ALL SELECT 12\n"
                + ")\n"
                + "SELECT \n"
                + "    m.Month,\n"
                + "    ISNULL(SUM(o.TotalPrice), 0) AS Revenue\n"
                + "FROM \n"
                + "    Months m\n"
                + "LEFT JOIN \n"
                + "    Orders o ON MONTH(o.CreatedAt) = m.Month AND YEAR(o.CreatedAt) = ? and o.Status = 'COMPLETED'\n"
                + "GROUP BY \n"
                + "    m.Month\n"
                + "ORDER BY \n"
                + "    m.Month;";
        try {
            ps = connection.prepareStatement(query);//nem cau lenh query sang sql
            ps.setInt(1, year);
            rs = ps.executeQuery();//chay cau lenh query, nhan ket qua tra ve
            while (rs.next()) {
                list.add(rs.getDouble(2));
            }

        } catch (Exception e) {
        }
        return list;
    }

}
