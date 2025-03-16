<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox-read.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:45 GMT -->
    <head>

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

    </head>
    <body class="ttr-opened-sidebar ttr-pinned-sidebar">

        <!-- header start -->
        <jsp:include page="../admin/common/header.jsp"></jsp:include>
            <!-- header end -->
            <!-- Left sidebar menu start -->
        <jsp:include page="../admin/common/sidebar.jsp"></jsp:include>
            <!-- Left sidebar menu end -->

            <!--Main container start -->
            <main class="ttr-wrapper">
                <div class="container-fluid">
                    <div class="db-breadcrumb">
                        <h4 class="breadcrumb-title">Contact Detail</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Contact Detail</li>
                        </ul>
                    </div>	
                    <div class="row">
                        <!-- Your Profile Views Chart -->
                        <div class="col-lg-12 m-b30">
                            <div class="widget-box">
                                <div class="email-wrapper">
                                    <div class="email-menu-bar">
                                        <!--                                    <div class="compose-mail">
                                                                                <a href="mailbox-compose.html" class="btn btn-block">Compose</a>
                                                                            </div>-->
                                        <div class="email-menu-bar-inner">
                                            <ul>
                                                <li class="active"><a href="contact-list"><i class="fa fa-envelope-o"></i>Inbox <span class="badge badge-success">8</span></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="mail-list-container">
                                        <div class="mail-toolbar">
                                            <div class="mail-search-bar">
                                                <form action="contact-list" method="get" style="display: flex">
                                                    <input type="text" class="form-control" placeholder="Search" name="txtSearch"/>
                                                    <button type="submit" class="btn btn-primary" style="margin-left: 6px">Search</button></form>
                                            </div>
                                            <!--                                        <div class="dropdown all-msg-toolbar">
                                                                                        <span class="btn btn-info-icon" data-toggle="dropdown"><i class="fa fa-ellipsis-v"></i></span>
                                                                                        <ul class="dropdown-menu">
                                                                                            <li><a href="#"><i class="fa fa-trash-o"></i> Delete</a></li>
                                                                                            <li><a href="#"><i class="fa fa-arrow-down"></i> Archive</a></li>
                                                                                            <li><a href="#"><i class="fa fa-clock-o"></i> Snooze</a></li>
                                                                                            <li><a href="#"><i class="fa fa-envelope-open"></i> Mark as unread</a></li>
                                                                                        </ul>
                                                                                    </div> -->
                                            <!--                                        <div class="next-prev-btn">
                                                                                        <a href="#"><i class="fa fa-angle-left"></i></a>
                                                                                        <a href="#"><i class="fa fa-angle-right"></i></a>
                                                                                    </div>-->
                                        </div>
                                        <div class="mailbox-view">
                                            <div class="mailbox-view-title">
                                                <h5 class="send-mail-title">${c.subject}</h5>
                                        </div>
                                        <div class="send-mail-details">
                                            <div class="d-flex">
                                                <div class="send-mail-user">
                                                    <div class="send-mail-user-pic">
                                                        <img src="/SP25_SE1808_SWP391_Project_G5/${c.customer.avatar}" alt="">
                                                    </div>
                                                    <div class="send-mail-user-info">
                                                        <h4>${c.customer.customerName}</h4>
                                                        <h5>From: ${c.customer.email}</h5>
                                                    </div>
                                                </div>
                                                <div class="ml-auto send-mail-full-info">
                                                    <div class="time"><span>${c.createAt}</span></div>
                                                </div>
                                            </div>
                                            <div class="read-content-body">
                                                <p>${c.message}</p>


                                                <!--<hr>-->
                                                <!--                                                <h6> <i class="fa fa-download m-r5"></i> Attachments <span>(3)</span></h6>
                                                                                                <div class="mailbox-download-file">
                                                                                                    <a href="#"><i class="fa fa-file-image-o"></i> photo.png</a>
                                                                                                    <a href="#"><i class="fa fa-file-text-o"></i> dec.text</a>
                                                                                                    <a href="#"><i class="fa fa-file"></i> video.mkv</a>
                                                                                                </div>-->
                                                <hr>
                                                <c:if test="${c.status eq 'PENDING'}">
                                                    <div class="form-group">
                                                        <form action="reply-contact">
                                                            <h6>Reply Message</h6>
                                                            <div class="m-b15">
                                                                <input type="hidden" value="${c.contactId}" name="contactId"/>
                                                                <textarea class="form-control" name="replyMessage"></textarea>
                                                            </div>
                                                            <button type="submit" class="btn">Reply Now</button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <!-- Your Profile Views Chart END-->
                </div>
            </div>
        </main>
        <div class="ttr-overlay"></div>

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
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
        <c:if test="${message != null}">
            <script type="text/javascript">
            toastr.success(`${message}`, 'Success', {timeOut: 1000});
            </script>
        </c:if>
        <c:if test="${errorMessage != null}">
            <script type="text/javascript">
                    toastr.error(`${errorMessage}`, 'Error', {timeOut: 1000});
            </script>
        </c:if>
    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/mailbox-read.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:11:45 GMT -->
</html>