<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions</title>
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

<script type="text/javascript">
$(document).ready(function(){
	//$(".clk").load("CountDown.jsp");
	function clock(){
	$.ajax({
		url: "CountDown.jsp",
		type: "post",
		success : function(result){
			$(".clk").html(result);
		}
	});
	setInterval(clock,60000);
	}
	clock();
	
});
</script>

<style type="text/css">

.form-group{

padding:20px;
}

</style>
</head>
<body class="qbdbackground">

<div class="qhead">

</div>

<div class="clk">
</div>

<div class="qbody">
<jsp:useBean id="quespro" class="onlinetest.student.QuesProcess" scope="session"></jsp:useBean>
<%-- <%@page errorPage="Errorpage.jsp" %>  --%>
<%@page import="java.util.*" %>
<%@page import="onlinetest.mysql.*" %>
<%@page import="onlinetest.admn.*" %>
<%@page import="onlinetest.student.*" %>
<%@page import="java.sql.*" %>
<%@page errorPage="Errorpage.jsp" %>

<%  

int j=quespro.isStart();
if(j==0)
	response.sendRedirect("Profile.jsp");

String testid,m=null,stuid=null,qno,subans;
String ques=null,opta=null,optb=null,optc=null,optd=null;
int max=0,n,i;
String id=request.getParameter("id");
i=Integer.parseInt(id);
String msg=(String)request.getParameter("msg");
  if(msg!=null)
	  out.println("<h2 style=\"color:red;\">Please select the option then click the button</h2>");




if(i==0)
{
	 stuid=(String)session.getAttribute("stuid");
		testid=request.getParameter("testid");
		//out.println(stuid+"  "+testid);
		i=1;
	    qno=""+i;		
}
else
{
	stuid=(String)session.getAttribute("stuid");
	testid=(String)session.getAttribute("testid");
	m=(String)session.getAttribute("max");
	max=Integer.parseInt(m);
    qno=""+i;
    
}



%>

        <jsp:setProperty property="testid" name="quespro" value="<%=testid %>"/>
    	<jsp:setProperty property="qno" name="quespro" value="<%=qno %>"/>
        <jsp:setProperty property="stuid" name="quespro" value="<%=stuid %>"/>
        
  <%

subans=quespro.isAnswered();
if(subans==null)
   subans="n";
  // out.println(subans);
   
  if(i==1){
	   // Read question is already answered or not
    
    
   
	if(testid.equalsIgnoreCase("")||testid==null)
		request.getRequestDispatcher("Profile.jsp").forward(request,response);
    session.setAttribute("testid",testid);
    i=1;
    qno=""+i;
    session.setAttribute("qno",qno);
    //out.println(stuid+", "+testid+ " , ,,"+i+","+qno);
	
    
    
    
        max=quespro.GetMaxQno();

      //  out.println(max);
        session.setAttribute("max",""+max);
        if(!quespro.isFinalSubmit()){
		      Vector<String> v1=quespro.FetchQuest();
		      Iterator<String> it1=v1.iterator();
               if(it1.hasNext())
               {
            	   ques=it1.next();
            	   opta=it1.next();
            	   optb=it1.next();
            	   optc=it1.next();
            	   optd=it1.next();
    	        %> 
    	        
    	        
    	        
                  <ul class="pagination">
                  <%
                  int k;
                  for(k=1;k<=max;k++)
                  {
                  %>
                  <li><a href="Questions.jsp?id=<%=k %>"><%=k %></a></li>
                  <%
                  }
                  %>
                  </ul> 
    	        
    	          <form action="StoreAns.jsp" method="post" class="qform">
    	            <pre><b><%=i %></b>.<%=ques %></pre><br/>
    	           <table>
    	           <tr><td></td><td> A.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="a" <%if(subans.equalsIgnoreCase("a")) out.println("checked"); %>/>&nbsp;&nbsp;<%=opta %></td></tr>
    	           <tr><td></td><td> B.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="b" <%if(subans.equalsIgnoreCase("b")) out.println("checked"); %>/>&nbsp;&nbsp;<%=optb %></td></tr>
    	            <tr><td></td><td>C.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="c" <%if(subans.equalsIgnoreCase("c")) out.println("checked"); %>/>&nbsp;&nbsp;<%=optc %></td></tr>
    	            <tr><td></td><td>D.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="d" <%if(subans.equalsIgnoreCase("d")) out.println("checked"); %>/>&nbsp;&nbsp;<%=optd %></td></tr>
    	            <tr><td>
    	            </td><td>
    	            <input type="submit" name="submit" class="btn btn-primary" value="Next"/>
    	            </td></tr>
    	            </table>
    	            </form>
    	           <%--  
                  <ul class="pagination">
                  <%
                  //int k;
                  for(k=1;k<=max;k++)
                  {
                  %>
                  <li><a href="Questions.jsp?id=<%=k %>"><%=k %></a></li>
                  <%
                  }
                  %>
                  --%>
                  </ul>


   <%
   
   } }
        else{
        	
        	request.getRequestDispatcher("MyResult.jsp").forward(request,response);
        }        
}


