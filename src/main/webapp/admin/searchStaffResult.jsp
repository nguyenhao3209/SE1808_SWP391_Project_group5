<%-- 
    Document   : searchStaffResult
    Created on : Mar 14, 2025, 3:43:28 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:forEach var="staff" items="${staffList}">
    <tr>
        <td>${staff.staffID}</td>
        <td>${staff.staffName}</td>
        <td>${staff.email}</td>
        <td>${staff.phone}</td>
        <td>${staff.citizenID}</td>
        <td>${staff.gender}</td>
        <td>${staff.status}</td>
        <td>${staff.address}</td>
        <td class="d-flex flex-row">
            <a href="editStaff?staffId=${staff.staffID}" class="btn btn-warning btn-sm">Edit</a>
            <a href="deleteStaff?staffId=${staff.staffID}" class="btn btn-danger btn-sm"
               onclick="return confirm('Are you sure you want to delete?');">Delete</a>
        </td>
    </tr>
</c:forEach>
