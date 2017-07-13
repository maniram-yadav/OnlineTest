package onlinetest.data;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.PageSize; 
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

/*************************************************
 *                                               *
 *        @AUTHOR   MANIRAM  YADAV               * 
 *        FGIET   B TECH  CSE  Student           *
 *                                               *
 * ***********************************************/                                            


public class Rectangle1 {
    public static final String DEST = "results/objects/rectangles.pdf";
 
    public static void main(String[] args) throws IOException,
            DocumentException {
    	ArrayList<String> al=new ArrayList<String>();
        File file = new File(DEST);
        file.getParentFile().mkdirs();
        new Rectangle1().createPdf(DEST);
    }
 
    public void createPdf(String dest) throws IOException, DocumentException {
    	 float left = 30;
         float right = 30;
         float top = 60;
         float bottom = 0;
         Document document = new Document(PageSize.A4, left, right, top, bottom);
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(dest));
        document.open();
        float llx = 36;
        float lly = 700;
        float urx = 200;
        float ury = 806;
        
        PdfContentByte canvas = writer.getDirectContent();
        Rectangle rect1 = new Rectangle(llx, lly, urx, ury);
        rect1.setBackgroundColor(BaseColor.LIGHT_GRAY);
        rect1.setBorder(Rectangle.BOX);
        rect1.setBorderWidth(1);
        canvas.rectangle(rect1);
        Rectangle rect2 = new Rectangle(llx + 60, lly, urx, ury - 40);
        rect2.setBackgroundColor(BaseColor.DARK_GRAY);
        rect2.setBorder(Rectangle.BOX);
        rect2.setBorderColor(BaseColor.WHITE);
        rect2.setBorderWidth(0.5f);
        canvas.rectangle(rect2);
        document.close();
    }
}