package Models;

import java.math.BigDecimal;

public class Vouchers {
    private int voucherID;
    private String name;
    private String description;
    private BigDecimal discountPercentage;
    private BigDecimal maxReducing;
    private String code;
    private int quantity;
    private String expiryDate;
    private boolean isActive;
    private BigDecimal minOrderValue;
    private int maxUsagePerUser;
    private int usageCount;
    // Trường mới cho ảnh
    private String imageURL;

    // Constructor mặc định
    public Vouchers() {
    }

    // Constructor đầy đủ (bao gồm cả cột mới)
    public Vouchers(int voucherID,
                    String name,
                    String description,
                    BigDecimal discountPercentage,
                    BigDecimal maxReducing,
                    String code,
                    int quantity,
                    String expiryDate,
                    boolean isActive,
                    BigDecimal minOrderValue,
                    int maxUsagePerUser,
                    int usageCount,
                    String imageURL) {
        this.voucherID = voucherID;
        this.name = name;
        this.description = description;
        this.discountPercentage = discountPercentage;
        this.maxReducing = maxReducing;
        this.code = code;
        this.quantity = quantity;
        this.expiryDate = expiryDate;
        this.isActive = isActive;
        this.minOrderValue = minOrderValue;
        this.maxUsagePerUser = maxUsagePerUser;
        this.usageCount = usageCount;
        this.imageURL = imageURL;
    }

    // Getter và Setter cho các cột cũ
    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(BigDecimal discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    public BigDecimal getMaxReducing() {
        return maxReducing;
    }

    public void setMaxReducing(BigDecimal maxReducing) {
        this.maxReducing = maxReducing;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    // Getter và Setter cho các cột mới
    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public BigDecimal getMinOrderValue() {
        return minOrderValue;
    }

    public void setMinOrderValue(BigDecimal minOrderValue) {
        this.minOrderValue = minOrderValue;
    }

    public int getMaxUsagePerUser() {
        return maxUsagePerUser;
    }

    public void setMaxUsagePerUser(int maxUsagePerUser) {
        this.maxUsagePerUser = maxUsagePerUser;
    }

    public int getUsageCount() {
        return usageCount;
    }

    public void setUsageCount(int usageCount) {
        this.usageCount = usageCount;
    }
    
    // Getter và Setter cho trường imageURL
    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
