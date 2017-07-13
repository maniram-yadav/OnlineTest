<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
</head>
<%--

                @Author Maniram Yadav
 --%>

<body>
<%@page import="java.sql.*" %>
<%@page import="onlinetest.admn.*" %>  
<%@page import="onlinetest.mysql.*" %>
<jsp:useBean id="obj" class="onlinetest.admn.loginbean"/>
<jsp:setProperty name="obj" property="*"></jsp:setProperty>
<script language="javascript">
var url=window.location.href;
if(url=="Admin.jsp")
	{
</script>
<% 
loginbean lb=new loginbean();
String userid=request.getParameter("userid");
String password=request.getParameter("userpass");
lb.setUserid(userid);
lb.setUserpass(password);
String userid1=lb.getUserid();
String password1=lb.getUserpass();
boolean state=lb.validate();
if(state)
{
	session.setAttribute("userid",userid);
	session.setAttribute("password",password);
	out.println("Successfully logined");
	response.sendRedirect("AdminProfile.jsp");	
}
else
{ 
	 out.println("error in login");
     String message="error in login";
     response.sendRedirect("../Admin.jsp");	
}
%>
<script language="javascript">
	}
else{
</script>
<p>Test successfully created</p>
<script language="javascript">
}
</script>
</body>
</html>