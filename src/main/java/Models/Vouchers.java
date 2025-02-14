/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import java.math.BigDecimal;

/**
 *
 * @author HaoNTCE180451
 */
public class Vouchers {
    private int voucherID;
    private String name;
    private String description;
    private BigDecimal discountPercentage;
    private BigDecimal maxReducing;
    private String code;
    private String quantity;
    private String expiryDate;

    public Vouchers() {
    }

    public Vouchers(int voucherID, String name, String description, BigDecimal discountPercentage, BigDecimal maxReducing, String code, String quantity, String expiryDate) {
        this.voucherID = voucherID;
        this.name = name;
        this.description = description;
        this.discountPercentage = discountPercentage;
        this.maxReducing = maxReducing;
        this.code = code;
        this.quantity = quantity;
        this.expiryDate = expiryDate;
    }

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

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }
    
    
}
