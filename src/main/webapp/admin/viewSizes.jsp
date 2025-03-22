<%-- 
    Document   : viewSizes
    Created on : Mar 22, 2025, 9:10:49 PM
    Author     : HAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="size-list">
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Size</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="size" items="${sizeList}">
                <tr>
                    <td>${size.size}</td>
                    <td>
                        <input type="number" class="form-control size-quantity" value="${size.stockQuantity}" 
                               data-sizeid="${size.sizeID}" min="0" />
                    </td>
                    <td>
                        <button class="btn btn-success update-size-btn" data-sizeid="${size.sizeID}">Update</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
    $(".update-size-btn").click(function () {
        let sizeID = $(this).data("sizeid");
        let newQuantity = $(this).closest("tr").find(".size-quantity").val();
console.log("Sending data:", { sizeID: sizeID, newQuantity: newQuantity });

        if (newQuantity === "" || isNaN(newQuantity) || newQuantity < 0) {
            alert("Invalid quantity!");
            return;
        }

        $.ajax({
            url: "updateSize",
            type: "POST",
            data: {sizeID: sizeID, newQuantity: newQuantity},
            success: function (response) {
                alert("Size quantity updated successfully!");
            },
            error: function (xhr) {
                alert("Error updating size!");
                console.error("Error response: " + xhr.responseText);
            }
        });
    });

</script>

