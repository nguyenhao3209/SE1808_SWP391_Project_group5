<%-- 
    Document   : addStaff
    Created on : Feb 18, 2025, 12:01:41 PM
    Author     : HuyLVQCE180656
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add new Staff</title>
        <!-- Th? vi?n Font Awesome ?? s? d?ng c?c icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

        <link rel="stylesheet" type="text/css" href="css/normalize.css">
        <link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
        <link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css"><!-- comment -->
        <style>

            .container.add-staff {
                max-width: 600px;
                width: 100%;
                padding: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease-in-out;
                margin-top: 50px;
            }

            .container.add-staff:hover {
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
                transform: translateY(-5px);
            }

            h2 {
                text-align: center;
                margin-bottom: 25px;
                font-size: 28px;
                font-weight: 700;
                color: #ff7f50;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                font-size: 15px;
                color: #555;
            }

            input[type="text"],
            input[type="email"],
            input[type="file"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                background-color: #f9f9f9;
                color: #333;
                transition: border-color 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            input[type="file"]:focus {
                border-color: #007bff;
                outline: none;
            }

            /*            .avatar-preview {
                            display: block;
                            margin: 20px auto;
                            width: 120px;
                            height: 120px;
                            border-radius: 50%;
                            object-fit: cover;
                            border: 4px solid #ff7f50;
                            box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
                        }*/

            button[type="submit"], button[type="button"] {
                display: block;
                width: 100%;
                padding: 14px;
                background: linear-gradient(90deg, #b29f7d, #6e6e6e);
                color: white;
                border: none;
                border-radius: 50px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                margin-top: 10px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
            }

            button[type="submit"]:hover, button[type="button"]:hover {
                background: linear-gradient(90deg, #b29f7d, #6e6e6e);
                transform: translateY(-3px);
                box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
            }

            .success-message {
                font-size: 18px; /* T?ng k?ch th??c font ch? */
                padding: 15px 30px; /* T?ng padding ?? c? th?m kho?ng tr?ng b?n trong */
                margin: 20px auto; /* ??t margin tr?n v? d??i */
                background-color: #28a745;
                color: white;
                border-radius: 8px;
                font-weight: 600;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                z-index: 1000; /* ??m b?o hi?n th? tr?n c?ng */
                position: relative; /* ??m b?o hi?n th? c?ng v?i b?ng */
                width: 100%; /* ??t chi?u r?ng b?ng v?i b?ng */
                max-width: none; /* Kh?ng gi?i h?n chi?u r?ng */
                text-align: center;
                display: block; /* ??m b?o th?ng b?o chi?m ??y ?? kh?ng gian */
                box-sizing: border-box; /* ??m b?o padding kh?ng l?m t?ng k?ch th??c t?ng th? */
            }

            .left-col, .right-col {
                width: 48%;
                /*                margin: 5px;
                                padding: 5px;*/
                box-sizing: border-box;
            }

            .left-col {
                float: left;
            }

            .right-col {
                float: right;
            }


        </style>
    </head>

    <body>

        <jsp:include page="common/header.jsp"/>
        <div class="container add-staff">
            <!-- Hi?n th? th?ng b?o n?u profile ???c c?p nh?t th?nh c?ng -->
            <c:if test="${not empty sessionScope.successMessage}">
                <p class="success-message">${sessionScope.successMessage}</p>
            </c:if>

            <h2>Add New Staff</h2>

            <div class="left-col">
                <form action="addStaff" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="userName">Full Name</label>
                        <input type="text" name="staffName" value="${sessionScope.staff.staffName}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" name="phone" value="${sessionScope.staff.phone}" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Role</label>
                        <input type="text" name="role" value="${sessionScope.staff.role}" required>
                    </div>

                    <div class="form-group">
                        <label for="hireDate">Hire Date</label>
                        <input type="date" name="hireDate" value="${sessionScope.staff.hireDate}" required>
                    </div>

            </div><!-- comment -->

            <div class="right-col">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" name="email" value="${sessionScope.staff.email}" required="">
                </div>

                <div class="form-group">
                    <label for="address">Gender</label>
                    <input type="text" name="gender" value="${sessionScope.staff.gender}" required>
                </div>

                <div class="form-group">
                    <label for="address">Status</label>
                    <input type="text" name="status" value="${sessionScope.staff.status}" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" name="address" value="${sessionScope.staff.address}" required>
                </div>
            </div>

            <button type="submit">Save</button>
            <button type="submit">Cancel</button>
        </form>
        <!-- N?t quay v? trang ch? -->
        <!--            <form action="home.jsp" method="get">
                        <button type="button" onclick="location.href = 'home.jsp'">Back to Home</button>
                    </form>-->
    </div>
    <jsp:include page="common/footer.jsp"/>
</body>
</html>
