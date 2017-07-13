<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--

                @Author Maniram Yadav
 --%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
</head>
<body>
<div class="container">
<%@page import="onlinetest.controller.*" %>
<form action="../testverify" method="post">
<div class="form-group">
<label for="testid">Test Id :</label>
<input type="text" name="testid" id="testid" placeholder="Test id" class="form-control"/>
</div>
<div class="form-group">
<label for="testname">Test Name :</label>
<input type="text" name="testname" id="testid" placeholder="Test name " class="form-control"/>
</div>
<div class="form-group">
<label for="certby">Certified By :</label>
<input type="text" name="certby" id="certby" placeholder="Department teacher" class="form-control"/></div>
<div class="form-group">
<label for="department">Sponsered Department :</label>
<input type="text" name="department" id="departmennt" placeholder="Teacher Department" class="form-control"/>
</div>
<input type="submit" name="Submit" class="btn btn-primary" value="Submit"/>
</form>
</div>
</body>
</html>