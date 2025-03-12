<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>News Management</title>
        <link rel="stylesheet" href="assets/css/style.css"> <!-- Thay thế CSS của template -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />
        <base href="${pageContext.request.contextPath}/">
        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/images/favicon.png" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>EduChamp : Education HTML Template </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/assets.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/vendors/calendar/fullcalendar.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="admin/assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="admin/assets/css/dashboard.css">
        <link class="skin" rel="stylesheet" type="text/css" href="admin/assets/css/color/color-1.css">  

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
                position: relative;
            }

            .news-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
            }

            .news-card img {
                width: 100%;
                border-radius: 10px;
                margin-bottom: 15px;
                transition: transform 0.3s ease;
            }

            .news-card img:hover {
                transform: scale(1.1);
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

            .read-more-btn, .delete-btn, .edit-btn {
                margin-top: 10px;
                display: inline-block;
                padding: 8px 16px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 0.9em;
                transition: background-color 0.3s ease, transform 0.3s ease;
            }

            .read-more-btn {
                background-color: #28a745; /* Green */
                color: white;
                border: none;
                cursor: pointer;
            }

            .read-more-btn:hover {
                background-color: #218838;
                transform: translateY(-2px);
            }

            .delete-btn {
                background-color: #dc3545; /* Red */
                color: white;
                border: none;
                cursor: pointer;
            }

            .delete-btn:hover {
                background-color: #c82333;
                transform: translateY(-2px);
            }

            .edit-btn {
                background-color: #ffc107; /* Yellow */
                color: white;
                border: none;
                cursor: pointer;
            }

            .edit-btn:hover {
                background-color: #e0a800;
                transform: translateY(-2px);
            }

            .btn-primary {
                background-color: #007bff; /* Blue */
                color: white;
                border: none;
                cursor: pointer;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }

            .sport-icon {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 24px;
                color: #ff5722; /* Màu cam thể thao */
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

            /* Pagination Styles */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination button {
                margin: 0 5px;
                padding: 5px 10px;
                border: 1px solid #ddd;
                background-color: #fff;
                cursor: pointer;
            }

            .pagination button.active {
                background-color: #007bff;
                color: #fff;
                border-color: #007bff;
            }
            .news-card-actions {
                position: absolute;
                bottom: 20px;
                left: 20px;
                right: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px;
                background-color: #ffffff;
                border-top: 1px solid #e0e0e0;
                border-radius: 0 0 15px 15px;
                box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
            }

            .news-card {
                position: relative;
                padding-bottom: 80px; /* Đảm bảo có đủ không gian cho các nút */
            }

            .news-card-content {
                margin-bottom: 80px; /* Đảm bảo nội dung không bị che bởi các nút */
            }
        </style>
    </head>

    <body class="ttr-opened-sidebar ttr-pinned-sidebar">
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
            <!-- header end -->
            <!-- Left sidebar menu start -->
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>
            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">News Management</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>List News</li>
                        </ul>
                    </div>
                </div>
                <div class="container news-list">
                    <h1 class="text-center">News</h1>
                    <div class="news-grid">
                    <c:if test="${not empty newsList}">
                        <c:forEach var="news" items="${newsList}" varStatus="loop">
                            <div class="news-card" data-page="${Math.floor(loop.index / 6) + 1}">
                                <div class="news-card-content">
                                    <h2>${news.title}</h2>
                                    <span class="news-date"><i class="fas fa-calendar-alt"></i> ${news.publishedDate}</span>
                                    <p><strong>Author:</strong> ${news.author}</p>
                                    <p><strong>Email:</strong> ${news.staff.email}</p>
                                    <p>${news.content}</p>
                                    <img src="${news.image}" alt="${news.title}" class="img-fluid rounded">
                                    <i class="fas fa-futbol sport-icon"></i> <!-- Biểu tượng thể thao -->

                                    <!-- Action Buttons -->
                                    <div class="news-card-actions">
                                        <a href="news-management?action=view&id=${news.newsID}" class="btn read-more-btn">
                                            <i class="fas fa-book-open"></i> Read More
                                        </a>
                                            <a href="update-news?id=${news.newsID}" class="btn edit-btn">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <a href="delete-news?id=${news.newsID}" class="btn delete-btn" onclick="return confirmDelete()">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </a>
                                    </div>
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
        </main>
        <!-- Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <!-- External JavaScripts -->
        <script src="admin/assets/js/jquery.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="admin/assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="admin/assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="admin/assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="admin/assets/vendors/counter/waypoints-min.js"></script>
        <script src="admin/assets/vendors/counter/counterup.min.js"></script>
        <script src="admin/assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="admin/assets/vendors/masonry/masonry.js"></script>
        <script src="admin/assets/vendors/masonry/filter.js"></script>
        <script src="admin/assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="admin/assets/vendors/scroll/scrollbar.min.js"></script>
        <script src="admin/assets/js/functions.js"></script>
        <script src="admin/assets/vendors/chart/chart.min.js"></script>
        <script src="admin/assets/js/admin.js"></script>
        <script src="admin/assets/vendors/calendar/moment.min.js"></script>
        <script src="admin/assets/vendors/calendar/fullcalendar.js"></script>
        <script src="admin/assets/vendors/switcher/switcher.js"></script>
        <script>
            function confirmDelete() {
                return confirm("Do you want to delete this news?");
            }

            function confirmUpdate() {
                return confirm("Do you want to update this news?");
            }

            // Pagination Script
            document.addEventListener("DOMContentLoaded", function () {
                const newsCards = document.querySelectorAll('.news-card');
                const itemsPerPage = 6;
                const totalPages = Math.ceil(newsCards.length / itemsPerPage);
                const paginationContainer = document.getElementById('pagination');

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

                function setActiveButton(button) {
                    const buttons = paginationContainer.querySelectorAll('button');
                    buttons.forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');
                }

                showPage(1);
                createPaginationButtons();
            });
        </script>
    </body>
</html>