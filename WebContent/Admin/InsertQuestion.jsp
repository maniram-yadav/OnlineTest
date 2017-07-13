<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert Question</title>

<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
</head>

<%--

                           @Author Maniram Yadav
 --%>


<body>
<%@page import="onlinetest.admn.*"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Vector" %>
<%@page import="java.util.Iterator" %>
<%-- ************     Select test id for Question Insertion *******     --%>
<form action="EnterQuestion.jsp" method="post">
<select name="testid" id="sel" onchange="validateid()" class="form-control input-lg" required>
<option value="">-- Select Test Id --</option>
<%
String testid=null;
testbean tb=new testbean();
Vector<String> v=tb.testid();
		Iterator<String> it=v.iterator();
while(it.hasNext()){
	testid=(String)it.next();

%>
<option value="<%=testid %>"><%=testid%></option>
<%
}
%>
</select>
<input type="submit" class="btn btn-success" name="submit" value="Submit"/>
</form> 
                                                            <%--  form End  --%>
        <div id="msg"></div>
<script>
function validatetid(){
	var select=document.getElementById("sel").value;
	var target=document.getElementById("msg");
if(select==" "){
	target.innerHTML="Select a valid Test ID";   }
else{
	terget.innerHTML="Submit";       }  }
</script>
</body>
</html>