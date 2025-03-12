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

@WebServlet(name = "UpdateNewsServlet", urlPatterns = {"/update-news"})
@MultipartConfig
public class UpdateNewsServlet extends HttpServlet {

    private NewsDAO newsDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        newsDAO = new NewsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int newsID = Integer.parseInt(request.getParameter("id"));
            News news = newsDAO.getNewsById(newsID);
            request.setAttribute("news", news);
            request.getRequestDispatcher("admin/updateNews.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid news ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy các tham số từ form
            int newsID = Integer.parseInt(request.getParameter("newsID"));
            String staffID = request.getParameter("staffID");
            String author = request.getParameter("author");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            LocalDateTime publishedDate = LocalDateTime.now();

            // Lấy file ảnh và file DOCX từ form
            Part imagePart = request.getPart("image");
            Part filePart = request.getPart("filePath");

            // Lấy thông tin bài viết hiện tại
            News currentNews = newsDAO.getNewsById(newsID);

            // Kiểm tra và lưu file ảnh mới (nếu có)
            String imageURL = (imagePart != null && imagePart.getSize() > 0) ? saveFile(imagePart, "images") : currentNews.getImage();

            // Kiểm tra và lưu file DOCX mới (nếu có)
            String filePath = (filePart != null && filePart.getSize() > 0) ? saveFile(filePart, "documents") : currentNews.getFilePath();

            // Kiểm tra các giá trị hợp lệ trước khi cập nhật
            if (staffID == null || staffID.isEmpty() || author == null || author.isEmpty() || title == null || title.isEmpty() || content == null || content.isEmpty()) {
                throw new IllegalArgumentException("Invalid input data");
            }

            // Cập nhật bài viết
            newsDAO.updateNewsById(newsID, staffID, author, title, content, publishedDate, filePath, imageURL);
            response.sendRedirect("news-management");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid newsID or staffID");
            request.getRequestDispatcher("admin/updateNews.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating news: " + e.getMessage());
            request.getRequestDispatcher("admin/updateNews.jsp").forward(request, response);
        }
    }

    private String saveFile(Part part, String directory) throws IOException {
        String fileName = part.getSubmittedFileName();
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }
        File uploads = new File(getServletContext().getRealPath("/" + directory));
        if (!uploads.exists()) {
            uploads.mkdirs();
        }
        File file = new File(uploads, fileName);
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        return directory + "/" + fileName;
    }
}