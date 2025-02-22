package Models;
import java.sql.Date;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author CE180220_Trần Minh Khánh
 */
public class Contact {
    private int contactId;
    private String customerId;
    private String subject;
    private String message;
    private Status status;
    private Date createAt;

    public Contact() {
    }
    public enum Status {
        PENDING, REPLIED
    }
    public Contact(int contactId, String customerId, String subject, String message, Status status, Date createAt) {
        this.contactId = contactId;
        this.customerId = customerId;
        this.subject = subject;
        this.message = message;
        this.status = status;
        this.createAt = createAt;
    }

    public Contact(String customerId, String subject, String message, Status status) {
        this.customerId = customerId;
        this.subject = subject;
        this.message = message;
        this.status = status;
    }

    public int getContactId() {
        return contactId;
    }

    public void setContactId(int contactId) {
        this.contactId = contactId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
    
}
