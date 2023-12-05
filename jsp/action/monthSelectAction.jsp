<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Calendar" %>

<%
// ex_ 1월, 2월 .. 
String month = request.getParameter("month");
// 월 글자 빼고 숫자만 추출
String onlyNumberDay = month.replaceAll("[^0-9]", "");

Date sessionDate = (Date) session.getAttribute("sessionDate");
Calendar cal = Calendar.getInstance();
cal.setTime(sessionDate);
// 월을 onlyNumberDay로 변경, -1해줘야함
cal.set(Calendar.MONTH, Integer.parseInt(onlyNumberDay) - 1); // 월은 0부터 시작하기 때문에 1을 빼줍니다.

Date modifiedDate = cal.getTime();
session.setAttribute("sessionDate", modifiedDate);


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