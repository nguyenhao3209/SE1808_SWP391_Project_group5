<%-- 
    Document   : header
    Created on : Feb 16, 2025, 6:43:29 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>  .user-avatar{
        width: 50px;
        height: 50px;
        border-radius: 25px;
    } </style>
<div id="header-wrap">

    <div class="top-content">
        <div class="container-fluid">
            <div class="row" style="display: flex">
                <div class="col-md-6">
                    <div class="social-links">
                        <ul>
                            <li>
                                <a href="#"><i class="icon icon-facebook"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="icon icon-twitter"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="icon icon-youtube-play"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="icon icon-behance-square"></i></a>
                            </li>
                        </ul>
                    </div><!--social-links-->
                </div>
                <div class="col-md-6">
                    <div class="right-element">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <!--<nav id="navbar">-->
                                <div class="main-menu stellarnav">
                                    <ul class="menu-list">
                                        <li class="menu-item has-sub">

                                            <a href="#" class="nav-link"><img class="user-avatar" src="${sessionScope.user.avatar}" alt="alt"/> ${sessionScope.user.customerName}</a>
                                            <ul>
                                                <li><a href="profile.jsp">Profile</a></li>
                                                <li><a href="change-pass.jsp">Change Password</a></li>
                                                <li><a href="logout">Logout</a></li>
                                            </ul>

                                        </li>
                                    </ul>

                                </div>
                            </c:when>   <c:otherwise>
                                <a href="login" class="user-account for-buy"><i
                                        class="icon icon-user"></i><span> Login</span></a>
                                    </c:otherwise>   </c:choose>

                    </div><!--top-right-->
                </div>

            </div>
        </div>
    </div><!--top-content-->

    <header id="header">
        <div class="container-fluid">
            <div class="row">

                <div class="col-md-2">
                    <div class="main-logo">
                        <a href="index.html"><img src="img/logo2.png" alt="logo"></a>
                    </div>

                </div>

                <div class="col-md-10">

                    <nav id="navbar">
                        <div class="main-menu stellarnav">
                            <ul class="menu-list">
                                <li class="menu-item active"><a href="home.jsp">Home</a></li>
                                <li class="menu-item has-sub">
                                    <a href="#pages" class="nav-link">Pages</a>

                                    <ul>
                                        <li class="active"><a href="home.jsp">Home</a></li>
                                        <li><a href="index.html">About</a></li>
                                        <li><a href="index.html">Styles</a></li>
                                        <li><a href="index.html">Blog</a></li>
                                        <li><a href="index.html">Post Single</a></li>
                                        <li><a href="index.html">Our Store</a></li>
                                        <li><a href="index.html">Product Single</a></li>
                                        <li><a href="index.html">Contact</a></li>
                                        <li><a href="index.html">Thank You</a></li>
                                    </ul>

                                </li>
                                <li class="menu-item"><a href="searchServlet" class="nav-link">Products</a></li>
                                <li class="menu-item"><a href="#popular-books" class="nav-link">Cart</a></li>
                                <li class="menu-item"><a href="#special-offer" class="nav-link">Voucher</a></li>
                                <li class="menu-item"><a href="#latest-blog" class="nav-link">Contact</a></li>
                                <li class="menu-item"><a href="#download-app" class="nav-link">Articles</a></li>
                            </ul>

                            <div class="hamburger">
                                <span class="bar"></span>
                                <span class="bar"></span>
                                <span class="bar"></span>
                            </div>

                        </div>
                    </nav>

                </div>

            </div>
        </div>
    </header>

</div><!--header-wrap-->
