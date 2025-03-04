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
                padding: 30px;
                background-color: #ffffff;
                border-radius: 20px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .news-content:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
            }

            .news-content img {
                max-width: 100%;
                height: auto;
                border-radius: 15px;
                margin-bottom: 25px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .news-content img:hover {
                transform: scale(1.03);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .news-content p {
                font-size: 1.1em;
                line-height: 1.8;
                color: #444;
                margin-bottom: 20px;
            }

            .news-content strong {
                color: #007BFF;
                font-weight: 600;
            }

            .back-link {
                display: inline-block;
                margin-top: 25px;
                color: #007BFF;
                text-decoration: none;
                font-size: 1em;
                transition: color 0.3s ease, transform 0.3s ease;
            }

            .back-link:hover {
                color: #0056b3;
                text-decoration: underline;
                transform: translateX(-5px);
            }

            /* Custom Styles for News List Page */
            .news-list {
                padding: 30px;
            }

            .news-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                gap: 30px;
                padding: 30px;
            }

            .news-card {
                border: 1px solid #e0e0e0;
                border-radius: 20px;
                padding: 25px;
                background-color: #ffffff;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .news-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
            }

            .news-card img {
                width: 100%;
                border-radius: 15px;
                margin-bottom: 20px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .news-card img:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .news-card h2 {
                font-size: 1.6em;
                color: #333;
                margin-bottom: 15px;
                font-weight: 700;
            }

            .news-date {
                color: #666;
                font-size: 0.95em;
                margin-bottom: 15px;
            }

            .news-card p {
                font-size: 1.05em;
                line-height: 1.7;
                color: #555;
                margin-bottom: 20px;
            }

            .news-card strong {
                color: #007BFF;
                font-weight: 600;
            }

            .read-more-btn {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 10px;
                font-size: 1em;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .read-more-btn:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .news-grid {
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                }

                .news-card h2 {
                    font-size: 1.4em;
                }

                .news-content p {
                    font-size: 1em;
                }

                .news-content {
                    padding: 20px;
                }

                .news-card {
                    padding: 20px;
                }
            }

            /* Additional Enhancements */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
            }

            h1 {
                font-size: 2.5em;
                font-weight: 700;
                color: #333;
                margin-bottom: 30px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            /* Animations */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .news-content, .news-card {
                animation: fadeIn 0.6s ease-out;
            }
        </style>
    </head>
    <body>
        <jsp:include page="./common/header.jsp"/>
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