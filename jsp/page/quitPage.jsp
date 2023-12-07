<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="../../css/common.css">
    <link type="text/css" rel="stylesheet" href="../../css/public.css">
</head>
<body>
    <div id="backParent">
        <div id="quit"> 탈퇴시 내 정보는 모두 삭제됩니다. </div>
        <div id="quit">정말 탈퇴하시겠습니까? </div>     
        
        <input type="button" id="backBtn" value="탈퇴하기" onclick="location.href='../action/quitAction.jsp'">
        <button onclick="history.back()" id="backBtn">이전으로</button>
    </div>
</body>
</html>