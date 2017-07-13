<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Result</title>
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
<script src="../js/Invalid.js"> </script>
<script src="../mycss/jquery.min.js"> </script>

</head>
<body>
<jsp:useBean id="obj" class="onlinetest.student.dataprocess" scope="session"></jsp:useBean>

<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.admn.testbean" %>
<%@page import="onlinetest.student.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Vector" %>
<%@page import="java.util.Iterator" %>
<div class="selectresult">
<select id="sel"  class="form-control input-lg">
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

</div>
<script> 
<%

String email=obj.getTxtemail();
%>

$(document).ready(function(){	
	
$("#sel").change(function(){
	var email="<%=email %>";
	//alert(email);
		var value=$("#sel :selected").val();
	  if(value!="")
		   {
		 // alert(value);
			$(".selectresult").load("Result.jsp",{testid:value,email:email});
		  /*
		  value="?testid=java1&&email=vikasu.125@gmail.com";
		   
		   $.ajax({
			url: "Result.jsp",
			type: "GET",
			data: value,
			success: function(result){
				$(".fetchresult").html(result);
			                         }
			
		          });
		    }
	    else
		    {
		        alert("Select valid id");
		    }
	  */
}
	     	
	});
});
</script> 
<div class="fetchresult"></div>

</body>
</html>