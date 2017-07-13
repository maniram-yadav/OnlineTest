<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ContDown</title>
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
<%@page import="onlinetest.student.*" %>
<%@page import="onlinetest.mysql.*"%>
<%@page import="java.sql.*" %>

<div id="clock"></div>

<script type="text/javascript">
var target=document.getElementById("clock");
<%
QuesProcess qp=new QuesProcess();
String endtime=qp.TestEndTime();
if(endtime!=null)
{
%>

var end="<%=endtime %>"
$(document).ready(function(){
	var date2 = new Date(end);
	
	function CountDown(){
	var date1 = new Date();

	
	var diff = date2.getTime() - date1.getTime();

	var msec = diff;
	
	var hh = Math.floor(msec /1000 / 60 / 60);
	hh=(hh<10)?"0"+hh:hh;
	
	msec -= hh * 1000 * 60 * 60;
	var mm = Math.floor(msec / 1000 / 60);
	mm=(mm<10)?"0"+mm:mm;
	
	msec -= mm * 1000 * 60;
	var ss = Math.floor(msec / 1000);
	ss=(ss<10)?"0"+ss:ss;
	
	msec -= ss * 1000;
	//alert(hh + ":" + mm + ":" + ss);
	if((hh==0&&mm==0&&ss==0)||msec<0)
		{
		
		target.innerHTML="Processing";
		clearInterval();	
		}
	else
		{

	target.innerHTML="  "+hh+" HH : "+mm+" MM";
	setInterval(CountDown,60000);
	}}
	CountDown();

});
<%}
else{%>
	target.innerHTML="Submitting test";
<%}
%>
</script>


</body>
</html>