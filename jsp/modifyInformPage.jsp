<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");


String sessionId = (String)session.getAttribute("sessionId");
String sessionPw = (String)session.getAttribute("sessionPw");
String sessionName = (String)session.getAttribute("sessionName");
String sessionTel = (String)session.getAttribute("sessionTel");
String sessionRank = (String)session.getAttribute("sessionRank");
String sessionDepartment = (String)session.getAttribute("sessionDepartment");

ArrayList<String>id = new ArrayList<String>();
id.add("\""+sessionId+"\"");

ArrayList<String>pw = new ArrayList<String>();
    pw.add("\""+sessionPw+"\"");

ArrayList<String>name = new ArrayList<String>();
    name.add("\""+sessionName+"\"");

ArrayList<String>tel = new ArrayList<String>();
    tel.add("\""+sessionTel+"\"");

ArrayList<String>rank = new ArrayList<String>();
    rank.add("\""+sessionRank+"\"");

ArrayList<String>department = new ArrayList<String>();
    department.add("\""+sessionDepartment+"\"");    

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
    <link type="text/css" rel="stylesheet" href="../css/modifyInform.css">
    <link type="text/css" rel="stylesheet" href="../css/common.css">
    <link type="text/css" rel="stylesheet" href="../css/public.css">
</head>
<body>
    <div id="backParent">
        <h1 id="modifyComment">내 정보 수정</h1>

        <button onclick="history.back()" id="backBtn">이전으로</button>

        <form name="myform" action="modifyInformAction.jsp" id="myform" onsubmit="blankCheck(event)">
            <div id="idParent">
                <span>id : </span>
                <input type="text" id="idValue" name="id" class="inputBox">
                <input type="button" id="duplicateBtn" value="중복확인" onclick="idCheckEvent()">
            </div>

            <div id="pwParent">
                <span>비밀번호 : </span>
                <input type="password" id="pwValue" name="pw" class="inputBox" >
            </div>
            
            <div id="pwCheckParent">
                <span>비밀번호 확인 : </span>
                <input type="password" id="pwCheckValue" class="inputBox">
            </div>
            
            <div id="nameParent">
                <span>이름 : </span>
                <input type="text" id="nameValue" name="name" class="inputBox">
            </div>

            <div id="telParent">
                <span>전화번호 : </span>
                <input type="text" id="telValue" name="tel" class="inputBox">
            </div>

            <div id="rankParent">
                <div id="Btn">직급</div>
                <input type="radio" name="rank" id="radioBtn" value="팀장">팀장
                <input type="radio" name="rank" id="radioBtn" value="팀원">팀원 
            </div>

            <div id="departmentParent">
                <div id="Btn">부서</div>
                <input type="radio" name="department" id="radioBtn" value="개발팀">개발팀
                <input type="radio" name="department" id="radioBtn" value="디자인팀">디자인팀
            </div>

            <input type="submit" id="findIdBtn" value="정보 수정">
       
        </form>

    </div>
    <script src="../js/modifyInform.js"></script>
    <script>
        var valid = <%= valid %>
        var id = <%= id %>
        var pw = <%= pw %>
        var name = <%= name %>
        var tel = <%= tel %>
        var rank = <%= rank %>
        var department = <%= department %>

        console.log("tel : "+tel)
        console.log("rank : "+rank)
        if(valid == false){
            alert("로그인 하십시오!")
            location.href = "../index.html"
        }
        else{
            var idDiv = document.getElementById("idValue")
            idDiv.placeholder = id

            var pwDiv = document.getElementById("pwValue")
            pwDiv.placeholder = pw

            var pwCheckDiv = document.getElementById("pwCheckValue")
            pwCheckDiv.placeholder = pw

            var nameDiv = document.getElementById("nameValue")
            nameDiv.placeholder = name

            var telDiv = document.getElementById("telValue")
            telDiv.placeholder = tel

            var rankDiv = document.getElementsByName("rank")
            
            for(var i=0; i<rankDiv.length; i++){
                if(rankDiv[i].value == rank){
                    rankDiv[i].checked = true
                }
                console.log("for문")
            }

            var departmentDiv = document.getElementsByName("department")
            for(var i=0; i<departmentDiv.length; i++){
                if(departmentDiv[i].value == department){
                    departmentDiv[i].checked = true
                }
            }
        }


        function blankCheck(event){
            var id = String(document.getElementById("idValue").value)
            var pw = String(document.getElementById("pwValue").value)
            var name = String(document.getElementById("nameValue").value)
            var tel = String(document.getElementById("telValue").value)
            
            if(id.length == 0){
                id = <%= sessionId %>
            }
            
            if(pw.length == 0){
                pw = <%= sessionPw %>
            }

            if(name.length == 0){ //전화번호 입력 안할시
            name = <%= sessionName %> 
            }

            if(tel.length == 0){
                tel = <%= sessionTel %>
            }

            checkEvent(event)

        }

    </script>
</body>
</html>