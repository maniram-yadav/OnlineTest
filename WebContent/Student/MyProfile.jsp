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
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../js/validation.form.js"> </script>
<script src="../mycss/jquery.min.js"> </script>

<style type="text/css">
.profile-attr{
font-size:25px;
font-family:algerian;
color:blue;
text-align:right;
padding:5px;
margin:7px;

}
.profile-value{

font-size:24px;
font-family:varanda;
color:red;
text-align:left;
padding:5px;
margin:7px;

}
</style>

</head>
<body>

<div class="myprofile">
<table class="table-responsive">
<tr><td><div class="profile-attr">Name       :</div></td><td><div class="profile-value">${param.name}</div></td></tr>
<tr><td><div class="profile-attr">Student Id :</div></td><td><div class="profile-value">${param.stuid}</div></td></tr>
<tr><td><div class="profile-attr">Email      :</div> </td><td><div class="profile-value">${param.email}</div></td></tr>
<tr><td><div class="profile-attr">Branch     :</div></td><td><div class="profile-value">${param.branch}</div></td></tr>
<tr><td><div class="profile-attr">Year       : </div></td><td><div class="profile-value">${param.year}</div></td></tr>
<tr><td><div class="profile-attr">Password   : </div></td><td><div class="profile-value"><div class="pass">*********</div></div></td></tr>
</table>
<button class="show1 btn btn-success btn-sm" type="button">Show Password</button>
</div>
<script>

</script>
<script>
<%
String pass=(String)request.getParameter("password");
%>
var i=0;
var pass="<%=pass %>";
$(document).ready(function(){
	
	$(".show1").on("click",function(){
		if(i==0)
			{
		$(".pass").html(pass);
		$(this).html("Hide Password");
		$(this).removeClass("btn-success").addClass("btn-danger");
		i=1;
			}
		else
			{

		$(".pass").html("** ** ***");
		$(this).html("Show Password");
		$(this).removeClass("btn-danger").addClass("btn-success");
			i=0;
			}
	});
});
</script>
</body>
</html>