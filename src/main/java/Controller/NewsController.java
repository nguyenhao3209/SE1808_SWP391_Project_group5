package Controller;

import Models.News;
import dal.NewsDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "NewsController", urlPatterns = {"/news-list"})
public class NewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NewsDAO newsDAO = new NewsDAO();
        List<News> newsList = newsDAO.getNewsList();  // Fetch the list of news

        request.setAttribute("newsList", newsList);  // Set the news list to the request object
        request.getRequestDispatcher("/news-list.jsp").forward(request, response);  // Forward to JSP page
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Redirect POST to GET
    }
}
