<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");

String nameValue = request.getParameter("name");
String telValue = request.getParameter("tel");

Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

String sql = "SELECT * FROM account";
PreparedStatement query = connect.prepareStatement(sql);

ResultSet result = query.executeQuery();

boolean valid = false;

String yourId = null;

while(result.next()){
    if( result.getString(4).equals(nameValue) && result.getString(5).equals(telValue) ){
        yourId = result.getString(2);
        valid = true;
    }
}

ArrayList<String> idList = new ArrayList<String>();
idList.add("\""+yourId+"\"");


%>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet">
</head>
<body>

        <script>
            var valid = <%=valid%>
            var myid = <%=idList%>
            

            if(valid == false){
                alert("존재하는 정보가 없습니다.")
                location.href = "../index.html"
            }
            else{
                alert("당신의 id는 "+myid+" 입니다.")
                location.href = "../index.html"
            }
        </script>
    </div>
</body>
</html>