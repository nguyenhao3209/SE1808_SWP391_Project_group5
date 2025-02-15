<%-- 
    Document   : error
    Created on : Oct 14, 2024, 8:07:55 PM
    Author     : CE180220_Trần Minh Khánh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .error-container {
            background: linear-gradient(90deg, #b29f7d, #6e6e6e);
            border: 1px solid #f5c6cb;
            padding: 20px;
            border-radius: 5px;
            max-width: 400px;
            text-align: center;
        }

        .error-container h1 {
            font-size: 24px;
        }

        .error-container p {
            margin: 15px 0;
        }

        .error-container a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #f5c6cb;
            color: #721c24;
            text-decoration: none;
            border-radius: 5px;
        }

        .error-container a:hover {
            background-color: #f1b0b7;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Error Occurred</h1>
        <p>${error}</p>
        <a href="home.jsp">Return to Homepage</a>
    </div>
</body>
</html>