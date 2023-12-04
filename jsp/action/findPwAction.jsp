<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
request.setCharacterEncoding("utf-8");

String idValue = request.getParameter("id");
String nameValue = request.getParameter("name");
String telValue = request.getParameter("tel");

boolean valid = false;
String yourPw = null;

ArrayList<String> pwList = new ArrayList<String>();

try{
Class.forName("com.mysql.jdbc.Driver");
Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/scheduler","heeju","1234");

String sql = "SELECT * FROM account";
PreparedStatement query = connect.prepareStatement(sql);

ResultSet result = query.executeQuery();

while(result.next()){
    if( result.getString(2).equals(idValue) && result.getString(4).equals(nameValue) && result.getString(5).equals(telValue) ){
        yourPw = result.getString(3);
        valid = true;
    }
}

pwList.add("\""+yourPw+"\"");

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
    <link type="text/css" rel="stylesheet">
</head>
<body>

        <script>
            var valid = <%=valid%>
            var mypw = <%=pwList%>
            

            if(valid == false){
                alert("존재하는 정보가 없습니다.")
                location.href = "../../index.html"
            }
            else{
                alert("당신의 pw는 "+mypw+" 입니다.")
                location.href = "../../index.html"
            }
        </script>
    </div>
</body>
</html>