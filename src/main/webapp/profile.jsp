<%-- 
    Document   : profile
    Created on : Feb 16, 2025, 8:15:10 PM
    Author     : Admin
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Profile</title>
        <!-- Th? vi?n Font Awesome ?? s? d?ng c?c icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        
        
               	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

       <link rel="stylesheet" type="text/css" href="css/normalize.css">
	<link rel="stylesheet" type="text/css" href="icomoon/icomoon.css">
	<link rel="stylesheet" type="text/css" href="css/vendor.css">
        <link rel="stylesheet" type="text/css" href="style.css"><!-- comment -->
        <style>

            .container.edit-profile {
                max-width: 500px;
                width: 100%;
                padding: 30px;
                background-color: #ffffff;
                border-radius: 15px;
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease-in-out;
                margin-top: 50px;  
            }

            .container.edit-profile:hover {
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

            .avatar-preview {
                display: block;
                margin: 20px auto;
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #ff7f50;
               box-shadow: 0 4px 10px rgba(255, 127, 80, 0.3);
            }

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


        </style>
    </head>

    <body>
        <jsp:include page="common/header.jsp"/>
        <div class="container edit-profile">
            <!-- Hi?n th? th?ng b?o n?u profile ???c c?p nh?t th?nh c?ng -->
            <c:if test="${not empty sessionScope.successMessage}">
                <p class="success-message">${sessionScope.successMessage}</p>
            </c:if>

            <h2>Edit Profile</h2>

            <form action="updateProfile" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="userName">User Name</label>
                    <input type="text" name="userName" value="${sessionScope.user.customerName}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" name="email" value="${sessionScope.user.email}" readonly="">
                </div>

                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" name="phone" value="${sessionScope.user.phone}" required>
                </div>

                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" name="address" value="${sessionScope.user.address}" required>
                </div>

                <!-- Hi?n th? avatar hi?n t?i -->
                <img src="${sessionScope.user.avatar}" id="avatarPreview" class="avatar-preview" alt="Current Avatar">

                <div class="form-group">
                    <label for="avatar">Change Avatar</label>
                    <input type="file" name="avatar" id="avatar" accept="image/*" onchange="previewAvatar(event)">
                </div>

                <button type="submit">Save Changes</button>
            </form>

            <!-- N?t quay v? trang ch? -->
<!--            <form action="home.jsp" method="get">
                <button type="button" onclick="location.href = 'home.jsp'">Back to Home</button>
            </form>-->
        </div>
                <jsp:include page="common/footer.jsp"/>
        <script>
            // Hi?n th? preview ?nh ngay sau khi ng??i d?ng ch?n file
            function previewAvatar(event) {
                const input = event.target;
                const reader = new FileReader();
                reader.onload = function () {
                    const avatarPreview = document.getElementById('avatarPreview');
                    avatarPreview.src = reader.result;  // G?n URL c?a ?nh preview v?o th? img
                };
                reader.readAsDataURL(input.files[0]);  // ??c file ?nh ?? ch?n
            }

            // ?n th?ng b?o sau 5 gi?y
            setTimeout(function () {
                const message = document.querySelector('.success-message');
                if (message) {
                    message.style.display = 'none';
                }
            }, 5000);  // ?n th?ng b?o sau 5 gi?y
        </script>

    </body>
</html>


