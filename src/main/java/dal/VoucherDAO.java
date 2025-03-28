package dal;

import java.math.BigDecimal;
import Models.Vouchers;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO extends DBContext {

    public VoucherDAO() {
        super();
    }

    // ================================
    // Các hàm tiện ích parse/format
    // ================================
    private Timestamp parseTimestamp(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        dateStr = dateStr.replace("T", " ");
        return Timestamp.valueOf(dateStr);
    }

    private String formatTimestamp(Timestamp ts) {
        if (ts == null) {
            return null;
        }
        LocalDateTime ldt = ts.toLocalDateTime();
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SS");
        return ldt.format(dtf);
    }

    // ================================
    // getAllVouchers()
    // ================================
    public List<Vouchers> getAllVouchers() {
        List<Vouchers> vouchers = new ArrayList<>();
        String sql = "SELECT VoucherID, [Name], [Description], DiscountPercentage, MaxReducing, "
                + "[Code], Quantity, ExpiryDate, IsActive, MinOrderValue, MaxUsagePerUser, UsageCount, ImageURL "
                + "FROM Vouchers";

        try ( PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Vouchers voucher = mapResultSetToVoucher(rs);
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }

    // ================================
    // getVoucherById(int id)
    // ================================
    public Vouchers getVoucherById(int id) {
        String sql = "SELECT * FROM Vouchers WHERE VoucherID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVoucher(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================
    // getVoucherByCode(String code)
    // ================================
    public Vouchers getVoucherByCode(String code) {
        String sql = "SELECT * FROM Vouchers WHERE Code = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, code);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVoucher(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================================
    // insertVoucher(Vouchers voucher)
    // ================================
    public boolean insertVoucher(Vouchers voucher) {
        String sql = "INSERT INTO Vouchers (Name, Description, DiscountPercentage, MaxReducing, "
                + "Code, Quantity, ExpiryDate, IsActive, MinOrderValue, MaxUsagePerUser, UsageCount, ImageURL) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, voucher.getName());
            stmt.setString(2, voucher.getDescription());
            stmt.setBigDecimal(3, voucher.getDiscountPercentage());
            stmt.setBigDecimal(4, voucher.getMaxReducing());
            stmt.setString(5, voucher.getCode());
            stmt.setInt(6, voucher.getQuantity());
            Timestamp ts = parseTimestamp(voucher.getExpiryDate());
            stmt.setTimestamp(7, ts);
            stmt.setBoolean(8, voucher.isIsActive());
            stmt.setBigDecimal(9, voucher.getMinOrderValue());
            stmt.setInt(10, voucher.getMaxUsagePerUser());
            stmt.setInt(11, voucher.getUsageCount());
            stmt.setString(12, voucher.getImageURL());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================
    // updateVoucher(Vouchers voucher)
    // ================================
    public boolean updateVoucher(Vouchers voucher) {
        String sql = "UPDATE Vouchers "
                + "SET [Name] = ?, [Description] = ?, DiscountPercentage = ?, MaxReducing = ?, "
                + "[Code] = ?, Quantity = ?, ExpiryDate = ?, IsActive = ?, MinOrderValue = ?, "
                + "MaxUsagePerUser = ?, UsageCount = ?, ImageURL = ? "
                + "WHERE VoucherID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, voucher.getName());
            stmt.setString(2, voucher.getDescription());
            stmt.setBigDecimal(3, voucher.getDiscountPercentage());
            stmt.setBigDecimal(4, voucher.getMaxReducing());
            stmt.setString(5, voucher.getCode());
            stmt.setInt(6, voucher.getQuantity());
            Timestamp ts = parseTimestamp(voucher.getExpiryDate());
            stmt.setTimestamp(7, ts);
            stmt.setBoolean(8, voucher.isIsActive());
            stmt.setBigDecimal(9, voucher.getMinOrderValue());
            stmt.setInt(10, voucher.getMaxUsagePerUser());
            stmt.setInt(11, voucher.getUsageCount());
            stmt.setString(12, voucher.getImageURL());
            stmt.setInt(13, voucher.getVoucherID());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================
    // deleteVoucher(int id)
    // ================================
    public boolean deleteVoucher(int id) {
        String sql = "DELETE FROM Vouchers WHERE VoucherID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ================================
    // getVouchersByPriceRange(BigDecimal totalPrice)
    // ================================
    public List<Vouchers> getVouchersByPriceRange(BigDecimal totalPrice, String customerID) {
        List<Vouchers> result = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers v "
                + "WHERE MinOrderValue <= ? "
                + "  AND NOT EXISTS ( "
                + "    SELECT 1 FROM Orders o "
                + "    WHERE o.VoucherID = v.VoucherID "
                + "    AND o.CustomerID = ? "
                + "  ) "
                + "  AND IsActive = 1 "
                + "  AND ExpiryDate >= GETDATE() "
                + "  AND UsageCount < Quantity";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBigDecimal(1, totalPrice);
            ps.setString(2, customerID);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Vouchers v = mapResultSetToVoucher(rs);
                    result.add(v);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // ================================
    // mapResultSetToVoucher
    // ================================
    private Vouchers mapResultSetToVoucher(ResultSet rs) throws SQLException {
        int voucherID = rs.getInt("VoucherID");
        String name = rs.getString("Name");
        String description = rs.getString("Description");
        BigDecimal discountPercentage = rs.getBigDecimal("DiscountPercentage");
        BigDecimal maxReducing = rs.getBigDecimal("MaxReducing");
        String code = rs.getString("Code");
        int quantity = rs.getInt("Quantity");
        boolean isActive = rs.getBoolean("IsActive");
        BigDecimal minOrderValue = rs.getBigDecimal("MinOrderValue");
        int maxUsagePerUser = rs.getInt("MaxUsagePerUser");
        int usageCount = rs.getInt("UsageCount");
        String imageURL = rs.getString("ImageURL");

        Timestamp ts = rs.getTimestamp("ExpiryDate");
        String expiryDateStr = null;
        if (ts != null) {
            expiryDateStr = formatTimestamp(ts);
        }

        return new Vouchers(
                voucherID,
                name,
                description,
                discountPercentage,
                maxReducing,
                code,
                quantity,
                expiryDateStr,
                isActive,
                minOrderValue,
                maxUsagePerUser,
                usageCount,
                imageURL
        );
    }

    // ================================
    // main test
    // ================================
    public static void main(String[] args) {
        VoucherDAO vDao = new VoucherDAO();
        List<Vouchers> vl = vDao.getVouchersByPriceRange(new BigDecimal("809.00"), "CU6001");
        System.out.println(vl.size());
    }
}
