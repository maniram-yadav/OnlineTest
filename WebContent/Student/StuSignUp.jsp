<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign up here</title>
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
</head>
<body class="conatiner">
<center>
<div  class="conatiner1" style="margin-top:15px;">
<% 
String str=(String)request.getAttribute("msg");
if(str!=null)
	out.println(str);
%>
     <form action="SignUpProcess.jsp" name="SignUp" method="post" onsubmit="return signupvalidate()">
            <table>
               <tr><td class="alignation">Full Name :</td><td><div class="form-group "><input type="text" name="txtname" onkeypress="valid()" class="form-control input-margin txtname in-color" placeholder="Your Full Name" required/></div></td></tr>
               <tr><td class="alignation">Email :</td><td><div class="form-group"><input type="email" name="txtemail"  onkeypress="valid()"  class="form-control input-margin txtemail in-color" placeholder="Your Email Address" required/></div></td></tr>
               <tr><td class="alignation">Password :</td><td><div class="form-group"><input type="password" name="userpass"  onkeypress="valid()" class="form-control input-margin userpass in-color" placeholder="*******"  required/></div></td></tr>
               <tr><td class="alignation">Branch :</td><td>
               <div class="form-group"><select name="sltbranch"   onkeypress="valid()" class="form-control input-margin sltbranch in-color" required>
               <option value="">-- Select Your Branch --</option>
               <option value="CSE" class="option">Computer Science and Engineering</option>
               <option value="ME" class="option">Mechanical Engineering</option>
               <option value="EC" class="option">Electronics and Communication</option>
               <option value="AE">Aeronautical Engineering</option>
               <option value="CE">Civil Engineering</option>
               <option value="MCA">Master in Computer Application</option>
               <option value="EI">Electronics and Instrumentation</option>
               </select></div>
               </td></tr>
               <tr><td class="alignation"  >Academic Year :</td><td>
               <div class="form-group"><select name="sltyear"  onkeypress="valid()" class="in-color form-control input-margin sltyear" required>
               <option value="">-- Your Academic year --</option>
               <option value="1st">First Year</option>
               <option value="2nd">Second Year</option>
               <option value="3rd">Third Year</option>
               <option value="4th">Forth Year</option>
               </select></div>
               </td></tr>
               <tr><td class="alignation">UPTU Roll No. </td><td>
               <div class="form-group"><input type="text" name="txtrollno"  onkeypress="valid()" class="in-color form-control input-margin txtrollno" placeholder="Uptu Roll No" required/></div>
               </td></tr>
               <tr colspan=2><td style="text-align:center;">
               <div class="form-group valid"><center><input type="submit" name="submit" id="submit" class="btn btn-success btn-md btnsubmit sign-button" value="Sign Up" onclick="signupvalidate" required/></center></div></td></tr>
            </table>
     </form>
     </div>
     
     <script>

	 var txtname,txtemail,userpass,sltbranch,sltyear,txtrollno;
           function valid(){
        	   txtname=document.getElementByClassName("txtname").value;
        	   txtemail=document.getElementByClassName("txtemail").value;
        	   userpass=document.getElementByClassName("userpass").value;
        	   sltbranch=document.getElementByClassName("sltbranch").value;
        	   sltyear=document.getElementByClassName("sltyear").value;
        	   txtrollno=document.getElementByClassName("txtrollno").value;
        	   if(txtname!=""&&txtname.length>3&&userpass.length>5&&sltbranch!=""&&sltyear!=""&&txtrollno!="")
        		   
        		   {
        		   alert("Processing done");
        		   
                   }
        	   else
        		   {
        		   
        		   alert("Enter valid value");
        		   }
        	   }
     </script>

<div class="content">
</div>
</center>
</body>
</html>