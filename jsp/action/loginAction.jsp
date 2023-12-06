<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
request.setCharacterEncoding("utf-8");

String idValue = request.getParameter("id"); 
String pwValue = request.getParameter("pw");

boolean valid = false;
ArrayList<String> idList = new ArrayList<String>();

// 로그인할때 오늘 날짜 저장
Date today = new java.util.Date();
session.setAttribute("sessionDate", today);

try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

    String sql = "SELECT * FROM account";
    PreparedStatement query = connect.prepareStatement(sql);

    ResultSet result = query.executeQuery();

    while(result.next()){
        if(result.getString(2).equals(idValue) && result.getString(3).equals(pwValue)){
            valid = true;
            session.setAttribute("sessionIdx", result.getString(1));
            session.setAttribute("sessionId", idValue);
            session.setAttribute("sessionPw", pwValue);
            session.setAttribute("sessionName", result.getString(4));
            session.setAttribute("sessionTel", result.getString(5));
            session.setAttribute("sessionRank", result.getString(6));  
            session.setAttribute("sessionDepartment", result.getString(7));
        }
    }
    
    String id = (String)session.getAttribute("sessionId");
    idList.add("\""+id+"\"");

}catch(Exception e){
    e.printStackTrace(); 
}
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <script>
        var valid = <%= valid %>
        var id = <%= idList %>

        if(valid === false){
            alert("일치하는 로그인 정보가 없습니다.")
            location.href = "../../index.html"
        }
        else{
            location.href="../page/mainPage.jsp"
        }
    </script>
</body>