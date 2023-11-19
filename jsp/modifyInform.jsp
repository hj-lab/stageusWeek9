<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

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
        <div id="modifyComment">내 정보 수정</div>

        <button onclick="history.back()" id="backBtn">이전으로</button>

        <form name="myform" action="modifyInformJ.jsp" id="myform">
            <div id="idParent">
                <span>id : </span>
                <input type="text" id="inputBox" placeholder="heeju">
                <input type="button" id="duplicateBtn" value="중복확인">
            </div>

            <div id="pwParent">
                <span>비밀번호 : </span>
                <input type="password" id="inputBox" placeholder="******">
            </div>
            
            <div id="pwCheckParent">
                <span>비밀번호 확인 : </span>
                <input type="password" id="inputBox" placeholder="******">
            </div>
            
            <div id="nameParent">
                <span>이름 : </span>
                <input type="text" id="inputBox" placeholder="조희주">
            </div>

            <div id="rankParent">
                <div id="Btn">직급</div>
                <input type="radio" name="rank" id="radioBtn" value="팀장">팀장
                <input type="radio" name="rank" id="radioBtn" value="팀원" checked="checked">팀원 
            </div>

            <div id="departmentParent">
                <div id="Btn">부서</div>
                <input type="radio" name="department" id="radioBtn" value="개발팀"  checked="checked">개발팀
                <input type="radio" name="department" id="radioBtn" value="디자인팀">디자인팀
            </div>

            <input type="submit" id="findIdBtn" value="정보 수정">
       
        </form>

    </div>
</body>
</html>