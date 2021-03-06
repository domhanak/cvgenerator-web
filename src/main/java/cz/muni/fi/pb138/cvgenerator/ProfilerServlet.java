package cz.muni.fi.pb138.cvgenerator;

import com.sun.deploy.util.SystemUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.awt.*;
import java.io.*;
import java.net.URISyntaxException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

/**
 * Created by Hany on 4.5.2014.
 */
@WebServlet(ProfilerServlet.URL_MAPPING + "/*")
public class ProfilerServlet extends HttpServlet {

    private Document profiles = null;

    private static final String LIST_JSP = "/index.jsp";
    private static final String LOAD_JSP = "/load.jsp";
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
                String pid;

                if (request.getParameter("pid") == null || request.getParameter("pid").isEmpty()){
                    request.setAttribute("error2", "You didn't fill your ID.");
                    request.getRequestDispatcher(LIST_JSP).forward(request, response);
                    return;
                } else {
                    /* Check if user that came created CV before */
                    pid = request.getParameter("pid");
                    if (!checkIfNewUser(pid, profiles)) {
                        Element el = profiles.getDocumentElement();
                        NodeList nl = el.getChildNodes();
                        for (int i = 0; i < nl.getLength(); i++)
                        {
                            if(nl.item(i).getNodeType() == Node.ELEMENT_NODE) {
                                Element element = (Element) nl.item(i);
                                if (element.getAttribute("pid").equals(pid)) {
                                    el.removeChild(element);
                                }
                            }
                        }
                    }
                }


                try {
                    profile = profiler.createProfile(pid);
                } catch (ProfilerException e) {
                    request.setAttribute("error2", "Some required fields weren't filled. Hint: " + e.getMessage());
                    request.getRequestDispatcher(LIST_JSP).forward(request, response);
                    return;
                }

                Element el = profiles.getDocumentElement();
                el.appendChild(profile);

                try {
                    saveToFile((File) getServletContext().getAttribute("xmlFile"), profiles);
                } catch (TransformerException e) {
                    e.printStackTrace();
                    return;
                }

                ProfileValidator profileValidator = new ProfileValidator((File) getServletContext().getAttribute("schemaFile"));
                String validationError = null;
                try {
                    validationError = profileValidator.validate((File) getServletContext().getAttribute("xmlFile"));
                    if (validationError != null){
                        System.err.println(validationError);
                        Element ele = profiles.getDocumentElement();
                        NodeList nl = ele.getChildNodes();
                        for (int i = 0; i < nl.getLength(); i++) {
                            if (nl.item(i).getNodeType() == Node.ELEMENT_NODE) {
                                Element element = (Element) nl.item(i);
                                if (element.getAttribute("pid").equals(pid)) {
                                    ele.removeChild(element);
                                    try {
                                        saveToFile((File) getServletContext().getAttribute("xmlFile"), profiles);
                                    } catch (TransformerException e) {
                                        e.printStackTrace();
                                        return;
                                    }
                                    request.setAttribute("error2", "Some required fields weren't filled correctly.");
                                    request.getRequestDispatcher(LIST_JSP).forward(request, response);
                                    return;
                                }
                            }
                        }
                    }

                } catch (IOException ex) {
                    System.err.println("File not found: " + ex.getMessage());
                    return;
                }

                TransformerFactory tf = TransformerFactory.newInstance();
                try {
                    Transformer xsltProc = tf.newTransformer(
                            new StreamSource(new File(this.getClass().getResource("/toPdf.xsl").toURI())));
                    xsltProc.setParameter("pid", pid);
                    xsltProc.transform(
                            new StreamSource(new File(this.getClass().getResource("/profiles.xml").toURI())),
                            new StreamResult(new File(this.getClass().getResource("/pdfko.tex").toURI())));
                } catch (TransformerException e) {
                    e.printStackTrace();
                    return;
                } catch (URISyntaxException e) {
                    e.printStackTrace();
                    return;
                }


                String path = null;
                path = ProfilerServlet.class.getProtectionDomain().getCodeSource().getLocation().toString();
                String[] pathFrags = path.split("/");
                String newPath = new String();

                if(System.getProperty("os.name").equals("Linux")) {
                    newPath += "/";
                }

                int counter = 0;
                while (!pathFrags[counter].equals("WEB-INF")){
                    if (pathFrags[counter].equals("file:")) {
                        counter++;
                        continue;
                    }

                    newPath += pathFrags[counter] + "/";
                    counter++;
                }
                newPath += "WEB-INF/classes/";

