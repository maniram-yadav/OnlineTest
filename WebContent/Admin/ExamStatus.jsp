<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Test Final Submission</title>
<%--

                           @Author Maniram Yadav
 --%>

</head>
<body>
<%@page import="onlinetest.admn.*" %>
<%
testbean tb=new testbean();
boolean status=tb.isTimeOver();
boolean status1=tb.isProcessing();
String testid=null;
//out.println(status);
if(status)
{
	out.println("<h4 >Exam continue</h4>");
	response.setHeader("Refresh","60,ExamStatus.jsp");
}else
{
	if(status1)
	{
	testid=tb.TestSubmitFinal();
	//out.println(testid);
	tb.setTestid(testid);
     tb.createRank();
     response.setHeader("Refresh","60,ExamStatus.jsp");
	}
	else{
   
   response.sendRedirect("CreateCertificate.jsp");
	}
	}
%>
</body>
</html>