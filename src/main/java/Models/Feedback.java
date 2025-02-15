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
public class Feedback {
    private int FeedbackID;
    private Customers customer;
    private int rating;
    private String comment;
    private DateTimeException createAt;

    public Feedback() {
    }

    public Feedback(int FeedbackID, Customers customer, int rating, String comment, DateTimeException createAt) {
        this.FeedbackID = FeedbackID;
        this.customer = customer;
        this.rating = rating;
        this.comment = comment;
        this.createAt = createAt;
    }

    public int getFeedbackID() {
        return FeedbackID;
    }

    public void setFeedbackID(int FeedbackID) {
        this.FeedbackID = FeedbackID;
    }

    public Customers getCustomer() {
        return customer;
    }

    public void setCustomer(Customers customer) {
        this.customer = customer;
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

    public DateTimeException getCreateAt() {
        return createAt;
    }

    public void setCreateAt(DateTimeException createAt) {
        this.createAt = createAt;
    }
    
    
}
