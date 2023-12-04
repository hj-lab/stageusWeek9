<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Calendar" %>

<%
Date sessionDate = (Date) session.getAttribute("sessionDate");

Calendar cal = Calendar.getInstance();
cal.setTime(sessionDate);
cal.add(Calendar.YEAR, 1); // 년도 +1

Date increasedDate = cal.getTime();

session.setAttribute("sessionDate", increasedDate);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        location.href = "../page/mainPage.jsp"
    </script>
</body>
</html>