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
    </tr>
</c:forEach>
