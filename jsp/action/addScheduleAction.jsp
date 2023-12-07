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

String sessionIdx = (String)session.getAttribute("sessionIdx");
//int numSessionIdx = 0;
//numSessionIdx = Integer.parseInt(sessionIdx);

Date sessionDate = (Date) session.getAttribute("sessionDate");
Calendar cal = Calendar.getInstance();
cal.setTime(sessionDate);
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1; // 월은 +1 해줘야함
int day = cal.get(Calendar.DAY_OF_MONTH);

String addScheduleTime = request.getParameter("addScheduleTime");
String[] timeParts = addScheduleTime.split(":");
int hour = Integer.parseInt(timeParts[0]); // 시간
int minute = Integer.parseInt(timeParts[1]); // 분

//위에꺼 조합해서 timestamp 형태로 만듦
cal.set(year, month - 1, day, hour, minute); // 월은 0부터 시작하므로 1을 빼고 설정합니다.
Timestamp timestamp = new Timestamp(cal.getTimeInMillis());

// 일정 내용
String addScheduleName = request.getParameter("addScheduleName");

String nameValue = (String)session.getAttribute("sessionName");

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");
//일정 목록 저장

String sql = "INSERT INTO schedule(account_idx, name, date, content) VALUES(?, ?, ?, ?)";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, sessionIdx);
query.setString(2, nameValue);
query.setTimestamp(3, timestamp);
query.setString(4, addScheduleName);

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
        location.href = "../page/mainPage.jsp"
    </script>
</body>
</html>