else{
	
	
	session.setAttribute("qno",qno);
	if(i>0&&i<=max)
	{   
	
 if(!quespro.isFinalSubmit()){
		      Vector<String>  v=quespro.FetchQuest();
		      Iterator<String> it=v.iterator();
               if(it.hasNext())
               {
            	   ques=it.next();
            	   opta=it.next();
            	   optb=it.next();
            	   optc=it.next();
            	   optd=it.next();
               %>  
               
                  <ul class="pagination">
                  <%
                  int k;
                  for(k=1;k<=max;k++)
                  {
                  %>
                  <li><a href="Questions.jsp?id=<%=k %>"><%=k %></a></li>
                  <%
                  }
                  %>
                  </ul> 
                 <form action="StoreAns.jsp" method="post" class="qform" onsubmit="validate()">
    	         <pre><%=i %>.&nbsp;&nbsp;<%=ques %></pre><br/>
    	        <table>
    	        
    	           
    	           <tr><td>  </td><td>A.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="a"  <%if(subans.equalsIgnoreCase("a")) out.println("checked"); %>/>&nbsp;&nbsp;<%=opta %> </td></tr>  	          
    	           <tr><td></td><td>B.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="b" <%if(subans.equalsIgnoreCase("b")) out.println("checked"); %>/>&nbsp;&nbsp;<%=optb %></td></tr>
    	           <tr><td></td><td>C.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="c" <%if(subans.equalsIgnoreCase("c")) out.println("checked"); %>/>&nbsp;&nbsp;<%=optc %> </td></tr>
    	           <tr><td></td><td>D.&nbsp;&nbsp;&nbsp;<input type="radio" name="ans" value="d" <%if(subans.equalsIgnoreCase("d")) out.println("checked"); %>/>&nbsp;&nbsp; <%=optd %> </td></tr>
    	           <tr><td>


                
    	         <%
    	          if(i>1&&i<=max)
    	          {
    	          %>
    	          <div class="form-group">
    	          <input type="submit" name="submit" class="btn btn-primary" value="Previous"/>
    	          </div>
    	          <%
    	          }
    	         %>
    	          </td>
    	           <td>
    	           <%
    	           if(i==max)
    	           {
    	           %>
    	           <div class="form-group">
    	           <input type="submit" name="submit" class="btn btn-primary" value="Final Submit"/>
    	           </div>
    	           <%
    	           }
    	           else
    	           {
    	           %>
    	           <div class="form-group">
    	           <input type="submit" name="submit" class="btn btn-success" value="Next"/></td></tr>
    	           </div>
    	           <%
    	           }
    	           %>
    	           
    	           </table>
    	            </form>
    	         
                  <%-- <ul class="pagination ques-link">
                  <%
                 // int k;
                  for(k=1;k<=max;k++)
                  {
                  %>
                  <li><a href="Questions.jsp?id=<%=k %>"><%=k %></a></li>
                  <%
                  }
                  %>
                  </ul> 
                  --%>   
    	            <%  }
               }
	    else
	    {
	    	
	    	request.getRequestDispatcher("Profile.jsp").forward(request,response);	
	    }
               
               }
	else{
		out.println("<b> Question Overflow ");
	    }	
}

%>
</div>

<script>
var value;
function validate(){
value=document.getElementByName("ans").value;
if(value!=""||value!=null){
	//alert(value);
	return true;
}
else
	{
	//alert("Please Select the option");
	return false;
	}
}

</script>
</body>
</html>