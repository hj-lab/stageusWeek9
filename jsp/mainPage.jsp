<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
request.setCharacterEncoding("utf-8");

// 내 정보 표시 
boolean valid = true;
String id = (String)session.getAttribute("sessionId");
String name = (String)session.getAttribute("sessionName");
String tel = (String)session.getAttribute("sessionTel");
String rank = (String)session.getAttribute("sessionRank");
String department = (String)session.getAttribute("sessionDepartment");

ArrayList<String> idList = new ArrayList<String>();
    idList.add("\""+id+"\"");
    
ArrayList<String> nameList = new ArrayList<String>();
    nameList.add("\""+name+"\"");
    
ArrayList<String> telList = new ArrayList<String>();
    telList.add("\""+tel+"\"");
    
ArrayList<String> rankList = new ArrayList<String>();
    rankList.add("\""+rank+"\"");
    
ArrayList<String> departmentList = new ArrayList<String>();
    departmentList.add("\""+department+"\"");


// 팀장일 경우를 대비한 해당 부서의 이름, id 가져오기
Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

String sql = "SELECT id, name, department FROM account";
PreparedStatement query = connect.prepareStatement(sql);

ResultSet result = query.executeQuery();


ArrayList<String> departmentIdList = new ArrayList<String>();
ArrayList<String> departmentNameList = new ArrayList<String>();

while(result.next()){
    if( result.getString("department").equals(department)){
        departmentIdList.add("\""+result.getString("id")+"\"");
        departmentNameList.add("\""+result.getString("name")+"\"");
    }
}


if(id == null){
    valid = false;
} 
// △ 내 정보 표시 관련

// ▽ 모달창에서 일정 보이기 관련

List<List<String>> DayScheduleList = (List<List<String>>) session.getAttribute("sessionDaySchedule");
String modalYear = (String)session.getAttribute("sessionModalYear");
String modalMonth = (String)session.getAttribute("sessionModalMonth");
String modalDay = (String)session.getAttribute("sessionModalDay");

ArrayList<String>modalNameList = new ArrayList<String>();
ArrayList<String>modalIdList = new ArrayList<String>();
ArrayList<String>modalHourList = new ArrayList<String>();
ArrayList<String>modalMinuteList = new ArrayList<String>();
ArrayList<String>modalContentList = new ArrayList<String>();

if (DayScheduleList != null) {
    for (int i = 0; i < DayScheduleList.size(); i++) {
        String nameValue = DayScheduleList.get(i).get(0); // DayScheduleList의 각 행의 첫 번째 열 값
        modalNameList.add("\"" + nameValue + "\""); // 큰따옴표 추가 후 idList에 추가

        String idValue = DayScheduleList.get(i).get(1);
        modalIdList.add("\"" + idValue + "\"");

        String hourValue = DayScheduleList.get(i).get(2);
        modalHourList.add("\"" + hourValue + "\"");

        String minuteValue = DayScheduleList.get(i).get(3);
        modalMinuteList.add("\"" + minuteValue + "\"");

        String contentValue = DayScheduleList.get(i).get(4);
        modalContentList.add("\"" + contentValue + "\"");
    }
}

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link type="text/css" rel="stylesheet" href="../css/common.css">
    <link type="text/css" rel="stylesheet" href="../css/public.css">
    <link type="text/css" rel="stylesheet" href="../css/main.css">
    
