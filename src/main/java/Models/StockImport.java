/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author HaoNTCE180451
 */
public class StockImport {

    private int importID;
    private Staffs staff;
    private String supplier;
    private Timestamp importDate;
    private BigDecimal totalCost;

    public StockImport() {
    }

    public StockImport(int importID, Staffs staff, String supplier, Timestamp importDate, BigDecimal totalCost) {
        this.importID = importID;
        this.staff = staff;
        this.supplier = supplier;
        this.importDate = importDate;
        this.totalCost = totalCost;
    }

    public int getImportID() {
        return importID;
    }

    public void setImportID(int importID) {
        this.importID = importID;
    }

    public Staffs getStaff() {
        return staff;
    }

    public void setStaff(Staffs staff) {
        this.staff = staff;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

}
