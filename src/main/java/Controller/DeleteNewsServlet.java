package Controller;

import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DeleteNewsServlet", urlPatterns = {"/delete-news"})
public class DeleteNewsServlet extends HttpServlet {

    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int newsID = Integer.parseInt(request.getParameter("id"));
        try {
            newsDAO.deleteNewsById(newsID);
            response.sendRedirect("news-management");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error deleting news");
            request.getRequestDispatcher("news-management.jsp").forward(request, response);
        }
    }
}