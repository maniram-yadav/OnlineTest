
package Tester; 
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
 
public class PdfReplace {
    public static final String SRC = "D:\\12.pdf";
    public static final String DEST = "D:\\mark11.pdf";
 
    public static void main(String[] args) throws IOException, DocumentException {
        File file = new File(DEST);
        file.getParentFile().mkdirs();
        new PdfReplace().manipulatePdf(SRC, DEST);
    }
 
    public void manipulatePdf(String src, String dest) throws IOException, DocumentException {
        PdfReader reader = new PdfReader(src);
        PdfDictionary dict = reader.getPageN(1);
        PdfObject object = dict.getDirectObject(PdfName.CONTENTS);
        if (object instanceof PRStream) {
            PRStream stream = (PRStream)object;
            byte[] data = PdfReader.getStreamBytes(stream);
            stream.setData(new String(data).replace("name", "maniram").getBytes());
        }
        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(dest));
        stamper.close();
        reader.close();
    }
}