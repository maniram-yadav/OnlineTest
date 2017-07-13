package onlinetest.data;
import java.util.Vector;
import onlinetest.network.MailString;
import javax.mail.*;

import java.io.IOException;
import java.sql.*;
import onlinetest.mysql.DBConnection;
import java.util.Date;
import java.util.Iterator;
import java.util.Properties;

import javax.activation.*;
import javax.mail.internet.*;
import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;
import javax.mail.Transport;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.MessagingException;

/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               *
 *        FGIET   B TECH  CSE  Student           * 
 *                                               *
 * ***********************************************/                                            


public class SendData {
   private static final String user=MailString.EMAIL;
   private static final String password=MailString.PASSWORD;
   private static final String host=MailString.HOST;
   private static final String port=MailString.PORT;
 /*  public static void main(String[] args) throws AddressException, MessagingException, SQLException{
	   SendData.sendMail();
   }
  */
   public static void sendMail() throws AddressException ,MessagingException, SQLException{
	   String message="";
	   String email="null";
	   String subject="";
	   String sql="select * from student_data where issent="+0+"";
	   String sql1=null;
	   String name=null,quiz=null,qid=null,anskeypd=null;
	   Vector<String> v=new Vector<String>();
	   Properties ppt=new Properties();
	   ppt.put("mail.smtp.starttls.enable","true");
       ppt.put("mail.smtp.host", host);
       ppt.put("mail.smtp.user",user);
       ppt.put("mail.smtp.password",password);
       ppt.put("mail.smtp.port",port);
       ppt.put("mail.smtp.auth","true");
       DBConnection db=null;
       int i=0;

       // creates a new session with an authenticator
       Authenticator auth = new Authenticator() {
           public PasswordAuthentication getPasswordAuthentication() {
               return new PasswordAuthentication(user,password);
           }
       };

       Session session = Session.getInstance(ppt,auth);
       MimeMessage msg = new MimeMessage(session);

       msg.setFrom(new InternetAddress(user));
       
       
       ResultSet rs = null; 
       

       try{
      
    	   db=new DBConnection();
          rs=db.stmt.executeQuery(sql);
      while(rs.next())
      {
          
    	  
    	  name=(String)rs.getString(3);
          email=(String)rs.getString(4);
          qid=(String)rs.getString(5);
          anskeypd=(String)rs.getString(6);
          
       
          
          v.add(name);
          v.add(email);
          v.add(qid);
          v.add(anskeypd);
      }
      
      
      }
       catch(Exception e)
       {
    	   if(rs!=null)
    	  
    	rs.close();
    	
       }
        
       
       try{
             Iterator<String> it=v.iterator();
    	   while(it.hasNext())
            {
          
    	  
    	  name=(String)it.next();
          email=(String)it.next();
          qid=(String)it.next();
          anskeypd=(String)it.next();
          subject="Answer Key QUIZSPHERE";
          
          
          
          message="Hi <h2> "+name+" </h2> <br/> Thank you for participating in the quiz organized by QuizSphere "
          		+ "at <b>FGIET</b>. Your test has been submitted successfully on "
          		+ " QUIZSPHERE and your answers along with answers key is given in attachment below"
          		+ " For more details refer the attached PDF <br/>"
          		+ "For further queries, kindly contact us<br/>"
          		+ "<h3>Sent By :</h3>Maniram Yadav";
         
          
          
          msg.setRecipient(Message.RecipientType.TO,new InternetAddress(email));
          msg.setSubject(subject);
          msg.setSentDate(new Date());
          msg.setText(message);
          
          
          // creates message part
          MimeBodyPart messageBodyPart = new MimeBodyPart();
          messageBodyPart.setContent(message, "text/html");
   
          // creates multi-part
          Multipart multipart = new MimeMultipart();
          multipart.addBodyPart(messageBodyPart);
   
          
          
          // adds attachments
          if (anskeypd != null ){
                  MimeBodyPart attachPart = new MimeBodyPart();
                   anskeypd="D://AnswerKey/"+anskeypd;
                  try {
                      attachPart.attachFile(anskeypd);
                  } catch (IOException ex) {
                      ex.printStackTrace();
                      System.out.println("Unable to sent the message");
                  }
                 // System.out.println(anskeypd);
                  multipart.addBodyPart(attachPart);
              }
          
   
          // sets the multi-part as e-mail's content
          msg.setContent(multipart);
   

          // sends the e-mail
          Transport.send(msg);
        //  return 1;
          sql="update student_data set issent="+1+" where email='"+email+"'";
          i=db.stmt.executeUpdate(sql);
       //   System.out.println("Issent status updated to 1 in db");
         // System.out.println("Sent Message");
         
      }
      
      
      
      
      
      
      // Final submit the test when data is sent to all the user
      sql="select issent from student_data where issent="+0+"";
      rs=db.stmt.executeQuery(sql);
      
      
      
      if(!rs.next())
      {
      sql="update prev_tests set status=\"Test Finished\" where status=\"Test Processing\"";
      i=db.stmt.executeUpdate(sql);
    //  System.out.println("Data sent to all student successfully. Exam Finished");
      }
      
      if(rs!=null)
      rs.close();
      if(db.stmt!=null)
      db.stmt.close();
      if(db.con!=null)
      db.con.close();
      }
       
       
       catch(Exception e)
       {
    	   System.out.println(e);
       }
       
       
       
       finally{
    	   if(rs!=null)
    	   rs.close();
    	   if(db.stmt!=null)
    	   db.stmt.close();
    	   if(db.con!=null)
    	   db.con.close();
       }

	   
   }
}