</head>
<body>
    <div id="backParent">
        <header id="yearParent">
            <div id="triangleLeft" onclick="yearDown()"></div>
            <div>
                <input type="button" id="year">
                <span>년</span>
            </div>
            <div id="triangleRight" onclick="yearUp()"></div>
            <div>
                <input type="button" id="month">
                <span id="monthLetter">월</span>
            </div>

            <!-- 팀장일때만 출력하는 요소 -->
            <div id="memberName">조희주 팀원</div>
        </header>

        <div id="monthBtnArea">
            <div id="monthBtnParent"></div> <!--월 표시 칸-->
            <img src="../img/sidebar.png" onclick="openNav()" id="navBtn">
        </div>
        <table id="calendar">
            <!-- <td>3 <br> <input type="button" id="scheduleBox" value="3"> </td> -->
        </table>

        <!-- 평소에는 안보이는창 -->
        <nav id="modal">
            <form action="addScheduleAction.jsp" id="modalContents">
                <header id="modalDate">
                    <input type="text" id="modalYear" name="modalYearName" class="modalDate" readonly>년
                    <input type="text" id="modalMonth" name="modalMonthName" class="modalDate" readonly>월
                    <input type="text" id="modalDay" name="modalDayName" class="modalDate" readonly>일
                </header>

                <div id="modalScheduleParent"> 

                    <div id="modalScheduleBox"> <!-- 일반 일정 출력 목록-->
                        <!--이거 js에서 동적으로 생성하게 하자-->
                        <!-- 그리고 이 칸에 스크롤 기능 넣기 !!-->

                        <!-- 이 버튼은 평소에 안보이게-->
                         <div id="addModalTime"> 
                            <div id="hideUpBtn">
                                <div class="triangleTop" id="hourUpBtn" onclick="hourUp()"></div>
                                <div class="triangleTop"  id="minuteUpBtn" onclick="minuteUp()"></div>
                            </div>

                            <div id="modalTime">
                                <input type="button" id="hour" value="9">
                                <div> : </div>
                                <input type="button" id="minute" value="30">
                            </div>

                            <div id="hideDownBtn">
                                <div class="triangleBottom" id="hourDownBtn" onclick="hourDown()"></div>
                                <div class="triangleBottom" id="minuteDownBtn" onclick="minuteDown()"></div>                        
                            </div>
                        </div>

                        <div id="addModalSchedule">
                            <!-- <form id="modalSchedule" onsubmit="return false">
                                <input type="text" class="modalScheduleComment" id="comment1" value="기획서 작성" disabled>
                                <div>
                                    <input type="submit" class="scheduleBtn" value="수정" onclick="modifySchedule();"> 
                                    <input type="button" class="scheduleBtn" value="삭제"> 
                                </div>
                            </form> -->
                        </div>    

                    </div>

                
                    <!-- 일정 추가 칸-->
                    <div id="modalScheduleAdd"> 

                        <!-- 시간칸 -->
                        <div id="addModalTime">
                            <div id="updownBtn">
                                <div class="triangleTop" id="addHourUpBtn" onclick="hourUp()"></div>
                                <div class="triangleTop" id="minuteUpBtn" onclick="minuteUp()"></div>
                            </div>

                            <div id="modalTime">
                                <input type="text" id="addHour" name="addHourName" class="addTime" readonly>
                                <div> : </div>
                                <input type="text" id="addMinute" name="addMinuteName" class="addTime" value="00" readonly>
                            </div>

                            <div id="updownBtn">
                                <div class="triangleBottom" id="hourDownBtn" onclick="hourDown()" ></div>
                                <div class="triangleBottom" id="minuteDownBtn" onclick="minuteDown()" ></div>                        
                            </div>
                        </div>
                        
                        <!-- 일정칸 -->
                        <div id="addModalSchedule">
                            <div id="modalSchedule">
                                <input type="text" id="modalComment" class="modalScheduleComment" placeholder="내용을 추가하세요" name="addScheduleName">
                                <div>
                                    <input type="submit" class="scheduleBtn" value="추가"> 
                                </div>
                            </div>
                        </div>

                    </div>
                    <img src="../img/x.png" id="xImg">
                </div>    
            </form>
        </nav>

    <!-- 사이드바 -->
    <div id="navBar">
        <div id="myInformParent">
            <div id="myInformComment">내 정보</div>
            <div>
                <div id="myName">이름 : </div>
                <div id="myId">Id : </div>
                <div id="myTel">전화번호 : </div>
                <div id="myRank">직급 : </div>
                <div id="myDepartment">부서 : </div>
            </div>
        </div>

        <div id="modifyMyInformParent">
            <input type="button" id="modifyBtn" value="정보 수정" onclick="location.href='modifyInformPage.jsp'">
        </div>

        <div id="logOutParent">
            <input type="button" id="logOutBtn" value="로그아웃" onclick="location.href='logoutAction.jsp'">
        </div>

        <div id="quitParent">
            <input type="button" id="quitBtn" value="회원 탈퇴" onclick="location.href='quitPage.jsp'">
        </div>

        <!-- 팀장일때만 보이게 처리 (jsp) -->
        <div id="memberListParent">
            
            
        </div>

        <img src="../img/x.png" id="navCloseBtn" onclick="closeNav()">

    </div>


    <script src="../js/main.js"></script>

    <script>
        // ▽ 내 정보 표시 관련
        var valid = <%= valid %>
        var id = <%= idList %>
        var name = <%= nameList %>
        var tel = <%= telList %>
        var rank = <%= rankList %>
        var department = <%= departmentList %>

        console.log("현재 sessionId : "+id)
        console.log("현재 sessionName : "+name)
        console.log("현재 sessionTel : "+tel)
        console.log("현재 sessionRank : "+rank)
        console.log("현재 sessionDepartment : "+department)

        // 로그인 상태가 아니면 mainPage에 들어올 수 없도록 처리
       if(valid == false){
            alert("로그인 하십시오!")
            location.href = "../index.html"
       }
       else{ // 내 정보 표시
        var myName = document.getElementById("myName")
        var myId = document.getElementById("myId")
        var myTel = document.getElementById("myTel")
        var myRank = document.getElementById("myRank")
        var myDepartment = document.getElementById("myDepartment")

        var nameDiv = document.createElement("span")
        nameDiv.innerHTML = name
        var idDiv = document.createElement("span")
        idDiv.innerHTML = id
        var telDiv = document.createElement("span")
        telDiv.innerHTML = tel
        var rankDiv = document.createElement("span")
        rankDiv.innerHTML = rank
        var departmentDiv = document.createElement("span")
        departmentDiv.innerHTML = department
        
        myName.appendChild(nameDiv)
        myId.appendChild(idDiv)
        myTel.appendChild(telDiv)
        myRank.appendChild(rankDiv)
        myDepartment.appendChild(departmentDiv)

        if(rank == "팀장"){
             var memberListParent = document.getElementById("memberListParent")
             var departmentIdList = <%=departmentIdList%>
             var departmentNameList = <%=departmentNameList%>

             var headerDiv = document.createElement("h4")
             headerDiv.innerHTML = "팀원 List"
             memberListParent.appendChild(headerDiv)

             for(var i=0; i<departmentIdList.length; i++){
                let memberId = departmentIdList[i]
                let memberName = departmentNameList[i]

                var departmentList = document.createElement("div") // 여기에 onclick 줘서 팀원 일정창으로 넘어가게
                departmentList.onclick = function() {
                    window.location.href = "goToMemberPage.jsp?id=" + memberId + "&name=" + memberName;
                };

                var departmentIdDiv = document.createElement("span")
                var dot = document.createElement("span")
                var departmentNameDiv = document.createElement("span")
                
                dot.innerHTML = " - "
                departmentIdDiv.innerHTML = departmentIdList[i]
                departmentNameDiv.innerHTML = departmentNameList[i]

                departmentList.appendChild(departmentIdDiv)
                departmentList.appendChild(dot)
                departmentList.appendChild(departmentNameDiv)
                
                memberListParent.appendChild(departmentList)
             }
        }

        }

        // △ 내 정보 표시 관련

        // ▽ 모달창에서 일정 목록 보이기 관련
        // window.onload = function(){
        // var nameList = <%= modalNameList %>
        // var idList = <%= modalIdList %>
        // var hourList = <%= modalHourList %>
        // var minuteList = <%= modalMinuteList %>
        // var contentList = <%= modalContentList %>
        
        // console.log("nameList : "+nameList)
        // console.log("idList : "+idList)
        // console.log("hourList : "+hourList)
        // }
      
        //window.addEventListener('DOMContentLoaded', function(){
            var nameList = <%= modalNameList %>
            var idList = <%= modalIdList %>
            var hourList = <%= modalHourList %>
            var minuteList = <%= modalMinuteList %>
            var contentList = <%= modalContentList %>
            var modalYear = <%= modalYear %>
            var modalMonth = <%= modalMonth %>
            var modalDay = <%= modalDay %>
            
            var scheduleCount = nameList.length
            
            console.log("nameList : "+nameList)
            console.log("idList : "+idList)
            console.log("hourList : "+hourList)
            console.log("yearList : "+modalYear)
            console.log("monthList : "+modalMonth)
            console.log("dayList : "+modalDay)

	   // });
        

    
