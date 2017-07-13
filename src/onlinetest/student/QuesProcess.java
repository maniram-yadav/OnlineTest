package onlinetest.student;
import java.io.Serializable;
import java.util.*;
import java.util.Date;

import onlinetest.mysql.*;
import java.sql.*;
import java.text.*;
public class QuesProcess implements Serializable {
	
	/*************************************************
	 *                                               *
	 *        @AUTHOR   MANIRAM  YADAV               * 
	 *        FGIET   B TECH  CSE  Student           *
	 *                                               *
	 * ***********************************************/                                            

	private static final long serialVersionUID = -4883439539398606907L;
private String testid,ans,qno,stuid,qid;
private int qd=1,qn=1,sd=1;
public String getStuid() {
	return stuid;
}

public void setStuid(String stuid) {
	this.stuid = stuid;
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

public String getQid() {
	return qid;
}

public void setQid(String qid) {
	this.qid = qid;
}

public String getQno() {
	return qno;
}

public void setQno(String qno) {
	this.qno = qno;
}




public int GetMaxQno() throws Exception{
	
	DBConnection db=new DBConnection();
	String sql="select q_no from test_question where test_id='"+testid+"' order by q_no desc";
	ResultSet rs=db.stmt.executeQuery(sql);
	if(rs.next())
	{		int i=rs.getInt(1);
	return i;
	}
	if(rs!=null)
	rs.close();
	if(db.stmt!=null)
	db.stmt.close();
	if(db.con!=null)
	db.con.close();
return 0;	
}





       /*  *****************   Fetch question from database Question.jsp  *******************  */
public Vector<String> FetchQuest() throws Exception{
	DBConnection db=new DBConnection();
	Vector<String> v=new Vector<String>();
	
	qn=Integer.parseInt(qno);
	     /*************      Select qid related to question no from test_question  ***************/
	String sql1="select q_id from test_question where q_no="+qn+" and test_id='"+testid+"'";
	 
	ResultSet rs=db.stmt.executeQuery(sql1);
	if(rs.next())
	    qd=rs.getInt(1);	
	if(rs!=null)
	rs.close();
	
	/*************   Select question text from question and q_id options related to qid  ************/
	
	String sql="select question.q_text,opt_a,opt_b,opt_c,opt_d from question,qid_options"
			+ " where question.q_id="+qd+" and qid_options.q_id="+qd+"";
	rs=db.stmt.executeQuery(sql);
	if(rs.next())
	{
		v.add(rs.getString(1));
		v.add(rs.getString(2));
		v.add(rs.getString(3));
		v.add(rs.getString(4));
		v.add(rs.getString(5));
	}
	if(rs!=null)
	rs.close();
	if(db.stmt!=null)
	db.stmt.close();
	if(db.con!=null)
	db.con.close();
	return v;
}





             /**********   Store student answer in database   Question.jsp   ************/
  public int StoreStuAns() throws Exception{
	 
	  DBConnection db=new DBConnection();
	  int correct=0,i;
	  qn=Integer.parseInt(qno);
	  String correct_option="N";
	  String sql1="select * from stu_answers where stu_id='"+stuid+"' and test_id='"+testid+"' and testq_no="+qn+"";
	  ResultSet rs=db.stmt.executeQuery(sql1);
	  
	  
	  // Update question answer if already has been answered  by student
	  if(rs.next())
	  {
		  
		  sql1="select correct_option from ques_ans where q_id="+qd+"";
		  if(rs!=null)
		  rs.close();
		  
          rs=db.stmt.executeQuery(sql1);
               if(rs.next())
               { 
            	   correct_option=rs.getString(1);
            	     if(correct_option.equalsIgnoreCase(ans))  
    	                       correct=1;
               }
               if(rs!=null)
            rs.close();
            
            sql1="update stu_answers set stu_option='"+ans+"',iscorrect="+correct+" where stu_id='"+stuid+"' and test_id='"+testid+"'"
            		+ " and testq_no="+qn+"";
            i=db.stmt.executeUpdate(sql1);
		  
	  }
	  
	  
	  else
	  {
	  
	    String sql="insert into stu_answers(stu_id,test_id,q_id,testq_no,correct_option,stu_option,iscorrect) values(?,?,?,?,?,?,?)";
	           
	       /*******   Query for choosing correct option from the database  ********/
	      sql1="select correct_option from ques_ans where q_id="+qd+"";
	      if(rs!=null)
	      rs.close();
	      rs=db.stmt.executeQuery(sql1);
	               if(rs.next())
	               {  correct_option=rs.getString(1);
	            	     if(correct_option.equalsIgnoreCase(ans))  
	    	                       correct=1;
	               }
	      
	             /*       Query for Inserting student record with answer in the database  */
	      PreparedStatement psmt=db.con.prepareStatement(sql);
	      psmt.setInt(1,Integer.parseInt(stuid));
	   psmt.setString(2,testid);
	      psmt.setInt(3,qd);
	      psmt.setInt(4,qn);
	      psmt.setString(5,correct_option);
	      psmt.setString(6,ans);
	      psmt.setInt(7, correct);
	      
	      i=psmt.executeUpdate();
	     psmt.close();
	  }
	  if(db.stmt!=null)
	  db.stmt.close();
	  if(db.con!=null)
	  db.con.close();
	  return i;
	      
  }
  
  
  
  
  
  
  /*****************    Final  SubMission Process  from  StoreAns.jsp        ***********************/

      public int FinalSubmit() throws Exception{
    	  int i=0,total=0;
    	  DBConnection db=new DBConnection ();
    	  Date d=new Date();
    	  String str,name=null,email=null;
    	  SimpleDateFormat sdfdate=new SimpleDateFormat("yyyy:MM:dd");
    	  SimpleDateFormat sdftime=new SimpleDateFormat("hh:mm:ss");
    	  String date=sdfdate.format(d);
    	  String time=sdftime.format(d);
    	  sd=Integer.parseInt(stuid);
    	  String sql="select * from stu_detail where stu_id="+sd+"";
    	  String sql1="select sum(iscorrect) as toatl from stu_answers where stu_id="+sd+"";
    	  ResultSet rs1=db.stmt.executeQuery(sql1);
    	  if(rs1.next())
    		  total=rs1.getInt(1);
    	  rs1.close();
    	  ResultSet rs=db.stmt.executeQuery(sql);
    	  if(rs.next())
    	  { name=rs.getString("name");
    		  email=rs.getString("email");
    	     sql1="select final_submit from stutest_history where stu_id="+sd+" and test_id='"+testid+"'";
    		  rs1=db.stmt.executeQuery(sql1);
    		  if(rs1.next())
    		  {
    			  str=rs1.getString("final_submit");
    			  if(str.equalsIgnoreCase("no"))
    				  str="yes";
    			  sql1="update stutest_history set final_submit='"+str+"' where stu_id="+sd+" and test_id='"+testid+"'";
    			  i=db.stmt.executeUpdate(sql1);
    		  rs1.close();
    		  }
    	  
    		  else
    		  {
    			  
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
    	  if(db.stmt!=null)
    	   db.stmt.close();
    	  if(db.con!=null)
    	   db.con.close();
    	  return i;
      

}  
      
      
      
/****************  Test on each page of Question.jsp Student final submitted or not  ************************/

public boolean isFinalSubmit() throws Exception{
	  boolean status=false;
	  String finalsubmit=null;
	  sd=Integer.parseInt(stuid);
	  DBConnection db=new DBConnection();
	  String sql="select final_submit from stutest_history where stu_id="+sd+" and test_id='"+testid+"'";
   ResultSet rs=db.stmt.executeQuery(sql);
  try{  if(rs.next())
    	finalsubmit=rs.getString("final_submit");
    if(finalsubmit.equalsIgnoreCase("yes"))
    	status=true;
    else
    	status=false;
  }
  catch(Exception e){
	  status=false;
  }
  if(rs!=null)
  rs.close();
  if(db.stmt!=null)
  db.stmt.close();
  if(db.con!=null)
  db.con.close();
    return status;
}




/********************     End of  Final  Submit    of  question    ***************************/


     /****************       Particular Student Result  in test  MyResult.jsp  *****************************/
public Vector<String> MarksDetail() throws Exception{
	int total=0;
	Vector<String> v=new Vector<String>();
	DBConnection db=new DBConnection();
	String sql="select sh.name,sh.test_id,sh.marks,sd.year,sd.branch,sd.rollno from stutest_history as sh,stu_detail as sd where sd.stu_id="+sd+" and sh.stu_id="+sd+" and test_id='"+testid+"'";
	ResultSet rs=db.stmt.executeQuery(sql);
	if(rs.next())
	{
		v.add(rs.getString(1));
		v.add(rs.getString(2));
		v.add(""+rs.getInt(3));
		v.add(rs.getString(4));
		v.add(rs.getString(5));
		v.add(rs.getString(6));
	}
	if(rs!=null)
	rs.close();
	if(db.stmt!=null)
	db.stmt.close();
	if(db.con!=null)
	db.con.close();
    return v;	
}   






/********************* Is   Quiz  Started  isStarted.jsp     ***************************/

  public String startedTest() throws Exception{
	    
	    String testid=null;
	    String sql="select * from prev_tests where status='"+"Started"+"'";
	    DBConnection db=new DBConnection();
	    ResultSet rs=db.stmt.executeQuery(sql);
	    if(rs.next())
	    	testid=rs.getString("test_id");
	    if(rs!=null)
	    rs.close();
	    if(db.stmt!=null)
	    db.stmt.close();
	    if(db.con!=null)
	    db.con.close();
	    return testid;
	  }

/****************** Return started test id to isStarted .jsp*******************/
/*public String testName() throws Exception{
	String sql="select testid from prev_tests where status";
	
}*/




/****************** Returned answer of question if already has been answered Question.jsp  *******************************/

  public String isAnswered() throws Exception{
	  qn=Integer.parseInt(qno);
	  sd=Integer.parseInt(stuid);
	  String stuans=null;
	    DBConnection db=new DBConnection();
	    String sql="select stu_option from stu_answers where stu_id="+sd+" and test_id='"+testid+"'"
	    		+ "  and testq_no="+qn+"";
	    ResultSet rs=db.stmt.executeQuery(sql);
	    if(rs.next())
	    	stuans=rs.getString(1);
	    if(rs!=null)
	    rs.close();
	    if(db.stmt!=null)
	    db.stmt.close();
	    if(db.con!=null)
	    db.con.close();
	    return stuans;
	  
  }
 
  /*************************    Return test end time to question page  *************************************/
  
  public String TestEndTime() throws Exception{

DBConnection db=new DBConnection();
String sql="select endtime from prev_tests where status=\"Started\"";
String endtime=null;
ResultSet rs=db.stmt.executeQuery(sql);
if(rs.next())
{

	endtime=rs.getString("endtime");
	
}
	if(rs!=null)
	rs.close();
if(db.stmt!=null)
	db.stmt.close();
if(db.con!=null)
	db.con.close();

	return endtime;  
  }
 
  
  
  // Check the status of exam i.e exam is finished or  not   Question.jsp
  
  public int isStart() throws Exception {
	  int i=0;
	  DBConnection db=new DBConnection();
	  String sql="select * from prev_tests where status =\"Started\"";
	  ResultSet rs=db.stmt.executeQuery(sql);
	  if(rs.next())
		  i=1;
	  return i;
  }
  
  
  
}