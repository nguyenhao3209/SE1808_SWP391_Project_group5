/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import Models.Customers;
import Models.OrderDetails;
import Models.Orders;
import Models.Products;
import Models.Staffs;
import Models.Vouchers;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.criteria.Order;

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

    public List<Orders> getAllOders() {
        ArrayList<Orders> list = new ArrayList<>();
        CustomersDAO customersDAO = new CustomersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        StaffsDAO staffsdao = new StaffsDAO();
        String sql = "SELECT *FROM [SE1808_SWP391_Group5].[dbo].[Orders] o\n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers customers = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                Vouchers voucher = voucherDAO.getVoucherById(rs.getInt("VoucherID"));
                Staffs staff = staffsdao.getStaffByID(rs.getString("StaffID"));
                list.add(new Orders(rs.getInt("OrderID"), customers, staff, voucher, rs.getString("Status"), rs.getString("PaymentMethod"), rs.getBigDecimal("TotalPrice"), rs.getDate("CreatedAt")));

            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
        }
        return list;
    }

    public Orders getOderByID(int id) {
        Orders order = null;
        CustomersDAO customersDAO = new CustomersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        StaffsDAO staffsdao = new StaffsDAO();
        String sql = "SELECT *FROM [SE1808_SWP391_Group5].[dbo].[Orders] o\n"
                + "where OrderID= ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers customers = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                Vouchers voucher = voucherDAO.getVoucherById(rs.getInt("VoucherID"));
                Staffs staff = staffsdao.getStaffByID(rs.getString("StaffID"));
                order = new Orders();
                order.setOrderID(rs.getInt("OrderID"));
                order.setCustomer(customers);
                order.setStaff(staff);
                order.setVoucher(voucher);
                order.setStatus(rs.getString("Status"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setTotalPrice(rs.getBigDecimal("TotalPrice"));
                order.setCreateAt(rs.getDate("CreatedAt"));

            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
        }
        return order;
    }

    public List<OrderDetails> getOdersDetailByID(int id) {
        ArrayList<OrderDetails> list = new ArrayList<>();

        ProductsDAO productsDAO = new ProductsDAO();
        String sql = "SELECT \n"
                + "    od.[OrderID],\n"
                + "    od.[OrderDetailID],\n"
                + "    od.[ProductID],\n"
                + "    od.[Price],\n"
                + "    od.[Quantity],\n"
                + "    o.[CustomerID],\n"
                + "    o.[TotalPrice],\n"
                + "    o.[CreatedAt]\n"
                + "FROM [SE1808_SWP391_Group5].[dbo].[Orders] o\n"
                + "JOIN [SE1808_SWP391_Group5].[dbo].[OrderDetails] od\n"
                + "    ON o.[OrderID] = od.[OrderID]\n"
                + "	Where o.[OrderID] = ?\n"
                + "ORDER BY o.[CreatedAt] DESC;";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                Products products = productsDAO.getProductByID(rs.getInt("ProductID"));
                Orders order = getOderByID(rs.getInt("OrderID"));

                list.add(new OrderDetails(rs.getInt("OrderDetailID"), order, products, rs.getBigDecimal("Price"), rs.getInt("Quantity")));

            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
        }
        return list;
    }

    public static void main(String[] args) {
        OrdersDAO odao = new OrdersDAO();
        List<OrderDetails> list = odao.getOdersDetailByID(1006);
        for (OrderDetails orderDetails : list) {
            System.out.println(orderDetails.getProduct().getProductID());
        }
    }

    public List<Orders> getOrdersByCustomerID(String id) {
        ArrayList<Orders> list = new ArrayList<>();
        CustomersDAO customersDAO = new CustomersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        StaffsDAO staffsdao = new StaffsDAO();
        String sql = "SELECT *FROM [SE1808_SWP391_Group5].[dbo].[Orders] where [CustomerID] = ? \n";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers customers = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                Vouchers voucher = voucherDAO.getVoucherById(rs.getInt("VoucherID"));
                Staffs staff = staffsdao.getStaffByID(rs.getString("StaffID"));
                list.add(new Orders(rs.getInt("OrderID"), customers, staff, voucher, rs.getString("Status"), rs.getString("PaymentMethod"), rs.getBigDecimal("TotalPrice"), rs.getDate("CreatedAt")));

            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace(); // Nên in lỗi để dễ dàng debug
        }
        return list;
    }

    public List<Integer> getMonthlyOrderCountByYear(int year) {
        List<Integer> list = new ArrayList<>();
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
                + "    COUNT(o.OrderID) AS OrderCount\n"
                + "FROM \n"
                + "    Months m\n"
                + "LEFT JOIN \n"
                + "    Orders o ON MONTH(o.CreatedAt) = m.Month AND YEAR(o.CreatedAt) = ? AND o.Status = 'COMPLETED'\n"
                + "GROUP BY \n"
                + "    m.Month\n"
                + "ORDER BY \n"
                + "    m.Month;";

        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, year);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getTop10StaffByOrderCount() {
        List<Map<String, Object>> list = new ArrayList<>();
        String query = "SELECT TOP 10 \n"
                + "    s.StaffID, \n"
                + "    s.StaffName, \n"
                + "    COUNT(o.OrderID) AS OrderCount\n"
                + "FROM \n"
                + "    Orders o\n"
                + "JOIN \n"
                + "    Staffs s ON o.StaffID = s.StaffID\n"
                + "WHERE \n"
                + "    o.Status = 'COMPLETED'\n"
                + "GROUP BY \n"
                + "    s.StaffID, s.StaffName\n"
                + "ORDER BY \n"
                + "    OrderCount DESC;";

        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("StaffID", rs.getString("StaffID"));
                map.put("StaffName", rs.getString("StaffName"));
                map.put("OrderCount", rs.getInt("OrderCount"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
