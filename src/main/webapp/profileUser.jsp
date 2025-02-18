<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            margin-top: 20px;
            text-align: center;
            color: #333;
        }

        .profile-container {
            margin: 20px auto;
            padding: 20px;
            max-width: 600px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .profile-header {
            background-color: #343a40; /* Màu tối hơn */
            color: white;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-header h3 {
            margin: 0;
        }

        .profile-details {
            width: 100%;
            border-collapse: collapse;
        }

        .profile-details th, .profile-details td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .profile-details th {
            background-color: #007bff; /* Màu xanh */
            color: white; /* Chữ trắng */
            width: 30%;
        }

        .avatar-preview {
            display: block;
            margin: 10px auto;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #007bff; /* Đường viền màu xanh */
        }
    </style>
</head>
<body>

<div class="profile-container">
    <div class="profile-header">
        <h3>Customer Profile</h3>
    </div>

    <img src="${sessionScope.viewedUser.avatar}" class="avatar-preview" alt="User Avatar">

    <table class="profile-details">
        <tr>
            <th>Customer Name</th>
            <td>${sessionScope.viewedUser.customerName}</td>
        </tr>
        <tr>
            <th>Email</th>
            <td>${sessionScope.viewedUser.email}</td>
        </tr>
        <tr>
            <th>Phone</th>
            <td>${sessionScope.viewedUser.phone}</td>
        </tr>
        <tr>
            <th>Address</th>
            <td>${sessionScope.viewedUser.address}</td>
        </tr>
        <tr>
            <th>Status</th>
            <td>${sessionScope.viewedUser.status}</td>
        </tr>
    </table>
</div>

</body>
</html>
