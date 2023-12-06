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
ArrayList<Integer> idxList = new ArrayList<Integer>();

try{
// 년, 월, 일 추출
int myYear = cal.get(Calendar.YEAR);
int myMonth = cal.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줌
int myDay = cal.get(Calendar.DAY_OF_MONTH);


Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

String sql = "SELECT idx, name, date, content FROM schedule WHERE YEAR(date) = ? AND MONTH(date) = ? AND DAY(date) = ?";
PreparedStatement query = connect.prepareStatement(sql);

query.setInt(1, myYear);
query.setInt(2, myMonth);
query.setInt(3, myDay);

ResultSet result = query.executeQuery();

while(result.next()){
    idxList.add(result.getInt(1));
    dayNameList.add("\""+result.getString(2)+"\"");
    dayTimeList.add("\""+result.getString(3)+"\"");
    dayContentList.add("\""+result.getString(4)+"\"");
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
        var idxList = <%= idxList %>

        var scheduleList = window.opener.document.getElementById("scheduleList")

        // 안에 내용이 있으면 삭제하고 다시 넣기
        while (scheduleList.firstChild) {
            scheduleList.removeChild(scheduleList.firstChild);
        }
        
            for(var i=0; i<dayNameList.length; i++){
                var currentDateTime = dayTimeList[i];

                var dateTimeParts = currentDateTime.split(' '); // 공백 기준 날짜, 시간 분할
                var datePart = dateTimeParts[0]; // 날짜 부분 (YYYY-MM-DD)
                var timePart = dateTimeParts[1]; // 시간 부분 (HH:MM:SS)

                var timeParts = timePart.split(':'); 
                var hourPart = timeParts[0]; // 시간 (HH)
                var minutePart = timeParts[1]; // 분 (MM)

                console.log(hourPart+minutePart)

                // div 구성하기
                var listParent = document.createElement("div")
                listParent.style.display = "flex"
                listParent.style.flexdirection = "column"
                // 내용, 수정버튼, 삭제 버튼 넣을 div
                var dayContentParent = document.createElement("div")
                dayContentParent.style.display = "flex"
                dayContentParent.style.flexdirection = "row"
                dayContentParent.style.justifycontent = "space-between"
                dayContentParent.style.alignItems = "center"
                dayContentParent.style.borderRadius = "10px";
                dayContentParent.style.border = "2px solid orange";
                dayContentParent.style.padding = "3px";
                dayContentParent.style.margin = "3px";
                dayContentParent.style.width = "80%";

                // 내용 넣을 input type="text"
                var content = document.createElement("input")
                content.setAttribute("type", "text")
                content.setAttribute("disabled", true)
                // 내용 넣기
                content.value = dayContentList[i]
                // input type="text"에 해당 목록의 고유한 idx값을 id로
                content.id = idxList[i]
                content.classList.add("contentClass")

                // 수정버튼
                var modifyBtn = document.createElement("input")
                modifyBtn.setAttribute("type", "button")
                modifyBtn.value = "수정"
                modifyBtn.id = "modifyBtn"
                modifyBtn.style.width = "40px"
                modifyBtn.style.height = "20px"
                modifyBtn.classList.add("modifyBtnClass")

                // 삭제버튼
                var deleteBtn = document.createElement("input")
                deleteBtn.setAttribute("type", "button")
                deleteBtn.value = "삭제"
                deleteBtn.id = "deleteBtn"
                deleteBtn.style.width = "40px"
                deleteBtn.style.height = "20px"
                deleteBtn.classList.add('deleteBtnClass')
                console.log(deleteBtn)

                dayContentParent.appendChild(content)
                dayContentParent.appendChild(modifyBtn)
                dayContentParent.appendChild(deleteBtn)
                
                // 시간 넣을 div
                var timeInput = document.createElement("input")
                timeInput.setAttribute("type", "time")
                timeInput.setAttribute("disabled", true)
                timeInput.style.borderRadius = "10px"
                timeInput.style.border = "2px solid orange"
                timeInput.style.padding = "3px"
                timeInput.style.margin = "3px"
                timeInput.classList.add('timeInputClass')

                var timeValue = hourPart + ":" + minutePart
                // 시간값 넣기
                timeInput.value = timeValue
                
                

                listParent.appendChild(timeInput)
                listParent.appendChild(dayContentParent)
                
                scheduleList.appendChild(listParent)
                
            }
    
        window.opener.postMessage('myPost', '*');
       window.close()
    </script>
</body>
</html>