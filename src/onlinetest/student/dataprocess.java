package onlinetest.student;
import java.util.*;
import onlinetest.mysql.*;
import java.sql.*;
import java.io.Serializable;
public class dataprocess implements Serializable{
	
	/*************************************************
	 *                                               *
	 *        @AUTHOR   MANIRAM  YADAV               *
	 *        FGIET   B TECH  CSE  Student           * 
	 *                                               *
	 * ***********************************************/                                            


	private static final long serialVersionUID = 1L;
	private String txtname,userpass,sltbranch,sltyear,txtrollno,txtemail;

	public String getTxtname() {
		return txtname;
	}

	public void setTxtname(String txtname) {
		this.txtname = txtname;
	}

	public String getUserpass() {
		return userpass;
	}

	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}

	public String getSltbranch() {
		return sltbranch;
	}

	public void setSltbranch(String sltbranch) {
		this.sltbranch = sltbranch;
	}

	public String getSltyear() {
		return sltyear;
	}

	public void setSltyear(String sltyear) {
		this.sltyear = sltyear;
	}

	public String getTxtrollno() {
		return txtrollno;
	}

	public void setTxtrollno(String txtrollno) {
		this.txtrollno = txtrollno;
	}

	public String getTxtemail() {
		return txtemail;
	}

	public void setTxtemail(String txtemail) {
		this.txtemail = txtemail;
	}
	    /*   ****************  Insertion  of stu detail in table SignUpProcess.jsp    **********************  */
public int isValid() throws Exception{
	int i=0;
	DBConnection db=new DBConnection();
	String sql3="select email from stu_detail where email='"+txtemail+"'";
	ResultSet rs1=db.stmt.executeQuery(sql3);
	if(rs1.next())
	{
		i=-1;
		rs1.close();
	}
	
	else
	{
	
	if(txtname.equals("")||userpass.equals("")||sltbranch.equals("")||sltyear.equals("")||txtrollno.equals("")||txtemail.equals("")||userpass.length()<6)
	{
		i=0;
	}	
	else{
		
		String sql="insert into stu_detail(name,email,year,branch,rollno) values(?,?,?,?,?)";
		String sql2="select stu_id from stu_detail where email='"+txtemail+"'";
		String sql1="insert into login_detail values(?,?,?)";
		PreparedStatement psm=db.con.prepareStatement(sql);
		psm.setString(1,txtname);
		psm.setString(2,txtemail);
		psm.setString(3,sltyear);
		psm.setString(4,sltbranch);
		psm.setString(5,txtrollno);
		i=psm.executeUpdate();
		if(psm!=null)
		psm.close();
		if(i>0)
		{
			ResultSet rs=db.stmt.executeQuery(sql2);
			if(rs.next())
				i=rs.getInt(1);
			
			psm=db.con.prepareStatement(sql1);
		           psm.setInt(1,i);
	               psm.setString(2,txtemail);
		           psm.setString(3,userpass);
		           i=psm.executeUpdate();
		           if(rs!=null)
		           rs.close();
		           if(psm!=null)
		           psm.close();
		}
		 /******************   Delete data from table if if login_insertion become unsuccess  **********************/
		        if(i==0){
		       	i=db.stmt.executeUpdate("delete from stu_detail where email='"+txtemail+"'");
			    i=0;
		        }
	
	}
	}
    if(db.stmt!=null)
db.stmt.close();
        if(db.con!=null)
db.con.close();

	return i;
}   



/******************** Student   Login verification  Profile.jsp *****************************/

                  public  Vector<String> ValidLogin() throws Exception{
                	  Vector<String> v=new Vector<String>();
                	  DBConnection db=new DBConnection();
                	  String sql="select * from login_detail where email=? and password=?";
                	  PreparedStatement psm=db.con.prepareStatement(sql);
                	  psm=db.con.prepareStatement(sql);
   	                  psm.setString(1,txtemail);
   		              psm.setString(2,userpass);
   		              ResultSet rs=psm.executeQuery();
   		              if(rs.next())
   		              {
   		            	  sql="select * from stu_detail where email='"+txtemail+"'";
   		            	  rs=db.stmt.executeQuery(sql);
   		              }
   		            while(rs.next())
   		            {
   		            	v.add(rs.getString(1));
   		            	v.add(rs.getString(2));
   		            	v.add(rs.getString(3));
   		            	v.add(rs.getString(4));
   		            	v.add(rs.getString(5));
   		            	v.add(rs.getString(6));
   		            }
   		         if(psm!=null)
   		            psm.close();
   		      if(rs!=null)
   		            rs.close();
   		   if(db.stmt!=null)     
   		      db.stmt.close();
   		if(db.con!=null)
   		            db.con.close();
                	  return v;
                	  
                	
                  }
                  
   
}
