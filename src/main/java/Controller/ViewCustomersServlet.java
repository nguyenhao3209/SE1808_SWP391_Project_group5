package controller;

import dal.CustomersDAO;
import Models.Customers;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewCustomersServlet", urlPatterns = {"/view-customers"})
public class ViewCustomersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CustomersDAO customersDAO = new CustomersDAO();
        List<Customers> customersList = customersDAO.getAllCustomers();
        
        request.setAttribute("customersList", customersList);
        request.getRequestDispatcher("admin/view-customers.jsp").forward(request, response);
    }
}
