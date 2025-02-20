<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>News List</title>
</head>
<body>
    <h2>News List</h2>

    <table border="1">
        <thead>
            <tr>
                <th>News ID</th>
                <th>Author</th>
                <th>Title</th>
                <th>Content</th>
                <th>Published Date</th>
                <th>View Document</th>
                <th>Image</th>
                <th>Staff ID</th>
                <th>Staff Name</th>
                <th>Staff Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="news" items="${newsList}">
                <tr>
                    <td>${news.newsID}</td>
                    <td>${news.author}</td>
                    <td>${news.title}</td>
                    <td>${news.content}</td>
                    <td>${news.publishedDate}</td>
                    <td>
                        <!-- Open .docx file using Google Docs Viewer -->
                        <a href="https://docs.google.com/gview?url=${pageContext.request.contextPath}/${news.filePath}&embedded=true" target="_blank">
                            View Document
                        </a>
                    </td>
                    <td>
                        <!-- Display image -->
                        <img src="${pageContext.request.contextPath}/${news.image}" alt="News Image" width="100" />
                    </td>
                    <td>${news.staff.staffID}</td>
                    <td>${news.staff.staffName}</td>
                    <td>${news.staff.email}</td>
                    <td>
                        <a href="newsDetail?newsId=${news.newsID}">View Details</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
