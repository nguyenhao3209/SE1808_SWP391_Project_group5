
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row" id="productList">
    <c:forEach var="product" items="${productsList}">
        <div class="col-md-6 col-lg-4 col-sm-6 m-b30">
            <div class="cours-bx">
                <div class="action-box">
                    <c:choose>
                        <c:when test="${product.getCategoryID().getCategoryName() ne 'Accessory'}">
                            <img src="./img/${product.getCategoryID().getCategoryName()}/${product.brand}/${product.imageURL}" alt="${product.productName}" />
                        </c:when>
                        <c:otherwise>
                            <img src="./img/${product.getCategoryID().getCategoryName()}/${product.imageURL}" alt="${product.productName}" />
                        </c:otherwise>
                    </c:choose>

                    <a href="productsDetail?id=${product.productID}" class="btn">Show Detail</a>
                </div>
                <div class="info-bx text-center">
                    <h5><a href="productsDetail?id=${product.productID}">${product.productName}</a></h5>
                    <span>${product.getCategoryID().getCategoryName()} - ${product.brand}</span>
                </div>
                <div class="cours-more-info">
                    <div class="review">
                        <span>${product.numberOfFeedbacks} Review</span>
                        <ul class="cours-star">
                            <li class="active">${product.avgRating}<i class="fa fa-star"></i></li>
                            <!--                                                            <li class="active"><i class="fa fa-star"></i></li>
                                                                                        <li class="active"><i class="fa fa-star"></i></li>
                                                                                        <li><i class="fa fa-star"></i></li>
                                                                                        <li><i class="fa fa-star"></i></li>-->
                        </ul>
                    </div>
                    <div class="price">
                        <c:if test="${product.getDiscountProduct() > 0}">
                            <del style="color: red;text-align: center;margin-right: 35px">$${String.format('%.2f', product.price)}</del> <!-- Original Price -->
                            <h5 style="color: black;text-align: center">$${String.format('%.2f', product.price * (1 - product.getDiscountProduct() / 100.0))}</h5> <!-- Discounted Price -->
                        </c:if>
                        <c:if test="${product.getDiscountProduct() <= 0}">
                            <div style="text-align: center;"> <!-- Center the regular price -->
                                <h5 style="color: black;text-align: center; margin-top: 15px">$${String.format('%.2f', product.price)}</h5> <!-- Regular Price -->
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    <div class="col-lg-12 m-b20">
        <div class="pagination-bx rounded-sm gray clearfix">
            <ul class="pagination">
                <c:if test="${pageNumber > 1}">
                    <li>
                        <a href="javascript:void(0)" data-page="${pageNumber-1}" class="pagination-link">&laquo;</a>
                    </li>
                </c:if>

                <c:forEach var="i" begin="${ totalPages < 9 ? 1 : pageNumber}" end="${pageNumber + 9 > totalPages ? totalPages : pageNumber + 9 }">
                    <li class="${i == pageNumber ? 'active' : ''}">
                        <a href="javascript:void(0)" data-page="${i}" class="pagination-link">${i}</a>
                    </li>
                </c:forEach>

                <c:if test="${pageNumber < totalPages}">
                    <li>
                        <a href="javascript:void(0)" data-page="${pageNumber+1}" class="pagination-link">&raquo;</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</div>
