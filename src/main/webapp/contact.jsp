<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="shortcut icon" type="image/x-icon" href="img/iconHome.webp" />
        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">

    </head>

    <body data-bs-spy="scroll" data-bs-target="#header" tabindex="0">

        <jsp:include page="common/header.jsp"/>

        <section id="subscribe">
            <div class="container mt-5">
                <div class="row justify-content-center">

                    <div class="col-md-8">
                        <div class="row">

                            <div class="col-md-6">

                                <div class="title-element">
                                    <h2 class="section-title divider">Send us your contact</h2>
                                </div>

                            </div>
                            <div class="col-md-6">

                                <div class="" data-aos="fade-up">
                                    <p style="margin-bottom: 4px">We will respond as soon as possible via your email.</p>
                                    <form action="contact" method="post">
                                        <div class="input-box form-group">
                                            <input type="text" placeholder="Enter subject"  class="form-control" name="subject" required="">
                                        </div>
                                        <div class="input-box message-box form-group">
                                            <textarea placeholder="Enter your message" name="message"  class="form-control" required=""></textarea>
                                        </div>
                                        <div class="button">
                                            <input type="submit" value="Send Now" style="margin-top: 0px">

                                        </div>
                                    </form>
                                </div>

                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </section>

        <jsp:include page="common/footer.jsp"/>
        <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
        <script src="js/jquery-1.11.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>
        <script src="js/plugins.js"></script>
        <script src="js/script.js"></script>
        <c:if test="${message != null}">
            <script type="text/javascript">
                toastr.success(`${message}`, 'Success', {timeOut: 1000});
            </script>
        </c:if>
    </body>

</html>