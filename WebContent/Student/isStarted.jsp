<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quiz Started</title>
<script src="../js/Invalid.js"> </script>
</head>
<%--

                           @Author Maniram Yadav
 --%>

<body>
<%@page import="onlinetest.student.QuesProcess" %>
<div>
<% 
QuesProcess qp=new QuesProcess();
String testid=qp.startedTest();
if(testid!=null)
{
	
	
%>
<a href="Questions.jsp?id=0&&testid=<%=testid %>"><button class="btn btn-primary btn-lg btn-block start-ex-button" type="button">Start Quiz</button></a>
<%
}
response.setHeader("Refresh","5,isStarted.jsp");

%></div>
</body>
</html>