<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");

 //세션값 불러와놓고
String sessionId = (String)session.getAttribute("sessionId");
String sessionPw = (String)session.getAttribute("sessionPw");
String sessionName = (String)session.getAttribute("sessionName");
String sessionTel = (String)session.getAttribute("sessionTel");
String sessionRank = (String)session.getAttribute("sessionRank");
String sessionDepartment = (String)session.getAttribute("sessionDepartment");

boolean valid = true;
// 세션에서 삭제
    if(sessionId != null){ // 로그인 상태일때만 지우기
    session.removeAttribute("sessionId");
    session.removeAttribute("sessionPw");
    session.removeAttribute("sessionName");
    session.removeAttribute("sessionTel");
    session.removeAttribute("sessionRank");
    session.removeAttribute("sessionDepartment");

    valid = false;

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

    // account 테이블에서 삭제
    String sql = "DELETE FROM account WHERE id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, sessionId);
    
    // schedule 테이블에서 삭제
    String sql2 = "DELETE FROM schedule WHERE id=?";
    PreparedStatement query2 = connect.prepareStatement(sql2);
    query2.setString(1, sessionId);
    
    
    query.executeUpdate();
    query2.executeUpdate();
    }


%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
    var valid = <%=valid%>

    if(valid == true){
        alert("로그인 하십시오.")
        location.href = "../index.html"
    }
    else{
        location.href = "../index.html"
    }
</script>
    
</body>
</html>