//     var addModalTime = document.getElementById("addModalTime")

//     for(var i=0; i<nameList.length; i++){
//             //시간 관련
//             // △△
//             var upDiv = document.createElement("div")
//             upDiv.style.display = 'flex'
//             upDiv.style.flexDirection = 'row'
//             upDiv.style.justifyContent = "center"
        
//             var hourUpBtn = document.createElement("div")
//             hourUpBtn.id = "hourUpBtn"
//             hourUpBtn.className = "triangleTop"

//             var minuteUpBtn = document.createElement("div")
//             minuteUpBtn.id = "minuteUpBtn"
//             minuteUpBtn.className = "triangleTop"
            
//             upDiv.appendChild(hourUpBtn)
//             upDiv.appendChild(minuteUpBtn)
//             //

//             // ㅁ:ㅁ
//             var timeDiv = document.createElement("div")
//             timeDiv.style.display = "flex"
//             timeDiv.style.flexDirection = "row"
//             timeDiv.style.textAlign = "center"
//             timeDiv.style.justifyContent = "center"
//             timeDiv.style.border = "2px solid orange"
//             timeDiv.style.borderRadius = "10px"

//             var hour = document.createElement("input")
//             hour.type = "text"
//             hour.className = "addTime"
//             hour.value = hourList[i]

//             var dot = document.createElement("div")
//             dot.innerHTML = ":"

//             var minute = document.createElement("input")
//             minute.type = "text"
//             minute.className = "addTime"
//             minute.value = minuteList[i]

//             timeDiv.appendChild(hour)
//             timeDiv.appendChild(dot)
//             timeDiv.appendChild(minute)
//             //

//             //▽▽
//             var downDiv = document.createElement("div")
//             downDiv.style.display = 'flex'
//             downDiv.style.flexDirection = 'row'
//             downDiv.style.justifyContent = "center"

//             var hourDownBtn = document.createElement("div")
//             hourDownBtn.id = "hourDownBtn"
//             hourDownBtn.className = "triangleBottom"

//             var minuteDownBtn = document.createElement("div")
//             minuteDownBtn.id = "minuteDownBtn"
//             minuteDownBtn.className = "triangleBottom"

//             downDiv.appendChild(hourDownBtn)
//             downDiv.appendChild(minuteDownBtn)

//             addModalTime.appendChild(upDiv)
//             addModalTime.appendChild(timeDiv)
//             addModalTime.appendChild(downDiv)
                                        
// }



    </script>
</body>
</html>

<!-- 스케줄이 있을때 띄우는 박스 : scheduleBox! -->