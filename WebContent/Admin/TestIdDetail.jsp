<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//ttd HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.ttd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test ID DEtail</title>
<%--

                           @Author Maniram Yadav
 --%>

<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../mycss/jquery.min.js"> </script>
</head>
<body>

<body class="container">
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.controller.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.*" %>
<div>
<%

String testid=(String)request.getParameter("testid");
DBConnection db=new DBConnection();
String sql="select * from testlist where test_id='"+testid+"'";
ResultSet rs=db.stmt.executeQuery(sql);
if(rs.next()){
	session.setAttribute("testid",rs.getString("test_id"));
  %>
  <table class="table table:hover">
 <tr> <td><b>Test Name : </b></td><td><%out.println(rs.getString("test_name")); %></td></tr>
 <tr> <td><b>Test Id   : </b></td><td><% out.println(rs.getString("test_id"));%></td></tr>
  <tr><td><b>Certified By :</b></td><td><% out.println(rs.getString("cert_by"));%></td></tr>
  <tr><td><b>Department Name : </b></td><td><% out.println(rs.getString("org_status"));%></td></tr>
 <tr><td>
  <form action="SaveTestTime.jsp" method="post">
  <input type="" name="totaltime" placeholder="Enter total exam time in minute" class="form-control"/>
  </td><td><input type="submit" class="btn btn-success" name="submit" value="Start Now" /></td></tr>
    <tr  colspan="2"><td colspan="2">
    
    <input type="checkbox" name="antest" value="antest" id="checked" onfocus="direct('StartTest.jsp')"/>&nbsp;&nbsp;&nbsp;Choose another Test</td></tr>
  </form>
  </table>
 
  <%} %>
  </div>
</table>
<script type="text/javascript">
function direct(data){
	
	window.location.href=data;
}
</script>
</body>
</html>