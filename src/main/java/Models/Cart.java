/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import java.sql.Date;

/**
 *
 * @author HaoNTCE180451
 */
public class Cart {
    private int cartID;
    private Customers customer;
    private Date createAt;
    private Products product;
    private int quantity;

    public Cart() {
    }

    public Cart(int cartID, Customers customer, Date createAt, Products product, int quantity) {
        this.cartID = cartID;
        this.customer = customer;
        this.createAt = createAt;
        this.product = product;
        this.quantity = quantity;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public Customers getCustomer() {
        return customer;
    }

    public void setCustomer(Customers customer) {
        this.customer = customer;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
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
}
