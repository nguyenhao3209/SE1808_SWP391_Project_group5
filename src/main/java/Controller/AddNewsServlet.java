package Controller;

import Models.News;
import Models.Staffs;
import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        request.getRequestDispatcher("admin/addNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staffs staff = (Staffs) session.getAttribute("user");

        if (staff == null) {
            response.sendRedirect("login"); // Chuyển hướng đến trang đăng nhập nếu không có thông tin staff
            return;
        }

        String staffID = staff.getStaffID(); // Lấy StaffID từ session
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
            request.getRequestDispatcher("admin/addNews.jsp").forward(request, response);
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
