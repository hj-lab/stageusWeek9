<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");

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

if(id == null){
    valid = false;
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
                    <span id="modalYear" name="modalYearName"></span>년
                    <span id="modalMonth" name="modalMonthName"></span>월
                    <span id="modalDay" name="modalDayName"></span>일
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
                        </div>

                        <div id="addModalSchedule">
                            <form id="modalSchedule" onsubmit="return false">
                                <input type="text" class="modalScheduleComment" id="comment1" value="기획서 작성" disabled>
                                <div>
                                    <input type="submit" class="scheduleBtn" value="수정" onclick="modifySchedule();"> 
                                    <input type="button" class="scheduleBtn" value="삭제"> 
                                </div>
                            </form>
                        </div>   -->

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
                                <input type="button" id="addHour" name="addHourName">
                                <div> : </div>
                                <input type="button" id="addMinute" name="addMinuteName" value="0">
                            </div>

                            <div id="updownBtn">
                                <div class="triangleBottom" id="hourDownBtn" onclick="hourDown()" ></div>
                                <div class="triangleBottom" id="minuteDownBtn" onclick="minuteDown()" ></div>                        
                            </div>
                        </div>
                        
                        <!-- 일정칸 -->
                        <div id="addModalSchedule">
                            <div id="modalSchedule">
                                <input type="text" class="modalScheduleComment" placeholder="내용을 추가하세요" name="addScheduleName">
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
            <input type="button" id="logOutBtn" value="로그아웃">
        </div>

        <div id="quitParent">
            <input type="button" id="quitBtn" value="회원 탈퇴">
        </div>

        <!-- 팀장일때만 보이게 처리 (jsp) -->
        <div id="memberListParent">
            <div id="memberListComment">팀원 list</div>
            <div>김땡땡 팀원</div>
        </div>

        <img src="../img/x.png" id="navCloseBtn" onclick="closeNav()">

    </div>


    <script src="../js/main.js"></script>

    <script>
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

        }

    </script>
</body>
</html>

<!-- 스케줄이 있을때 띄우는 박스 : scheduleBox! -->