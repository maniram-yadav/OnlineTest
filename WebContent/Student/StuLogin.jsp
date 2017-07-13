<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page </title>
<%--

                           @Author Maniram Yadav
 --%>
<script src="../js/Invalid.js"> </script>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>

<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<!-- <script src="../css/bootstrap-select.min.js"> </script> -->
<script src="../css/jquery.min.js"> </script>
<script src="../js/validation.form.js"> </script>
<script src="../js/Invalid.js"> </script>
<script src="../mycss/jquery.min.js"> </script>
</head>
<body class="container">
<%@page import="java.util.*" %>
<center>
<div style="margin-top:10px;">
<%
Enumeration name=request.getParameterNames();
if(name.hasMoreElements())
{
String msg=(String)name.nextElement();
String msgvalue=request.getParameter(msg);
out.println(msgvalue);
}
%>
<form action="Profile.jsp" method="post">
<table>
<tr><td>Email Id : </td>
<td><div class="form-group">
<input type="email" name="txtemail" autofocus=true   placeholder="Enter Email Id here" class="form-control in-color" required/></div></td></tr>
<tr><td>Password :</td><td>
<div class="form-group"><input type="password" name="userpass"  minlength=6 placeholder="**********"  class="form-control in-color" required/></div></td></tr>
<tr><td></td><td><input type="submit" name="submit" class="btn btn-success sign-button" value="Login"/></td></tr>
</table>
</form>
</center>
</div>
</body>
</html>