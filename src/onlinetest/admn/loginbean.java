package onlinetest.admn;
import onlinetest.mysql.*;
import java.io.*;
import java.sql.*;
public class loginbean implements Serializable {
	
	/*************************************************
	 *                                               *
	 *        @AUTHOR   MANIRAM  YADAV               *
	 *        FGIET   B TECH  CSE  Student           * 
	 *                                               *
	 * ***********************************************/                                            


	private static final long serialVersionUID = 1L;
	private String userid,userpass;
	//private static final long serialVersionUID = 1L;
	public loginbean(){
		this.userid=this.getUserid();
		this.userpass=this.getUserpass();
	}
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpass() {
		return userpass;
	}

	public void setUserpass(String userpass) {
		this.userpass = userpass;
	}
	public boolean validate() {
		boolean status=true;
		String sql="select userid,password from admin_login where userid='"+userid+"' and password='"+userpass+"'";
		try{
			DBConnection db=new DBConnection();
			ResultSet rs=db.stmt.executeQuery(sql);
			if(rs.next())
				status=true;
			else 
				status=false;
			if(rs!=null)
			rs.close();
			if(db.stmt!=null)
			db.stmt.close();
			if(db.con!=null)
			db.con.close();
		   }
		catch(Exception e){
			status=false;
			
		                  }
		return status;
	}
	
}
