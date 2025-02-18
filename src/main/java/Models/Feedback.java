package Models;

import java.time.LocalDateTime;
import java.util.List;

public class Feedback {
    private String feedbackID;
    private String customerID;
    private int productID;
    private int rating;
    private String comment;
    private LocalDateTime createdAt;
    
    private List<Reply> replies;

    public Feedback() {
    }

    public Feedback(String feedbackID, String customerID, int productID, int rating, String comment, LocalDateTime createdAt, List<Reply> replies) {
        this.feedbackID = feedbackID;
        this.customerID = customerID;
        this.productID = productID;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.replies = replies;
    }

    public String getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(String feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<Reply> getReplies() {
        return replies;
    }

    public void setReplies(List<Reply> replies) {
        this.replies = replies;
    }

    
}
