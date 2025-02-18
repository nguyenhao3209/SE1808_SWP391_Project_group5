/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

/**
 *
 * @author HaoNTCE180451
 */
public class ProductSizes {
    private int sizeID;
    private Products product;
    private String size;
    private int stockQuantity;

    public ProductSizes() {
    }

    public ProductSizes(int sizeID, Products product, String size, int stockQuantity) {
        this.sizeID = sizeID;
        this.product = product;
        this.size = size;
        this.stockQuantity = stockQuantity;
    }
    
    public ProductSizes(Products product, String size, int stockQuantity) {
        this.product = product;
        this.size = size;
        this.stockQuantity = stockQuantity;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
}
