package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;

/**
 * Created by Hany on 4.5.2014.
 */
@WebServlet(ProfilerServlet.URL_MAPPING + "/*")
public class ProfilerServlet extends HttpServlet {

    private Document profiles = null;

    private static final String LIST_JSP = "/index.jsp";
    public static final String URL_MAPPING = "/profiles";
    private DocumentBuilder dBuilder;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        profiles = (Document) getServletContext().getAttribute("profilesDoc");

        String action = request.getPathInfo();
        switch (action) {
            case "/add":
                Profiler profiler = new Profiler(request);
                Element profile = profiler.createProfile();
                Element el = profiles.getDocumentElement();
                el.appendChild(profile);
                try {
                    saveToFile((File) getServletContext().getAttribute("xmlFile"),
                            profiles);
                } catch (TransformerException e) {
                    e.printStackTrace();
                }
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
        DOMSource source = new DOMSource(doc);
        StreamResult result = new StreamResult(xmlFile);
        transformer.transform(source, result);
    }

    private Document fileParser(File xmlFile) throws IOException, SAXException, ParserConfigurationException
    {
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        dbFactory.setValidating(true);
        dBuilder = dbFactory.newDocumentBuilder();
        return dBuilder.parse(xmlFile);
    }
}