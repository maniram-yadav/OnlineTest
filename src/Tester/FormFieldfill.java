package Tester;
 
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
 
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class FormFieldfill {
 
    public static final String SRC = "results/form.pdf";
    public static final String DEST = "results/field_format.pdf";
 
 
    public static void main(String[] args) throws DocumentException, IOException {
        File file = new File(DEST);
        file.getParentFile().mkdirs();
        new FormFieldfill().manipulatePdf(SRC, DEST);
    }
 
    public void manipulatePdf(String src, String dest) throws DocumentException, IOException {
        PdfReader reader = new PdfReader(src);
        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(dest));
        AcroFields form = stamper.getAcroFields();
        form.setField("Name", "0.8");
        form.setField("Company", "1217000.000000", "$1,217,000");
        stamper.setFormFlattening(true);
        stamper.close();
    }
}