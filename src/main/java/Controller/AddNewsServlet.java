package Controller;

import Models.News;
import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.http.Part;

@WebServlet(name = "AddNewsServlet", urlPatterns = {"/add-news"})
@MultipartConfig
public class AddNewsServlet extends HttpServlet {

    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffID = request.getParameter("staffID");
        String author = request.getParameter("author");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        LocalDateTime publishedDate = LocalDateTime.now();

        Part imagePart = request.getPart("image");
        Part filePart = request.getPart("filePath");

        String imageURL = saveFile(imagePart, "images");
        String filePath = saveFile(filePart, "documents");

        try {
            newsDAO.addNews(staffID, author, title, content, publishedDate, filePath, imageURL);
            response.sendRedirect("news-management");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error adding news");
            request.getRequestDispatcher("addNews.jsp").forward(request, response);
        }
    }

    private String saveFile(Part part, String directory) throws IOException {
        if (part == null || part.getSize() == 0) {
            return null; // Không có tệp được tải lên
        }

        String fileName = part.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }

        File uploads = new File(getServletContext().getRealPath("/" + directory));
        if (!uploads.exists()) {
            uploads.mkdirs();
        }

        File file = new File(uploads, fileName);
        try ( InputStream input = part.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        return directory + "/" + fileName;
    }

}
