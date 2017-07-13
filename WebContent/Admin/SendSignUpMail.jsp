<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%--

                           @Author Maniram Yadav
 --%>

<body>
<%@page import="onlinetest.network.*" %>
<%

int i=0;
 i=WelcomeEmail.sendMail();
 if(i!=0){
	 
	 out.println(" <b> "+i+"</b> Welcome message sent successfully to corressponding users");
 }
 else
 {
	 out.println("<h4>Mail already has been delivered to all the users</h4>");
 }
%>
</body>
</html>