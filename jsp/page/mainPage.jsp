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
request.setCharacterEncoding("utf-8");

ArrayList<String> idList = new ArrayList<String>();
ArrayList<String> nameList = new ArrayList<String>();
ArrayList<String> telList = new ArrayList<String>();
ArrayList<String> rankList = new ArrayList<String>();
ArrayList<String> departmentList = new ArrayList<String>();
//팀장일때 필요한 목록들
ArrayList<String> departmentIdList = new ArrayList<String>();
ArrayList<String> departmentNameList = new ArrayList<String>();

int nowYear = 0;
int nowMonth = 0;

boolean valid = true;
String id = (String)session.getAttribute("sessionId");

if(id == null){
    valid = false;
} 
else{
    // 내 정보 표시 
    String name = (String)session.getAttribute("sessionName");
    String tel = (String)session.getAttribute("sessionTel");
    String rank = (String)session.getAttribute("sessionRank");
    String department = (String)session.getAttribute("sessionDepartment");
    Date sessionDate = (Date) session.getAttribute("sessionDate");

    idList.add("\""+id+"\"");
    nameList.add("\""+name+"\"");
    telList.add("\""+tel+"\""); 
    rankList.add("\""+rank+"\"");  
    departmentList.add("\""+department+"\"");

    // 오늘 날짜 계산
    Calendar cal = Calendar.getInstance();
    cal.setTime(sessionDate);
    nowYear = cal.get(Calendar.YEAR); // 년도 가져오기
    nowMonth = cal.get(Calendar.MONTH) + 1; // 월 가져오기 (+1 해야 실제 월 값과 일치)


    // 팀장일 경우 : 해당 부서 팀원들의 모든 이름, id 가져오기
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

    if(rank.equals("1")){
        String sql = "SELECT id, name, department_idx FROM account";
        PreparedStatement query = connect.prepareStatement(sql);

        ResultSet result = query.executeQuery();

        while(result.next()){
            if( result.getString("department").equals(department)){
                departmentIdList.add("\""+result.getString("id")+"\"");
                departmentNameList.add("\""+result.getString("name")+"\"");
            }
        }
    }
    

}
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link type="text/css" rel="stylesheet" href="../../css/common.css">
    <link type="text/css" rel="stylesheet" href="../../css/public.css">
    <link type="text/css" rel="stylesheet" href="../../css/main.css">
    
