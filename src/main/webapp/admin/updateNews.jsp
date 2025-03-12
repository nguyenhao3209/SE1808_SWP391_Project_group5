<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update News</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Helvetica Neue', sans-serif;
                background-color: #f9f9f9;
                color: #333;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            h1 {
                text-align: center;
                font-size: 2.5rem;
                font-weight: 700;
                color: #0077cc;
                margin-bottom: 20px;
                letter-spacing: 1px;
            }

            form {
                background: #fff;
                max-width: 700px;
                width: 100%;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border: 1px solid #e0e0e0;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #555;
                font-size: 15px;
            }

            input[type="text"],
            input[type="date"],
            input[type="file"],
            textarea {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
                color: #333;
                font-size: 1rem;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="date"]:focus,
            input[type="file"]:focus,
            textarea:focus {
                border-color: #0077cc;
                box-shadow: 0 0 8px rgba(0, 119, 204, 0.2);
                outline: none;
            }

            textarea {
                resize: vertical;
                min-height: 150px;
            }

            .btn {
                background: #0077cc;
                color: #fff;
                padding: 12px;
                font-size: 17px;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
                width: 100%;
                box-shadow: 0 4px 8px rgba(0, 119, 204, 0.2);
            }

            .btn:hover {
                background: #005fa3;
                transform: translateY(-2px);
                box-shadow: 0 6px 12px rgba(0, 119, 204, 0.3);
            }

            .btn:active {
                transform: translateY(0);
                box-shadow: 0 4px 8px rgba(0, 119, 204, 0.2);
            }
        </style>
    </head>
    <body>
        <div>
            <h1>Update News</h1>
            <form action="update-news" method="post" enctype="multipart/form-data">
                <input type="hidden" name="newsID" value="${news.newsID}">
                <label for="staffID">Staff ID:</label>
                <input type="text" name="staffID" id="staffID" value="${news.staff.staffID}" required>

                <label for="author">Author:</label>
                <input type="text" name="author" id="author" value="${news.author}" required>

                <label for="title">Title:</label>
                <input type="text" name="title" id="title" value="${news.title}" required>

                <label for="content">Content:</label>
                <textarea name="content" id="content" required>${news.content}</textarea>

                <label for="image">Image:</label>
                <c:if test="${not empty news.image}">
                    <img src="${news.image}" alt="Current Image" style="max-width: 200px; margin-bottom: 10px;">
                    <p>Current Image: ${news.image}</p>
                    <p>Leave blank to keep the current image.</p>
                </c:if>
                <input type="file" name="image" id="image" accept="image/*">

                <label for="filePath">File DOCX:</label>
                <c:if test="${not empty news.filePath}">
                    <p>Current File: ${news.filePath}</p>
                    <p>Leave blank to keep the current file.</p>
                </c:if>
                <input type="file" name="filePath" id="filePath" accept=".docx">

                <input type="submit" value="Update News" class="btn">
            </form>
        </div>
    </body>
</html>