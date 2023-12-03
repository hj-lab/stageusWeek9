<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%
request.setCharacterEncoding("utf-8");

String sessionId = (String)session.getAttribute("sessionId");

String idValue = request.getParameter("id"); 
String pwValue = request.getParameter("pw");
String nameValue = request.getParameter("name");
String telValue = request.getParameter("tel");
String rankValue = request.getParameter("rank");
String departmentValue = request.getParameter("department");

String beforeSessionId = (String)session.getAttribute("sessionId");
String beforeSessionPw = (String)session.getAttribute("sessionPw");
String beforeSessionName = (String)session.getAttribute("sessionName");
String beforeSessionTel = (String)session.getAttribute("sessionTel");

    
if(idValue == null){
    idValue = beforeSessionId;
}

if(pwValue == null){
    pwValue = beforeSessionPw;
}
if(nameValue == null){
    nameValue = beforeSessionName;
}
if(telValue == null){
    telValue = beforeSessionTel;
}

boolean valid = true;

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

if(sessionId == null){
    valid = false;
}
else{

String sql = "UPDATE account SET id=?, pw=?, name=?, tel=?, rank=?, department=? WHERE id = ?";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, idValue);
query.setString(2, pwValue);
query.setString(3, nameValue);
query.setString(4, telValue);
query.setString(5, rankValue);
query.setString(6, departmentValue);
query.setString(7, sessionId);

query.executeUpdate();

session.setAttribute("sessionId", idValue);
session.setAttribute("sessionPw", pwValue);
session.setAttribute("sessionName", nameValue);
session.setAttribute("sessionTel", telValue);
session.setAttribute("sessionRank", rankValue);  
session.setAttribute("sessionDepartment", departmentValue);
}



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
        
        location.href = "mainPage.jsp"
    </script>
</body>
</html>