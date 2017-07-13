<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Final Result</title>
<%--

                           @Author Maniram Yadav
 --%>
<script src="../js/Invalid.js"> </script>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<script src="../AngularJs/angular.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../js/validation.form.js"> </script>
<script src="../mycss/jquery.min.js"> </script>

</head>
<body style="background-color:white;">
<%@page import="onlinetest.mysql.DBConnection"%>
<%@page import="java.sql.*" %>
<table class="table table.hovered">
<thead>
<td>Name</td>
<td>Branch</td>
<td>Year</td>
<td>Test Id</td><td>Date </td><td>Submit Time</td><td>Marks</td><td>Position</td></thead>

<%
String name,email,stime,date,branch,year;
int marks=0,rank=0;
String testid=request.getParameter("testid");
String sql="select * from stutest_history  as osh inner join stu_detail as osd "+
"on osd.stu_id=osh.stu_id where osh.test_id='"+testid+"' and osh.test_id in "+
" (select op.test_id from prev_tests as op where op.status=\"Test Processing\" "+
" or status=\"Test Finished\" ) order by osh.rank asc";


DBConnection db=new DBConnection();
ResultSet rs=db.stmt.executeQuery(sql);
while(rs.next())
{
   branch=rs.getString("branch");
   year=rs.getString("year");
	name=rs.getString("name");
	email=rs.getString("email");
	testid=rs.getString("test_id");
	date=rs.getString("date");
	stime=rs.getString("submit_time");
	marks=rs.getInt("marks");
	rank=rs.getInt("rank");
%>

<tr><td><%=name %></td><td><%=branch %></td><td><%=year %></td><td><%=testid %></td><td><%=date %></td><td><%=stime %></td><td><%=marks %></td><td><%=""+rank %><td></tr>
<%} 
rs.close();
db.stmt.close();
db.con.close();
%>
</table>
</body>
</html>