<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
request.setCharacterEncoding("utf-8");

String idValue = request.getParameter("id"); 
String pwValue = request.getParameter("pw");
String nameValue = request.getParameter("name");
String telValue = request.getParameter("tel");
String rankValue = request.getParameter("rank");
String departmentValue = request.getParameter("department");




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
        alert("페이지 넘김 성공")
    </script>
</body>
</html>