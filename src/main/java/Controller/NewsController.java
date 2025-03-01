package Controller;

import Models.News;
import dal.NewsDAO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "NewsController", urlPatterns = {"/news-list"})
public class NewsController extends HttpServlet {

    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        newsDAO = new NewsDAO(); // Initialize the NewsDAO object
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            // Default action: show the list of news
            showNewsList(request, response);
        } else {
            switch (action) {
                case "view":
                    viewNewsDetail(request, response);
                    break;
                default:
                    showNewsList(request, response);
                    break;
            }
        }
    }

    private void showNewsList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<News> newsList = (ArrayList<News>) newsDAO.getNewsList();
        request.setAttribute("newsList", newsList);
        request.getRequestDispatcher("newsList.jsp").forward(request, response);
    }

    private void viewNewsDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        News news = newsDAO.getNewsById(id);

        if (news != null) {
            ServletContext context = getServletContext();
            ArrayList<String> newsDetail = newsDAO.extractContentAndImg(
                context.getRealPath("/resources").replace("resources", "\\") + news.getFilePath()
            );

            request.setAttribute("newsDetail", newsDetail);
            request.setAttribute("news", news);
            request.getRequestDispatcher("newsDetail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "News not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle POST requests if needed
        // For example, you can add functionality to create, update, or delete news
    }

    @Override
    public String getServletInfo() {
        return "NewsController handles the display and management of news articles.";
    }
}