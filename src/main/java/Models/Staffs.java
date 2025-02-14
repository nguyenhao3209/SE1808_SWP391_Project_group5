/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

import java.time.DateTimeException;

/**
 *
 * @author HaoNTCE180451
 */
public class Staffs {
    private String staffID;
    private String staffName;
    private String email;
    private String avatar;
    private DateTimeException tolenExpiry;
    private String password;
    private String phone;
    private String gender;
    private String address;
    private String role;
    private Staffs supervisor;
    private String status;
    private String passwordRecoveryToken;
    private DateTimeException hireDate;

    public Staffs() {
    }

    public Staffs(String staffID, String staffName, String email, String avatar, DateTimeException tolenExpiry, String password, String phone, String gender, String address, String role, Staffs supervisor, String status, String passwordRecoveryToken, DateTimeException hireDate) {
        this.staffID = staffID;
        this.staffName = staffName;
        this.email = email;
        this.avatar = avatar;
        this.tolenExpiry = tolenExpiry;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.address = address;
        this.role = role;
        this.supervisor = supervisor;
        this.status = status;
        this.passwordRecoveryToken = passwordRecoveryToken;
        this.hireDate = hireDate;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public DateTimeException getTolenExpiry() {
        return tolenExpiry;
    }

    public void setTolenExpiry(DateTimeException tolenExpiry) {
        this.tolenExpiry = tolenExpiry;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Staffs getSupervisor() {
        return supervisor;
    }

    public void setSupervisor(Staffs supervisor) {
        this.supervisor = supervisor;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPasswordRecoveryToken() {
        return passwordRecoveryToken;
    }

    public void setPasswordRecoveryToken(String passwordRecoveryToken) {
        this.passwordRecoveryToken = passwordRecoveryToken;
    }

    public DateTimeException getHireDate() {
        return hireDate;
    }

    public void setHireDate(DateTimeException hireDate) {
        this.hireDate = hireDate;
    }
    
    
}
