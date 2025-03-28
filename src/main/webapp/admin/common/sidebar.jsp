<%-- Document : sidebar Created on : Sep 22, 2024, 6:36:55 PM Author : Admin --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<div class="ttr-sidebar">
    <div class="ttr-sidebar-wrapper content-scroll">
        <!-- side menu logo start -->
        <div class="ttr-sidebar-logo">
            <a class="m-1" href="./dashboard"><img alt="" src="img/logoItem.jpg" width="122"></a>
            <div class="ttr-sidebar-toggle-button">
                <i class="ti-arrow-left"></i>
            </div>
        </div>
        <!-- side menu logo end -->
        <!-- sidebar menu start -->
        <nav class="ttr-sidebar-navi">
            <ul>
                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                    <li>
                        <a href="dashboard" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-home"></i></span>
                            <span class="ttr-label">Dashboard</span>
                        </a>
                    </li>
                </c:if>
                <li>
                    <a href="contact-list" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-email"></i></span>
                        <span class="ttr-label">Contact</span>
                    </a>
                </li>

                <li>
                    <a href="OrdersServlet" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-shopping-cart"></i></span>
                        <span class="ttr-label">Orders Management</span>
                    </a>
                </li>
                <li>
                    <a href="admin" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-user"></i></span>
                        <span class="ttr-label">Customers Management</span>
                    </a>
                </li>
                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                    <li>
                        <a href="#" class="ttr-material-button">
                            <span class="ttr-icon"><i class="ti-user"></i></span>
                            <span class="ttr-label">Staffs Management</span>
                            <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul>
                            <li>
                                <a href="admin/addStaff.jsp" class="ttr-material-button"><span class="ttr-label">Add Staff</span></a>
                            </li>
                            <li>
                                <a href="listStaffs" class="ttr-material-button"><span class="ttr-label">Staffs List</span></a>
                            </li>
                        </ul>
                    </li>
                </c:if>
                <li>
                    <a href="" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-package"></i></span>
                        <span class="ttr-label">Stock Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="viewStockProducts" class="ttr-material-button"><span
                                    class="ttr-label">Stock Products</span></a>
                        </li>
                        <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                            <li>
                                <a href="viewImported" class="ttr-material-button"><span
                                        class="ttr-label">Imported Invoices</span></a>
                            </li> 
                        </c:if>
                        <li>
                            <a href="admin/stock_import.jsp" class="ttr-material-button"><span
                                    class="ttr-label">Inventory In.</span></a>
                        </li>
                        <li>
                            <a href="admin/stock_import_excel.jsp" class="ttr-material-button"><span
                                    class="ttr-label">Inventory In. From Excel</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-archive"></i></span>
                        <span class="ttr-label">Products Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="listProducts" class="ttr-material-button"><span
                                    class="ttr-label">Products List</span></a>
                        </li>

                        <li>
                            <a href="admin/addProduct.jsp" class="ttr-material-button"><span
                                    class="ttr-label">Add Product</span></a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="CategoryServlet?action=list" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-tag"></i></span>
                        <span class="ttr-label">Category Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>

                    </a>
                    <ul>
                        <li>
                            <a href="admin/category-form.jsp" class="ttr-material-button"><span class="ttr-label">Add Category</span></a>
                        </li>
                        <li>
                            <a href="CategoryServlet?action=list" class="ttr-material-button"><span class="ttr-label">List Category</span></a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="VoucherServlet?action=list" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-gift"></i></span>
                        <span class="ttr-label">Voucher Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>

                    </a>
                    <ul>
                        <li>
                            <a href="VoucherServlet?action=list" class="ttr-material-button"><span class="ttr-label">Voucher List</span></a>
                        </li>
                        <li>
                            <a href="admin/voucher-form.jsp" class="ttr-material-button"><span class="ttr-label">Add Voucher</span></a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-book"></i></span>
                        <span class="ttr-label">News Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="news-management" class="ttr-material-button"><span class="ttr-label">News List</span></a>
                        </li>
                        <li>
                            <a href="add-news" class="ttr-material-button"><span class="ttr-label">Add News</span></a>
                        </li>
                    </ul>
                </li>

                <li class="ttr-seperate"></li>

            </ul>
            <!-- sidebar menu end -->
        </nav>
        <!-- sidebar menu end -->
    </div>
</div>