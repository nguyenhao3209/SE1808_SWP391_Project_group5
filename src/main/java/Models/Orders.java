/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import java.math.BigDecimal;
import java.time.DateTimeException;

/**
 *
 * @author HaoNTCE180451
 */
public class Orders {
    private int orderID;
    private Customers customer;
    private Staffs staff;
    private Vouchers voucher;
    private String status;
    private String paymentMethod;
    private BigDecimal totalPrice;
    private DateTimeException createAt;

    public Orders() {
    }

    public Orders(int orderID, Customers customer, Staffs staff, Vouchers voucher, String status, String paymentMethod, BigDecimal totalPrice, DateTimeException createAt) {
        this.orderID = orderID;
        this.customer = customer;
        this.staff = staff;
        this.voucher = voucher;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.createAt = createAt;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Customers getCustomer() {
        return customer;
    }

    public void setCustomer(Customers customer) {
        this.customer = customer;
    }

    public Staffs getStaff() {
        return staff;
    }

    public void setStaff(Staffs staff) {
        this.staff = staff;
    }

    public Vouchers getVoucher() {
        return voucher;
    }

    public void setVoucher(Vouchers voucher) {
        this.voucher = voucher;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public DateTimeException getCreateAt() {
        return createAt;
    }

    public void setCreateAt(DateTimeException createAt) {
        this.createAt = createAt;
    }
    
    
}
