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

//내 정보 표시
ArrayList<String> idList = new ArrayList<String>();
ArrayList<String> nameList = new ArrayList<String>();
ArrayList<String> telList = new ArrayList<String>();
ArrayList<String> rankList = new ArrayList<String>();
ArrayList<String> departmentList = new ArrayList<String>();
//팀장일때 필요한 목록들
ArrayList<String> departmentIdList = new ArrayList<String>();
ArrayList<String> departmentNameList = new ArrayList<String>();

//일정개수가 있는 일만 담음
ArrayList<Integer> scheduleDayList = new ArrayList<Integer>();
//일정개수 담은 list
ArrayList<Integer> scheduleCountList = new ArrayList<Integer>();
// 팀원 list

int nowYear = 0;
int nowMonth = 0;

boolean valid = true;
String id = (String)session.getAttribute("sessionId");

if(id == null){
    valid = false;
} 
else{
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

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

    // 해당 년, 월의 일정 목록 가져오기 -> 개수 표시할 때 필요
    int [] scheduleCount = new int[31];
    String sql2 = "SELECT DAY(date) AS day,COUNT(*) as dayCount FROM schedule WHERE YEAR(date) = ? AND MONTH(date) = ? GROUP BY DAY(date)";
    PreparedStatement query2 = connect.prepareStatement(sql2);
    
    query2.setInt(1, nowYear);
    query2.setInt(2, nowMonth);

    ResultSet result2 = query2.executeQuery();


    while(result2.next()){
        int day = result2.getInt("day");
        int count = result2.getInt("dayCount");

        scheduleDayList.add(day); // 10일에
        scheduleCountList.add(count); // 일정 4개

    }

    // 팀장일 경우 : 해당 부서 팀원들의 모든 이름, id 가져오기
   
    if(rank.equals("1")){
        int timoneIdx = 2;
        int departmentIdx = Integer.parseInt(department);
        
        String sql = "SELECT id, name FROM account WHERE rank_idx =? AND department_idx = ?";
        PreparedStatement query = connect.prepareStatement(sql);

        query.setInt(1, timoneIdx);
        query.setInt(2, departmentIdx);

        ResultSet result = query.executeQuery();

        while(result.next()){
                departmentIdList.add("\""+result.getString("id")+"\"");
                departmentNameList.add("\""+result.getString("name")+"\"");
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
            <div id="memberName"></div>
        </header>

        <div id="monthBtnArea">
            <div id="monthBtnParent"></div> <!--월 표시 칸-->
            <img src="../../img/sidebar.png" onclick="openNav()" id="navBtn">
        </div>
        <table id="calendar">
            <!-- <td>3 <br> <input type="button" id="scheduleBox" value="3"> </td> -->
        </table>

        <!-- 평소에는 안보이는창 -->
        <nav id="modal">
            <div id="modalContents">
                
                <header id="modalDate">
                    <input type="text" id="modalYear" name="modalYearName" class="modalDate" readonly>년
                    <input type="text" id="modalMonth" name="modalMonthName" class="modalDate" readonly>월
                    <input type="text" id="modalDay" name="modalDayName" class="modalDate" readonly>일
                </header>

                <div id="modalScheduleParent"> 

                    <div id="modalScheduleBox"> <!-- 일반 일정 출력 목록-->
                            <div id="scheduleList">
                                
                            </div>
                    </div>

                
                    <!-- 일정 추가 칸-->
                    <form action="../action/addScheduleAction.jsp" id="modalScheduleAdd"> 
                        <!-- 시간칸 -->
                        <div id="addModalTime"> 
                            <div id="modalTime">
                                <input type="time" id="timebox" name="addScheduleTime">
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

                    </form>
                    <img src="../../img/x.png" id="xImg">
                </div>    
            </div>
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
            <input type="button" id="logOutBtn" value="로그아웃" onclick="location.href='../action/logoutAction.jsp'">
        </div>

        <div id="quitParent">
            <input type="button" id="quitBtn" value="회원 탈퇴" onclick="location.href='quitPage.jsp'">
        </div>

        <!-- 팀장일때만 보이게 처리 (jsp) -->
        <div id="memberListParent">
            
            
        </div>

        <img src="../../img/x.png" id="navCloseBtn" onclick="closeNav()">

    </div>


    <script src="../../js/main.js"></script>

    <script>
        // ▽ 내 정보 표시 관련

        var valid = <%= valid %>
        var id = <%= idList %>
        var name = <%= nameList %>
        var tel = <%= telList %>
        var rank = <%= rankList %>
        var department = <%= departmentList %>

        // 일정이 있는 날짜, 개수
        var scheduleDayList = <%= scheduleDayList %>
        var scheduleCount = <%= scheduleCountList %>

        console.log("현재 sessionId : "+id)
        console.log("현재 sessionName : "+name)
        console.log("현재 sessionTel : "+tel)
        console.log("현재 sessionRank : "+rank)
        console.log("현재 sessionDepartment : "+department)

        
        
        // 로그인 상태가 아니면 mainPage에 들어올 수 없도록 처리
       if(valid == false){
            alert("로그인 하십시오!")
            location.href = "../../index.html"
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
        if(rank == 1){
            rankDiv.innerHTML = "팀장"
        }
        if(rank == 2){
            rankDiv.innerHTML = "팀원"
        }

        var departmentDiv = document.createElement("span")
        if(department == 1){
            departmentDiv.innerHTML = "개발팀"
        }
        if(department == 2){
            departmentDiv.innerHTML = "디자인팀"
        }
        
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
                    window.location.href = "../action/goToMemberAction.jsp?id=" + memberId + "&name=" + memberName;
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

            //  var memberNameParent = document.getElementById("clickName")
            //  var memberName = document.createElement("div")
            // //  memberName.innerHTML = clickName

            // console.log(clickName)
            //  memberNameParent.appendChild(memberName)
        }

        }
        // △ 내 정보 표시 관련

        for(var i=0; i<5; i++){
            var newRow = calendarParent.insertRow()
            for(var j=0; j<7; j++){
                var newCell = newRow.insertCell()
                newCell.classList.add("myNewCell")

                if(i<4){
                    newCell.innerHTML = i*7 + (j+1)
                    newCell.id = "day"+(i*7+(j+1))

                    newCell.onclick = function(){
                        modal.style.display = "block"
                        var dateValues = displayDate(this)
                        var myDay = dateValues.day
                        window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=-100, top=-100,  scrollbars=no,status=no,toolbar=no,menubar=no,resizeable=no,location=no")
                    }
                }
                else{
                    if(j == 0){
                        newCell.id = "day29"

                        newCell.onclick = function(){
                            modal.style.display = "block"
                            var dateValues = displayDate(this)
                            var myDay = dateValues.day
                            window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=screen.width,top=screen.height ")
                        }
                    }
                    else if(j == 1){
                        newCell.id = "day30"

                        newCell.onclick = function(){
                            modal.style.display = "block"
                            var dateValues = displayDate(this)
                            var myDay = dateValues.day
                            window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=screen.width,top=screen.height ")
                        }
                    }
                    else if(j == 2){
                        newCell.id = "day31"

                        newCell.onclick = function(){
                            modal.style.display = "block"
                            var dateValues = displayDate(this)
                            var myDay = dateValues.day
                            window.open("../action/printModalScheduleAction.jsp?myDay="+myDay, "daySelect", " width=1, height=1, left=screen.width,top=screen.height ")
                        }
                    }
                    else{
                        newCell.innerHTML = ""
                    }
                }
            } 
}

for (var i = 0; i < scheduleDayList.length; i++) {

    // 일정이 있는 날짜값 가져옴
    var dayNumber = scheduleDayList[i];

    var mycell = document.getElementById("day"+dayNumber)
    console.log(mycell.innerHTML)

    var countDiv = document.createElement("div");

    // 일정 개수 표시
    if(scheduleCount[i] > 9){
        countDiv.innerHTML = "9+"
    }
    else{
        countDiv.innerHTML = scheduleCount[i];
    }
        
    countDiv.style.width = "30%";
    countDiv.style.borderRadius = "10px";
    countDiv.style.border = "2px solid orange";

    mycell.appendChild(countDiv);

}

    </script>
</body>
</html>
