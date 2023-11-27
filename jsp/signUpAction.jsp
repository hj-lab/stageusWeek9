<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
request.setCharacterEncoding("utf-8");

String idValue = request.getParameter("id"); 
String pwValue = request.getParameter("pw");
String nameValue = request.getParameter("name");
String birthValue = request.getParameter("birth");
String telValue = request.getParameter("tel");
String rankValue = request.getParameter("rank");
String departmentValue = request.getParameter("department");


Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

//SQL 만들기 (회원탈퇴하고싶으면 sql문만 바꿔주면됨 -> insert,update,delete 다 똑같음)
String sql = "INSERT INTO account(id, pw, name, tel, rank, department) VALUES(?, ?, ?, ?, ?, ?)";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, idValue);
query.setString(2, pwValue);
query.setString(3, nameValue);
query.setString(4, telValue);
query.setString(5, rankValue);
query.setString(6, departmentValue);

//query 전송
query.executeUpdate();

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
        location.href = "../index.html"
    </script>
</body>
</html>