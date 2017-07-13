<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile Page</title>
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
<script>
$(document).ready(function(){
	$(".collapsed").on("click",function(){
		$("#myNavbar").slideToggle(800,"swing");
		
	});
	
	
	
	
});
</script>

</head>
<body class="body-background">
   <%@page import="onlinetest.mysql.DBConnection" %>
   <%@page import="java.sql.ResultSet" %>  
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand collapse" href="#">Profile Page</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
 <ul class="nav navbar-nav">
<%--  <li class="active"><a href="#" class="instruction nav-button"><button class="btn  btn-lg nav-btnclick">Instruction</button></a></li>

<li><a  href="#" class="developer  nav-button1"><button class="btn  btn-lg nav-btnclick">Developer</button></a></li>   --%>
<li><a href="#" class="myprofile  nav-button2"><button class="btn  btn-lg nav-btnclick">My Profile</button></a></li>
<li><a href="#" class="myresult  nav-button"><button class="btn btn-lg nav-btnclick">My Result</button></a></li>
<li><a href="#" class="finalresult  nav-button1"><button class="btn btn-lg nav-btnclick">Final Result</button></a></li>
<li><a href="#" class="startexam  nav-button1"><button class="btn btn-lg nav-btnclick">Start Exam</button></a></li>
<li><a href="Logout.jsp" class="logout  nav-button1"><button class="btn btn-lg nav-btnclick">Logout</button></a></li>

</ul>
     
    </div>
  </div>
</nav>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<jsp:useBean id="obj" class="onlinetest.student.dataprocess" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="obj"/>
<%     
String name=obj.getTxtname();
String email=null,password=null,year=null,branch=null,sstuid=null;
int stuid=0;

   email=obj.getTxtemail();
   password=obj.getUserpass();
   Vector<String> v=obj.ValidLogin();
   Iterator<String> it=v.iterator();
   if(it.hasNext())
   {  
	   stuid=Integer.parseInt((String)it.next());
	   sstuid=""+stuid;
	   name=(String)it.next();
	   session.setAttribute("txtemail",(String)it.next());
	   session.setAttribute("stuid",sstuid);
	   
		year=(String)it.next();
	   branch=(String)it.next();
	   Object o=session.getAttribute("stuid");
	  
   }
   else
   { 
	   String msg="Password or Email Id mismatch. Login Again with valid Information";
	   response.sendRedirect("StuLogin.jsp?msg="+msg);

   }
  
   
%>
<center>
<div class="data">
<%--*****************  started Exam Link will be shown here *********************** --%>
<H1 style="margin-top:50px;color:black;"> Welcome to the Quizsphere </H1>
</div>
</center>

<div class="question">
<%--*****************  started Exam Link will be shown here *********************** --%>
</div>

<script type="text/javascript" >
<%
String sql="select test_id from prev_tests where status=\"Started\"";
DBConnection db=new DBConnection();
String testid=null,finalv="no";
ResultSet rs=db.stmt.executeQuery(sql);
if(rs.next())
	testid=rs.getString(1);
sql="select * from stutest_history where email='"+email+"' and test_id='"+testid+"'";
rs=db.stmt.executeQuery(sql);
 if(rs.next())
	 finalv="";
 if(rs!=null)
 rs.close();
 if(db.stmt!=null)
 db.stmt.close();
 if(db.con!=null)
 db.con.close();
%>
$(document).ready(function(){
	                   
		function Questions(){
			var v="<%=finalv %>";
			//alert("value :"+v);
			if(v!=""){
			           $.ajax({
			        	   url: 'isStarted.jsp',
			        	   type: 'get',
			        	   success: function(result)
			        	   {
			        	   $('.question').html(result);
			        	   }
			        	   }
			        	   );
			}
			           if(v!="")
		                     setTimeout(Questions,2000);
			           else
			        	   clearTimeOut();
		                     }
		
		Questions();
		   
        $(".myprofile").on("click",function(){
      	  var values;
      	  values="name="+"<%=name %>" +"&email="+"<%=email %>"+"&stuid="+"<%=stuid %>"+"&year="+"<%=year%>"+"&branch="+"<%=branch %>"+"&password="+"<%=password %>"+"";
		           $.ajax({
		        	   url: 'MyProfile.jsp',
		        	   type: 'post',
                     data: values,
		        	   success: function(result)
		        	   {
		        	   $('.data').html(result);
		        	   }
		        	   }
		        	   );
                  });

        $(".myresult").on("click",function(){
      	           $.ajax({
		        	   url: 'MyResult.jsp',
		        	   type: 'post',
		        	   success: function(result)
		        	   {
		        	   $('.data').html(result);
		        	   }
		        	   }
		        	   );
                  });
        
        $(".finalresult").on("click",function(){
	           $.ajax({
	        	   url: 'FinalResult.jsp',
	        	   type: 'post',
	        	   success: function(result)
	        	   {
	        	   $('.data').html(result);
	        	   }
	        	   }
	        	   );
           });
        $(".startexam").on("click",function(){
	           $.ajax({
	        	   url: 'StartExam.jsp',
	        	   type: 'post',
	        	   success: function(result)
	        	   {
	        	   $('.data').html(result);
	        	   }
	        	   }
	        	   );
        });

 
        
        $(".nav-btnclick").on("click",function(){
        	$(this).css("color","white");
        	$(".btn").removeClass("shake-button");
        	$(this).addClass("shake-button");
        	$(".btn").removeClass("nav-btnclick1").addClass("nav-btnclick");
        	$(this).removeClass("nav-btnclick").addClass("nav-btnclick1");
        });
        
                             
});
</script>
</body>
</html>