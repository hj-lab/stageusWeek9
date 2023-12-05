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
// 내가 클릭한 칸의 일을 가져옴
String day = request.getParameter("myDay");

Date sessionDate = (Date) session.getAttribute("sessionDate");
Calendar cal = Calendar.getInstance();
cal.setTime(sessionDate);

// 세션의 일 업데이트
cal.set(Calendar.DAY_OF_MONTH, Integer.parseInt(day));

Date modifiedDate = cal.getTime();
session.setAttribute("sessionDate", modifiedDate);

// 클릭한 일의 일정 리스트 가져오기
Date sessionTodayDate = (Date) session.getAttribute("sessionDate");

ArrayList<String> dayNameList = new ArrayList<String>();
ArrayList<String> dayTimeList = new ArrayList<String>();
ArrayList<String> dayContentList = new ArrayList<String>();
  
try{
// 년, 월, 일 추출
int myYear = cal.get(Calendar.YEAR);
int myMonth = cal.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줌
int myDay = cal.get(Calendar.DAY_OF_MONTH);


Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

String sql = "SELECT name, date, content FROM schedule WHERE YEAR(date) = ? AND MONTH(date) = ? AND DAY(date) = ?";
PreparedStatement query = connect.prepareStatement(sql);

query.setInt(1, myYear);
query.setInt(2, myMonth);
query.setInt(3, myDay);

ResultSet result = query.executeQuery();

while(result.next()){
    dayNameList.add("\""+result.getString(1)+"\"");
    dayTimeList.add("\""+result.getString(2)+"\"");
    dayContentList.add("\""+result.getString(3)+"\"");
}

}catch(Exception e){
    e.printStackTrace(); 
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
        var dayNameList = <%= dayNameList %>
        var dayTimeList = <%= dayTimeList %>
        var dayContentList = <%= dayContentList %>

       
        // alert("내가 선택한 day는 "+day)

        var scheduleList = window.opener.document.getElementById("scheduleList")

        while (scheduleList.firstChild) {
            scheduleList.removeChild(scheduleList.firstChild);
        }
        
            for(var i=0; i<dayNameList.length; i++){
                var currentDateTime = dayTimeList[i]; // 각 요소의 첫 번째 문자열을 가져옵니다.

                var dateTimeParts = currentDateTime.split(' '); // 공백을 기준으로 날짜와 시간을 분할합니다.
                var datePart = dateTimeParts[0]; // 날짜 부분 (YYYY-MM-DD)
                var timePart = dateTimeParts[1]; // 시간 부분 (HH:MM:SS)

                var timeParts = timePart.split(':'); // 콜론을 기준으로 시간과 분을 분할합니다.
                var hourPart = timeParts[0]; // 시간 (HH)
                var minutePart = timeParts[1]; // 분 (MM)

                console.log(hourPart+minutePart)

                // div 구성하기
                var listParent = document.createElement("div")
                listParent.style.display = "flex"
                listParent.style.flexDirectio
                // 내용 넣을 div
                var dayContent = document.createElement("div")
                dayContent.style.border = "2px solid red"
                // 시간 넣을 div
                var timeInput = document.createElement("input");
                timeInput.setAttribute("type", "time");
                var timeValue = hourPart + ":" + minutePart;
                // 시간값 넣기
                timeInput.value = timeValue;
                // 내용 넣기
                dayContent.innerHTML = dayContentList[i]

                listParent.appendChild(timeInput)
                listParent.appendChild(dayContent)
                
                scheduleList.appendChild(listParent)
                
            }
    
        
        window.close()
    </script>
</body>
</html>