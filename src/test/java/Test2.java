
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
public class Test2 {

    //TC1 : Test for check: Was product bought by customer - Case product was bought. Input: customerId = "CU6001", productId = 2
    @Test
    public void testIsBoughtCaseBought() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        boolean result = reviewsDAO.isBought("CU6001",2);
        assertEquals(true, result);

    }

    //TC2 : Test for check: Was product bought by customer - Case product was not bought. Input: customerId = "CU6001", productId = 5
    @Test
    public void testIsBoughtCaseCaseNotBought() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        boolean result = reviewsDAO.isBought("CU6001",5);
        assertEquals(false, result);

    }
    
    //TC3 : Test for check: Was product bought by customer - Case no customer. Input: customerId = null, productId = 5
    @Test
    public void testIsBoughtCaseCaseNoCustomer() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        boolean result = reviewsDAO.isBought(null,5);
        assertEquals(false, result);

    }

    //TC4 : Test for check: Was product bought by customer - Case no product. Input: customerId = "CU6001", productId = -10000000
    @Test
    public void testIsBoughtCaseCaseNoProduct() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        boolean result = reviewsDAO.isBought("CU6001",-10000000);
        assertEquals(false, result);

    }
    
    //TC4 : Test for check: Was product bought by customer - Case no product and customer. Input: customerId = null, productId = -10000000
    @Test
    public void testIsBoughtCaseCaseNoProductAndCustomer() {
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        boolean result = reviewsDAO.isBought(null,-10000000);
        assertEquals(false, result);

    }
    

}
