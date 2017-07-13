package onlinetest.admn;
import java.util.*;
import java.io.Serializable;
import onlinetest.mysql.*;
import java.sql.*;
import java.text.*;
import java.util.Date;
public class testbean implements Serializable{
	
	/*************************************************
	 *                                               *
	 *        @AUTHOR   MANIRAM  YADAV               *
	 *        FGIET   B TECH  CSE  Student           * 
	 *                                               *
	 * ***********************************************/                                            


	private String stuid,qid;
	private int qd=1,qn=1,sd=1;
	private static final long serialVersionUID = 1L;
	private String testid,certby,testname,department,qno,ques,a,b,c,d,ans;
	private String date,stime,etime,minutes,status;
    
	public String getStime() {
		return stime;
	}

	public void setStime(String stime) {
		this.stime = stime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}

	public String getMinutes() {
		return minutes;
	}

	public void setMinutes(String minutes) {
		this.minutes = minutes;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getQno() {
		return qno;
	}

	public void setQno(String qno) {
		this.qno = qno;
	}

	public String getQues() {
		return ques;
	}

	public void setQues(String ques) {
		this.ques = ques;
	}

	public String getA() {
		return a;
	}

	public void setA(String a) {
		this.a = a;
	}

	public String getB() {
		return b;
	}

	public void setB(String b) {
		this.b = b;
	}

	public String getC() {
		return c;
	}

	public void setC(String c) {
		this.c = c;
	}

	public String getD() {
		return d;
	}

	public void setD(String d) {
		this.d = d;
	}

	public String getAns() {
		return ans;
	}

	public void setAns(String ans) {
		this.ans = ans;
	}

	public String getTestid() {
		return testid;
	}

	public void setTestid(String testid) {
		this.testid = testid;
	}

	public String getCertby() {
		return certby;
	}

	public void setCertby(String certby) {
		this.certby = certby;
	}

	public String getTestname() {
		return testname;
	}

	public void setTestname(String testname) {
		this.testname = testname;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}
	
	
	/******************  Test ID and name creation in database   ***************/
    public boolean isInserted() throws Exception{
    	boolean status=false;
    	Date d=new Date();
    	SimpleDateFormat sdf=new SimpleDateFormat("yyy-MM-dd");
    	String date=sdf.format(d);
    	if(testid.equals(' ')||testname.equals(' ')||certby.equals(' ')||department.equals(' '))
    		return false;
    	    String sql="insert into testlist values('"+testid+"','"+testname+"','"+certby+"','"+department+"','"+date+"')";
    	   DBConnection db=new DBConnection();
    	    int i=db.stmt.executeUpdate(sql);
    	    status=(i==1)?true:false;
    	    if(db.stmt!=null)
    	    db.stmt.close();
    	    if(db.con!=null)
    	    db.con.close();
    	   return status;
          }  
    
    /*******************  return test list name to admin from database   ********************/
     
    public Vector<String>  testid() throws Exception{
    	 String sql="select * from testlist";
    	 Vector<String> v=new Vector<String>();
    	 DBConnection db=new DBConnection();
    	 ResultSet rs=db.stmt.executeQuery(sql);
    	 while(rs.next())
    	 {
    		 v.add(rs.getString(1));
    	 }
    	 if(rs!=null)
    	 rs.close();
    	 if(db.stmt!=null)
    	 db.stmt.close();
    	 if(db.con!=null)
    	 db.con.close();
    	 return v;
     }
    
    
    
    /***************      Controlled by Storeques.jsp          ****************/
    /*******************    Store question in database         ***********************/
    
    
    public boolean QinsDB() throws Exception{
    	boolean state=false;
    	int qnum=0;
        int qid=0,i1,i3,i4,i5;
        DBConnection db=new DBConnection();
                
        
        /*******      Insert question    ******/
        if(ques.equals("")||a.equals("")||b.equals("")||c.equals("")||d.equals("")||ans.equals(""))
        {
        	state=false;
        }

        else
        	{
        	ques=String.format("%s",ques);
        	String sql="insert into question(q_text) values('"+ques+"')";
        	
    	        i1=db.stmt.executeUpdate(sql);
     if(i1>0){
    	 
    	                       /**********     Find question id of inserted question   *****************/
    	  String sql1="select q_id from question where q_text='"+ques+"'";
    	         String sql2="select max(q_no) from test_question where test_id='"+testid+"'";
    	             /*   ********    Find max question number related to test in database  ***********   */
    	
    	 
    	         ResultSet rs=db.stmt.executeQuery(sql2);
    	          if(rs.next())
    		          qnum=rs.getInt(1);
    	          else 
    		           qnum=0;
    	          qnum+=1;
    	          if(rs!=null)
    	          rs.close();
    	
    	rs=db.stmt.executeQuery(sql1);
    	if(rs.next())
    		qid=rs.getInt(1);
    	else 
    		 qid=0;
    	if(rs!=null)
    	rs.close();
    	a=String.format("%s",a);
    	b=String.format("%s",b);
    	c=String.format("%s",c);
    	d=String.format("%s",d);
    	
    	          String sql3="insert into qid_options values("+qid+",'"+a+"','"+b+"','"+c+"','"+d+"')";
    	          i3=db.stmt.executeUpdate(sql3);
    	String sql5="insert into ques_ans values("+qid+",'"+ans+"')";
    	i5=db.stmt.executeUpdate(sql5);
    	
    	String sql4="insert into test_question(test_id,q_id,q_no) values('"+testid+"',"+qid+","+qnum+")";
    	          i4=db.stmt.executeUpdate(sql4);
    	          if(i3>0&&i4>0&&i5>0)
    	        	  state=true;
    	          else 
    	          {  String sql6="delete * from onlinequiz.question,onlinequiz.qid_options,onlinequiz.ques_ans,onlinequiz.test_question where q_id="+qid+"";
    	        	 int i7=(int) db.stmt.executeLargeUpdate(sql6);  
    	          state=false;
    	          }
    	        }}
     if(db.stmt!=null)
     db.stmt.close();
     if(db.con!=null)
     db.con.close();
    	return state;
    }
    
    
    
    
    /*************      Insert start time and end time of exam in db SaveTestTime.jsp  TestIdDetail.jsp  ****************/
   public int savetime() throws Exception{
	   DBConnection db=new DBConnection();
	   String sql="insert into prev_tests(test_id,starttime,endtime,date,status,examduration) values(?,?,?,?,?,?)";
	   PreparedStatement ps=db.con.prepareStatement(sql);
	   ps.setString(1, testid);
	   ps.setString(2, stime);
	   ps.setString(3, etime);
	   ps.setString(4, date);
	   ps.setString(5, status);
	   ps.setInt(6, Integer.parseInt(minutes));
	   int i=ps.executeUpdate();
	   if(ps!=null)
	   ps.close();
	   if(db.stmt!=null)
	   db.stmt.close();
	   if(db.con!=null)
	   db.con.close();
	   return i;
   }
   
   /**************    return max qno from database of the test id      *******************/






/******************  Return true if exam finished  ExamStatus.jsp  ***************************/

   public boolean isTimeOver() throws Exception{
	   boolean status=false;
	   String str=null,now=null;
	   DBConnection db=new DBConnection();
	   String sql="select endtime from prev_tests where status=\"Started\"";
        ResultSet rs=db.stmt.executeQuery(sql);
        if(rs.next())
        {  	str=rs.getString("endtime");// Exame execution time
        
        Date d=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        now=sdf.format(d);  // current time

DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
Date date1 = formatter.parse(str);  // exam execution time
Date date2 = formatter.parse(now);   // current time


       // Get msec from each, and subtract.
        long diff = date1.getTime() - date2.getTime();
       if(diff>0)
       status=true;
        } 
if(rs!=null)
        rs.close();
if(db.stmt!=null)
        db.stmt.close();
if(db.con!=null)
        db.con.close();
        return status;
   }

   /*
   public static void main(String[] args) throws Exception{
	   
	   String str=new testbean().TestSubmitFinal();
	   System.our.println("main function");
   }
   */

/********************   Submit test final  ExamStatus.jsp   
 * @return ************************/
 public String TestSubmitFinal() throws Exception{
	 int i=0,total=0;
	 ArrayList<Integer> al=new ArrayList<Integer>();
	 //PreparedStatement psm=null;
	String tid=null;
	 DBConnection db=new DBConnection();
	 String str,name=null,email=null,sql;
	 ResultSet rs;

	 
     sql="select test_id from prev_tests where status=\"Started\"";
     rs=db.stmt.executeQuery(sql);
     String testid=null,sql1;
     
     if(rs.next())
    	 testid=rs.getString("test_id");
    
     rs.close();
     
	 /*sql="select distinct stu_answers.stu_id FROM stu_answers where stu_answers.stu_id "+
			 " not in (SELECT stutest_history.stu_id FROM stutest_history) and stu_answers.test_id in "
			 +" (select prev_tests.test_id from prev_tests where prev_tests.status=\"Test Processing\")";
    */
     
	
     sql="select distinct stu_answers.stu_id FROM stu_answers where stu_answers.test_id='"+testid+"' and stu_answers.stu_id "+
			 " not in (SELECT stutest_history.stu_id FROM stutest_history) ";
			 
    
	 
	 
	 /************** Store in array list stuid  who have not final submitted************/
	 
	 
	 rs=db.stmt.executeQuery(sql);    
	 
    while(rs.next()){                                
		sd=rs.getInt(1);                               
		al.add(sd); 
	//System.out.println(";;;;Main : "+sd);
		
    }
    //if(rs!=null)
    //rs.close();
    Iterator<Integer> it=al.iterator();
    while(it.hasNext()){
    	
    	sd=(int)it.next();
   	   Date d=new Date();
   	  SimpleDateFormat sdfdate=new SimpleDateFormat("yyyy:MM:dd");
   	  SimpleDateFormat sdftime=new SimpleDateFormat("hh:mm:ss");
   	  String date=sdfdate.format(d);
   	  String time=sdftime.format(d);
   	
   	  //System.out.println("it : ==="+sd); 
   	  
//   	  sd=Integer.parseInt(stuid);
   	  sql="select * from stu_detail where stu_id="+sd+"";
   	  sql1="select sum(iscorrect) as toatl from stu_answers where stu_id="+sd+"";
   	  /*ResultSet */
   	  
   	  
   	  rs=db.stmt.executeQuery(sql1);
   	  if(rs.next())
   		  total=rs.getInt(1);
   	  
   	  
   	//if(rs1!=null)
   	  //rs1.close();     	
   	
   	  rs=db.stmt.executeQuery(sql);
   	  if(rs.next())
   		  {
   		  name=rs.getString("name");
   		  email=rs.getString("email");
   	  /*
   		  sql1="select final_submit from stutest_history where stu_id="+sd+" and test_id='"+testid+"'";
   		   	
   		  rs=db.stmt.executeQuery(sql1);
   		  if(rs.next())
   		  {
   			  str=rs.getString("final_submit");
   			  if(str.equalsIgnoreCase("no"))
   				  str="yes";
   			
   			  sql1="update stutest_history set final_submit='"+str+"' where stu_id="+sd+" and test_id='"+testid+"'";
   			 
   			  i=db.stmt.executeUpdate(sql1);
   		     
   		  }
   	  
   		  else
   		  {
   		*/	  
   	  sql="insert into stutest_history(stu_id,name,email,test_id,date,submit_time,final_submit,marks) values(?,?,?,?,?,?,?,?)";
   		  PreparedStatement psm=db.con.prepareStatement(sql);
   		  psm.setInt(1,sd);
   		  psm.setString(2,name);
   		  psm.setString(3,email);
   		  psm.setString(4,testid);
   		  psm.setString(5,date);
   		  psm.setString(6,time);
   		  psm.setString(7,"yes");
   		  psm.setInt(8,total);
   		 i=psm.executeUpdate(); 
   		if(psm!=null) 
      		 psm.close();	 
   		 
   	        
   	  }
 
	 
	 }
    
	 sql="update prev_tests set status=\"Test Processing\" where status=\"Started\"";
	 i=db.stmt.executeUpdate(sql);
	 
   		  
   		 
	 if(rs!=null)
		 rs.close();
	 
	 if(db.stmt!=null)
	 db.stmt.close();
	 
	 if(db.con!=null)
	 db.con.close();
	 
	 return testid;
 }
 


  
 
    /***********************  start ranking of students  ExamStatus.jsp*****************************/
   public void createRank() throws Exception {
	 DBConnection db=new DBConnection();
	 String str=null;
	 int value,key;
	 ArrayList<Integer> al=new ArrayList<Integer>();
	 int i=1,k,size=0;
	 
	 String sql="SELECT * FROM  stutest_history where test_id='"+testid+"' order by marks desc,submit_time asc";
     ResultSet rs=db.stmt.executeQuery(sql);
     
     while(rs.next())
     {
    	 sd=rs.getInt("stu_id");    
         al.add(sd);
     }
     if(rs!=null)
     rs.close();
    Iterator<Integer> it=al.iterator();
     while(it.hasNext())
     {
    	 value=(int)it.next();
    	 sql="update stutest_history set rank="+(i++)+" where stu_id="+value+"";
    	 k=db.stmt.executeUpdate(sql);
     }
     if(db.stmt!=null)
   db.stmt.close();
     if(db.con!=null)
   db.con.close();
   }
public boolean isProcessing() throws Exception{
	DBConnection db=new DBConnection();
	boolean state=false;
	 String   sql="select test_id from prev_tests where status=\"Started\"";
	    ResultSet rs=db.stmt.executeQuery(sql);    
		 if(rs.next())
		 { 
			state =true;
		 }
		
		 if(rs!=null)
			 rs.close();
		 if(db.stmt!=null)
			 db.stmt.close();
		 if(db.con!=null)
			 db.con.close();
	return state;
}
}