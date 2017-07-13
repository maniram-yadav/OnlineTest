package onlinetest.network;
import java.util.Vector;
import java.util.Iterator;
import javax.mail.*;

import java.util.Date;
import java.util.Properties;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.activation.*;
import javax.mail.internet.*;

import onlinetest.mysql.DBConnection;

/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               * 
 *        FGIET   B TECH  CSE  Student           *
 *                                               *
 * ***********************************************/                                            


public class WelcomeEmail {
   private static final String user=MailString.EMAIL;
   private static final String password=MailString.PASSWORD;
   private static final String host=MailString.HOST;
   private static final String port=MailString.PORT;
  /*public static void main(String[] args) throws AddressException ,MessagingException, SQLException{
   
	   WelcomeEmail.sendMail();
   }*/
   public static int sendMail() throws AddressException ,MessagingException, SQLException{
	   Properties ppt=new Properties();
	   ppt.put("mail.smtp.starttls.enable","true");
       ppt.put("mail.smtp.host", host);
       ppt.put("mail.smtp.user",user);
       ppt.put("mail.smtp.password",password);
       ppt.put("mail.smtp.port",port);
       ppt.put("mail.smtp.auth","true");
       int i=0;
       DBConnection db = null;
       String sql="select * from stu_detail where stu_detail.email not in (select maildetail.email from maildetail)";
       String email1=null,name=null,year,branch,rollno,password1,message,subject;
       int j=0,sid;
       Vector<String> v=new Vector<String>();
       subject="QuizSphere SignUp Welcome";
       // creates a new session with an authenticator
       Authenticator auth = new Authenticator() {
           public PasswordAuthentication getPasswordAuthentication() {
               return new PasswordAuthentication(user,password);
           }
       };

       Session session = Session.getInstance(ppt,auth);

       // creates a new e-mail message
      
       MimeMessage msg = new MimeMessage(session);
       msg.setFrom(new InternetAddress(user));
       
       
       
       
       try{
    	      db=new DBConnection();
    	       ResultSet rs=db.stmt.executeQuery(sql);
    	        
    	        while(rs.next()){
    	        	email1=rs.getString("email");
    	        	name=rs.getString("name");
    	        	//password1=rs.getString("password");
    	        	year=rs.getString("year");
    	        	branch=rs.getString("branch");
    	        	rollno=rs.getString("rollno");
    	        	sid=rs.getInt("stu_id");
    	        	
    	        	v.add(email1);
    	        	v.add(name);
    	        	v.add(year);
    	        	v.add(branch);
    	        	v.add(rollno);
    	        	v.add(""+sid);
    	         }
    	}
    	  catch(Exception e){
    	          	
    	  
    	    return -1;
    	  }
       
       
    	        	
       try{
      Iterator<String> it=v.iterator();
        while(it.hasNext()){
        	email1=(String)it.next();
        	name=(String)it.next();
        	
        	year=(String)it.next();
        	branch=(String)it.next();
        	rollno=(String)it.next();
        	sid=Integer.parseInt((String)it.next());
        	

        	
        	//InternetAddress[] toAddresses =new InternetAddress[toAddress.length()];
    
        	/* 
        	 * message="Hi <h3>"+name+"</h3> ,<br/> Thank You for signing up and keep in touch with <h2>QUIZSPHERE</h2> "
            		+"A platform where you test your knowledge and improve yourself.<br/>"
            		+ " You profile detail of QUIZSPHER has been given below ..<table>"
            		+ "<tr><td>Name</td><td>"+name+"</td></tr><tr><td>Email</td><td>"+email1+"</td></tr><tr><td>Year</td><td>"+year+"</td></tr>"
            		+ "<tr><td>Branch</td><td>"+branch+"</td></tr><tr><td>Roll No.</td>"+rollno+"<td></td></tr><tr><td>Student Id. </td><td>"+sid+"</td></tr>";
            		
            *
            */
        	  message="Congratulations <h3>"+name+"</h3> !<br/>You have been successfuly registered to <h3>QUIZSPHERE</h3> "
             		+"It is a platform where you can test your knowledge through variety of problems.<br/>"
        			  +" In Quizsphere we conduct test within a proper environment that includes user-friendly interface "
        			  + "and within valid time schedule that matches with various online test conditions."
        			  
             		+ " Your  <h3>QUIZSPHERE</h3> profile detail :<table>"
             		+ "<tr><td>Name</td><td>"+name+"</td></tr><tr><td>Email</td><td>"+email1+"</td></tr><tr><td>Year</td><td>"+year+"</td></tr>"
             		+ "<tr><td>Branch</td><td>"+branch+"</td></tr><tr><td>Roll No.</td>"+rollno+"<td></td></tr><tr><td>Student Id. </td><td>"+sid+"</td></tr></table>"
             		+"Thank you <br/><h4>With Regards</h4><b>Maniram Yadav</b><br/><b>Student of Computer Science and Engineering<b/>";
        	  
             
        	
        	
        	
        	/*"Dear <h3>"+name+"</h3> , Welcome to the <h4>QUIZSPHERE</h4> a web application designed for organizing "
            		+ " quizes and tests in FGIET.";*/
            		/*""+
              "<html>"+
            "<head>"+
            "<style type=\"text/css\">"+
            ".move{"+
            "position:absolute;"+
            "color:red;"+
            "font-weight:600;"+
            " font-family:algerian;"+
            "text-shadow:2px 2px yellow;"+
            "animation:3s anim infinite;"+
            "transform-origin:center;"+
            "}"+
            "@keyframes anim{"+
               "25%{"+
               "transform:rotate(10deg);"+
               "}"+
               "   50%{"+
               "transform:rotate(0deg);"+
               "}"+
               "75%{"+
              " transform:rotate(-10deg);"+
             "  }"+
            "}"+
            ".clg{"+
               "font-family:algerian;"+
               "font-size:25px;"+
               "width:60%;"+
               "height:auto;"+
               "color:white;"+
               "background:radial-gradient(circle,pink,yellow,blue,black);"+
               "animation:5s anim1 infinite ease-in;"+
               "border-radius:50%;"+
               "text-align:center;"+
              " text-shadow:2px 2px red,4px 4px black;"+
             "  font-size:30px;"+
            "}"+
            "@keyframes anim1{"+
            "25%{background:radial-gradient(circle,brown,yellow,blue,black);"+
            "transform:translateX(-40%);"+
            "}"+
            "50%{background:radial-gradient(circle,yellow,brown,black,pink);"+
            "transform:translateX(0%);"+
            "}"+
            "75%{background:radial-gradient(circle,blue,black,brown,yellow);"+
            "transform:translateX(40%);"+
            "}"+
            "100%{background:radial-gradient(circle,black,brown,yellow,blue);}"+

            "}"+
            "table{"+
            "color:white;"+
            "}"+
            ".back{"+
            "border:2px red solid;"+
            "border-radius:4px;"+
            "}"+
            "</style>"+
            "</head>"+
            "<bodY>"+
            "<div class=\"back\">"+
            "Dear "+
            "<br/>"+
            "<div class=\"move\">Maniram Yadav</div>"+
            "<br/>"+
            "<br/>"+
            "<div>"+
            "Welcome for Signing up on quiz leading Web Application in <br/><center> <p class=\"clg\">FGIET</p> </center>"+
            "</div>"+
            "<div>"+
            "You have entered the following information at the time of signing up on <h3>QUIZSPHERE</h3>"+
            "<table bgcolor=\"black\" border=\"2\">"+
            "<tr><td><b>Name :</b></td>"+name+"<td></tr>"+
            "<tr><td><b>Email :</b></td>"+email1+"<td></tr>"+
            "<tr><td><b>Branch :</b></td>"+branch+"<td></tr>"+
            "<tr><td><b>Year :</b></td>"+year+"<td></tr>"+
            "<tr><td><b>Roll No. :</b></td><td>"+rollno+"</td></tr>"+
          //  "<tr><td><b>Password</b></td><td>"+password1+"</td></tr>"+

            "</table>"+
            "<br/>"+
            "<div>"+
            "I hope you enjoy this software."+
           " </div>"+
            "</div>"+
            "<div style=\"float:left;\">"+
            "<h4>With Regards</h4>"+
            "<span> Maniram Yadav<br/>"+
            "CSE 3rd Year "+
            "(FGIET Student)</span>"+
            "</div>"+
           " </body>"+
           " </html>";
           */
        	
       
            msg.setRecipient(Message.RecipientType.TO,new InternetAddress(email1));
             msg.setSubject(subject);
             msg.setSentDate(new Date());
             msg.setText(message);
             
             MimeBodyPart messageBodyPart = new MimeBodyPart();
             messageBodyPart.setContent(message, "text/html");
      
             // creates multi-part
             Multipart multipart = new MimeMultipart();
             multipart.addBodyPart(messageBodyPart);
      
                        // sets the multi-part as e-mail's content
             msg.setContent(multipart);
      

             // sends the e-mail
             Transport.send(msg);
           //  return 1;
            // System.out.println("Email sent  :  "+j);

             sql="insert into maildetail values('"+email1+"')";
             i=db.stmt.executeUpdate(sql);
          //   System.out.println("Status updated in db");
             j++;
             }
        
        
        //System.out.println("Email sent Succesfully");
       
        
       }
       catch(Exception e)
       {
    	   System.out.println(e);
       }
       finally{
    	   
    	   if(db.stmt!=null)
    	   db.stmt.close();
    	   if(db.con!=null)
           db.con.close();
            }
       
       return j;
   }
}
