<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SignUp here</title>
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

<%@page import="java.sql.*" %>
<%@page import="onlinetest.admn.*" %>  
<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.student.*" %>
<%@page import="onlinetest.network.*" %>
<% 

String str="Please enter valid data";
dataprocess dp=new dataprocess();
 dp.setSltbranch(request.getParameter("sltbranch"));
 dp.setSltyear(request.getParameter("sltyear"));
 dp.setTxtemail(request.getParameter("txtemail"));
 dp.setTxtname(request.getParameter("txtname"));
 dp.setTxtrollno(request.getParameter("txtrollno"));
 dp.setUserpass(request.getParameter("userpass"));
try{
  int i=dp.isValid();
  if(i==-1)
  {
	  str="<br/><h4>This email id already exist in database. use another email id for Login.</h4><br/>";
		
	  request.setAttribute("msg",str);
	  request.getRequestDispatcher("StuSignUp.jsp").forward(request,response);
	 
  }
  else
  {
  if(i>0)
  {     

	  request.getRequestDispatcher("test.html").forward(request, response);
  }
  else
  { 
	  request.setAttribute("msg",str);
	  request.getRequestDispatcher("StuSignUp.jsp").forward(request,response);
	  
  }
  }}
catch(Exception e){
	str="Exception has been occured. Either your mail id already exist in database or any other problem has been occured.";
	
	  request.setAttribute("msg",str);
	  request.getRequestDispatcher("StuSignUp.jsp").forward(request,response);
	
                  }

%>
</body>
</html>