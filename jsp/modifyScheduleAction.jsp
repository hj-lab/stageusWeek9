<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("utf-8");

// 수정할 일정의 내용
String modifySchedule = request.getParameter("modifySchedule");

ArrayList<String>id = new ArrayList<String>();
    id.add("\""+modifySchedule+"\"");


String sessionId = (String)session.getAttribute("sessionId");
String sessionModalYear = (String)session.getAttribute("sessionModalYear"); //현재 클릭한 요소의 년
String sessionModalMonth = (String)session.getAttribute("sessionModalMonth"); //현재 클릭한 요소의 월
String sessionModalDay = (String)session.getAttribute("sessionModalDay"); //현재 클릭한 요소의 일
String sessionModalHour = (String)session.getAttribute("sessionModalHour");
String sessionModalMinute = (String)session.getAttribute("sessionModalMinute");

ArrayList<String>hour = new ArrayList<String>();
    hour.add("\""+sessionModalHour+"\"");

boolean valid = true;

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

if(sessionId == null){
    valid = false;
}
else{

String sql = "UPDATE schedule SET content=? WHERE id = ? AND year=? AND month=? AND day=? AND hour=? AND minute=?";
PreparedStatement query = connect.prepareStatement(sql);

query.setString(1, modifySchedule);
query.setString(2, sessionId);
query.setString(3, sessionModalYear);
query.setString(4, sessionModalMonth);
query.setString(5, sessionModalDay);
query.setString(6, sessionModalHour);
query.setString(7, sessionModalMinute);

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
        var check = <%= id %>
        var hour = <%= hour %>
        alert("넘어온 sibling은 "+check+"넘어온 hour은 "+hour)
        window.history.back();
    </script> 
</body>
</html>