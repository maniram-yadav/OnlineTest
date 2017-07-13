function login(){
	
	var password=document.getElementByName("userpass");
	if((password=="")||password.length<6)
		{
		alert("Enter correct Email or Password");
		}
}

function signupvalidate(){
	var txtname,txtemail,userpass,sltbranch,sltyear,txtrollno;
	
	
	if(document.SignUp.userpass.value.length<6)
		{
		alert("Password should be at least 6 character long");
		return false;
		}
	  
	return true;
}