</head>
<body>
    <div id="backParent">
        <header id="yearParent">
            <div id="triangleLeft" onclick="location.href='../action/yearDownAction.jsp'"></div>
            <div id="year">
                <div>년</div>
            </div>
            <div id="triangleRight" onclick="location.href='../action/yearUpAction.jsp'"></div>
            <div id="month">
                <div id="monthLetter">월</div>
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
                         <!-- <div id="addModalTime"> 
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
                        </div> -->

                        <!-- <div id="addModalSchedule">
                            <form id="modalSchedule" onsubmit="return false">
                                <input type="text" class="modalScheduleComment" id="comment1" value="기획서 작성" disabled>
                                <div>
                                    <input type="submit" class="scheduleBtn" value="수정" onclick="modifySchedule();"> 
                                    <input type="button" class="scheduleBtn" value="삭제"> 
                                </div>
                            </form>
                        </div>     -->

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
       else{
        //현재 년도 표시
        var yearParent = document.getElementById("year")
        var nowYearParent = document.createElement("div")
        var nowYear = <%= nowYear %>
        nowYearParent.innerHTML = nowYear
        yearParent.insertBefore(nowYearParent, yearParent.firstChild);
        
        //현재 월 표시
        var monthParent = document.getElementById("month")
        var nowMonthParent = document.createElement("div")
        var nowMonth = <%= nowMonth %>
        nowMonthParent.innerHTML = nowMonth
        monthParent.insertBefore(nowMonthParent, monthParent.firstChild);
        
        // 내 정보 표시
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


        if(rank == "1"){
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
        

    // 일정 목록 출력 관련
     var addModalTime = document.getElementById("addModalTime")
     var addModalSchedule = document.getElementById("addModalSchedule")
     var modalScheduleBox = document.getElementById("modalScheduleBox")

     for(var i=0; i<nameList.length; i++){
             //시간 관련
             // △△
            var modalTime = document.createElement("div")
            modalTime.id = "addModalTime"

             var upDiv = document.createElement("div")
             upDiv.style.display = 'flex'
             upDiv.style.flexDirection = 'row'
             upDiv.style.justifyContent = "center"
      
             var hourUpBtn = document.createElement("div")
             hourUpBtn.id = "hourUpBtn"
             hourUpBtn.className = "triangleTop"

             var minuteUpBtn = document.createElement("div")
             minuteUpBtn.id = "minuteUpBtn"
             minuteUpBtn.className = "triangleTop"
          
             upDiv.appendChild(hourUpBtn)
             upDiv.appendChild(minuteUpBtn)
             //
             // ㅁ:ㅁ
             var timeDiv = document.createElement("div")
             timeDiv.style.display = "flex"
             timeDiv.style.flexDirection = "row"
             timeDiv.style.textAlign = "center"
             timeDiv.style.justifyContent = "center"
             timeDiv.style.border = "2px solid orange"
             timeDiv.style.borderRadius = "10px"
             var hour = document.createElement("input")
             hour.type = "text"
             hour.className = "addTime"
             hour.value = hourList[i]

             var dot = document.createElement("div")
             dot.innerHTML = ":"

             var minute = document.createElement("input")
             minute.type = "text"
             minute.className = "addTime"
             minute.value = minuteList[i]

             timeDiv.appendChild(hour)
             timeDiv.appendChild(dot)
             timeDiv.appendChild(minute)
             //

             //▽▽
             var downDiv = document.createElement("div")
             downDiv.style.display = 'flex'
             downDiv.style.flexDirection = 'row'
             downDiv.style.justifyContent = "center"

             var hourDownBtn = document.createElement("div")
             hourDownBtn.id = "hourDownBtn"
             hourDownBtn.className = "triangleBottom"

             var minuteDownBtn = document.createElement("div")
             minuteDownBtn.id = "minuteDownBtn"
             minuteDownBtn.className = "triangleBottom"

             downDiv.appendChild(hourDownBtn)
             downDiv.appendChild(minuteDownBtn)

            //  addModalTime.appendChild(upDiv)
            //  addModalTime.appendChild(timeDiv)
            //  addModalTime.appendChild(downDiv)

            modalTime.appendChild(upDiv)
            modalTime.appendChild(timeDiv)
            modalTime.appendChild(downDiv)
                                   
             
             // ▽ 일정 목록
            var modalScheduleList = document.createElement("div")
            modalScheduleList.id= "addModalSchedule"

             var scheduleDiv = document.createElement("div")
             scheduleDiv.style.display = "flex"
             scheduleDiv.style.flexDirection = "row"
             scheduleDiv.style.justifyContent = "center"
             scheduleDiv.style.border = "2px solid orange"
             scheduleDiv.style.borderRadius = "10px"

             var scheduleText = document.createElement("input")
             scheduleText.type = "text"
             scheduleText.value = contentList[i]
             scheduleText.disabled = true

             var modifyBtn = document.createElement("input")
             modifyBtn.type = "button"
             modifyBtn.class ="scheduleBtn"
             modifyBtn.value = "수정"
             modifyBtn.onclick = function(){
                modifySchedule(this)
             }
             
             var deleteBtn = document.createElement("input")
             deleteBtn.type = "button"
             deleteBtn.class = "scheduleBtn"
             deleteBtn.value = "삭제"
             deleteBtn.onclick = function(){
                deleteSchedule(this)
             }

             scheduleDiv.appendChild(scheduleText)
             scheduleDiv.appendChild(modifyBtn)
             scheduleDiv.appendChild(deleteBtn)

             //addModalSchedule.appendChild(scheduleDiv)
             modalScheduleList.appendChild(scheduleDiv)

             var listOneParent = document.createElement("div")
             listOneParent.style.display = "flex"
             listOneParent.style.flexDirection = "row"

             listOneParent.appendChild(modalTime)
             listOneParent.appendChild(modalScheduleList)

            modalScheduleBox.appendChild(listOneParent)

 }



    </script>
</body>
</html>

<!-- 스케줄이 있을때 띄우는 박스 : scheduleBox! -->