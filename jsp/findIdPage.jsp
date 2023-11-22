<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="../css/findId.css">
    <link type="text/css" rel="stylesheet" href="../css/common.css">
    <link type="text/css" rel="stylesheet" href="../css/public.css">

</head>
<body>
    <div id="backParent">
        <h1 id="findIdComment">id 찾기</h1>
        <button onclick="history.back()" id="backBtn">이전으로</button>

        <form name="myform" action="findIdAction.jsp" id="myform">
            <input type="text" name="name" id="inputBox" placeholder="이름 입력">
            <input type="text" name="tel" id="inputBox" placeholder="전화번호 입력 / - 제외">
            <input type="submit" id="findIdBtn" value="id 찾기">
        </form>

    </div>
</body>
</html>