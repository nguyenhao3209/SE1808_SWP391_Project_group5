/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import com.nimbusds.oauth2.sdk.Role;
import java.io.ObjectInputFilter.Status;
import java.time.LocalDateTime;

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class Customers {
private String customerId;  // ID người dùng (khóa chính)
    private String customerName;  // Tên người dùng
    private String email;  // Địa chỉ email
    private String password;  // Mật khẩu người dùng (đã mã hóa)
    private String phone;  // Số điện thoại
    private String address;  // Địa chỉ
    private Role role;  // Phân quyền người dùng (ENUM)
    private Status status;  // Trạng thái tài khoản (ENUM)
    private String passwordRecoveryToken;  // Token khôi phục mật khẩu
    private LocalDateTime tokenExpiry;  // Thời gian hết hạn của token
    private String avatar;  // Đường dẫn hoặc URL của avatar

    public Customers() {
    }

    public Customers(String customerId, String customerName, String email, String password, String phone, String address, Role role, Status status, String passwordRecoveryToken, LocalDateTime tokenExpiry, String avatar) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.status = status;
        this.passwordRecoveryToken = passwordRecoveryToken;
        this.tokenExpiry = tokenExpiry;
        this.avatar = avatar;
    }

    // Enum cho Role (ADMIN, USER)
    public enum Role {
        ADMIN, USER
    }

    // Enum cho Status (ACTIVE, INACTIVE)
    public enum Status {
        ACTIVE, INACTIVE
    }

//    public User(int userId, String userName, String email, String password, String phone, String address,
//                Role role, Status status, String passwordRecoveryToken, LocalDateTime tokenExpiry, String avatar) {
//        this.userId = userId;
//        this.userName = userName;
//        this.email = email;
//        this.password = password;
//        this.phone = phone;
//        this.address = address;
//        this.role = role;
//        this.status = status;
//        this.passwordRecoveryToken = passwordRecoveryToken;
//        this.tokenExpiry = tokenExpiry;
//        this.avatar = avatar;
//    }

    public Customers(String userName, String email) {
        this.customerName = userName;
        this.email = email;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    // Sửa lại phương thức này để trả về đúng thuộc tính `passwordRecoveryToken`
    public String getPasswordRecoveryToken() {
        return passwordRecoveryToken;
    }

    public void setPasswordRecoveryToken(String passwordRecoveryToken) {
        this.passwordRecoveryToken = passwordRecoveryToken;
    }

    public LocalDateTime getTokenExpiry() {
        return tokenExpiry;
    }

    public void setTokenExpiry(LocalDateTime tokenExpiry) {
        this.tokenExpiry = tokenExpiry;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "Customers{" + "customerId=" + customerId + ", customerName=" + customerName + ", email=" + email + ", password=" + password + ", phone=" + phone + ", address=" + address + ", role=" + role + ", status=" + status + ", passwordRecoveryToken=" + passwordRecoveryToken + ", tokenExpiry=" + tokenExpiry + ", avatar=" + avatar + '}';
    }
    
    
}   
