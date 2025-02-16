<%-- 
    Document   : change-pass
    Created on : Feb 16, 2025, 8:16:26 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- META ============================================= -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="keywords" content="" />
        <meta name="author" content="" />
        <meta name="robots" content="" />

        <!-- DESCRIPTION -->
        <meta name="description" content="EduChamp : Education HTML Template" />

        <!-- OG -->
        <meta property="og:title" content="EduChamp : Education HTML Template" />
        <meta property="og:description" content="EduChamp : Education HTML Template" />
        <meta property="og:image" content="" />
        <meta name="format-detection" content="telephone=no">

        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
        <!-- FAVICONS ICON ============================================= -->
        <link rel="icon" href="img/bg" type="image/x-icon" />
        <link rel="shortcut icon" type="image/x-icon" href="img/bg1" />

        <!-- PAGE TITLE HERE ============================================= -->
        <title>G6 : Badminton Sales </title>

        <!-- MOBILE SPECIFIC ============================================= -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--[if lt IE 9]>
        <script src="assets/js/html5shiv.min.js"></script>
        <script src="assets/js/respond.min.js"></script>
        <![endif]-->

        <!-- All PLUGINS CSS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/assets.css">

        <!-- TYPOGRAPHY ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/typography.css">

        <!-- SHORTCODES ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/shortcodes/shortcodes.css">

        <!-- STYLESHEETS ============================================= -->
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link class="skin" rel="stylesheet" type="text/css" href="assets/css/color/color-1.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        

        <style>
            .account-head:after{
                background:linear-gradient(45deg, rgba(0, 0, 0, 0.1) 0%, rgba(0, 0, 0, 0.1) 100%) !important;
            }
            .account-head {
                min-width: 600px;
            }
            @keyframes zoom {
                0% {
                    transform: scale(0.96);
                }
                50% {
                    transform: scale(1); /* Phóng to 1.2 lần */
                }
                100% {
                    transform: scale(0.96);

                }

            }
            /* Đặt icon ở góc dưới bên phải */
            .audio-icon {
                position: fixed;
                bottom: 20px;
                right: 20px;
                font-size: 40px; /* Kích thước của biểu tượng */
                color: #f7b205;
                cursor: pointer;
                transition: color 0.3s;
            }

            .audio-icon:hover {
                color: #4c1864;
            }

            label.error{
                margin-top: 55px;
                color: red !important;
            }
        </style>
    </head>
    <body id="bg">
   
        <div class="page-wraper">
            <div id="loading-icon-bx"></div>
            <div class="account-form">
                <div style="width: 600px;background: #666">
                    <div class="account-head" style="background-image:url(img/bg1);background-color: inherit;background-repeat: no-repeat;background-size: cover;animation: zoom 10s infinite ease-in-out;overflow: hidden;">
                        <!-- <a href="index.html"><img src="assets/images/logo-white-2.png" alt=""></a> -->
                    </div></div>
                <div class="account-form-inner">
                    <div class="account-container">
                        <div class="heading-bx left">
                            <h2 class="title-head">Change <span>Password</span></h2>
                            <p>Login Your Account <a href="login">Click here</a></p>
                        </div>	
                        <form class="contact-bx" action="change-pass" method="post" id="formChangePass">
                            <div class="row placeani">
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Old Password</label>
                                            <input name="oldPassword" type="password" id="oldPassword" required="" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>New Password</label>
                                            <input name="newPassword" type="password" id="newPassword" required="" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <label>Confirm New Password</label>
                                            <input name="confirmNewPassword" type="password" id="confirmNewPassword" required="" class="form-control">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 m-b30">
                                    <button name="submit" type="submit" value="Submit" class="btn button-md">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Audio element -->
            <audio id="background-audio">
                <source src="assets/images/power-drive-extreme-sports-123406.mp3" type="audio/mpeg">
                Your browser does not support the audio element.
            </audio>

            <!-- Play/Stop button -->
            <div id="audio-control" class="audio-icon">
                <i class="fa fa-play"></i> <!-- Biểu tượng Play -->
            </div>

        </div>
        <!-- External JavaScripts -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/bootstrap-select/bootstrap-select.min.js"></script>
        <script src="assets/vendors/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
        <script src="assets/vendors/magnific-popup/magnific-popup.js"></script>
        <script src="assets/vendors/counter/waypoints-min.js"></script>
        <script src="assets/vendors/counter/counterup.min.js"></script>
        <script src="assets/vendors/imagesloaded/imagesloaded.js"></script>
        <script src="assets/vendors/masonry/masonry.js"></script>
        <script src="assets/vendors/masonry/filter.js"></script>
        <script src="assets/vendors/owl-carousel/owl.carousel.js"></script>
        <script src="assets/js/functions.js"></script>
        <script src="assets/js/contact.js"></script>
        <script src='assets/vendors/switcher/switcher.js'></script>

        <script>
            // Lấy phần tử âm thanh và biểu tượng
            const audio = document.getElementById('background-audio');
            const audioControl = document.getElementById('audio-control');
            const icon = audioControl.querySelector('i');

            // Biến để theo dõi trạng thái âm thanh (phát hoặc dừng)
            let isPlaying = false;

            // Thêm sự kiện 'click' vào biểu tượng Play/Stop
            audioControl.addEventListener('click', function () {
                if (isPlaying) {
                    audio.pause(); // Dừng âm thanh
                    icon.classList.remove('fa-stop'); // Loại bỏ icon Stop
                    icon.classList.add('fa-play'); // Thêm icon Play
                } else {
                    audio.play(); // Phát âm thanh
                    icon.classList.remove('fa-play'); // Loại bỏ icon Play
                    icon.classList.add('fa-stop'); // Thêm icon Stop
                }
                isPlaying = !isPlaying; // Đổi trạng thái
            });

            // Đảm bảo biểu tượng quay về 'Play' khi âm thanh kết thúc
            audio.addEventListener('ended', function () {
                icon.classList.remove('fa-stop');
                icon.classList.add('fa-play');
                isPlaying = false;
            });


        </script>
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

</html>


