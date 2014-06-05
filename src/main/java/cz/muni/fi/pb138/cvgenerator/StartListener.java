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

/**
 * Created by Hany on 4.5.2014.
 */
@WebListener
public class StartListener implements ServletContextListener {

    private DocumentBuilder dBuilder = null;
    private Document doc = null;
    private File file = null;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent)
    {
        ServletContext servletContext = servletContextEvent.getServletContext();
        File file = new File("profiles.xml");
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
        servletContext.setAttribute("profilesDoc", doc);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent)
    {
        System.out.print(true);
    }

    private Document fileParser(File xmlFile) throws IOException, SAXException, ParserConfigurationException
    {
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        dbFactory.setValidating(true);
        dBuilder = dbFactory.newDocumentBuilder();
        return dBuilder.parse(xmlFile);
    }
}
