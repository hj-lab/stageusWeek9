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
<%@ page import="java.text.SimpleDateFormat" %>

<%

// timestamp 형인거 setTimestamp를 setdate로 바꾸고 나머지 다 datetime형태로 바꾸기
request.setCharacterEncoding("utf-8");

// 수정할 일정의 내용
String time = request.getParameter("time");
String content = request.getParameter("content");
Date sessionDate = (Date) session.getAttribute("sessionDate");
String sessionId = (String)session.getAttribute("sessionId");

//timestamp 형식으로 바꾸기
Timestamp timestamp = new Timestamp(sessionDate.getTime());

boolean valid = true;

Calendar cal = Calendar.getInstance();
cal.setTime(sessionDate);
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH); // 월은 0부터 시작하므로 +1을 해야 실제 월이 됩니다.
int day = cal.get(Calendar.DAY_OF_MONTH);

SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
Date timeDate = sdf.parse(time); // time 값을 Date 객체로 파싱합니다.

Calendar timeCal = Calendar.getInstance();
timeCal.setTime(sessionDate);
int hour = timeCal.get(Calendar.HOUR_OF_DAY);
int minute = timeCal.get(Calendar.MINUTE);

timeCal.set(Calendar.HOUR_OF_DAY, hour);
timeCal.set(Calendar.MINUTE, minute);

Date modifiedDate = timeCal.getTime();
Timestamp modifiedTimestamp = new Timestamp(modifiedDate.getTime());


Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

if(sessionId == null){
    valid = false;
}
else{

String sql = "UPDATE schedule SET content=? AND date=? WHERE id = ? AND date = ?";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, content);
query.setTimestamp(2, modifiedTimestamp);
query.setString(3, sessionId);
query.setTimestamp(4,timestamp);

query.executeUpdate();

session.setAttribute("sessionDate", modifiedTimestamp);
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
        
       location.href = "../page/mainPage.jsp"
    </script> 
</body>
</html>