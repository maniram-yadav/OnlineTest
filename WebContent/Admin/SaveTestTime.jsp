<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Save Test time in DB</title>

<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../mycss/jquery.min.js"> </script>
</head>
<%--

                           @Author Maniram Yadav
                           *        FGIET   B TECH  CSE  Student           *
 --%>

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

SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss aa");
String myTime = df.format(new Date());
Date d = df.parse(myTime); 

Calendar cal = Calendar.getInstance();
cal.setTime(d);

String minute=request.getParameter("totaltime");
int minutes=Integer.parseInt(minute);
cal.add(Calendar.MINUTE, minutes);                     // Add test time to Exam start time  and store in database
String endtime = df.format(cal.getTime());

//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss aa");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");

String stime=df.format(new Date());
String date=sdf1.format(new Date());

String msg="";
DBConnection db=new DBConnection();
testbean tb=new testbean();
tb.setDate(date);
tb.setEtime(endtime);
tb.setStatus("Started");
tb.setStime(stime);
tb.setTestid((String)session.getAttribute("testid"));
tb.setMinutes(minute);
int i=tb.savetime();
  if(i>0)
  { 
	  out.println("<h3>Successfully exam started</h3>");
      response.sendRedirect("AdminProfile.jsp");
  }
	  else
	  {  out.println("Unable to start exam due to some error");
	  request.getRequestDispatcher("StartTest.jsp").include(request,response);
	  }
%>
</div>
</body>
</html>