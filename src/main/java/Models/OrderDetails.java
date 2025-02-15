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
public class OrderDetails {
    private int orderDetail;
    private Orders order;
    private Products product;
    private BigDecimal price;
    private int quantity;

    public OrderDetails() {
    }

    public OrderDetails(int orderDetail, Orders order, Products product, BigDecimal price, int quantity) {
        this.orderDetail = orderDetail;
        this.order = order;
        this.product = product;
        this.price = price;
        this.quantity = quantity;
    }

    public int getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(int orderDetail) {
        this.orderDetail = orderDetail;
    }

    public Orders getOrder() {
        return order;
    }

    public void setOrder(Orders order) {
        this.order = order;
    }

    public Products getProduct() {
        return product;
    }

    public void setProduct(Products product) {
        this.product = product;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
