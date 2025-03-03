<%-- 
    Document   : deleteNews
    Created on : Mar 2, 2025, 4:11:02 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Delete News</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1 class="text-center">Delete News</h1>
            <p>Are you sure you want to delete this news?</p>
            <form action="delete-news" method="POST">
                <input type="hidden" name="id" value="${param.id}">
                <button type="submit" class="btn btn-danger">Delete</button>
                <a href="news-list" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </body>
</html>