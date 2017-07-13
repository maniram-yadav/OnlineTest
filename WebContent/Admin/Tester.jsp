<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%--

                           @Author Maniram Yadav
 --%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../mycss/jquery.min.js"> </script>
<script type="text/javascript">
$(document).ready(function(){
	
		
	
	
 $(document).on("mousemove",function(e){
	 if(e.pageX<100||e.pageY<200)
$(".ajax1").css({cursor:"none",position:"absolute", left:e.pageX,top:e.pageY});
	 
});

$(document).on("mouseup",function(e){
$(document)
.mouseXPos(e.pageX + 50);
});

function ajaxupdate(){
	
		$.ajax({
		url: 'ExamStatus.jsp',
		type: 'POST',
		success: function(result)
		{
		$('.ajax1').html(result);
		}
		});
	//setTimeout(ajaxupdate,500);
}
ajaxupdate();



$(document).mousemove(function(event){
    $("span").text(event.pageX + ", " + event.pageY);
    if(event.pageX<100)
    	 {
    	$(document)
         .mouseXPos(event.pageX + 50)
         .mouseYPos(event.pageY + 50);
    	}
    if(event.pageX>1000)
    	 {$(document)
         .mouseXPos(event.pageX - 50)
         .mouseYPos(event.pageY + 50);}
});

$(function(){
var d2 = new Date();
var d1 = new Date("2016-10-19 23:54:04");
var hour=(d2-d1)%(1000*60*60);
var minute=(d2-d1)%(1000*60);
$(".second").html("Diff. Seconds : "+((d2-d1)/1000).toString()+"Time : "+hour+" : "+minute+"   :");
 });
});
</script>

</head>
<body>
<div>
Page loader
</div>

<button type="button" id="submit">Click here</button>
<div class="ajax1">
hjkh
</div>
<span>
</span>
<div class="second"></div>
<div id="clock"></div>
</body>
</html>