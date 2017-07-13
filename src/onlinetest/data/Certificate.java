package onlinetest.data;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import com.itextpdf.text.*;
import com.itextpdf.text.Font.FontFamily;

import java.io.*;

import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import onlinetest.mysql.DBConnection;;
public class Certificate {
	
	/*************************************************
	 *                                               *
	 *        @AUTHOR   MANIRAM  YADAV               *
	 *        FGIET   B TECH  CSE  Student           * 
	 *                                               *
	 * ***********************************************/                                            

	static String testid=null;
	static String password=null,email=null,branch=null,year=null,name=null,submit_time=null,date=null,rollno=null;
	static int marks=0,rank=0,stuid=0; 
	static final String Mainpass="maniram12";
	static String docname=null;
	static String docpass=null;
	String destfolder=null;
	
	
	
	//**********************************************************//
	//public static void main(String[] args) throws Exception {
	public static void CreateAnsKey() throws Exception {
	
		@SuppressWarnings("rawtypes")
		ArrayList<ArrayList> alstu=new Certificate().FetchStu();
		new Certificate();
		Certificate.Create(alstu);
	    
	
	}
	


	
	
	
	
	

	public static void Create(ArrayList<ArrayList> al2) throws Exception{
		//System.out.println();
		DBConnection db=new DBConnection();
		ResultSet rs=null;
		BaseFont bf;
		String tname=null,tdepart=null,quizname=null;
	   String corans=null,stuans=null,quesno=null,correct=null,sql=null;
	   sql="select * from testlist where test_id='"+testid+"'";
	   rs=db.stmt.executeQuery(sql);
	    
	   if(rs.next())
	    {
	    	tname=rs.getString("cert_by");
	    	tdepart=rs.getString("org_status");
	    	quizname=rs.getString("test_name");
	    }
	   //System.out.println(tname+"   "+tdepart+"    "+quizname);
	    rs.close(); 
	    Font font;
		String DEST=null;
		ArrayList<String> al3=new ArrayList<String>();
		Iterator<ArrayList> it=al2.iterator();
		if(it.hasNext())
		{
			al3=it.next();
			Iterator<String> it1=al3.iterator();
			while(it1.hasNext())
			{
				
				password=(String)it1.next();
	   			branch=(String)it1.next();
	   			year=(String)it1.next();
	   			rollno=(String)it1.next();
	   			name=(String)it1.next();
	   			testid=(String)it1.next();
	   			submit_time=(String)it1.next();
	   			date=(String)it1.next();
	   			marks=Integer.parseInt((String)it1.next());
	   			rank=Integer.parseInt((String)it1.next());
	   		    stuid=Integer.parseInt((String)it1.next());
                email=(String)it1.next();
                
	   			docpass=password+"123";
	   		    docname=testid+marks+year+rank+stuid+".pdf";
	   		    DEST="D://AnswerKey/"+docname;
//				System.out.println(name);
			//	System.out.println(rank+"  "+testid+"  "+email+"  "+stuid+"   "+docname);	
		OutputStream file = new FileOutputStream(DEST);

		 float left = 50;
         float right = 50;
         float top = 50;
         float bottom = 50;
         Document document = new Document(PageSize.A4, left, right, top, bottom);
         

		PdfWriter writer = PdfWriter.getInstance(document, file);
		Font chapterFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD,12, Font.ITALIC);
        Font paragraphFont = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL);
       // Font paragraphFont = FontFactory.getFont(FontFactory.HELVETICA, 15, Font.NORMAL);
        
     
        
          writer.setEncryption(docpass.getBytes(), Mainpass.getBytes(),
				PdfWriter.ALLOW_PRINTING, PdfWriter.ENCRYPTION_AES_128);

               
        
        font = new Font(FontFamily.HELVETICA,Font.BOLD,50,BaseColor.YELLOW);
        PdfPTable pt=new PdfPTable(4);
        PdfPCell pc=new PdfPCell();
		document.open();
		
	        Font red = new Font(FontFamily.TIMES_ROMAN,18, Font.BOLD, BaseColor.RED);
	       
	        Font fdetail = new Font(FontFamily.HELVETICA,24, Font.ITALIC, BaseColor.BLUE);
	        Font qname = new Font(FontFamily.HELVETICA,27, Font.UNDERLINE, BaseColor.BLACK);
	        
	        Font black = new Font(FontFamily.HELVETICA,16, Font.ITALIC, BaseColor.BLACK);
	        Font black1 = new Font(FontFamily.HELVETICA,15, Font.BOLD, BaseColor.BLACK);
		       
	 
	        
	        Paragraph p=new Paragraph();    
	        p.setTabSettings(new TabSettings(200f));
		    p.add(Chunk.TABBING);
		    p.add(new Chunk(quizname,qname));
		    document.add(p);
		    p=new Paragraph("           ");
		    document.add(p);
		    document.add(p);
		    
		    p=new Paragraph();
	        p.setTabSettings(new TabSettings(20f));
		    p.add(Chunk.TABBING);
		    p.add(new Chunk("-- Permitted By --",black1));
		    document.add(p);
		    p=new Paragraph();
		    p.setTabSettings(new TabSettings(26f));
		    p.add(Chunk.TABBING);
			p.add(new Chunk(tname,paragraphFont));
			document.add(p);
			p=new Paragraph();
			    
			p.setTabSettings(new TabSettings(26f));
			p.add(Chunk.TABBING);
		    p.add(new Chunk(tdepart,paragraphFont));
		    document.add(p);
			
	        
		    p=new Paragraph("           ");
		    document.add(p);
		    document.add(p);
		    p=new Paragraph();
		    p.setTabSettings(new TabSettings(125f));
		    p.add(Chunk.TABBING);
		    p.add(new Chunk("--:  STUDENT DETAIL  :--",fdetail));
		    document.add(p);
		    p=new Paragraph("              ");
		    document.add(p);
		    document.add(p);
		    
		    p=new Paragraph();
		    
		    p.setTabSettings(new TabSettings(150f));
		    p.add(Chunk.TABBING);
		    p.add(new Chunk("Name  :  ",black));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk(name,red));
			 document.add(p);
		
			 
			 p=new Paragraph("           ");
			    document.add(p);
			    
			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Student Id  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+stuid,red));
		     document.add(p);
		     
			
		     p=new Paragraph("           ");
			    document.add(p);
			    
			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Roll No.  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+rollno,red));
		     document.add(p);
		     p=new Paragraph("           ");
			    document.add(p);
			    
			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Branch  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+branch,red));
		     document.add(p);
		     p=new Paragraph("           ");
			    document.add(p);
			    			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Year  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+year,red));
		     document.add(p);
		     p=new Paragraph("           ");
			    document.add(p);
			    
			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Test Id  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+testid,red));
		     document.add(p);
		     p=new Paragraph("           ");
			    
			    document.add(p);
			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Submit Time  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+submit_time,red));
		     document.add(p);
		     p=new Paragraph("           ");
			    document.add(p);
			    	    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Test date :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+date,red));
		     document.add(p);
		     p=new Paragraph("           ");
			    document.add(p);
			
			    
			 p=new Paragraph();
			 p.setTabSettings(new TabSettings(150f));
			 p.add(Chunk.TABBING);
			 p.add(new Chunk("Marks  :  ",black));
		     p.add(Chunk.TABBING);
		     p.add(new Chunk(""+marks,red));
		     document.add(p);
            p=new Paragraph("              ");
            document.add(p);
            document.newPage();
            
            p=new Paragraph("              ");
            document.add(p);
           
            p=new Paragraph("Answer key");
            document.add(p);
            p=new Paragraph("              ");
            document.add(p);
		pc = new PdfPCell(new Phrase("Qusetion Number"));
		pc.setBorder(Rectangle.TOP);
		pc.setUseBorderPadding(true);
		pc.setBorderWidthTop(5f);
		pc.setBorderColorTop(BaseColor.RED);
		pc.setBackgroundColor(BaseColor.GREEN);
		pt.addCell(pc);
		pc = new PdfPCell(new Phrase("Correct Answer"));
		pc.setBorder(Rectangle.TOP);
		pc.setUseBorderPadding(true);
		pc.setBorderWidthTop(5f);
		pc.setBorderColorTop(BaseColor.RED);
		pc.setBackgroundColor(BaseColor.GRAY);
		pt.addCell(pc);
		pc = new PdfPCell(new Phrase("Student Answer"));
		pc.setBorder(Rectangle.TOP);
		pc.setUseBorderPadding(true);
		pc.setBorderWidthTop(5f);
		pc.setBorderColorTop(BaseColor.RED);
		pc.setBackgroundColor(BaseColor.ORANGE);
		pt.addCell(pc);
		pc = new PdfPCell(new Phrase("Rewards"));
		pc.setBorder(Rectangle.TOP);
		pc.setUseBorderPadding(true);
		pc.setBorderWidthTop(5f);
		pc.setBorderColorTop(BaseColor.RED);
		pc.setBackgroundColor(BaseColor.PINK);
		pt.addCell(pc);
	 sql="select testq_no,correct_option,stu_option,iscorrect from stu_answers where stu_id="+stuid+""
				+ " and test_id='"+testid+"' order by testq_no asc";
	
		
		rs=db.stmt.executeQuery(sql);
		
		while(rs.next())
		{
			quesno=" "+rs.getInt(1);
			pc=new PdfPCell(new Phrase(quesno));
			pc.setBackgroundColor(BaseColor.GREEN);
			pt.addCell(pc);
			
			pc=new PdfPCell(new Phrase(rs.getString(2)));
			pc.setBackgroundColor(BaseColor.GRAY);
			pt.addCell(pc);
			
			pc=new PdfPCell(new Phrase(rs.getString(3)));
			pc.setBackgroundColor(BaseColor.ORANGE);
			pt.addCell(pc);
			
			correct=""+rs.getInt(4);
			pc=new PdfPCell(new Phrase(correct));
			pc.setBackgroundColor(BaseColor.PINK);
			pt.addCell(pc);
		   
		}
		document.add(pt);
		p=new Paragraph("             ");
		document.add(p);
		document.add(p);
		document.add(p);
		
		p=new Paragraph();
		 p.setTabSettings(new TabSettings(300f)); 
		 p.add(Chunk.TABBING);
		 p.add(new Chunk("-: Designed & Developed By :-  ",chapterFont));
		 document.add(p);
			//p=new Paragraph("             ");
			//document.add(p);
		 p=new Paragraph();
		 p.setTabSettings(new TabSettings(345f));
		 p.add(Chunk.TABBING);
		 p.add(new Chunk("MANIRAM YADAV  ",paragraphFont));
		 document.add(p);
		 
		 p=new Paragraph();
		 p.setTabSettings(new TabSettings(345f));
		 p.add(Chunk.TABBING);
		 p.add(new Chunk("CSE Student (FGIET)",paragraphFont));
		 document.add(p);
	     
		 p=new Paragraph();
		 p.setTabSettings(new TabSettings(345f));
		 p.add(Chunk.TABBING);
		 p.add(new Chunk("Admin and Developer of QUIZSPHERE",paragraphFont));
		 document.add(p);
	     
	    
		document.close();
		file.close();
		if(rs!=null)
	     rs.close();
		//Inert pdf name in student data
	     String sql1="update student_data set stuans_pdf='"+docname+"' where stu_id="+stuid+" and test_id='"+testid+"'";
		sql="insert into student_data(stu_id,name,email,test_id,stuans_pdf) values(?,?,?,?,?)";
		int i=db.stmt.executeUpdate(sql1);
		if(i==0)
		{
			PreparedStatement psm=db.con.prepareStatement(sql);
			psm.setInt(1,stuid);
			psm.setString(2,name);
			psm.setString(3, email);
			psm.setString(4,testid);
			psm.setString(5,docname);
			i=psm.executeUpdate();
			if(psm!=null)
				psm.close();
		}
		//System.out.println(rank+"  "+testid+"  "+email+" ===== "+stuid);
		
			
		
			}
			if(db.stmt!=null)
			db.stmt.close();
			if(db.con!=null)
	        db.con.close();

			}

        
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	       public ArrayList<ArrayList> FetchStu() throws Exception {
	    	   
	    	   
	    	   DBConnection db=new DBConnection();
	   		ArrayList<String> al=new ArrayList<String>();
	   		ArrayList<ArrayList> al1=new ArrayList<ArrayList>();
	   		File file=new File("D:\\AnswerKey");
	   		if(!file.exists())
	   		{
	   		//	System.out.println("Not exist");
	   		file.mkdirs();
	   		}
	   		
	   	
	   		String sql="select test_id from prev_tests where status=\"Test Processing\"";
	   		ResultSet rs=db.stmt.executeQuery(sql);
	   		if(rs.next())
	   			testid=rs.getString(1);
	   		rs.close();
	   		if(testid!=null)
	   		{
	   	   sql="select ld.password,sd.branch,sd.year,sd.rollno,sh.name,sh.test_id,sh.submit_time,sh.date,sh.marks,sh.rank,ld.stu_id,ld.email "
	   	   		+ " from stu_detail as sd inner join stutest_history as sh  on "+
	           " sd.stu_id=sh.stu_id inner join login_detail as ld  on ld.stu_id=sh.stu_id"
	           + " where sh.test_id='"+testid+"' order by rank asc";
	   	
	   		
	   		rs=db.stmt.executeQuery(sql);
	   		while(rs.next())
	   		{
	   			password=rs.getString(1);
	   			branch=rs.getString(2);
	   			year=rs.getString(3);
	   			rollno=rs.getString(4);
	   			name=rs.getString(5);
	   			testid=rs.getString(6);
	   			submit_time=rs.getString(7);
	   			date=rs.getString(8);
	   			marks=rs.getInt(9);
	   			rank=rs.getInt(10);
	   		    stuid=rs.getInt(11);
	   		    email=rs.getString(12);
	   		   // System.out.println(rank+"  "+testid+"  "+email+"  "+stuid);
	   			al.add(password);
	   			al.add(branch);
	   			al.add(year);
	   			al.add(rollno);
	   			al.add(name);
	   			al.add(testid);
	   			al.add(submit_time);
	   			al.add(date);
	   			al.add(""+marks);
	   			al.add(""+rank);
	   			al.add(""+stuid);
	   			al.add(email);
	   			al1.add(al);
	   		}
	    	   
	   }
	   		rs.close();
	   		db.stmt.close();
	   		db.con.close();
	   return al1;
	 }
   }