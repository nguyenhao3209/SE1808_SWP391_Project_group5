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
public class News {
    private int newsID;
    private Staffs staff;
    private String author;
    private String title;
    private String content;
    private DateTimeException publishedDate;
    private String filePath;
    private String image;

    public News() {
    }

    public News(int newsID, Staffs staff, String author, String title, String content, DateTimeException publishedDate, String filePath, String image) {
        this.newsID = newsID;
        this.staff = staff;
        this.author = author;
        this.title = title;
        this.content = content;
        this.publishedDate = publishedDate;
        this.filePath = filePath;
        this.image = image;
    }

    public int getNewsID() {
        return newsID;
    }

    public void setNewsID(int newsID) {
        this.newsID = newsID;
    }

    public Staffs getStaff() {
        return staff;
    }

    public void setStaff(Staffs staff) {
        this.staff = staff;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public DateTimeException getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(DateTimeException publishedDate) {
        this.publishedDate = publishedDate;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    
}
