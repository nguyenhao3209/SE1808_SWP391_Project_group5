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
public class Reply {
    private int replyID;
    private Customers customer;
    private Staffs staff;
    private Feedback feedback;
    private DateTimeException createAt;
    private String comment;

    public Reply() {
    }

    public Reply(int replyID, Customers customer, Staffs staff, Feedback feedback, DateTimeException createAt, String comment) {
        this.replyID = replyID;
        this.customer = customer;
        this.staff = staff;
        this.feedback = feedback;
        this.createAt = createAt;
        this.comment = comment;
    }

    public int getReplyID() {
        return replyID;
    }

    public void setReplyID(int replyID) {
        this.replyID = replyID;
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

    public Feedback getFeedback() {
        return feedback;
    }

    public void setFeedback(Feedback feedback) {
        this.feedback = feedback;
    }

    public DateTimeException getCreateAt() {
        return createAt;
    }

    public void setCreateAt(DateTimeException createAt) {
        this.createAt = createAt;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
}
