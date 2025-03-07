<%-- Document : sidebar Created on : Sep 22, 2024, 6:36:55 PM Author : Admin --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="ttr-sidebar">
    <div class="ttr-sidebar-wrapper content-scroll">
        <!-- side menu logo start -->
        <div class="ttr-sidebar-logo">
            <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
            <div class="ttr-sidebar-toggle-button">
                <i class="ti-arrow-left"></i>
            </div>
        </div>
        <!-- side menu logo end -->

        <!-- sidebar menu start -->
        <nav class="ttr-sidebar-navi">
            <ul>
                <li>
                    <a href="dashboard" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-home"></i></span>
                        <span class="ttr-label">Dashboard</span>
                    </a>
                </li>
                 <li>
                    <a href="contact-list" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-email"></i></span>
                        <span class="ttr-label">Contact</span>
                    </a>
                </li>
                <li>
                    <a href="admin/review.jsp" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-comments"></i></span>
                        <span class="ttr-label">Review</span>
                    </a>
                </li>
                <li>
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-user"></i></span>
                        <span class="ttr-label">My Profile</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="admin/user-profile.jsp" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
                        </li>
                        <li>
                            <a href="admin/user-profile.jsp" class="ttr-material-button"><span class="ttr-label">User Profile</span></a>
                        </li>
                    </ul>
                </li>

                <li>
                    <a href="OrdersServlet" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-comments"></i></span>
                        <span class="ttr-label">Orders Management</span>
                    </a>
                </li>
                <li>
                    <a href="admin" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-comments"></i></span>
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
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-user"></i></span>
                        <span class="ttr-label">Stock Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="viewImported" class="ttr-material-button"><span class="ttr-label">Imported Invoices</span></a>
                        </li>
                        <li>
                            <a href="admin/stock_import.jsp" class="ttr-material-button"><span class="ttr-label">Stock In</span></a>
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
                            <a href="admin/voucher-form.jsp" class="ttr-material-button"><span class="ttr-label">Add Voucher</span></a>
                        </li>
                        <li>
                            <a href="VoucherServlet?action=list" class="ttr-material-button"><span class="ttr-label">List Voucher</span></a>
                        </li>
                    </ul>
                </li


                <li>
                    <a href="#" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-user"></i></span>
                        <span class="ttr-label">News Management</span>
                        <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                    </a>
                    <ul>
                        <li>
                            <a href="news-management" class="ttr-material-button"><span class="ttr-label">List News</span></a>
                        </li>
                    </ul>
                </li>
                 <li>
                    <a href="CategoryServlet?action=list" class="ttr-material-button">
                        <span class="ttr-icon"><i class="ti-gift"></i></span>
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
                </li
                <li class="ttr-seperate"></li>
            </ul>
            <!-- sidebar menu end -->
        </nav>
        <!-- sidebar menu end -->
    </div>
</div>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>


            <div class="ttr-sidebar">
                <div class="ttr-sidebar-wrapper content-scroll">
                    <!-- side menu logo start -->
                    <div class="ttr-sidebar-logo">
                        <a href="#"><img alt="" src="assets/images/logo.png" width="122" height="27"></a>
                        <div class="ttr-sidebar-toggle-button">
                            <i class="ti-arrow-left"></i>
                        </div>
                    </div>
                    <!-- side menu logo end -->
                    <!-- sidebar menu start -->
                    <nav class="ttr-sidebar-navi">
                        <ul>
                            <li>
                                <a href="dashboard" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-home"></i></span>
                                    <span class="ttr-label">Dashboard</span>
                                </a>
                            </li>
                            <li>
                                <a href="contact-list" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-email"></i></span>
                                    <span class="ttr-label">Contact</span>
                                </a>
                            </li>
                            <li>
                                <a href="admin/review.jsp" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-comments"></i></span>
                                    <span class="ttr-label">Review</span>
                                </a>
                            </li>
                            <li>
                                <a href="" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-user"></i></span>
                                    <span class="ttr-label">My Profile</span>
                                    <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                                </a>
                                <ul>
                                    <li>
                                        <a href="admin/user-profile.jsp" class="ttr-material-button"><span
                                                class="ttr-label">User Profile</span></a>
                                    </li>
                                    <li>
                                        <a href="admin/user-profile.jsp" class="ttr-material-button"><span
                                                class="ttr-label">User Profile</span></a>
                                    </li>
                                </ul>
                            </li>

                            <li>
                                <a href="OrdersServlet" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-comments"></i></span>
                                    <span class="ttr-label">Orders Management</span>
                                </a>
                            </li>
                            <li>
                                <a href="admin" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-comments"></i></span>
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
                                            <a href="admin/addStaff.jsp" class="ttr-material-button"><span
                                                    class="ttr-label">Add Staff</span></a>
                                        </li>
                                        <li>
                                            <a href="listStaffs" class="ttr-material-button"><span
                                                    class="ttr-label">Staffs List</span></a>
                                        </li>
                                    </ul>
                                </li>
                            </c:if>
                            <li>
                                <a href="" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-user"></i></span>
                                    <span class="ttr-label">Stock Management</span>
                                    <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                                </a>
                                <ul>
                                    <li>
                                        <a href="viewStockProducts" class="ttr-material-button"><span
                                                class="ttr-label">View Stock Products</span></a>
                                    </li>

                                    <li>
                                        <a href="viewImported" class="ttr-material-button"><span
                                                class="ttr-label">Imported Invoices</span></a>
                                    </li>
                                    <li>
                                        <a href="viewImported" class="ttr-material-button"><span
                                                class="ttr-label">Imported Invoices</span></a>
                                    </li>
                                    <li>
                                        <a href="admin/stock_import.jsp" class="ttr-material-button"><span
                                                class="ttr-label">Stock Import</span></a>
                                    </li>
                                    <li>
                                        <a href="admin/stock_import_excel.jsp" class="ttr-material-button"><span
                                                class="ttr-label">Stock Import From Excel</span></a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#" class="ttr-material-button">
                                    <span class="ttr-icon"><i class="ti-user"></i></span>
                                    <span class="ttr-label">News Management</span>
                                    <span class="ttr-arrow-icon"><i class="fa fa-angle-down"></i></span>
                                </a>
                                <ul>
                                    <li>
                                        <a href="news-management" class="ttr-material-button"><span
                                                class="ttr-label">List News</span></a>
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
