package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;

/**
 * Created by Hany on 4.5.2014.
 */
@WebServlet(ProfilerServlet.URL_MAPPING + "/*")
public class ProfilerServlet extends HttpServlet {

    private Document profiles = null;

    private static final String LIST_JSP = "/index.jsp";
    public static final String URL_MAPPING = "/profiles";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        profiles = (Document) getServletContext().getAttribute("profilesDoc");

        String action = request.getPathInfo();
        switch (action) {
            case "/add":
                Profiler profiler = new Profiler(request, profiles);
                Element profile = null;

                try {
                    profile = profiler.createProfile();
                } catch (ProfilerException e) {
                    request.setAttribute("error2", "Some required fields weren't filled. Hint: " + e.getMessage());
                    request.getRequestDispatcher(LIST_JSP).forward(request, response);
                    return;
                }

                Element el = profiles.getDocumentElement();
                System.out.println(el.getTagName());
                el.appendChild(profile);

                try {
                    saveToFile((File) getServletContext().getAttribute("xmlFile"), profiles);
                } catch (TransformerException e) {
                    e.printStackTrace();
                    return;
                }


                ProfileValidator profileValidator = new ProfileValidator((File) getServletContext().getAttribute("schemaFile"));
                String validationError = null;
                try
                {
                    validationError = profileValidator.validate((File) getServletContext().getAttribute("xmlFile"));
                    System.err.println(validationError);

                }catch (IOException ex) {
                    System.err.println("File not found: "+ex.getMessage());
                }




                TransformerFactory tf = TransformerFactory.newInstance();
                try {
                    Transformer xsltProc = tf.newTransformer(
                            new StreamSource(new File(this.getClass().getResource("/toPdf.xsl").toURI())));
                    xsltProc.transform(
                            new StreamSource(new File(this.getClass().getResource("/profiles.xml").toURI())),
                            new StreamResult(new File(this.getClass().getResource("/latex.tex").toURI())));
                } catch (TransformerException e) {
                    e.printStackTrace();
                } catch (URISyntaxException e) {
                    e.printStackTrace();
                }

                File workingDirectory = null;
                try {
                    workingDirectory = new File(this.getClass().getResource("/").toURI());
                    File template = new File(workingDirectory.getAbsolutePath() + File.separator + "latex.tex");
                    File desktop = new File(System.getProperty("user.home")	+ File.separator + "Desktop");
                /*
                    JLRGenerator pdfGen = new JLRGenerator();

                    pdfGen.generate(template, desktop, workingDirectory);

                    File pdf1 = pdfGen.getPDF();
                    JLROpener.open(pdf1);

                } catch (URISyntaxException e) {
                    e.printStackTrace();
                }
*/

                request.getRequestDispatcher(LIST_JSP).forward(request, response);
                return;
            default:
                throw new ServletException("");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
    }

    private void saveToFile(File xmlFile, Document doc) throws TransformerException
    {
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        transformer.setOutputProperty(OutputKeys.ENCODING,"UTF-8");
        transformer.setOutputProperty(OutputKeys.INDENT,"yes");
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(xmlFile);
        transformer.transform(source, result);
    }
}