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

ArrayList<String> yearList = new ArrayList<String>();
yearList.add("\""+yearValue+"\"");

ArrayList<String> monthList = new ArrayList<String>();
    monthList.add("\""+monthValue+"\"");
  
    
    ArrayList<String> dayList = new ArrayList<String>();
        dayList.add("\""+dayValue+"\"");
          
    
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
        var year = <%= yearList %>
        var month = <%= monthList %>
        var day = <%= dayList %>

        alert("year은"+year+" month는 "+month+" day는 "+day)
        
        location.href = "mainPage.jsp"
    </script>
    
</body>
</html>