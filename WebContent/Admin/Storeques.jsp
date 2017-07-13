<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question storage</title>
</head>
<body>
<%--

                           @Author Maniram Yadav
 --%>

       
<body class="container">
<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.controller.*" %>
<%@page import="java.sql.*" %>
<%
DBConnection db=new DBConnection();
testbean tb=new testbean();
tb.setTestid((String)session.getAttribute("testid"));
tb.setA(request.getParameter("a"));
tb.setAns(request.getParameter("ans"));
tb.setB(request.getParameter("b"));
tb.setC(request.getParameter("c"));
tb.setD(request.getParameter("d"));
tb.setQno(request.getParameter("qno"));
tb.setQues(request.getParameter("ques"));
boolean s=tb.QinsDB();
if(s){
	 out.println("inserted");
      response.sendRedirect("EnterQuestion.jsp");
}
	 else
	{
		 out.println("Please Enter Valid question and answer");
}%>
</body>
</html>