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
                padding: 40px 20px;
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .news-list h1 {
                font-size: 3em;
                color: #2c3e50;
                margin-bottom: 30px;
                text-align: center;
                font-weight: 700;
                letter-spacing: -1px;
            }

            .news-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 30px;
                padding: 20px;
            }

            .news-card {
                border: 1px solid #e0e0e0;
                border-radius: 15px;
                padding: 25px;
                background-color: #ffffff;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                overflow: hidden;
            }

            .news-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            }

            .news-card img {
                width: 100%;
                border-radius: 10px;
                margin-bottom: 20px;
                transition: transform 0.3s ease;
            }

            .news-card img:hover {
                transform: scale(1.1);
            }

            .news-card h2 {
                font-size: 1.75em;
                color: #34495e;
                margin-bottom: 15px;
                font-weight: 600;
                line-height: 1.3;
            }

            .news-date {
                color: #7f8c8d;
                font-size: 0.95em;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
            }

            .news-date i {
                margin-right: 8px;
                color: #3498db;
            }

            .news-card p {
                font-size: 1em;
                line-height: 1.8;
                color: #555;
                margin-bottom: 20px;
            }

            .news-card strong {
                color: #2980b9;
            }

            .read-more-btn, .delete-btn {
                margin-top: 15px;
                display: inline-block;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-size: 1em;
                transition: background-color 0.3s ease, transform 0.3s ease;
                font-weight: 500;
            }

            .read-more-btn {
                background-color: #3498db;
                color: white;
                border: none;
                cursor: pointer;
            }

            .read-more-btn:hover {
                background-color: #2980b9;
                transform: translateY(-3px);
            }

            .delete-btn {
                background-color: #e74c3c;
                color: white;
                border: none;
                cursor: pointer;
            }

            .delete-btn:hover {
                background-color: #c0392b;
                transform: translateY(-3px);
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .news-grid {
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                }

                .news-card h2 {
                    font-size: 1.5em;
                }

                .news-card p {
                    font-size: 0.95em;
                }
            }

            /* Pagination Styles */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 30px;
                padding: 20px 0;
            }

            .pagination button {
                margin: 0 8px;
                padding: 8px 16px;
                border: 1px solid #ddd;
                background-color: #fff;
                cursor: pointer;
                border-radius: 8px;
                font-size: 1em;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .pagination button:hover {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
            }

            .pagination button.active {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
            }
        </style>
    </head>
    <body>
        <jsp:include page="./common/header.jsp"/>
        <div class="container news-list">
            <h1 class="text-center">News</h1>
            <div class="news-grid">
                <c:if test="${not empty newsList}">
                    <c:forEach var="news" items="${newsList}" varStatus="loop">
                        <div class="news-card" data-page="${Math.floor(loop.index / 9) + 1}">
                            <div class="news-card-content">
                                <h2>${news.title}</h2>
                                <span class="news-date"><i class="bi bi-calendar3"></i> ${news.publishedDate}</span>
                                <p><strong>Author:</strong> ${news.author}</p>
                                <p><strong>Email:</strong> ${news.staff.email}</p>
                                <p>${news.content}</p>
                                <img src="${news.image}" alt="${news.title}" class="img-fluid rounded">

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
            <!-- Pagination -->
            <div class="pagination" id="pagination"></div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            // Pagination Script
            document.addEventListener("DOMContentLoaded", function () {
                const newsCards = document.querySelectorAll('.news-card');
                const itemsPerPage = 6; // Đã thay đổi từ 9 thành 6
                const totalPages = Math.ceil(newsCards.length / itemsPerPage);
                const paginationContainer = document.getElementById('pagination');

                // Hiển thị bài báo của trang cụ thể
                function showPage(page) {
                    newsCards.forEach((card, index) => {
                        const cardPage = Math.floor(index / itemsPerPage) + 1;
                        if (cardPage === page) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                }

                // Tạo các nút phân trang
                function createPaginationButtons() {
                    paginationContainer.innerHTML = '';
                    for (let i = 1; i <= totalPages; i++) {
                        const button = document.createElement('button');
                        button.innerText = i;
                        button.addEventListener('click', () => {
                            showPage(i);
                            setActiveButton(button);
                        });
                        paginationContainer.appendChild(button);
                    }
                    setActiveButton(paginationContainer.firstChild);
                }

                // Đặt nút phân trang hiện tại là active
                function setActiveButton(button) {
                    const buttons = paginationContainer.querySelectorAll('button');
                    buttons.forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');
                }

                // Hiển thị trang đầu tiên khi tải trang
                showPage(1);
                createPaginationButtons();
            });
        </script>
    </body>
</html>