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

<%@page import="onlinetest.mysql.DBConnection" %>
<%@page import="java.sql.*" %>
<% 
String testid,email,date,stime,name;
int marks=0;
testid=request.getParameter("testid");
email=request.getParameter("email");
//out.println(email+"  "+testid);
DBConnection db=new DBConnection();

String sql="select * from stutest_history  where test_id='"+testid+"' and email='"+email+"'";  
ResultSet rs=db.stmt.executeQuery(sql);
if(rs.next())
{
	%>
	<table class="table">

<thead><td>Name</td><td>Test Id</td><td>Date </td><td>Submit Time</td><td>Marks</td></thead>
	
	<%
	name=rs.getString("name");
	email=rs.getString("email");
	testid=rs.getString("test_id");
	date=rs.getString("date");
	stime=rs.getString("submit_time");
	marks=rs.getInt("marks");
%>
<tr><td><%=name %></td><td><%=testid %></td><td><%=date %></td><td><%=stime %></td><td><%=marks %></td></tr>
</table>
<%}
else{
	%>
	<div class="alert-success"> You have not attempted any quiz for this quiz id</div>
	<%
	}
if(rs!=null)
rs.close();
if(db.stmt!=null)
db.stmt.close();
if(db.con!=null)
db.con.close();
%>

</body>
</html>