                try {
                    String cmd = "pdflatex -output-directory=" + newPath + " " + newPath + "pdfko.tex";
                    Process p = Runtime.getRuntime().exec(cmd);


                    BufferedReader stdInput = new BufferedReader(new
                            InputStreamReader(p.getInputStream()));

                    BufferedReader stdError = new BufferedReader(new
                            InputStreamReader(p.getErrorStream()));

                    System.out.println("Here is the standard output of the command:\n");
                    String s = null;
                    while ((s = stdInput.readLine()) != null) {
                        System.out.println(s);
                    }
                    System.out.print("Som tu!");
                    System.out.println("Here is the standard error of the command (if any):\n");
                    while ((s = stdError.readLine()) != null) {
                        System.out.println(s);
                    }

                    try {
                        Desktop desktop = null;
                        // Before more Desktop API is used, first check
                        // whether the API is supported by this particular
                        // virtual machine (VM) on this particular host.

                        ServletOutputStream outStream = response.getOutputStream();
                        File downloadFile = new File(newPath + "/pdfko.pdf");
                        FileInputStream inStream = new FileInputStream(downloadFile);
                        response.setContentType("application/pdf");
                        response.setContentLength((int) downloadFile.length());
                        response.setHeader("Content-disposition","attachment; filename=" +"pdfko.pdf");
                        byte[] buffer = new byte[4096];
                        int bytesRead = -1;

                        while ((bytesRead = inStream.read(buffer)) != -1) {
                            outStream.write(buffer, 0, bytesRead);
                        }

                        inStream.close();
                        outStream.close();

//                        if (Desktop.isDesktopSupported()) {
//                            desktop = Desktop.getDesktop();
//                            File file = new File(newPath + "/pdfko.pdf");
//                            System.out.println("Opening " + file);
//                                desktop.open(file);
//
//                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } catch (IOException e) {
                    System.out.print("error  " + e.getMessage());
                }

                request.getRequestDispatcher(LIST_JSP).forward(request, response);
                return;
            default:
                throw new ServletException("");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getPathInfo();
        profiles = (Document) getServletContext().getAttribute("profilesDoc");
        switch (action) {
            case "/load":
                String loadPid = request.getParameter("loadpid");

                if(checkIfNewUser(loadPid, profiles))
                {
                    request.setAttribute("PidError", "No pid found with value:" + loadPid);
                    request.getRequestDispatcher(LIST_JSP).forward(request,response);
                }
                else {
                    try {
                        String xmlString = documentToString(createProfileDocument(profiles, loadPid));
                        System.out.println(xmlString);
                        request.setAttribute("profilesDoc", xmlString);
                        System.out.println(loadPid);
                        request.setAttribute("loadPid", loadPid);
                        request.getRequestDispatcher(LOAD_JSP).forward(request, response);

                    } catch (ServletException ex) {
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
                    } catch (IOException ex) {
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getMessage());
                    }

                    return;
                }
            default:
                return;
        }

    }


    private String documentToString(Document doc)
    {
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer transformer;
        String xmlString=null;
        try {
            transformer = tf.newTransformer();
            StringWriter writer = new StringWriter();
            transformer.transform(new DOMSource(doc), new StreamResult(writer));
            xmlString = writer.getBuffer().toString();

        } catch (TransformerException e) {
            e.printStackTrace();
        }

        return xmlString;
    }

    private Document createProfileDocument(Document doc, String loadPid)
    {
        Element docEle = doc.getDocumentElement();
        NodeList profileNodes = docEle.getElementsByTagName("profile");
        for (int i = 0; i < profileNodes.getLength(); i++)
        {
            Element element = (Element) profileNodes.item(i);
            if (loadPid.equals(element.getAttribute("pid"))){

                Node node = profileNodes.item(i);

                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                factory.setNamespaceAware(true);
                DocumentBuilder builder = null;
                try {
                    builder = factory.newDocumentBuilder();
                }catch (ParserConfigurationException ex){}

                Document newDocument = builder.newDocument();
                Element el = newDocument.createElement("profiles");

                el.appendChild(newDocument.importNode(node,true));
                newDocument.appendChild(el);
                return newDocument;

            }
        }
        return null;
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

    private boolean checkIfNewUser(String pid, Document doc)
    {
        if (pid == null || doc == null){
            throw new IllegalArgumentException("pid or doc are null");
        }

        Element docEle = doc.getDocumentElement();
        if (docEle == null) {
            return true;
        }
        NodeList nl = docEle.getChildNodes();
        if (nl == null){
            return true;
        }

        for (int i = 0; i < nl.getLength(); i++)
        {
            if(nl.item(i).getNodeType() == Node.ELEMENT_NODE){
                Element el = (Element) nl.item(i);
                if (pid.equals(el.getAttribute("pid"))){
                    return false;
                }
            }

        }
        return true;
    }

}