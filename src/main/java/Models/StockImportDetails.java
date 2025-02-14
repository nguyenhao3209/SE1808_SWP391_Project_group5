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
public class StockImportDetails {
    private int importDetailID;
    private StockImport stockImport;
    private Products product;
    private int quantity;
    private BigDecimal costPrice;

    public StockImportDetails() {
    }

    public StockImportDetails(int importDetailID, StockImport stockImport, Products product, int quantity, BigDecimal costPrice) {
        this.importDetailID = importDetailID;
        this.stockImport = stockImport;
        this.product = product;
        this.quantity = quantity;
        this.costPrice = costPrice;
    }

    public int getImportDetailID() {
        return importDetailID;
    }

    public void setImportDetailID(int importDetailID) {
        this.importDetailID = importDetailID;
    }

    public StockImport getStockImport() {
        return stockImport;
    }

    public void setStockImport(StockImport stockImport) {
        this.stockImport = stockImport;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(BigDecimal costPrice) {
        this.costPrice = costPrice;
    }

   
}
