
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMMM yyyy" var="currentMonth" />


<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:08:15 GMT -->
    <head>
        <base href="${pageContext.request.contextPath}/">
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />
        <!-- DESCRIPTION -->

        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="../error-404.html" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="img/iconAdmin.webp" />

        <!-- PAGE TITLE HERE ============================================= -->


        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

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
                        <h4 class="breadcrumb-title">Dashboard</h4>
                        <ul class="db-breadcrumb-list">
                            <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                            <li>Dashboard</li>
                        </ul>
                    </div>	
                    <!-- Card -->
                    <div class="row">
                        <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                            <div class="widget-card widget-bg1">					 
                                <div class="wc-item">
                                    <h4 class="wc-title">
                                        Total Frofit
                                    </h4>
                                    <span class="wc-des">
                                        All Customs Value 
                                    <br/>${currentMonth}
                                    </span>
                                    <span class="wc-stats">
                                        $<span class="counter">
                                        <fmt:formatNumber value="${totalProfit}" pattern="###,##0.00"/>
                                    </span>
                                </span>
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg2">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    New Feedbacks
                                </h4>
                                <span class="wc-des">
                                    Customer Review  <br/> ${currentMonth}
                                </span>
                                <span class="wc-stats counter">
                                    ${totalFeedbacksInMonth}
                                </span>
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg3">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    New Orders 
                                </h4>
                                <span class="wc-des">
                                    Fresh Order Amount   <br/> ${currentMonth}
                                </span>
                                <span class="wc-stats counter">
                                    ${totalOrdersInMonth}
                                </span>	
                            </div>				      
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3 col-xl-3 col-sm-6 col-12">
                        <div class="widget-card widget-bg4">					 
                            <div class="wc-item">
                                <h4 class="wc-title">
                                    Total Users 
                                </h4>
                                <span class="wc-des">
                                    Sign account  <br/> ${currentMonth}
                                </span>
                                <span class="wc-stats counter">
                                    ${totalCustomers}
                                </span>
                            </div>				      
                        </div>
                    </div>
                </div>
                <!-- Card END -->
                <div class="row">
                    <!-- Your Profile Views Chart -->
                    <div class="col-lg-8 m-b30">
                        <div class="widget-box">
                            <div class="wc-title" style="display: flex; align-items: center">
                                <h4 style="margin-right: 16px; width: 200px">Revenue ${yearSelect}</h4>
                                <select class="form-control" id="yearSelect" onchange="changeYear(this)">
                                    <c:forEach items="${years}" var="o">
                                        <option value="${o}" ${yearSelect == o ? 'selected' : ''}>${o}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="widget-inner">
                                <!--<canvas id="chart" width="100" height="45"></canvas>-->
                                <canvas id="lineChart" width="100" height="45"></canvas>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Number of orders sold ${yearSelect}</h4>
                            </div>
                            <div class="widget-inner">

                                <canvas id="myPieChart" width="400" height="400"></canvas>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 m-b30">
                        <div class="widget-box">
                            <div class="wc-title">
                                <h4>Top 10 staffs with the most sales ${yearSelect}</h4>
                            </div>
                            <div class="widget-inner">
                                <!--                                <div class="orders-list">
                                                                    <ul>
                                                                        <li>
                                                                            <span class="orders-title">
                                                                                <a href="#" class="orders-title-name">Anna Strong </a>
                                                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                                                            </span>
                                                                            <span class="orders-btn">
                                                                                <a href="#" class="btn button-sm red">Unpaid</a>
                                                                            </span>
                                                                        </li>
                                                                        <li>
                                                                            <span class="orders-title">
                                                                                <a href="#" class="orders-title-name">Revenue</a>
                                                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                                                            </span>
                                                                            <span class="orders-btn">
                                                                                <a href="#" class="btn button-sm red">Unpaid</a>
                                                                            </span>
                                                                        </li>
                                                                        <li>
                                                                            <span class="orders-title">
                                                                                <a href="#" class="orders-title-name">Anna Strong </a>
                                                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                                                            </span>
                                                                            <span class="orders-btn">
                                                                                <a href="#" class="btn button-sm green">Paid</a>
                                                                            </span>
                                                                        </li>
                                                                        <li>
                                                                            <span class="orders-title">
                                                                                <a href="#" class="orders-title-name">Revenue</a>
                                                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                                                            </span>
                                                                            <span class="orders-btn">
                                                                                <a href="#" class="btn button-sm green">Paid</a>
                                                                            </span>
                                                                        </li>
                                                                        <li>
                                                                            <span class="orders-title">
                                                                                <a href="#" class="orders-title-name">Anna Strong </a>
                                                                                <span class="orders-info">Order #02357 | Date 12/08/2019</span>
                                                                            </span>
                                                                            <span class="orders-btn">
                                                                                <a href="#" class="btn button-sm green">Paid</a>
                                                                            </span>
                                                                        </li>
                                                                    </ul>
                                                                </div>-->
                                <canvas id="myBarChart" width="100" height="45"></canvas>
                            </div>
                        </div>
                    </div>
                    <!--                    <div class="col-lg-12 m-b30">
                                            <div class="widget-box">
                                                <div class="wc-title">
                                                    <h4>Basic Calendar</h4>
                                                </div>
                                                <div class="widget-inner">
                                                    <div id="calendar"></div>
                                                </div>
                                            </div>
                                        </div>-->
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
        <!--        <script>
        
        
                                                $(document).ready(function () {
        
                                                    $('#calendar').fullCalendar({
                                                        header: {
                                                            left: 'prev,next today',
                                                            center: 'title',
                                                            right: 'month,agendaWeek,agendaDay,listWeek'
                                                        },
                                                        defaultDate: '2019-03-12',
                                                        navLinks: true, // can click day/week names to navigate views
        
                                                        weekNumbers: true,
                                                        weekNumbersWithinDays: true,
                                                        weekNumberCalculation: 'ISO',
        
                                                        editable: true,
                                                        eventLimit: true, // allow "more" link when too many events
                                                        events: [
                                                            {
                                                                title: 'All Day Event',
                                                                start: '2019-03-01'
                                                            },
                                                            {
                                                                title: 'Long Event',
                                                                start: '2019-03-07',
                                                                end: '2019-03-10'
                                                            },
                                                            {
                                                                id: 999,
                                                                title: 'Repeating Event',
                                                                start: '2019-03-09T16:00:00'
                                                            },
                                                            {
                                                                id: 999,
                                                                title: 'Repeating Event',
                                                                start: '2019-03-16T16:00:00'
                                                            },
                                                            {
                                                                title: 'Conference',
                                                                start: '2019-03-11',
                                                                end: '2019-03-13'
                                                            },
                                                            {
                                                                title: 'Meeting',
                                                                start: '2019-03-12T10:30:00',
                                                                end: '2019-03-12T12:30:00'
                                                            },
                                                            {
                                                                title: 'Lunch',
                                                                start: '2019-03-12T12:00:00'
                                                            },
                                                            {
                                                                title: 'Meeting',
                                                                start: '2019-03-12T14:30:00'
                                                            },
                                                            {
                                                                title: 'Happy Hour',
                                                                start: '2019-03-12T17:30:00'
                                                            },
                                                            {
                                                                title: 'Dinner',
                                                                start: '2019-03-12T20:00:00'
                                                            },
                                                            {
                                                                title: 'Birthday Party',
                                                                start: '2019-03-13T07:00:00'
                                                            },
                                                            {
                                                                title: 'Click for Google',
                                                                url: 'http://google.com/',
                                                                start: '2019-03-28'
                                                            }
                                                        ]
                                                    });
        
                                                });
        
                </script>-->
        <script type="text/javascript">
                                    var data = [];
            <c:forEach items="${revenue}" var="t">
                                    data.push(`${t}`);
            </c:forEach>
                                    var areaData = {
                                        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                        datasets: [{
                                                label: 'Revenue',
                                                data: data,
                                                backgroundColor: [
                                                    "rgba(255, 99, 132, 0.5)", // ??
                                                    "rgba(54, 162, 235, 0.5)", // Xanh d??ng
                                                    "rgba(255, 206, 86, 0.5)", // Vàng
                                                    "rgba(75, 192, 192, 0.5)", // Xanh ng?c
                                                    "rgba(153, 102, 255, 0.5)", // Tím
                                                    "rgba(255, 159, 64, 0.5)", // Cam
                                                    "rgba(231, 76, 60, 0.5)", // ?? ??m
                                                    "rgba(46, 204, 113, 0.5)", // Xanh lá
                                                    "rgba(241, 196, 15, 0.5)", // Vàng sáng
                                                    "rgba(52, 152, 219, 0.5)", // Xanh n??c bi?n
                                                    "rgba(155, 89, 182, 0.5)", // Tím ??m
                                                    "rgba(243, 156, 18, 0.5)"   // Cam ??m
                                                ],
                                                borderColor: [
                                                    "rgba(255, 99, 132, 0.5)", // ??
                                                    "rgba(54, 162, 235, 0.5)", // Xanh d??ng
                                                    "rgba(255, 206, 86, 0.5)", // Vàng
                                                    "rgba(75, 192, 192, 0.5)", // Xanh ng?c
                                                    "rgba(153, 102, 255, 0.5)", // Tím
                                                    "rgba(255, 159, 64, 0.5)", // Cam
                                                    "rgba(231, 76, 60, 0.5)", // ?? ??m
                                                    "rgba(46, 204, 113, 0.5)", // Xanh lá
                                                    "rgba(241, 196, 15, 0.5)", // Vàng sáng
                                                    "rgba(52, 152, 219, 0.5)", // Xanh n??c bi?n
                                                    "rgba(155, 89, 182, 0.5)", // Tím ??m
                                                    "rgba(243, 156, 18, 0.5)"   // Cam ??m
                                                ],
                                                borderWidth: 1,
                                                fill: true, // 3: no fill
                                            }]
                                    };

                                    var areaOptions = {
                                        plugins: {
                                            filler: {
                                                propagate: true
                                            }
                                        },
                                        scales: {
                                            yAxes: [{
                                                    gridLines: {
                                                        color: "rgba(204, 204, 204,0.1)"
                                                    }
                                                }],
                                            xAxes: [{
                                                    gridLines: {
                                                        color: "rgba(204, 204, 204,0.1)"
                                                    }
                                                }]
                                        }
                                    }

                                    if ($("#lineChart").length) {
                                        var lineChartCanvas = $("#lineChart").get(0).getContext("2d");
                                        var lineChart = new Chart(lineChartCanvas, {
                                            type: 'line',
                                            data: areaData,
                                            options: areaOptions
                                        });
                                    }
                                    var dataPieChart = [];
            <c:forEach items="${numberOfOrdersList}" var="t">
                                    dataPieChart.push(`${t}`);
            </c:forEach>
                                    var areaData1 = {
                                        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                                        datasets: [{
                                                label: 'Number of orders',
                                                data: dataPieChart,
                                                backgroundColor: [
                                                    "rgba(255, 99, 132, 0.5)", // ??
                                                    "rgba(54, 162, 235, 0.5)", // Xanh d??ng
                                                    "rgba(255, 206, 86, 0.5)", // Vàng
                                                    "rgba(75, 192, 192, 0.5)", // Xanh ng?c
                                                    "rgba(153, 102, 255, 0.5)", // Tím
                                                    "rgba(255, 159, 64, 0.5)", // Cam
                                                    "rgba(231, 76, 60, 0.5)", // ?? ??m
                                                    "rgba(46, 204, 113, 0.5)", // Xanh lá
                                                    "rgba(241, 196, 15, 0.5)", // Vàng sáng
                                                    "rgba(52, 152, 219, 0.5)", // Xanh n??c bi?n
                                                    "rgba(155, 89, 182, 0.5)", // Tím ??m
                                                    "rgba(243, 156, 18, 0.5)"   // Cam ??m
                                                ],
                                                borderColor: [
                                                    "rgba(255, 99, 132, 0.5)", // ??
                                                    "rgba(54, 162, 235, 0.5)", // Xanh d??ng
                                                    "rgba(255, 206, 86, 0.5)", // Vàng
                                                    "rgba(75, 192, 192, 0.5)", // Xanh ng?c
                                                    "rgba(153, 102, 255, 0.5)", // Tím
                                                    "rgba(255, 159, 64, 0.5)", // Cam
                                                    "rgba(231, 76, 60, 0.5)", // ?? ??m
                                                    "rgba(46, 204, 113, 0.5)", // Xanh lá
                                                    "rgba(241, 196, 15, 0.5)", // Vàng sáng
                                                    "rgba(52, 152, 219, 0.5)", // Xanh n??c bi?n
                                                    "rgba(155, 89, 182, 0.5)", // Tím ??m
                                                    "rgba(243, 156, 18, 0.5)"   // Cam ??m
                                                ],
                                                borderWidth: 1,
                                                fill: true, // 3: no fill
                                            }]
                                    };
                                    if ($("#myPieChart").length) {
                                        var lineChartCanvas = $("#myPieChart").get(0).getContext("2d");
                                        var lineChart = new Chart(lineChartCanvas, {
                                            type: 'pie',
                                            data: areaData1
                                        });
                                    }
                                    var staffNames = [];
                                    var orderCounts = [];

            <c:forEach items="${topStaffs}" var="staff">
                                    staffNames.push("${staff['StaffID']} - ${staff['StaffName']}");
                                        orderCounts.push(${staff['OrderCount']});
            </c:forEach>;
                                        var areaData2 = {
                                            labels: staffNames,
                                            datasets: [{
                                                    label: 'Number of orders',
                                                    data: orderCounts,
                                                    backgroundColor: [
                                                        "rgba(255, 99, 132, 0.5)", // ??
                                                        "rgba(54, 162, 235, 0.5)", // Xanh d??ng
                                                        "rgba(255, 206, 86, 0.5)", // Vàng
                                                        "rgba(75, 192, 192, 0.5)", // Xanh ng?c
                                                        "rgba(153, 102, 255, 0.5)", // Tím
                                                        "rgba(255, 159, 64, 0.5)", // Cam
                                                        "rgba(231, 76, 60, 0.5)", // ?? ??m
                                                        "rgba(46, 204, 113, 0.5)", // Xanh lá
                                                        "rgba(241, 196, 15, 0.5)", // Vàng sáng
                                                        "rgba(52, 152, 219, 0.5)", // Xanh n??c bi?n
                                                        "rgba(155, 89, 182, 0.5)", // Tím ??m
                                                        "rgba(243, 156, 18, 0.5)"   // Cam ??m
                                                    ],
                                                    borderColor: [
                                                        "rgba(255, 99, 132, 0.5)", // ??
                                                        "rgba(54, 162, 235, 0.5)", // Xanh d??ng
                                                        "rgba(255, 206, 86, 0.5)", // Vàng
                                                        "rgba(75, 192, 192, 0.5)", // Xanh ng?c
                                                        "rgba(153, 102, 255, 0.5)", // Tím
                                                        "rgba(255, 159, 64, 0.5)", // Cam
                                                        "rgba(231, 76, 60, 0.5)", // ?? ??m
                                                        "rgba(46, 204, 113, 0.5)", // Xanh lá
                                                        "rgba(241, 196, 15, 0.5)", // Vàng sáng
                                                        "rgba(52, 152, 219, 0.5)", // Xanh n??c bi?n
                                                        "rgba(155, 89, 182, 0.5)", // Tím ??m
                                                        "rgba(243, 156, 18, 0.5)"   // Cam ??m
                                                    ],
                                                    borderWidth: 1,
                                                    fill: true, // 3: no fill
                                                }]
                                        };
                                        if ($("#myBarChart").length) {
                                            var lineChartCanvas = $("#myBarChart").get(0).getContext("2d");
                                            var lineChart = new Chart(lineChartCanvas, {
                                                type: 'bar',
                                                data: areaData2
                                            });
                                        }
        </script>
        <script>
            function changeYear(selectElement) {
                let selectedYear = selectElement.value;
                console.log("Selected year:", selectedYear); // Ki?m tra giï¿½ tr? ???c ch?n
                window.location.href = "dashboard?year=" + selectedYear; // Chuy?n h??ng ??n servlet/dashboard v?i tham s? year
            }
        </script>

    </body>

    <!-- Mirrored from educhamp.themetrades.com/demo/admin/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Fri, 22 Feb 2019 13:09:05 GMT -->
</html>