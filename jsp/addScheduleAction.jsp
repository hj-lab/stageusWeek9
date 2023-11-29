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

// select로 목록 가져오기 -> 이건 display에서 필요할거같은데
String sql2 = "SELECT * FROM schedule WHERE year=? AND month=? AND day=?";
PreparedStatement query2 = connect.prepareStatement(sql2);

query2.setString(1, yearValue);
query2.setString(2, monthValue);
query2.setString(3, dayValue);

ResultSet result = query2.executeQuery();

//2차원 배열 생성
List<List<String>> dataList = new ArrayList<>();
while (result.next()) {
    // 각 행의 값들을 저장할 List 생성
    List<String> rowValues = new ArrayList<>();

    // 2, 3, 7, 8, 9 번째 column의 값을 가져와서 리스트에 추가
    rowValues.add(result.getString(2)); // 2번째 column : name
    rowValues.add(result.getString(3)); // 3번째 column : id
    rowValues.add(result.getString(7)); // 7번째 column : hour
    rowValues.add(result.getString(8)); // 8번째 column : minute
    rowValues.add(result.getString(9)); // 9번째 column : content

    // 현재 행의 데이터 리스트를 전체 데이터 리스트에 추가
    dataList.add(rowValues);
}

// 이름, id, hour, minute, content를 순서대로 담고 있는 2차원 배열
if (session.getAttribute("sessionDaySchedule") != null) {
    session.removeAttribute("sessionDaySchedule"); // sessionDaySchedule 속성 제거
}
session.setAttribute("sessionDaySchedule", dataList);

List<List<String>> DayScheduleList = (List<List<String>>) session.getAttribute("sessionDaySchedule");
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