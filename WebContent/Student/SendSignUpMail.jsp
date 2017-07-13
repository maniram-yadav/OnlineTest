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
</head>
<body>
<%@page import="onlinetest.network.*" %>
<%
//WelcomeEmail we=new WelcomeEmail();
/*String Message=request.getParameter("txtname")+" ,Your's Welcome for signing up to QUIZSPHERE ",
		  toemail=request.getParameter("txtemail"),
		  subject="Message from QUIZSPHERE";
		  
out.println("Data Successfully inserted");
 */
int i=WelcomeEmail.sendMail();
out.println(i+" Message sent to corresponding email id successfully");

%>
</body>
</html>