package onlinetest.data;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Date;
import com.itextpdf.*;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;

/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               *
 *        FGIET   B TECH  CSE  Student           * 
 *                                               *
 * ***********************************************/                                            


public class a {

	private static String USER_PASS = "Hello123";

	private static String OWNER_PASS = "Owner123";
	
	
	public static void main(String[] args) throws ClassNotFoundException{
		try {
			
			OutputStream file = new FileOutputStream(new File("D://Test.pdf"));

			Document document = new Document();
			PdfWriter writer = PdfWriter.getInstance(document, file);
			Font chapterFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Font.ITALIC);
	        Font paragraphFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL);
	        

			writer.setEncryption(USER_PASS.getBytes(), OWNER_PASS.getBytes(),
					PdfWriter.ALLOW_PRINTING, PdfWriter.ENCRYPTION_AES_128);

			document.open();
			document.add(new Paragraph("Hello World, iText , I love you so much"));
			document.add(new Paragraph(new Date().toString()));

			document.close();
			file.close();

		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}