package dal;

import Models.Customers;
import Models.OrderDetails;
import Models.Orders;
import Models.Products;
import Models.Staffs;
import Models.Vouchers;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.persistence.criteria.Order;

/**
 * OrdersDAO - Quản lý thao tác CRUD trên bảng Orders và OrderDetails
 */
public class OrdersDAO extends DBContext {

    private PreparedStatement ps = null;
    private ResultSet rs = null;

    public OrdersDAO() {
        super();
    }

    /**
     * Chèn 1 đơn hàng (Orders) và danh sách OrderDetails (sản phẩm trong đơn).
     * Bảng Orders đã có cột VoucherID, StaffID, v.v. Tuỳ logic, bạn có thể set
     * StaffID = null nếu chưa có nhân viên phụ trách.
     *
     * @param order Đối tượng Orders (chứa Customer, Voucher, PaymentMethod,
     * v.v.)
     * @param orderItemsList Danh sách OrderDetails (sản phẩm, số lượng, đơn
     * giá)
     * @return orderId ID của đơn hàng vừa chèn, 0 nếu thất bại
     */
    public int insertOrder(Orders order, ArrayList<OrderDetails> orderItemsList) {
        int orderId = 0;

        // Bảng Orders (OrderID, CustomerID, StaffID, VoucherID, Status, PaymentMethod, TotalPrice, CreatedAt)
        // Sử dụng OUTPUT INSERTED.OrderID để lấy OrderID sau khi chèn
        String orderSql = "INSERT INTO [dbo].[Orders] "
                + "(CustomerID, StaffID, VoucherID, Status, PaymentMethod, TotalPrice, Address, Phone) "
                + "OUTPUT INSERTED.OrderID "
                + "VALUES (?, NULL, ?, ?, ?, ?, ?, ?)";

        // Bảng OrderDetails (OrderDetailID, OrderID, ProductID, Price, Quantity)
        String orderItemSql = "INSERT INTO [dbo].[OrderDetails] (OrderID, ProductID, Price, Quantity, SizeID) "
                + "VALUES (?, ?, ?, ?, ?)";

        // Giảm số lượng tồn kho
        String updateStockSql = "UPDATE [dbo].[Products] SET StockQuantity = StockQuantity - ? WHERE ProductID = ?";

        String updateProductSizeStockSql = "UPDATE [dbo].[ProductSizes] SET StockQuantity = StockQuantity - ? WHERE ProductID = ? AND SizeID = ?";

        try {
            // 1) Chèn Orders trước
            PreparedStatement psOrder = connection.prepareStatement(orderSql);

            // CustomerID
            psOrder.setString(1, order.getCustomer().getCustomerId());

            // StaffID = NULL (tạm, bạn có thể setStaff() tuỳ logic)
            // VoucherID
            if (order.getVoucher() != null) {
                psOrder.setInt(2, order.getVoucher().getVoucherID());
            } else {
                psOrder.setNull(2, java.sql.Types.INTEGER);
            }

            // Status
            psOrder.setString(3, order.getStatus());
            // PaymentMethod
            psOrder.setString(4, order.getPaymentMethod());
            // TotalPrice
            psOrder.setBigDecimal(5, order.getTotalPrice());

            psOrder.setString(6, order.getAddress());
            psOrder.setString(7, order.getPhone());

            // Lấy OrderID vừa chèn
            ResultSet rs = psOrder.executeQuery();
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                throw new SQLException("Không lấy được OrderID sau khi chèn Orders.");
            }
            rs.close();
            psOrder.close();

            // 2) Chèn các OrderDetails
            PreparedStatement psOrderItem = connection.prepareStatement(orderItemSql);
            PreparedStatement psUpdateStock = connection.prepareStatement(updateStockSql);
            PreparedStatement psUpdateProductSizeStock = connection.prepareStatement(updateProductSizeStockSql);

            for (OrderDetails item : orderItemsList) {
                // OrderID
                psOrderItem.setInt(1, orderId);
                // ProductID
                psOrderItem.setInt(2, item.getProduct().getProductID());
                // Price
                psOrderItem.setBigDecimal(3, item.getPrice());
                // Quantity
                psOrderItem.setInt(4, item.getQuantity());
                if (item.getSize() != null) {
                    psOrderItem.setInt(5, item.getSize().getSizeID());
                } else {
                    psOrderItem.setInt(5, java.sql.Types.INTEGER);
                }
                psOrderItem.executeUpdate();

                // Giảm tồn kho
                psUpdateStock.setInt(1, item.getQuantity());
                psUpdateStock.setInt(2, item.getProduct().getProductID());
                psUpdateStock.executeUpdate();

                // Giảm tồn kho trong ProductSize (nếu có SizeID)
                if (item.getSize() != null) {
                    psUpdateProductSizeStock.setInt(1, item.getQuantity());
                    psUpdateProductSizeStock.setInt(2, item.getProduct().getProductID());
                    psUpdateProductSizeStock.setInt(3, item.getSize().getSizeID());
                    psUpdateProductSizeStock.executeUpdate();
                }
            }
            psOrderItem.close();
            psUpdateStock.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    /**
     * getCountOrdersByUserVoucher - Đếm số đơn hàng mà user đã dùng 1 voucherID
     * cụ thể. Dùng để kiểm tra maxUsagePerUser.
     *
     * @param customerId Mã khách hàng (VD: "CUS123")
     * @param voucherID Mã voucher (int)
     * @return Số đơn hàng mà user đã áp voucher này
     */
    public int getCountOrdersByUserVoucher(String customerId, int voucherID) {
        String sql = "SELECT COUNT(*) AS cnt "
                + "FROM Orders "
                + "WHERE CustomerID = ? AND VoucherID = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setInt(2, voucherID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cnt");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * updateStatusPayment - Cập nhật trạng thái thanh toán đơn hàng
     */
    public void updateStatusPayment(Orders o) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, o.getStatus());
            ps.setInt(2, o.getOrderID());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * getMonthlyRevenueByYear - Lấy doanh thu từng tháng cho năm chỉ định
     * Status = 'COMPLETED' mới tính là doanh thu
     */
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
                + "FROM Months m\n"
                + "LEFT JOIN Orders o ON MONTH(o.CreatedAt) = m.Month \n"
                + "    AND YEAR(o.CreatedAt) = ? \n"
                + "    AND o.Status = 'COMPLETED'\n"
                + "GROUP BY m.Month\n"
                + "ORDER BY m.Month;";
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, year);
            rs = ps.executeQuery();
            while (rs.next()) {
                // cột 1 = month, cột 2 = revenue
                list.add(rs.getDouble(2));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * getAllOders - Lấy toàn bộ đơn hàng (Orders) từ DB
     */
    public List<Orders> getAllOders() {
        ArrayList<Orders> list = new ArrayList<>();
        CustomersDAO customersDAO = new CustomersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        StaffsDAO staffsdao = new StaffsDAO();

        String sql = "SELECT * FROM [SE1808_SWP391_Group5].[dbo].[Orders] o";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers customers = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                Vouchers voucher = voucherDAO.getVoucherById(rs.getInt("VoucherID"));
                Staffs staff = staffsdao.getStaffByID(rs.getString("StaffID"));
                Orders od = new Orders(
                        rs.getInt("OrderID"),
                        customers,
                        staff,
                        voucher,
                        rs.getString("Status"),
                        rs.getString("PaymentMethod"),
                        rs.getBigDecimal("TotalPrice"),
                        rs.getDate("CreatedAt"),
                        rs.getString("StatusDL"),
                        rs.getString("Address"),
                        rs.getString("Phone")
                );
                list.add(od);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
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
                order.setStatusDL(rs.getString("StatusDL"));
                order.setPhone(rs.getString("Phone"));
                order.setAddress(rs.getString("Address"));

            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public List<OrderDetails> getOdersDetailByID(int id) {
        ArrayList<OrderDetails> list = new ArrayList<>();

        ProductsDAO productsDAO = new ProductsDAO();

        String sql = "SELECT "
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
                + "WHERE o.[OrderID] = ?\n"
                + "ORDER BY o.[CreatedAt] DESC;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Products products = productsDAO.getProductByID(rs.getInt("ProductID"));
                Orders order = getOderByID(rs.getInt("OrderID"));

                list.add(new OrderDetails(
                        rs.getInt("OrderDetailID"),
                        order,
                        products,
                        rs.getBigDecimal("Price"),
                        rs.getInt("Quantity")
                ));
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Orders> getOrdersByCustomerID(String id) {
        ArrayList<Orders> list = new ArrayList<>();
        CustomersDAO customersDAO = new CustomersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        StaffsDAO staffsdao = new StaffsDAO();

        String sql = "SELECT * FROM [SE1808_SWP391_Group5].[dbo].[Orders] WHERE [CustomerID] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers customers = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                Vouchers voucher = voucherDAO.getVoucherById(rs.getInt("VoucherID"));
                Staffs staff = staffsdao.getStaffByID(rs.getString("StaffID"));
                Orders od = new Orders(
                        rs.getInt("OrderID"),
                        customers,
                        staff,
                        voucher,
                        rs.getString("Status"),
                        rs.getString("PaymentMethod"),
                        rs.getBigDecimal("TotalPrice"),
                        rs.getDate("CreatedAt"),
                        rs.getString("StatusDL"),
                        rs.getString("Address"),
                        rs.getString("Phone")
                );
                list.add(od);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
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

    public List<Map<String, Object>> getTop10StaffByOrderCount(int year) {
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
                + "    o.Status = 'COMPLETED' and YEAR(o.CreatedAt) = ?\n"
                + "GROUP BY \n"
                + "    s.StaffID, s.StaffName\n"
                + "ORDER BY \n"
                + "    OrderCount DESC;";

        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, year);
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

    public void updateOrder(Orders order) {
        String sql = "UPDATE Orders SET Phone = ?, Status = ?, StatusDL = ?, Address = ?, StaffID = ? WHERE OrderID = ?";
        try {
            Staffs staff = order.getStaff();
            ps = connection.prepareStatement(sql);
            ps.setString(1, order.getPhone());
            ps.setString(2, order.getStatus());
            ps.setString(3, order.getStatusDL());
            ps.setString(4, order.getAddress());
            ps.setInt(5, order.getOrderID());
            ps.setString(6, staff.getStaffID());

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Orders> getFilteredOrders(String search, String status, String minPrice, String maxPrice, Date startDate, Date endDate) {

        ArrayList<Orders> list = new ArrayList<>();
        CustomersDAO customersDAO = new CustomersDAO();
        VoucherDAO voucherDAO = new VoucherDAO();
        StaffsDAO staffsdao = new StaffsDAO();

        String sql = "SELECT * FROM [SE1808_SWP391_Group5].[dbo].[Orders] o "
                + "JOIN [SE1808_SWP391_Group5].[dbo].[Customers] c ON o.CustomerID = c.CustomerID "
                + "WHERE 1=1 ";

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND c.CustomerName LIKE ?";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND o.Status LIKE ?";
        }
        if (minPrice != null && !minPrice.trim().isEmpty()) {
            sql += " AND o.TotalPrice >= ?";
        }
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            sql += " AND o.TotalPrice <= ?";
        }
        if (startDate != null) {
            sql += " AND o.CreatedAt >= ?";
        }
        if (endDate != null) {
            sql += " AND o.CreatedAt <= ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(index++, status);
            }
            if (minPrice != null && !minPrice.trim().isEmpty()) {
                ps.setBigDecimal(index++, new BigDecimal(minPrice));
            }
            if (maxPrice != null && !maxPrice.trim().isEmpty()) {
                ps.setBigDecimal(index++, new BigDecimal(maxPrice));
            }
            if (startDate != null) {
                ps.setDate(index++, new java.sql.Date(startDate.getTime()));
            }
            if (endDate != null) {
                ps.setDate(index++, new java.sql.Date(endDate.getTime()));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customers customers = customersDAO.getCustomerByID(rs.getString("CustomerID"));
                Vouchers voucher = voucherDAO.getVoucherById(rs.getInt("VoucherID"));
                Staffs staff = staffsdao.getStaffByID(rs.getString("StaffID"));
                Orders od = new Orders(
                        rs.getInt("OrderID"),
                        customers,
                        staff,
                        voucher,
                        rs.getString("Status"),
                        rs.getString("PaymentMethod"),
                        rs.getBigDecimal("TotalPrice"),
                        rs.getDate("CreatedAt"),
                        rs.getString("StatusDL"),
                        rs.getString("Address"),
                        rs.getString("Phone")
                );
                list.add(od);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    public static void main(String[] args) {
        OrdersDAO odao = new OrdersDAO();
        List<Orders> list = odao.getFilteredOrders(null, null, null, null, null, null);
        for (Orders orders : list) {
            System.out.println(orders.getOrderID());
        }
    }

}
