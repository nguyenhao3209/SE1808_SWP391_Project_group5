package dal;

import Models.Vouchers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO extends DBContext {

    public VoucherDAO() {
        super();
    }

    public List<Vouchers> getAllVouchers() {
        List<Vouchers> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers";
        try ( PreparedStatement stmt = connection.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Vouchers voucher = new Vouchers(
                        rs.getInt("VoucherID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getBigDecimal("DiscountPercentage"),
                        rs.getBigDecimal("MaxReducing"),
                        rs.getString("Code"),
                        rs.getInt("Quantity"),
                        rs.getString("ExpiryDate")
                );

                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }

    public Vouchers getVoucherById(int id) {
        String sql = "SELECT * FROM Vouchers WHERE VoucherID = ?"; // Sửa lỗi `id` thành `VoucherID`
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Vouchers(
                            rs.getInt("VoucherID"),
                            rs.getString("Name"),
                            rs.getString("Description"),
                            rs.getBigDecimal("DiscountPercentage"),
                            rs.getBigDecimal("MaxReducing"),
                            rs.getString("Code"),
                            rs.getInt("Quantity"),
                            rs.getString("ExpiryDate")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addVoucher(Vouchers voucher) {
        String sql = "INSERT INTO Vouchers (Name, Description, DiscountPercentage, MaxReducing, Code, Quantity, ExpiryDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, voucher.getName());
            stmt.setString(2, voucher.getDescription());
            stmt.setBigDecimal(3, voucher.getDiscountPercentage());
            stmt.setBigDecimal(4, voucher.getMaxReducing());
            stmt.setString(5, voucher.getCode());
            stmt.setInt(6, voucher.getQuantity());
            stmt.setString(7, voucher.getExpiryDate());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateVoucher(Vouchers voucher) {
        String sql = "UPDATE Vouchers SET Code = ?, DiscountPercentage = ?, expiryDate = ?, MaxReducing = ? WHERE VoucherID = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, voucher.getCode());
            stmt.setBigDecimal(2, voucher.getDiscountPercentage());
            stmt.setString(3, voucher.getExpiryDate());
            stmt.setBigDecimal(4, voucher.getMaxReducing());
            stmt.setInt(5, voucher.getVoucherID());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

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

    public boolean insertVoucher(Vouchers voucher) {
        String sql = "INSERT INTO Vouchers (Name, Description, DiscountPercentage, MaxReducing, Code, Quantity, ExpiryDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, voucher.getName());
            stmt.setString(2, voucher.getDescription());
            stmt.setBigDecimal(3, voucher.getDiscountPercentage());
            stmt.setBigDecimal(4, voucher.getMaxReducing());
            stmt.setString(5, voucher.getCode());
            stmt.setInt(6, voucher.getQuantity());
            stmt.setString(7, voucher.getExpiryDate());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
