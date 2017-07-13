<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%--

                @Author Maniram Yadav
 --%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administartor Page</title>

<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../mycss/jquery.min.js"> </script>


<script>
$(document).ready(
		function(){
		$(".createtest").on("click",function(){
			
				$.ajax({
					     url: "CreateTest.jsp",
					     type: "POST",
					     success: function(data){
					    	 
					    	 $(".showpage").html(data);

                         }
				        });
								
		        	 });
		
		$(".insertques").on("click",function(){
			
		$.ajax({
				     url: "InsertQuestion.jsp",
				     type: "POST",
				     success: function(data){
				    	 
				    	 $(".showpage").html(data);

                     }
			        });
							
	        	 });
		
		$(".starttest").on("click",function(){
			
			$.ajax({
				     url: "StartTest.jsp",
				     type: "POST",
				     success: function(data){
				    	 
				    	 $(".showpage").html(data);

                     }
			        });
							
	        	 });
		function SentMailStatus(){
			
			$.ajax({
				     url: "SendSignUpMail.jsp",
				     type: "POST",
				     success: function(data){
				    	 
				    	 $(".col4").html(data);

                     }
			        });
					setTimeout(SentMailStatus,160000);		
	        	 }

		function ExamStatus(){
			
			$.ajax({
				     url: "ExamStatus.jsp",
				     type: "POST",
				     success: function(data){
				    	 
				    	 $(".col1").html(data);

                     }
			        });
					setTimeout(ExamStatus,4000);		
	        	 }
		ExamStatus();
		SentMailStatus();
		});	
	
</script>
<style type="text/css">
ul li{
background-color:red;
}
</style>
<script>
$(document).ready(function(){
	$(".collapsed").on("click",function(){
		$("#AdminNavbar").slideToggle(800,"swing");
		
	});
	
	
});
</script>
</head>


<body>
<div class="adminnav">

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#AdminNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Admin Panel</a>
    </div>
    
<div class="collapse navbar-collapse" id="AdminNavbar">

<ul class="nav navbar-nav">

<li><a href="#" class="createtest">
<button class="btn btn-success btn-lg nav-button">Create Test</button></a></li>

<li><a href="#" class="insertques">
<button class="btn btn-success btn-lg nav-button">Insert Question</button></a></li>

<li><a  href="#" class="starttest">
<button class="btn btn-success btn-lg nav-button">Start Test</button></a></li>
<%--<li><a href="#"  class="createuser">
<button class="btn btn-success btn-lg nav-button">Create User</button></a></li>

<li><a href="#"  class="finduser">
<button class="btn btn-success btn-lg nav-button">Find User</button></a></li>

<li><a href="#"  class="findresult">
<button class="btn btn-success btn-lg nav-button">Find Result</button></a></li>
 
  --%>

<li><a  href="Logout.jsp">
<button class="btn btn-success btn-lg nav-button">Log out</button></a></li>
 
</ul>
     
   </div>
 </div>
</nav>
 </div>
<center><div class="showpage">
</div>
</center>
 

<div class="adminfoot">
<div class="row">
<div class="col col-lg-3 col-mg-3 col1"></div>
<div class="col col-lg-3 col-mg-3 col2"></div>
<div class="col col-lg-3 col-mg-3 col3"></div>
<div class="col col-lg-3 col-mg-3 col4"></div>
</div>
</div>
</body>
</html>