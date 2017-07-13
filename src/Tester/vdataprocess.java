package Tester;
import java.util.*;
import java.sql.*;
import onlinetest.mysql.*;
public class vdataprocess {
     
	 public Vector<Vector> Data() throws Exception{
		 DBConnection db=new DBConnection();
		 Vector<Vector> vl1=new Vector<Vector>();
		 Vector<String> vl=new Vector<String>();
		 String sql="select * from testlist";
		 ResultSet rs=db.stmt.executeQuery(sql);
		 while(rs.next())
		 {
			 vl.add(rs.getString(1));
			 vl.add(rs.getString(2));
			 vl.add(rs.getString(3));
			 vl.add(rs.getString(4));
			 vl.add(rs.getString(5));
			 vl.add("::------------::");
			 vl1.add(vl);
		 }
		 return vl1;
	 }   
}
