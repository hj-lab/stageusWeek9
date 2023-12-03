<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("utf-8");

// 삭제할 일정 가져옴
String deleteSchedule = request.getParameter("deleteSchedule");

String sessionId = (String)session.getAttribute("sessionId");
String sessionModalYear = (String)session.getAttribute("sessionModalYear"); //현재 클릭한 요소의 년
String sessionModalMonth = (String)session.getAttribute("sessionModalMonth"); //현재 클릭한 요소의 월
String sessionModalDay = (String)session.getAttribute("sessionModalDay"); //현재 클릭한 요소의 일
String sessionModalHour = (String)session.getAttribute("sessionModalHour");
String sessionModalMinute = (String)session.getAttribute("sessionModalMinute");

ArrayList<String>del = new ArrayList<String>();
        del.add("\""+deleteSchedule+"\"");

        ArrayList<String>day = new ArrayList<String>();
            day.add("\""+sessionModalDay+"\"");
    
boolean valid = true;

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

if(sessionId == null){
    valid = false;
}
else{

String sql = "DELETE FROM schedule WHERE id = ? AND year=? AND month=? AND day=? AND hour=? AND minute=? AND content=?";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, sessionId);
query.setString(2, sessionModalYear);
query.setString(3, sessionModalMonth);
query.setString(4, sessionModalDay);
query.setString(5, sessionModalHour);
query.setString(6, sessionModalMinute);
query.setString(7, deleteSchedule);

query.executeUpdate();

//세션에서도 삭제해야함
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
        
        var hour = <%= del %>

        alert("선택한 날짜의 내용 "+hour)
        location.href = "mainPage.jsp"
    </script>
</body>
</html>