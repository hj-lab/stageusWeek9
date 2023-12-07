<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%
request.setCharacterEncoding("utf-8");

String sessionId = (String)session.getAttribute("sessionId");

String pwValue = request.getParameter("pw");
String nameValue = request.getParameter("name");
String telValue = request.getParameter("tel");
String rankValue = request.getParameter("rank");
String departmentValue = request.getParameter("department");

boolean valid = true;

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

if(sessionId == null){
    valid = false;
}
else{

String sql = "UPDATE account SET pw=?, name=?, tel=?, rank_idx=?, department_idx=? WHERE id = ?";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, pwValue);
query.setString(2, nameValue);
query.setString(3, telValue);
query.setString(4, rankValue);
query.setString(5, departmentValue);
query.setString(6, sessionId);

query.executeUpdate();

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
        var departmentValue = <%= departmentValue %>
        console.log(departmentValue)
        
        location.href = "../page/mainPage.jsp"
    </script>
</body>
</html>