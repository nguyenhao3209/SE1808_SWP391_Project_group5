
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.math.BigDecimal;
import java.sql.Date;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class Products {
    private int productID;
    private String productName;
    private BigDecimal price;
    private int stockQuantity;
    private String brand;
    private int categoryID;
    private String description;
    private String imageURL;
    private Date createdAt;
    private Date updatedAt;
    private BigDecimal discountProduct;
    
    private int numberOfFeedbacks;
    private double avgRating;

    public Products() {
    }

    public Products(int productID, String productName, BigDecimal price, int stockQuantity, String brand, int category, String description, String imageURL, Date createdAt, Date updatedAt, BigDecimal discountProduct) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.brand = brand;
        this.categoryID = categoryID;
        this.description = description;
        this.imageURL = imageURL;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.discountProduct = discountProduct;
    }

    public Products(int productID, String productName, BigDecimal price, int stockQuantity, String brand, String category, String description, String imageURL, BigDecimal discountProduct) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.brand = brand;
        this.categoryID = categoryID;
        this.description = description;
        this.imageURL = imageURL;
        this.discountProduct = discountProduct;
    }

    public Products(String productName, BigDecimal price, int stockQuantity, String brand, String category, String description, String imageURL, BigDecimal discountProduct) {
        this.productName = productName;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.brand = brand;
        this.categoryID = categoryID;
        this.description = description;
        this.imageURL = imageURL;
        this.discountProduct = discountProduct;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public BigDecimal getDiscountProduct() {
        return discountProduct;
    }

    public void setDiscountProduct(BigDecimal discountProduct) {
        this.discountProduct = discountProduct;
    }

    public int getNumberOfFeedbacks() {
        return numberOfFeedbacks;
    }

    public void setNumberOfFeedbacks(int numberOfFeedbacks) {
        this.numberOfFeedbacks = numberOfFeedbacks;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

}

