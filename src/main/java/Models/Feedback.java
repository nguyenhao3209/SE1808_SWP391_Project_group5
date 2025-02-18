package Models;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

public class Feedback {
    private int reviewID;
    private Customers user;
    private int productID;
    private int rating;
    private String comment;
    private Date createdAt;
    private String customerId;

    private List<Reply> replies;

    // Constructor mặc định
    public Feedback() {
        this.createdAt = new Date(System.currentTimeMillis());
    }

    public Feedback(int reviewID, Customers user, int productID, int rating, String comment, Date createdAt, String customerId, List<Reply> replies) {
        this.reviewID = reviewID;
        this.user = user;
        this.productID = productID;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.customerId = customerId;
        this.replies = replies;
    }

    public int getReviewID() {
        return reviewID;
    }
   

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }
   

    public Customers getUser() {
        return user;
    }

    public void setUser(Customers user) {
        this.user = user;
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public List<Reply> getReplies() {
        return replies;
    }

    public void setReplies(List<Reply> replies) {
        this.replies = replies;
    }
     @Override
    public String toString() {
        return "Feedback{" + "reviewID=" + reviewID + ", user=" + user + ", productID=" + productID + ", rating=" + rating + ", comment=" + comment + ", createdAt=" + createdAt + '}';
    }
}