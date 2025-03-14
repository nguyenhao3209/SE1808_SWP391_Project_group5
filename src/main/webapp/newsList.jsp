<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Sports News List</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" rel="stylesheet">
        <!-- Thư viện Font Awesome để sử dụng các icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/iconHome.webp" />
        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        <!-- Custom Styles -->
        <style>
            /* Custom Styles for Sports News List Page */
            .news-list {
                padding: 40px 20px;
                background: linear-gradient(135deg, #f8f9fa, #e9ecef);
                min-height: 100vh;
            }

            .news-list h1 {
                font-size: 3.5em;
                color: #2c3e50;
                margin-bottom: 30px;
                text-align: center;
                font-weight: 900;
                letter-spacing: -1px;
                text-transform: uppercase;
                background: linear-gradient(135deg, #3498db, #2ecc71);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
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
                position: relative;
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
                font-weight: 700;
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
                background-color: #2ecc71;
                color: white;
                border: none;
                cursor: pointer;
            }

            .read-more-btn:hover {
                background-color: #27ae60;
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
            }

            .pagination button {
                margin: 0 5px;
                padding: 0 12px;
                border: 1px solid #ccc;
                color: #333;
                cursor: pointer;
                border-radius: 4px;
            }

            .pagination button.active {
                color: #fff;
                border-color: #007bff;
            }



            .news-card-content {
                display: flex;
                flex-direction: column;
                height: 100%;
            }

            .news-card-content p,
            .news-card-content h2,
            .news-card-content .news-date {
                flex-grow: 1;
            }

            .read-more-btn {
                margin-top: auto;
            }

            /* Sports Icon */
            .sports-icon {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 1.5em;
                color: #2ecc71;
            }
        </style>
    </head>
    <body>
        <jsp:include page="./common/header.jsp"/>
        <div class="container news-list mt-5">
            <h1 class="text-center">Sports ARTICLES</h1>
            <div class="news-grid">
                <c:if test="${not empty sessionScope.newsList}">
                    <c:forEach var="news" items="${sessionScope.newsList}" varStatus="loop">
                        <div class="news-card" data-page="${Math.floor(loop.index / 9) + 1}">
                            <div class="news-card-content">
                                <i class="bi bi-trophy sports-icon"></i>
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
        <jsp:include page="common/footer.jsp"/>
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
        <script>
            // Pagination Script
            document.addEventListener("DOMContentLoaded", function () {
                const newsCards = document.querySelectorAll('.news-card');
                const itemsPerPage = 6;
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