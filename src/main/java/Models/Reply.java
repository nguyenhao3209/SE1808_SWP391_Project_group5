package Models;

import java.time.LocalDateTime;
import java.util.Date;

public class Reply {
    private int replyID;
    private int feedbackID;
    private String customerId;
    private String comment;
    private Date createdAt;
    private String staffID;
    private Customers user;

    public Reply() {
    }

    public Reply(int replyID, int feedbackID, String customerId, String comment, Date createdAt, String staffID, Customers user) {
        this.replyID = replyID;
        this.feedbackID = feedbackID;
        this.customerId = customerId;
        this.comment = comment;
        this.createdAt = createdAt;
        this.staffID = staffID;
        this.user = user;
    }

    public int getReplyID() {
        return replyID;
    }

    public void setReplyID(int replyID) {
        this.replyID = replyID;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public Customers getUser() {
        return user;
    }

    public void setUser(Customers user) {
        this.user = user;
    }
    
    }