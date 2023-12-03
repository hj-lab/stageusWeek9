<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
request.setCharacterEncoding("utf-8");

try{
    String idValue = request.getParameter("id"); 
    String pwValue = request.getParameter("pw");
    String nameValue = request.getParameter("name");
    String telValue = request.getParameter("tel");
    String rankValue = request.getParameter("rank");
    String departmentValue = request.getParameter("department");

    if (idValue == null || idValue.trim().isEmpty() || idValue.length() < 4 || idValue.length() > 11) {
%>
        <script>
            alert("id를 제대로 입력하십시오.")
        </script>
<%
    }
    else if (pwValue == null || pwValue.trim().isEmpty() || !pwValue.matches("(?=.*[a-zA-Z])(?=.*[0-9]).{8,15}")) {
%>
        <script>
            alert("pw를 제대로 입력하십시오.")
        </script>
<%
    }
    else if (nameValue == null || nameValue.trim().isEmpty() || nameValue.trim().length() < 2 || nameValue.trim().length() > 30) {
%>
        <script>
            alert('이름을 제대로 입력하세요.');
        </script>
<%
    } else if (telValue == null || telValue.trim().isEmpty() || !telValue.matches("[0-9]+")) {
%>
        <script>
            alert('전화번호를 제대로 입력하세요.');
        </script>
<%
    } else if (rankValue == null) {
%>
        <script>
            alert('직급을 선택하세요.');
        </script>
<%
    } else if (departmentValue == null) {
%>
        <script>
            alert('부서를 선택하세요.');
        </script>
<%
    }else{
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

        //SQL 만들기 (회원탈퇴하고싶으면 sql문만 바꿔주면됨 -> insert,update,delete 다 똑같음)
        String sql = "INSERT INTO account(id, pw, name, tel, rank_idx, department_idx) VALUES(?, ?, ?, ?, ?, ?)";
        PreparedStatement query = connect.prepareStatement(sql);

        query.setString(1, idValue);
        query.setString(2, pwValue);
        query.setString(3, nameValue);
        query.setString(4, telValue);
        query.setString(5, rankValue);
        query.setString(6, departmentValue);

        //query 전송
        query.executeUpdate();
    }
}catch(Exception e){
    e.printStackTrace(); 
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
        location.href = "../../index.html"
    </script>
</body>
</html>