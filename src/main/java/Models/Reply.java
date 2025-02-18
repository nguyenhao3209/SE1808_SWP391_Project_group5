package Models;

import java.time.LocalDateTime;

public class Reply {
    private int replyID;
    private String customerID;
    private String staffID;
    private String feedbackID;
    private LocalDateTime createdAt;
    private String comment;

    private Customers customers;

    public Reply() {
    }

    public Reply(int replyID, String customerID, String staffID, String feedbackID, LocalDateTime createdAt, String comment, Customers customers) {
        this.replyID = replyID;
        this.customerID = customerID;
        this.staffID = staffID;
        this.feedbackID = feedbackID;
        this.createdAt = createdAt;
        this.comment = comment;
        this.customers = customers;
    }

    public int getReplyID() {
        return replyID;
    }

    public void setReplyID(int replyID) {
        this.replyID = replyID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public String getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(String feedbackID) {
        this.feedbackID = feedbackID;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Customers getCustomers() {
        return customers;
    }

    public void setCustomers(Customers customers) {
        this.customers = customers;
    }
    
    
}
