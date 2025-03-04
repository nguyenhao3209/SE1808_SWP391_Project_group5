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
                background: linear-gradient(90deg, #b29f7d, #6e6e6e);
                color: #ddd;
                padding: 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                animation: backgroundShift 12s ease-in-out infinite;
            }

            @keyframes backgroundShift {
                0%, 100% {
                    background: radial-gradient(circle, #1c1f24, #14171a);
                }
                50% {
                    background: radial-gradient(circle, #14171a, #0f1215);
                }
            }

            h1 {
                text-align: center;
                font-size: 2.5rem;
                font-weight: 700;
                color: #0077cc;
                margin-bottom: 20px;
                letter-spacing: 1px;
                text-shadow: 0 3px 6px rgba(0, 0, 0, 0.2);
                animation: glow 1.5s ease-in-out infinite alternate;
            }

            @keyframes glow {
                0%, 100% {
                    color: #0077cc;
                    text-shadow: 0 0 10px #0077cc;
                }
                50% {
                    color: #005fa3;
                    text-shadow: 0 0 20px #005fa3;
                }
            }

            form {
                background: #1b1e21;
                max-width: 700px;
                padding: 35px;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6);
                transform: scale(0.95);
                animation: scaleUp 0.8s ease forwards;
            }

            @keyframes scaleUp {
                from {
                    transform: scale(0.9);
                    opacity: 0.8;
                }
                to {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #b0c4de;
                font-size: 15px;
            }

            input[type="text"],
            input[type="date"],
            input[type="file"],
            textarea {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border: 1px solid #333;
                border-radius: 8px;
                background-color: #2c2f33;
                color: #ddd;
                box-shadow: inset 0 3px 6px rgba(0, 0, 0, 0.3);
                transition: box-shadow 0.3s ease, border-color 0.3s ease;
                font-size: 1rem;
            }

            input[type="text"]:focus,
            input[type="date"]:focus,
            input[type="file"]:focus,
            textarea:focus {
                border-color: #3498db;
                box-shadow: 0 0 10px rgba(52, 152, 219, 0.3);
                outline: none;
            }

            textarea {
                resize: vertical;
                min-height: 150px;
            }

            .btn {
                background: linear-gradient(135deg, #0077cc, #005fa3);
                color: #fff;
                padding: 12px;
                font-size: 17px;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease;
                width: 100%;
                box-shadow: 0 5px 15px rgba(0, 119, 204, 0.3);
            }

            .btn:hover {
                background: linear-gradient(135deg, #005fa3, #0077cc);
                transform: scale(1.03);
                box-shadow: 0 8px 20px rgba(0, 119, 204, 0.4);
            }

            .btn:active {
                transform: translateY(0);
                box-shadow: 0 3px 8px rgba(76, 175, 80, 0.2);
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