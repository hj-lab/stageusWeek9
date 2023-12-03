<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("utf-8");

//해당 일정의 년, 월, 일
String yearValue = request.getParameter("modalYearName");
String monthValue = request.getParameter("modalMonthName");
String dayValue = request.getParameter("modalDayName");
// 해당 일정의 시간, 분
String hourValue = request.getParameter("addHourName");
String minuteValue = request.getParameter("addMinuteName");
// 해당 일정의 내용
String scheduleValue = request.getParameter("addScheduleName");
// 세션에서 현재 나의 id, name 가져옴
String idValue = (String)session.getAttribute("sessionId");
String nameValue = (String)session.getAttribute("sessionName");

if (session.getAttribute("sessionModalHour") != null) {
    session.removeAttribute("sessionModalHour"); 
}
session.setAttribute("sessionModalHour", hourValue);

if (session.getAttribute("sessionModalMinute") != null) {
    session.removeAttribute("sessionModalMinute"); 
}
session.setAttribute("sessionModalMinute", minuteValue);


Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");
//일정 목록 저장
String sql = "INSERT INTO schedule(name, id, year, month, day, hour, minute, content) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, nameValue);
query.setString(2, idValue);
query.setString(3, yearValue);
query.setString(4, monthValue);
query.setString(5, dayValue);
query.setString(6, hourValue);
query.setString(7, minuteValue);
query.setString(8, scheduleValue);

//query 전송, 저장 끝
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
        // 년,월,일, id, name 은 jsp에서 처리
        // 시간, 분, 내용 은 js에서 출력
        location.href = "mainPage.jsp"
        // 페이지 이동 없이 원래 화면에 있도록
    </script>
</body>
</html>