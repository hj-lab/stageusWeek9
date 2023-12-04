<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="../../css/findPw.css">
    <link type="text/css" rel="stylesheet" href="../../css/common.css">
    <link type="text/css" rel="stylesheet" href="../../css/public.css">
</head>
<body>
    <div id="backParent">
        <h1 id="findPwComment">Pw 찾기</h1>
        <button onclick="history.back()" id="backBtn">이전으로</button>

        <form name="myform" action="../action/findPwAction.jsp" id="myform">
            <input type="text" name="id" id="inputBox" placeholder="id 입력">
            <input type="text" name="name" id="inputBox" placeholder="이름 입력">
            <input type="text" name="tel" id="inputBox" placeholder="전화번호 입력 / - 제외">
            <input type="submit" id="findPwBtn" value="pw 찾기">
        </form>

    </div>
</body>
</html>