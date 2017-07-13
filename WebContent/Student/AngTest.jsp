<!DOCTYPE html>
<html>
<title> Angular Js</title>
<script src="../AngularJs/angular.min.js"></script>
<script src="../js/Invalid.js"> </script>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<link rel="stylesheet" href="../css/bootstrap-select.min.css"/>
<link rel="stylesheet" href="../mycss/bootstyle.min.css"/>
<script src="../css/bootstrap.min.js"> </script>
<script src="../css/bootstrap-select.min.js"> </script>
<script src="../css/jquery.min.js"> </script>
<script src="../js/validation.form.js"> </script>
<script src="../mycss/jquery.min.js"> </script>

<body>
<%@page import="onlinetest.mysql.DBConnection"%>
<%@page import="java.sql.*" %>




<%--
<center><h3>Click the table headers to change the sorting order:</h3></center>
<br/>

<div ng-app="myApp" ng-controller="namesCtrl">

<table>
<tr>
<th><p><input type="text" ng-model="name"></p></th>
<th><p><input type="text" ng-model="branch"></p></th>
<th><p><input type="text" ng-model="year"></p></th>
<th><p><input type="text" ng-model="testtd"></p></th>
<th><p><input type="text" ng-model="date"></p></th>
<th><p><input type="text" ng-model="stime"></p></th>
<th><p><input type="text" ng-model=""></p></th>
<th><p><input type="text" ng-model="test"></p></th>

</tr>
<tr><td></td></tr>
</table>

 

<table class="table" border="1" width="100%">
<tr>
<th ng-click="orderByMe('name')">Name</th>
<th ng-click="orderByMe('branch')">Branch</th>
<th ng-click="orderByMe('year')">Year</th>
<th ng-click="orderByMe('testid')">Test Id</th>
<th ng-click="orderByMe('date')">Date</th>
<th ng-click="orderByMe('stime')">Submit Time</th>
<th ng-click="orderByMe('marks')">Marks</th>
<th ng-click="orderByMe('position')">Position</th>

</tr>
<tr ng-repeat="x in names | orderBy:myOrderBy">
<td>{{x.name}}</td>
<td>{{x.branch}}</td>
<td>{{x.year}}</td>
<td>{{x.testid}}</td>
<td>{{x.date}}</td>
<td>{{x.stime}}</td>
<td>{{x.marks}}</td>
<td>{{x.position}}</td>
</tr>
</table>

</div>
--%>








 

                <%
                    String name,email,stime,date,branch,year;
                    
                    int marks=0,rank=0;
                    String testid=request.getParameter("testid");
                    String sql="select * from stutest_history  as osh inner join stu_detail as osd "+
                    "on osd.stu_id=osh.stu_id where osh.test_id='"+testid+"' and osh.test_id in "+
                    " (select op.test_id from prev_tests as op where op.status=\"Test Processing\" "+
                    " or status=\"Test Finished\" ) order by osh.rank asc";


                    DBConnection db=new DBConnection();
                    ResultSet rs=db.stmt.executeQuery(sql);
                    if(rs.next())
                    {
                    	rs.previous();
                    %>
 <table class="table">


<tr>
<th>Name</th>
<th>Branch</th>
<th>Year</th>
<th>Test Id</th>
<th>Date</th>
<th>Submit Time</th>
<th>Marks</th>
<th>Position</th>

</tr>                    
                    <%
                    
                    while(rs.next())
                    {
                       branch=rs.getString("branch");
                       year=rs.getString("year");
                    	name=rs.getString("name");
                    	email=rs.getString("email");
                    	testid=rs.getString("test_id");
                    	date=rs.getString("date");
                    	stime=rs.getString("submit_time");
                    	marks=rs.getInt("marks");
                    	rank=rs.getInt("rank");
                    	
                   %>
         <tr><td><%=name %></td><td><%=branch %></td><td><%=year %></td><td><%=testid %></td><td><%=date %></td><td><%=stime %></td><td><%=marks %></td><td><%=rank %></td></tr>          
                   <% }  %>
                    </table>
                    <%}
                    
                    else{
                    	
                    
                   %>
                   <div class="label label-primary">
                   Any student Information does not exist in database for this Quiz Id.
                   </div>
                   
<%}
                    
                    if(rs!=null)
                    	rs.close();
                    if(db.stmt!=null)
                    	db.stmt.close();
                    if(db.con!=null)
                    	db.con.close();
                    %>









<%--
<script>
angular.module('myApp', []).controller('namesCtrl', function($scope) {
    $scope.names = [
                    <%
                  /* String name,email,stime,date,branch,year;
                   String country="India";
                  int marks=0,rank=0;
                   String testid=request.getParameter("testid");
                    String sql="select * from stutest_history  as osh inner join stu_detail as osd "+
                    "on osd.stu_id=osh.stu_id where osh.test_id='"+testid+"' and osh.test_id in "+
                    " (select op.test_id from prev_tests as op where op.status=\"Test Processing\" "+
                    " or status=\"Test Finished\" ) order by osh.rank asc";


                    DBConnection db=new DBConnection();
                    ResultSet rs=db.stmt.executeQuery(sql);
                    while(rs.next())
                    {
                       branch=rs.getString("branch");
                       year=rs.getString("year");
                    	name=rs.getString("name");
                    	email=rs.getString("email");
                    	testid=rs.getString("test_id");
                    	date=rs.getString("date");
                    	stime=rs.getString("submit_time");
                    	marks=rs.getInt("marks");
                    	rank=rs.getInt("rank");
                    */	
             if(rs.next()){   
            	 rs.previous();
                    %>
        {name:'<%=name %>',branch:'<%=branch %>',year:'<%=year %>',testid:'<%=testid %>',date:'<%=date %>',stime:'<%=stime %>',marks:'<%=marks %>',position:'<%=rank %>'},
        <%}
             else{
            
                 %>
                 {name:'<%=name %>',branch:'<%=branch %>',year:'<%=year %>',testid:'<%=testid %>',date:'<%=date %>',stime:'<%=stime %>',marks:'<%=marks %>',position:'<%=rank %>'}
                 <%}
                    }%>
        //{name:'',branch:'',year:'',testid:'',date:'',stime:'',marks:'',position:''}
        ];
    $scope.orderByMe = function(x) {
        $scope.myOrderBy = x;
    }
});
</script>
 --%>
 
 
 
 
 
 
</body>
</html>

