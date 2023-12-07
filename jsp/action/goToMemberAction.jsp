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

// 팀장이 팀원 페이지를 클릭했다는 것을 알기 위해
session.setAttribute("sessionAnotherPerson", memberName);


ArrayList<String> id = new ArrayList<String>();
    id.add("\""+memberId+"\"");

ArrayList<String> name = new ArrayList<String>();
    name.add("\""+memberName+"\"");
    

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
        var name = <%= name %>
        alert("memberpage로 이동함, id는 "+id)
        location.href = "../page/mainPage.jsp?clickName="+name;

    </script>
</body>
</html>