/*
 * This example was written in answer to:
 * http://stackoverflow.com/questions/34433510
 */
package Tester;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfShading;
import com.itextpdf.text.pdf.PdfShadingPattern;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * @author maniram
 */
public class GradientToptoBottom {

    public static final String DEST = "results/graphics/gradient_top_to_bottom.pdf";
    
    public static void main(String[] args) throws IOException, DocumentException {
        File file = new File(DEST);
        file.getParentFile().mkdirs();
        new GradientToptoBottom().createPdf(DEST);
    }
    public void createPdf(String dest) throws IOException, DocumentException {
        Rectangle pageSize = new Rectangle(200,300);
        Document document = new Document(pageSize);
        Font chapterFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Font.ITALIC);
        Font paragraphFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Font.NORMAL);
     

        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(dest));
        document.open();
        PdfShading shading = PdfShading.simpleAxial(writer,
                0, pageSize.getHeight(),
                0, 0,
                BaseColor.MAGENTA, BaseColor.GREEN);
        PdfShadingPattern pattern = new PdfShadingPattern(shading);
        PdfContentByte canvas = writer.getDirectContent();
        canvas.setShadingFill(pattern);
        canvas.rectangle(0, 0, pageSize.getWidth(), pageSize.getHeight());
        canvas.fill();
        Paragraph paragraph2=new Paragraph("Maniram Yadav",paragraphFont);
        paragraph2.setSpacingBefore(30f);
        
        
        document.add(new Paragraph("Mani--------------------",paragraphFont));
        document.add(paragraph2);
        document.close();
        
        
    }
    
}