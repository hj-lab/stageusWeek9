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
String time = request.getParameter("time"); // 17:37 형식
String myContent = request.getParameter("content");
int idxNum = Integer.parseInt(request.getParameter("idx"));
Date sessionDate = (Date) session.getAttribute("sessionDate");
String sessionName = (String)session.getAttribute("sessionName");
String sessionId = (String)session.getAttribute("sessionId");

boolean valid = true;

Calendar cal = Calendar.getInstance();
cal.setTime(sessionDate);
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH); // 월은 0부터 시작하므로 +1을 해야 실제 월이 됩니다.
int day = cal.get(Calendar.DAY_OF_MONTH);

//input type="time"에서 값 가져옴
String[] timeParts = time.split(":");
int modifyHour = 0;
int modifyMinute = 0;
if (timeParts.length == 2) {
    modifyHour = Integer.parseInt(timeParts[0].trim()); // 시간
    modifyMinute = Integer.parseInt(timeParts[1].trim()); // 분
}


// 세션 값 변경
Calendar timeCal = Calendar.getInstance();
timeCal.setTime(sessionDate);

timeCal.set(Calendar.HOUR_OF_DAY, modifyHour);
timeCal.set(Calendar.MINUTE, modifyMinute);

Date modifiedDate = timeCal.getTime();

Timestamp timeStampSessionDate = new Timestamp(sessionDate.getTime());
Timestamp timeStampModifiedDate = new Timestamp(modifiedDate.getTime());

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

if(sessionId == null){
    valid = false;
}
else{
// 원래는 WHERE name=? date=?
String sql = "UPDATE schedule SET content=? AND date=? WHERE idx = ? ";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, myContent);
query.setTimestamp(2, timeStampModifiedDate);
query.setInt(3, idxNum);

query.executeUpdate();

session.setAttribute("sessionDate", modifiedDate);
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