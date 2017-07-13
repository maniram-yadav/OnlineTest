package onlinetest.mysql;

import java.sql.*;
public class DBConnection {
    public Connection con;
    public PreparedStatement pstmt;
    public Statement stmt;
    public DBConnection () throws Exception 
    {
    Class.forName("com.mysql.jdbc.Driver");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/onlinequiz","root","");
    stmt=con.createStatement();
    }
	
	public Connection getConnection(){
	return con;
	}
}
