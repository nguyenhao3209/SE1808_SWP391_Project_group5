<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
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
</style>
<div class="profile-container">
    <h3>Customer Profile</h3>


    <img src="${sessionScope.viewedUser.avatar}" id="avatarPreview" class="avatar-preview" alt="User Avatar">

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

