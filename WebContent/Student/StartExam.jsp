<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%--

                           @Author Maniram Yadav
 --%>
<script src="../js/Invalid.js"> </script>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../js/validation.form.js"> </script>
<script src="../mycss/jquery.min.js"> </script>
</head>
<body>
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.mysql.DBConnection" %>
<%@page import="java.sql.ResultSet" %>
<%
DBConnection db=new DBConnection();
String sql="select test_id from prev_tests where status=\"Started\"";
ResultSet rs=db.stmt.executeQuery(sql);
if(rs.next())
{
String testid=rs.getString("test_id");
%>
<a href="Questions.jsp?id=0&&testid=<%=testid %>" ><button type="button" class="btn btn-primary">Click here</button></a>
<% 
}
else
{
%>
<h4>Exam has not been started yet.</h4>
<%} %>
</body>
</html>