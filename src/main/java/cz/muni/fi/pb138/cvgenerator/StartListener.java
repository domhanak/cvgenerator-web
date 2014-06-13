package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import javax.xml.validation.SchemaFactory;
import javax.xml.XMLConstants;
import javax.xml.validation.Schema;

/**
 * Created by Hany on 4.5.2014.
 */
@WebListener
public class StartListener implements ServletContextListener {

    private DocumentBuilder dBuilder = null;
    private Document doc = null;
    private File file = null;
    private File schemaFile = null;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent)
    {

        ServletContext servletContext = servletContextEvent.getServletContext();


        //File file = null;
        try {
            file = new File(this.getClass().getResource("/profiles.xml").toURI());
            schemaFile = new File(this.getClass().getResource("/profiles.xsd").toURI());
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }

        if (file == null) {
            throw new NullPointerException("File is null!");
        }

        try {
            doc = fileParser(file);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }

        servletContext.setAttribute("xmlFile", file);
        servletContext.setAttribute("schemaFile", schemaFile);
        servletContext.setAttribute("profilesDoc", doc);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent)
    {
        System.out.print(true);
    }

    private Document fileParser(File xmlFile) throws IOException, SAXException, ParserConfigurationException
    {
        /*
        SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = sf.newSchema(schemaFile);

        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        dbFactory.setValidating(true);
        dbFactory.setSchema(schema);
        dBuilder = dbFactory.newDocumentBuilder();
        return dBuilder.parse(xmlFile);
        */
        ProfileValidator profileValidator = new ProfileValidator(schemaFile);

        try
        {
            return profileValidator.parse(file);

        }catch (IOException ex) {
            System.err.println("File not found: "+ex.getMessage());
        }catch (SAXException ex) {
            System.err.println("Validation error: " + ex.getMessage());
        }
        return null;

    }
}
