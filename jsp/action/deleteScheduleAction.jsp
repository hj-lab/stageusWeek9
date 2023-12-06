<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>

<%
request.setCharacterEncoding("utf-8");

String scheduleContent = request.getParameter("content");
String sessionId = (String)session.getAttribute("sessionId");
Date sessionDate = (Date) session.getAttribute("sessionDate");

int year =0;
int month =0;
int day =0;

boolean valid = true;

if(sessionId == null){
    valid = false;
}
else{
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

    Calendar cal = Calendar.getInstance();
    cal.setTime(sessionDate);
    year = cal.get(Calendar.YEAR);
    month = cal.get(Calendar.MONTH) + 1; // 월은 +1 해줘야함
    day = cal.get(Calendar.DAY_OF_MONTH);

    String sql = "DELETE FROM schedule WHERE YEAR(date) = ? AND MONTH(date) = ? AND DAY(date)= ? AND content =?";
    PreparedStatement query = connect.prepareStatement(sql);

    query.setInt(1, year);
    query.setInt(2, month);
    query.setInt(3, day);
    query.setString(4, scheduleContent);

    query.executeUpdate();
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
        var valid = <%= valid %>

        if(valid == false){
            alert("로그인 하세요!")
            location.href = "../../index.html"
        }
        else{
        location.href = "../page/mainPage.jsp"
        }
    </script>
</body>
</html>