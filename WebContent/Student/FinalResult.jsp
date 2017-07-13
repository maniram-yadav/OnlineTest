<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="../js/Invalid.js"> </script>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../js/validation.form.js"> </script>
<script src="../mycss/jquery.min.js"> </script>

<%--

                           @Author Maniram Yadav
 --%>

</head>
<body>
<%@page import="onlinetest.mysql.DBConnection" %>
<%@page import="java.sql.*" %>
<div class="findall">
<select name="testid" id="tid" class="form-control input-lg">

<option value="">--- Select Test Id ---</option>
<% 
DBConnection db=new DBConnection();
String sql="select distinct test_id from prev_tests";
ResultSet rs=db.stmt.executeQuery(sql);
while(rs.next())
{
%>
<option value="<%=rs.getString(1)%>" ><%=rs.getString(1)%></option>
<%
}
rs.close();
db.stmt.close();
db.con.close();
%>
</select>



</div>


<script type="text/javascript">


$(document).ready(function(){
	
	
	$("#tid").change(function(){
		
		var value=$("#tid :selected").val();
	  if(value!="")
		   {
		  $(".findall").fadeOut(1000,function(){
		  $(".findall").load("AllResult.jsp",{testid:value}).fadeIn(1200);
		  });
		   /*value="?testid='"+value+"'";
		   
		   $.ajax({
			url: "AllResult.jsp",
			type: "POST",
			data: value,
			success: function(result){
				$(".findall").html(result);
			                         }
			
		          });
		  */}
	    else
		    {
		        alert("Select valid id");
		    }
		
	     	
	});
	
         });
</script>
<div id="testid"></div>
</body>
</html>