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
</head>
<body>
<%@page import="java.util.*" %>
<jsp:useBean id="quespro" class="onlinetest.student.QuesProcess" scope="session"></jsp:useBean>
<%
String testid=(String)session.getAttribute("testid");
String qno=(String)session.getAttribute("qno");
String stuid=(String)session.getAttribute("stuid") ;
String ans=(String)request.getParameter("ans");
int id=Integer.parseInt(qno);
String submit_value=(String)request.getParameter("submit");
try{
if(!ans.equals("")&&ans!=null)
{
out.println(stuid+"  ans : "+ans);
%>
        <jsp:setProperty property="testid" name="quespro" value="<%=testid %>"/>
    	<jsp:setProperty property="qno" name="quespro" value="<%=qno %>"/>
        <jsp:setProperty property="stuid" name="quespro" value="<%=stuid %>"/>
        <jsp:setProperty property="ans" name="quespro" value="<%=ans %>"/>	
<% 
int i=quespro.StoreStuAns();

if(submit_value.equalsIgnoreCase("Final Submit"))
{
	i=quespro.FinalSubmit();
out.println("Nothing happen"+i);
if(i==1)
   response.sendRedirect("Profile.jsp?msg=Successfull Submitted");
else 
	out.println("Unable to final submit");
}
                 else{  
                	 if(submit_value.equalsIgnoreCase("Previous"))
	                          id-=1;
                         else
                               id+=1;
                	 
                         if(i>0){

                                 response.sendRedirect("Questions.jsp?id="+id);
                                 }

                          else
	                            out.println("Unable to store ans");
                      }
}
else
{
	response.sendRedirect("Questions.jsp?id="+id+"&&msg=Please Select the option of question");
}
}
catch(Exception e){
	
	response.sendRedirect("Questions.jsp?id="+id+"&&msg=Please Select the option of question");
}
%>
</body>
</html>