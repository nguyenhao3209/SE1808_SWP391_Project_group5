
import Models.Feedback;
import dal.ProductsDAO;
import dal.ReviewsDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import static junit.framework.Assert.assertEquals;
import org.junit.Test;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/UnitTests/JUnit4TestClass.java to edit this template
 */



/**
 *
 * @author tien
 */
public class Test1 {
    

    
    //TC1 : Test for get review with one star rating; Input: productID=92, rating=1
    @Test
    public void testGetReviewsByProductIdAndRatingOne() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();
        List<Feedback> reviews = reviewsDAO.getReviewsByProductIdAndRating(92, 1);
        
        
        for (Feedback review : reviews) {
            int result = review.getRating();
            assertEquals(1, result);
        }
      
    }
    
    //TC2 : Test for get review with 0 star rating; Input: productID=2, rating=0
    @Test
    public void testGetReviewsByProductIdAndRatingZero() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();
        List<Feedback> reviews = reviewsDAO.getReviewsByProductIdAndRating(2, 0);
        
        
        for (Feedback review : reviews) {
            int result = review.getRating();
            assertEquals(null, result);
        }
      
    }
    
    //TC3 : Test for get review with 5 star rating; Input: productID=37, rating=5
    @Test
    public void testGetReviewsByProductIdAndRatingFive() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();
        List<Feedback> reviews = reviewsDAO.getReviewsByProductIdAndRating(37, 5);
        
        
        for (Feedback review : reviews) {
            int result = review.getRating();
            assertEquals(5, result);
        }
      
    }
    
    //TC4 : Test for get review with negative star rating; Input: productID=37, rating=-10
    @Test
    public void testGetReviewsByProductIdAndRatingNegative() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();
        List<Feedback> reviews = reviewsDAO.getReviewsByProductIdAndRating(37, -10);
        
        
        for (Feedback review : reviews) {
            int result = review.getRating();
            assertEquals(null, result);
        }
      
    }
    
    //TC5 : Test for get review with more than 5 star rating; Input: productID=37, rating=7
    @Test
    public void testGetReviewsByProductIdAndRatingMoreThanFive() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();
        List<Feedback> reviews = reviewsDAO.getReviewsByProductIdAndRating(37, 7);
        
        
        for (Feedback review : reviews) {
            int result = review.getRating();
            assertEquals(null, result);
        }
      
    }
    
    //TC6 : Test for get review with 3 star rating; Input: productID=37, rating=3
    @Test
    public void testGetReviewsByProductIdAndRatingThree() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();
        List<Feedback> reviews = reviewsDAO.getReviewsByProductIdAndRating(37, 5);
        
        
        for (Feedback review : reviews) {
            int result = review.getRating();
            assertEquals(5, result);
        }
      
    }
    
   
}
