<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("sessionId");

boolean valid = true;

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
        <div id="yearParent">
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
        </div>

        <div id="monthBtnArea">
            <div id="monthBtnParent"></div> <!--월 표시 칸-->
            <img src="../img/sidebar.png" onclick="openNav()" id="navBtn">
        </div>
        <table id="calendar">
            
                <!-- <td>3 <br> <input type="button" id="scheduleBox" value="3"> </td> -->
           
           

        </table>


        <!-- 평소에는 안보이는창 -->
        <div id="modal">
            <div id="modalContents">
                <div id="modalDate">
                    <span>2023</span>년
                    <span>11</span>월
                    <span>1</span>일
                </div>

                <div id="modalScheduleParent"> 

                    <div id="modalScheduleBox"> <!-- 일반 일정 출력 목록-->
                        
                        <div id="addModalTime"> <!-- 이 버튼은 평소에 안보이게-->
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
                                <!-- disabled는 readonly와 다르게 form 전송할때 전송안됨 -->
                                <div>
                                    <input type="submit" class="scheduleBtn" value="수정" onclick="modifySchedule();"> 
                                    <input type="button" class="scheduleBtn" value="삭제"> 
                                </div>
                            </form>
                        </div>  

                    </div>

                    <!-- 구분선 -->

                    <div id="modalScheduleAdd"> <!-- 일정 추가 칸-->

                        <div id="addModalTime">
                            <div id="updownBtn">
                                <div class="triangleTop" id="addHourUpBtn"></div>
                                <div class="triangleTop" id="minuteUpBtn" ></div>
                            </div>

                            <div id="modalTime">
                                <input type="button" id="hour" value="10">
                                <div> : </div>
                                <input type="button" id="minute" value="35">
                            </div>

                            <div id="updownBtn">
                                <div class="triangleBottom" id="hourDownBtn" ></div>
                                <div class="triangleBottom" id="minuteDownBtn" ></div>                        
                            </div>
                        </div>
                        
                        <div id="addModalSchedule">
                            <div id="modalSchedule">
                                <input type="text" id="modalScheduleComment" placeholder="내용을 추가하세요">
                                <div>
                                    <input type="button" class="scheduleBtn" value="추가"> 
                                </div>
                            </div>
                        </div>
                    </div>

                    <img src="../img/x.png" id="xImg">
            </div>    
        </div>
    </div>

    <!-- 사이드바 -->
    <div id="navBar">
        <div id="myInformParent">
            <div id="myInformComment">내 정보</div>
            <div>
                <div>이름 : 조희주</div>
                <div>Id : myid</div>
                <div>전화번호 : 010-1234-5678</div>
                <div>직급 : 팀원</div>
                <div>부서 : 개발팀</div>
            </div>
        </div>

        <div id="modifyMyInformParent">
            <input type="button" id="modifyBtn" value="정보 수정" onclick="location.href='modifyInform.jsp'">
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

       if(valid == false){
            alert("로그인 하십시오!")
            location.href = "../index.html"
       }

    </script>
</body>
</html>

<!-- 스케줄이 있을때 띄우는 박스 : scheduleBox! -->