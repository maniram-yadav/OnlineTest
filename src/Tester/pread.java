package Tester;


/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               * 
 *                                               *
 * ***********************************************/                                            


import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PRStream;
import com.itextpdf.text.pdf.PdfDictionary;
import com.itextpdf.text.pdf.PdfName;
import com.itextpdf.text.pdf.PdfObject;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
 
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class pread {
	public static void main(String[] args) {

	    String DEST = "D://mark12.pdf";

	    try {
	        PdfReader reader = new PdfReader("D://mark1.pdf");
	        PdfDictionary dictionary = reader.getPageN(1);
	        PdfObject object = dictionary.getDirectObject(PdfName.CONTENTS);
	        if (object instanceof PRStream) {
	            PRStream stream = (PRStream)object;
	            byte[] data = PdfReader.getStreamBytes(stream);
	            stream.setData(new String(data).replace("name", "A-B-C-D-E-F-G-H-I-J-K-L-M-N-O-P-Q-R-S-T-U-V-W-X-Y-Z").getBytes());
	        }
	        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(DEST));
	        stamper.close();
	        reader.close();
	    } catch (IOException | DocumentException e) {
	        e.printStackTrace();
	    }

	}
}
