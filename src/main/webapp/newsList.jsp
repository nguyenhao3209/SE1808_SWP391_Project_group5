<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

    <head>
        <title>News List</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css">
        <!-- Custom Styles -->
        <style>
            /* Custom Styles for News List Page */
            .news-list {
                padding: 20px;
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .news-list h1 {
                font-size: 2.5em;
                color: #333;
                margin-bottom: 20px;
                text-align: center;
                font-weight: bold;
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
                font-weight: bold;
            }

            .news-date {
                color: #666;
                font-size: 0.9em;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .news-date i {
                margin-right: 5px;
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
                border: none;
                cursor: pointer;
            }

            .read-more-btn:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }

            .delete-btn {
                background-color: #dc3545;
                color: white;
                border: none;
                cursor: pointer;
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

                .news-card p {
                    font-size: 0.9em;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="./common/header.jsp"/>
        <div class="container news-list">
            <h1 class="text-center">News</h1>
            <div class="news-grid">
                <c:if test="${not empty newsList}">
                    <c:forEach var="news" items="${newsList}">
                        <div class="news-card">
                            <div class="news-card-content">
                                <h2>${news.title}</h2>
                                <span class="news-date"><i class="bi bi-calendar3"></i> ${news.publishedDate}</span>
                                <p><strong>Author:</strong> ${news.author}</p>
                                <p><strong>Email:</strong> ${news.staff.email}</p>
                                <p>${news.content}</p>
                                <img src="${news.image}" alt="${news.title}" class="img-fluid rounded">

                                <!-- Check if the user is ADMIN -->


                                <!-- Read More link with icon -->
                                <a href="news-list?action=view&id=${news.newsID}" class="btn read-more-btn">
                                    <i class="bi bi-book"></i> Read More
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty newsList}">
                    <p>No news available.</p>
                </c:if>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    </body>
</html>