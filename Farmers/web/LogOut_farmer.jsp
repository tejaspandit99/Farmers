<%-- 
    Document   : LogOut_farmer
    Created on : 26 May, 2021, 5:39:40 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log out</title>
    </head>
    <body>
        <h1><%
            session.invalidate();
            response.sendRedirect("farmers-login.html");
        %></h1>
    </body>
</html>
