<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions</title>

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
<body>
<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.controller.*" %>
<%@page import="java.sql.*" %>
<div class="inqueshead">
</div>
<center>
<% 
String testid=request.getParameter("testid");
int i=0;
if(testid!=null)
{ 
	session.setAttribute("testid",testid);
	}
else{
	testid=(String)session.getAttribute("testid");
}
try{
DBConnection db=new DBConnection();
String sql="select max(q_no) from test_question where test_id='"+testid+"'";
ResultSet rs=db.stmt.executeQuery(sql);

if(rs.next())
	i=rs.getInt(1);//question number in db
else 
	i=0;
i++;}
catch(Exception e){
	i=1;
}
%>
<form action="Storeques.jsp" method="post" onsubmit="return quesvalid()">
<div class="form-group">
<div class="setlabel"><b>Q NO. <%=i %></b></div>
<input type="hidden" name="qno" value="<%=i %>"/>
<textarea name="ques" rows="5" class="input-lg" cols="160">
</textarea>
</div>
<div class="form-group"><div class="setlabel"><b> A . </b></div><input type="text" class="input-lg input-lg1" name="a"  placeholder="option a"/></div>
 <div class="form-group"><div class="setlabel"><b>B . </b></div><input type="text" class="input-lg input-lg1" name="b" placeholder="option b"/></div>
 <div class="form-group"><div class="setlabel"><b>C . </b></div><input type="text" class="input-lg input-lg1" name="c" placeholder="option c"/></div>
 <div class="form-group"><div class="setlabel"><b>D .</b></div> <input type="text" class="input-lg input-lg1" name="d" placeholder="option d"/></div>
 <div class="form-group">
 <div class="setlabel"></div>
 <select name="ans" class="input-lg">
 <option value="">--Select Correct Option--</option>
 <option value="a">A</option>
 <option value="b">B</option>
 <option value="c">C</option>
 <option value="d">D</option>
 </select>
 </div>
<div class="setlabel"></div> <div class="form-group"><input type="submit" name="submit" class="btn btn-info" value="submit" onsubmit="quesvalid()"/></div>
</form><%--         **********         Form End Tag     ************ --%>
<script>
function quesvalid(){
var ques,a,b,c,d,ans;
ques=document.getElementByName("ques").value;
a=document.getElementByName("a").value;
b=document.getElementByName("b").value;
c=document.getElementByName("c").value;
d=document.getElementByName("d").value;
ans=document.getElementByName("ans").value;
 if(ques!=""&&a!=""&&b!=""&&c!=""&&d!=""&&ans!="")
	 {
	 return true;
	 
	 }
 else{
	 alert("Enter question in correct formet");
	 return false;
 }
}
</script>
</center>
<div class="inquesfoot"></div>
</body>
</html>