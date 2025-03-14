
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <title>SEEW HUB</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="format-detection" content="telephone=no">
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="author" content="">
        <meta name="keywords" content="">
        <meta name="description" content="">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">


    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

        <jsp:include page="common/header.jsp"/>

        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

        <section id="billboard">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 position-relative">
                        <button class="prev slick-arrow">
                            <i class="icon icon-arrow-left"></i>
                        </button>

                        <div style="height: 80vh;" class="main-slider pattern-overlay">
                            <c:forEach var="slide" items="${sessionScope.slides}">
                                <div style="height: 60vh;" class="slider-item position-relative">
                                    <img src="img/Slider/${slide.imageURL}" alt="banner" class="banner-image" 
                                         style="height: 60vh; width: 100%; object-fit: cover; border-radius: 10px;">


                                    <div class="banner-content position-absolute top-50 start-50 translate-middle text-center text-white p-3"
                                         style="background: rgba(0, 0, 0, 0.5); border-radius: 10px; width: 80%; height: 75vh;">
                                        <h2 style="color: #00FFFFFF" class="banner-title">${slide.product.productName}</h2>

                                        <p>
                                            <c:choose>
                                                <c:when test="${fn:length(slide.product.description) > 100}">
                                                    ${fn:substring(slide.product.description, 0, 500)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${slide.product.description}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>

                                        <div class="btn-wrap">
                                            <a href="productDetails?id=${slide.product.productID}" class="btn btn-outline-light border-light">
                                                Read More <i class="icon icon-ns-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div><!-- banner-content -->
                                </div><!-- slider-item -->
                            </c:forEach>
                        </div><!-- slider -->

                        <button class="next slick-arrow">
                            <i class="icon icon-arrow-right"></i>
                        </button>
                    </div>
                </div>
            </div>

            <section id="popular-books" class="bookshelf py-5 my-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">

                            <div class="section-header align-center">
                                <div class="title">
                                    <span>Some Product Sale</span>
                                </div>
                                <h2 class="section-title">Sale Product</h2>
                            </div>

                            <ul class="tabs">
                                <li data-category-id="1" class="tab ${sessionScope.check_click_category == '1' ? 'active' : ''}">Racket</li>
                                <li data-category-id="2" class="tab ${sessionScope.check_click_category == '2' ? 'active' : ''}">Shoes</li>
                                <li data-category-id="3" class="tab ${sessionScope.check_click_category == '3' ? 'active' : ''}">Clothes</li>
                                <li data-category-id="4" class="tab ${sessionScope.check_click_category == '4' ? 'active' : ''}">Bag</li>
                                <li data-category-id="5" class="tab ${sessionScope.check_click_category == '5' ? 'active' : ''}">Accessory</li>
                            </ul>

                            <div class="tab-content">
                                <div id="product-list">
                                    <div class="row">
                                        <c:forEach var="product" items="${sessionScope.saleList}">
                                            <c:if test="${product[7] == sessionScope.check_click_category}">
                                                <div class="col-md-3">
                                                    <div class="product-item position-relative">
                                                        <figure class="product-style">
                                                            <c:choose>
                                                                <c:when test="${sessionScope.check_click_category == '5'}">
                                                                    <img style="height: 40vh;" src="./img/${product[6]}/${product[4]}" alt="Product" class="product-item img-fluid">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img style="height: 40vh;" src="./img/${product[6]}/${product[3]}/${product[4]}" alt="Product" class="product-item img-fluid">
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <!-- Giá sale ở góc phải trên -->
                                                            <c:if test="${not empty product[5] and product[5] != '0'}">
                                                                <span class="badge bg-danger position-absolute top-0 end-0 m-2 sale-badge px-10 py-10 fs-6 fw-bold rounded-pill">
                                                                    -${product[5]}%
                                                                </span>
                                                            </c:if>
                                                            <a href="./productDetails?id=${product[0]}" class="btn btn-primary mt-2">View Details</a>
                                                        </figure>
                                                        <figcaption>
                                                            <h3>${product[1]}</h3>
                                                            <c:if test="${sessionScope.check_click_category != '5'}">
                                                                <span>${product[3]}</span>
                                                            </c:if>
                                                            <div class="item-price">
                                                                <c:choose>
                                                                    <c:when test="${not empty product[5] and product[5] != '0'}">
                                                                        <span class="original-price text-decoration-line-through text-muted">${product[2]}$</span>
                                                                        <span class="discounted-price text-danger fw-bold">
                                                                            <c:set var="discountedPrice" value="${product[2] - (product[2] * product[5] / 100)}" />
                                                                            <fmt:formatNumber value="${discountedPrice}" type="number" minFractionDigits="2" />$
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="discounted-price">${product[2]}$</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </figcaption>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section id="latest-blog" class="py-5 my-5">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="section-header align-center">
                                <div class="title">
                                    <span>Read our articles</span>
                                </div>
                                <h2 class="section-title">Latest Articles</h2>
                            </div>

                            <div class="row">
                                <c:if test="${not empty sessionScope.newsList}">
                                    <c:forEach var="news" items="${sessionScope.newsList}" varStatus="loop" begin="0" end="2">
                                        <div class="col-md-4 d-flex align-items-stretch">
                                            <div class="news-card card mb-4 shadow-sm">
                                                <img style="height: 30vh;" src="${news.image}" alt="${news.title}" class="card-img-top img-fluid rounded">
                                                <div class="card-body d-flex flex-column">
                                                    <p class="card-text mb-2"><strong><i class="bi bi-person-circle"></i> Author:</strong> ${news.author}</p>
                                                    <p class="card-text mb-2"><strong><i class="bi bi-envelope"></i> Email:</strong> ${news.staff.email}</p>
                                                    <p class="card-text mb-2"><strong><i class="bi bi-calendar"></i> Published on:</strong> ${news.publishedDate}</p>
                                                    <h3 class="card-title mb-2">${news.title}</h3>
                                                    <span class="news-date mb-3">

                                                    </span>
                                                    <a href="news-list?action=view&id=${news.newsID}" class="btn read-more-btn btn-primary mt-auto">
                                                        <i class="bi bi-book"></i> Read More
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty newsList}">
                                    <p class="text-center">No news available.</p>
                                </c:if>
                            </div>

                            <div class="row">
                                <div class="btn-wrap align-center">
                                    <a href="news-list" class="btn btn-outline-accent btn-accent-arrow" tabindex="0">
                                        Read All Articles <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </section>

            <jsp:include page="common/footer.jsp"/>
            <script src="js/jquery-1.11.0.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"></script>
            <script src="js/plugins.js"></script>
            <script src="js/script.js"></script>
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    document.querySelectorAll(".tabs li").forEach(tab => {
                        tab.addEventListener("click", function () {
                            let categoryID = this.getAttribute("data-category-id");

                            // Cập nhật class active
                            document.querySelectorAll(".tabs li").forEach(item => item.classList.remove("active"));
                            this.classList.add("active");

                            // Gửi AJAX request lấy sản phẩm mới
                            fetch("home?categoryID=" + categoryID)
                                    .then(response => response.text())
                                    .then(data => {
                                        let parser = new DOMParser();
                                        let doc = parser.parseFromString(data, "text/html");
                                        let newProducts = doc.querySelector("#product-list").innerHTML;
                                        document.getElementById("product-list").innerHTML = newProducts;
                                    })
                                    .catch(error => console.error("Lỗi tải dữ liệu:", error));
                        });
                    });
                });
            </script>

    </body>

</html>