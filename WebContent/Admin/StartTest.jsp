<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Start exam</title>

<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../mycss/jquery.min.js"> </script>
<%--

                           @Author Maniram Yadav
 --%>


</head>

<body class="container">
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.controller.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<div class="content">
       <form action="TestIdDetail.jsp" method="post">           
                        <%--  **********  Select  test  id from database   ************** --%>
         <div class="form-group">
        <select name="testid" id="selct" class="form-control input-lg" required>
        <option value="">-- Select Test Id  --</option>
         <%
            testbean tb=new testbean();
            Vector<String> v=tb.testid();
            Iterator<String> it=v.iterator();
            while(it.hasNext()){
            	String opt=it.next();
         %>
         
          <option value="<%=opt %>"><%=opt %></option>
          
        <%}%>
        </select>
        </div>
        <div class="form-group">
        <input type="submit" name="submit" value="Submit" class="btn btn-success" />
        </div>
       </form>
</div>
</body>
</html>