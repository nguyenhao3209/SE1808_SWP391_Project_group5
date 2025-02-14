/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author HaoNTCE180451
 */
public class Products {
    private int productID;
    private String productName;
    private String description;
    private int stockQuantity;
    private String brand;
    private Category categoryID;
    private BigDecimal price;
    private BigDecimal discountPercent;
    private String imageURL;
    private Date createAt;
    private Date updateAt;

    public Products() {
    }

    public Products(int productID, String productName, String description, int stockQuantity, String brand, Category categoryID, BigDecimal price, BigDecimal discountPercent, String imageURL, Date createAt, Date updateAt) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.stockQuantity = stockQuantity;
        this.brand = brand;
        this.categoryID = categoryID;
        this.price = price;
        this.discountPercent = discountPercent;
        this.imageURL = imageURL;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public Category getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(Category categoryID) {
        this.categoryID = categoryID;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Date updateAt) {
        this.updateAt = updateAt;
    }

    
    
}
