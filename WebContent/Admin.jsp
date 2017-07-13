<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<%--

               @Author    Maniram    Yadav
 --%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Login</title>
<link rel="stylesheet" href="css\bootstrap.min.css"/>
<link rel="stylesheet" href="mycss\bootstyle.min.css"/>
<script src="css\bootstrap.min.js"> </script>
<script src="css\jquery.min.js"> </script>
<script src="js\validation.form.js"></script>
</head>
<body>
<div class="container">
<form action="Admin/AdminPage.jsp" method="post" class="form-vertical">
<div class="loginstyle">
<div class="form-group">
<span>User Id :</span>
<input type="text" name="userid" placeholder="User Id" class="form-control input-lg1"/>
</div>
<div class="form-group"><span>Password :</span>
<input type="password" name="userpass" placeholder="*******" class="form-control input-lg1"/></div>
<div class="form-group row" style="padding-left:80px;" >
<input type="submit" name="submit" value="Login" class="btn btn-success btn-lg"/></div>
</div>
</form>
</div>

</body>
</html>