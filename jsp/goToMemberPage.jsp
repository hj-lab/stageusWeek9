<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("utf-8");

String memberId = request.getParameter("id");
String memberName = request.getParameter("name");

ArrayList<String> id = new ArrayList<String>();
    id.add("\""+memberId+"\"");


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
        var id = <%= id %>
        alert("memberpage로 이동함, id는 "+id)
        location.href = "mainPage.jsp"

    </script>
</body>
</html>