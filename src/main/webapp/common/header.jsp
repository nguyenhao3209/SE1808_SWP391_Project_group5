<%-- 
    Document   : header
    Created on : Feb 16, 2025, 6:43:29 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<style>  .user-avatar{
        width: 50px;
        height: 50px;
        border-radius: 25px;
    } </style>
<div id="header-wrap">

    <div class="top-content p-0">
        <div class="container-fluid">
            <div class="row" style="display: flex;">
                <div class="col-md-10">
                    <div class="row">

                        <div class="col-md-2 pt-2">
                            <div class="main-logo"">
                                <a style="height: 14vh;" href="./home"><img width="100px" src="img/logo4.png" alt="logo"></a>
                            </div>

                        </div>

                        <div class="col-md-10">

                            <nav id="navbar">
                                <div class="main-menu stellarnav pt-2 pb-2">
                                    <ul class="menu-list">
                                        <li class="menu-item active"><a href="home">Home</a></li>
                                        <li class="menu-item"><a href="searchServlet" class="nav-link">Products</a></li>
                                        <li class="menu-item"><a href="cart" class="nav-link">Cart</a></li>
                                        <li class="menu-item"><a href="ViewVouchersServlet" class="nav-link">Vouchers</a></li>
                                        <li class="menu-item"><a href="contact.jsp" class="nav-link">Contact</a></li>
                                        <li class="menu-item"><a href="news-list" class="nav-link">Articles</a></li>
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
                <div class="col-md-2">
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
                                                <li><a href="HistoryServlet">History</a></li>
                                                <li><a href="change-pass.jsp">Change Password</a></li>
                                                <li><a href="logout">Logout</a></li>
                                            </ul>

                                        </li>
                                    </ul>

                                </div>
                            </c:when>   <c:otherwise>
                                <div class="main-menu stellarnav pt-3">
                                    <a href="login" class="user-account for-buy"><i
                                            class="icon icon-user"></i><span> Login</span></a>
                                </div>

                            </c:otherwise>   </c:choose>

                    </div><!--top-right-->
                </div>

            </div>
        </div>
    </div><!--top-content-->
</div><!--header-wrap-->
