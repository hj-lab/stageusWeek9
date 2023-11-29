<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
String yearValue = request.getParameter("year");
String monthValue = request.getParameter("month");
String dayValue = request.getParameter("day");
    
// select로 목록 가져오기
Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

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
    rowValues.add(result.getString(2)); // name
    rowValues.add(result.getString(3)); // id
    rowValues.add(result.getString(7)); // hour
    rowValues.add(result.getString(8)); // minute
    rowValues.add(result.getString(9)); // content

    // 현재 행의 데이터 리스트를 전체 데이터 리스트에 추가
    dataList.add(rowValues);
}


if (session.getAttribute("sessionDaySchedule") != null) {
    session.removeAttribute("sessionDaySchedule"); // sessionDaySchedule 속성 제거
}
session.setAttribute("sessionDaySchedule", dataList);


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
   //location.href = document.referrer
   location.reload(true)
   //window.history.back()
    
   
    
    </script>
    
</body>
</html>