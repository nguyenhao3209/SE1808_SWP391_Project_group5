<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>${news.title}</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom Styles -->
        <style>
            /* Custom Styles for News Detail Page */
            .news-content {
                margin-top: 30px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .news-content img {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }

            .news-content img:hover {
                transform: scale(1.02);
            }

            .news-content p {
                font-size: 1.1em;
                line-height: 1.8;
                color: #333;
                margin-bottom: 15px;
            }

            .news-content strong {
                color: #007BFF;
            }

            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #007BFF;
                text-decoration: none;
                font-size: 1em;
                transition: color 0.3s ease;
            }

            .back-link:hover {
                color: #0056b3;
                text-decoration: underline;
            }

            /* Custom Styles for News List Page */
            .news-list {
                padding: 20px;
            }

            .news-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 25px;
                padding: 20px;
            }

            .news-card {
                border: 1px solid #e0e0e0;
                border-radius: 15px;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .news-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .news-card img {
                width: 100%;
                border-radius: 10px;
                margin-bottom: 15px;
                transition: transform 0.3s ease;
            }

            .news-card img:hover {
                transform: scale(1.05);
            }

            .news-card h2 {
                font-size: 1.5em;
                color: #333;
                margin-bottom: 10px;
            }

            .news-date {
                color: #666;
                font-size: 0.9em;
                margin-bottom: 10px;
            }

            .news-card p {
                font-size: 1em;
                line-height: 1.6;
                color: #555;
                margin-bottom: 15px;
            }

            .news-card strong {
                color: #007BFF;
            }

            .read-more-btn, .delete-btn {
                margin-top: 10px;
                display: inline-block;
                padding: 8px 16px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 0.9em;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .read-more-btn {
                background-color: #007BFF;
                color: white;
            }

            .read-more-btn:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }

            .delete-btn {
                background-color: #dc3545;
                color: white;
            }

            .delete-btn:hover {
                background-color: #c82333;
                transform: translateY(-2px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .news-grid {
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                }

                .news-card h2 {
                    font-size: 1.3em;
                }

                .news-content p {
                    font-size: 1em;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1 class="text-center">${news.title}</h1>
            <div class="news-content">
                <img src="${news.image}" alt="${news.title}" />
                <p><strong>Author:</strong> ${news.author}</p>
                <p><strong>Email:</strong> ${news.staff.email}</p>
                <c:forEach var="content" items="${newsDetail}">
                    <p>${content}</p>
                </c:forEach>
            </div>
            <a href="news-list" class="back-link"><i class="bi bi-arrow-left"></i> Back to News List</a>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>