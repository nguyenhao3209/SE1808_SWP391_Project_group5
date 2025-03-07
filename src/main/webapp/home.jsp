
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

                        <div class="main-slider pattern-overlay">
                            <c:forEach var="slide" items="${sessionScope.slides}">
                                <div class="slider-item position-relative">
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
        </section>


        <section id="client-holder" data-aos="fade-up">
            <div class="container">
                <div class="row">
                    <div class="inner-content">
                        <div class="logo-wrap">
                            <div class="grid">
                                <a href="#"><img src="images/client-image1.png" alt="client"></a>
                                <a href="#"><img src="images/client-image2.png" alt="client"></a>
                                <a href="#"><img src="images/client-image3.png" alt="client"></a>
                                <a href="#"><img src="images/client-image4.png" alt="client"></a>
                                <a href="#"><img src="images/client-image5.png" alt="client"></a>
                            </div>
                        </div><!--image-holder-->
                    </div>
                </div>
            </div>
        </section>

        <section id="featured-books" class="py-5 my-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">

                        <div class="section-header align-center">
                            <div class="title">
                                <span>Some quality items</span>
                            </div>
                            <h2 class="section-title">Featured Books</h2>
                        </div>

                        <div class="product-list" data-aos="fade-up">
                            <div class="row">

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/product-item1.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Simple way of piece life</h3>
                                            <span>Armor Ramsey</span>
                                            <div class="item-price">$ 40.00</div>
                                        </figcaption>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/product-item2.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Great travel at desert</h3>
                                            <span>Sanchit Howdy</span>
                                            <div class="item-price">$ 38.00</div>
                                        </figcaption>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/product-item3.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>The lady beauty Scarlett</h3>
                                            <span>Arthur Doyle</span>
                                            <div class="item-price">$ 45.00</div>
                                        </figcaption>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="product-item">
                                        <figure class="product-style">
                                            <img src="images/product-item4.jpg" alt="Books" class="product-item">
                                            <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                                Cart</button>
                                        </figure>
                                        <figcaption>
                                            <h3>Once upon a time</h3>
                                            <span>Klien Marry</span>
                                            <div class="item-price">$ 35.00</div>
                                        </figcaption>
                                    </div>
                                </div>

                            </div><!--ft-books-slider-->
                        </div><!--grid-->


                    </div><!--inner-content-->
                </div>

                <div class="row">
                    <div class="col-md-12">

                        <div class="btn-wrap align-right">
                            <a href="#" class="btn-accent-arrow">View all products <i
                                    class="icon icon-ns-arrow-right"></i></a>
                        </div>

                    </div>
                </div>
            </div>
        </section>

        <section id="best-selling" class="leaf-pattern-overlay">
            <div class="corner-pattern-overlay"></div>
            <div class="container">
                <div class="row justify-content-center">

                    <div class="col-md-8">

                        <div class="row">

                            <div class="col-md-6">
                                <figure class="products-thumb">
                                    <img src="images/single-image.jpg" alt="book" class="single-image">
                                </figure>
                            </div>

                            <div class="col-md-6">
                                <div class="product-entry">
                                    <h2 class="section-title divider">Best Selling Book</h2>

                                    <div class="products-content">
                                        <div class="author-name">By Timbur Hood</div>
                                        <h3 class="item-title">Birds gonna be happy</h3>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu feugiat amet,
                                            libero ipsum enim pharetra hac.</p>
                                        <div class="item-price">$ 45.00</div>
                                        <div class="btn-wrap">
                                            <a href="#" class="btn-accent-arrow">shop it now <i
                                                    class="icon icon-ns-arrow-right"></i></a>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                        <!-- / row -->

                    </div>

                </div>
            </div>
        </section>

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
                                                                <img src="./img/${product[6]}/${product[4]}" alt="Product" class="product-item img-fluid">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="./img/${product[6]}/${product[3]}/${product[4]}" alt="Product" class="product-item img-fluid">
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <!-- Giá sale ở góc phải trên -->
                                                        <c:if test="${not empty product[5] and product[5] != '0'}">
                                                            <span class="badge bg-danger position-absolute top-0 end-0 m-2 sale-badge px-10 py-10 fs-6 fw-bold rounded-pill">-${product[5]}%</span>
                                                        </c:if>
                                                        <button type="button" class="add-to-cart btn btn-primary mt-2">Add to Cart</button>
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

        <section id="quotation" class="align-center pb-5 mb-5">
            <div class="inner-content">
                <h2 class="section-title divider">Quote of the day</h2>
                <blockquote data-aos="fade-up">
                    <q>?The more that you read, the more things you will know. The more that you learn, the more places
                        you?ll go.?</q>
                    <div class="author-name">Dr. Seuss</div>
                </blockquote>
            </div>
        </section>

        <section id="special-offer" class="bookshelf pb-5 mb-5">

            <div class="section-header align-center">
                <div class="title">
                    <span>Grab your opportunity</span>
                </div>
                <h2 class="section-title">Books with offer</h2>
            </div>

            <div class="container">
                <div class="row">
                    <div class="inner-content">
                        <div class="product-list" data-aos="fade-up">
                            <div class="grid product-grid">
                                <div class="product-item">
                                    <figure class="product-style">
                                        <img src="images/product-item5.jpg" alt="Books" class="product-item">
                                        <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                            Cart</button>
                                    </figure>
                                    <figcaption>
                                        <h3>Simple way of piece life</h3>
                                        <span>Armor Ramsey</span>
                                        <div class="item-price">
                                            <span class="prev-price">$ 50.00</span>$ 40.00
                                        </div>
                                </div>
                                </figcaption>

                                <div class="product-item">
                                    <figure class="product-style">
                                        <img src="images/product-item6.jpg" alt="Books" class="product-item">
                                        <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                            Cart</button>
                                    </figure>
                                    <figcaption>
                                        <h3>Great travel at desert</h3>
                                        <span>Sanchit Howdy</span>
                                        <div class="item-price">
                                            <span class="prev-price">$ 30.00</span>$ 38.00
                                        </div>
                                </div>
                                </figcaption>

                                <div class="product-item">
                                    <figure class="product-style">
                                        <img src="images/product-item7.jpg" alt="Books" class="product-item">
                                        <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                            Cart</button>
                                    </figure>
                                    <figcaption>
                                        <h3>The lady beauty Scarlett</h3>
                                        <span>Arthur Doyle</span>
                                        <div class="item-price">
                                            <span class="prev-price">$ 35.00</span>$ 45.00
                                        </div>
                                </div>
                                </figcaption>

                                <div class="product-item">
                                    <figure class="product-style">
                                        <img src="images/product-item8.jpg" alt="Books" class="product-item">
                                        <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                            Cart</button>
                                    </figure>
                                    <figcaption>
                                        <h3>Once upon a time</h3>
                                        <span>Klien Marry</span>
                                        <div class="item-price">
                                            <span class="prev-price">$ 25.00</span>$ 35.00
                                        </div>
                                </div>
                                </figcaption>

                                <div class="product-item">
                                    <figure class="product-style">
                                        <img src="images/product-item2.jpg" alt="Books" class="product-item">
                                        <button type="button" class="add-to-cart" data-product-tile="add-to-cart">Add to
                                            Cart</button>
                                    </figure>
                                    <figcaption>
                                        <h3>Simple way of piece life</h3>
                                        <span>Armor Ramsey</span>
                                        <div class="item-price">$ 40.00</div>
                                    </figcaption>
                                </div>
                            </div><!--grid-->
                        </div>
                    </div><!--inner-content-->
                </div>
            </div>
        </section>

        <section id="subscribe">
            <div class="container">
                <div class="row justify-content-center">

                    <div class="col-md-8">
                        <div class="row">

                            <div class="col-md-6">

                                <div class="title-element">
                                    <h2 class="section-title divider">Subscribe to our newsletter</h2>
                                </div>

                            </div>
                            <div class="col-md-6">

                                <div class="subscribe-content" data-aos="fade-up">
                                    <p>Sed eu feugiat amet, libero ipsum enim pharetra hac dolor sit amet, consectetur. Elit
                                        adipiscing enim pharetra hac.</p>
                                    <form id="form">
                                        <input type="text" name="email" placeholder="Enter your email addresss here">
                                        <button class="btn-subscribe">
                                            <span>send</span>
                                            <i class="icon icon-send"></i>
                                        </button>
                                    </form>
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
                                            <img src="${news.image}" alt="${news.title}" class="card-img-top img-fluid rounded">
                                            <div class="card-body d-flex flex-column">
                                                <p class="card-text"><strong><i class="bi bi-person-circle"></i> Author:</strong> ${news.author}</p>
                                                <p class="card-text"><strong><i class="bi bi-envelope"></i> Email:</strong> ${news.staff.email}</p>
                                                <p class="card-text"><strong><i class="bi bi-calendar"></i> Published on:</strong> ${news.publishedDate}</p>
                                                <h3 class="card-title">${news.title}</h3>
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

        <section id="download-app" class="leaf-pattern-overlay">
            <div class="corner-pattern-overlay"></div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="row">

                            <div class="col-md-5">
                                <figure>
                                    <img src="images/device.png" alt="phone" class="single-image">
                                </figure>
                            </div>

                            <div class="col-md-7">
                                <div class="app-info">
                                    <h2 class="section-title divider">Download our app now !</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis sed ptibus
                                        liberolectus nonet psryroin. Amet sed lorem posuere sit iaculis amet, ac urna.
                                        Adipiscing fames semper erat ac in suspendisse iaculis.</p>
                                    <div class="google-app">
                                        <img src="images/google-play.jpg" alt="google play">
                                        <img src="images/app-store.jpg" alt="app store">
                                    </div>
                                </div>
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