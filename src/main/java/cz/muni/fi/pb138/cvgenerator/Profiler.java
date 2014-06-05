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
import java.util.Arrays;
import java.util.List;

/**
 * Created by Hany on 4.5.2014.
 */
@WebServlet(Profiler.URL_MAPPING + "/*")
public class Profiler extends HttpServlet {

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
                Element profile = profiles.createElement("profile");
                profile.setAttribute("pid", "");

                Element contact = profiles.createElement("contact");
                contact.appendChild(createSimpleElement(request.getParameter("degree"), "degree", request));
                contact.appendChild(createSimpleElement(request.getParameter("name"), "name", request));
                contact.appendChild(createSimpleElement(request.getParameter("surname"), "surname", request));
                contact.appendChild(createAddressElement(request));
                contact.appendChild(createSimpleElement(request.getParameter("country"), "country", request));
                contact.appendChild(createSimpleElement(request.getParameter("fax"), "fax", request));
                contact.appendChild(createSimpleElement(request.getParameter("tel"), "phone", request));
                contact.appendChild(createSimpleElement(request.getParameter("email"), "email", request));
                contact.appendChild(createSimpleElement(request.getParameter("homepage"), "homepage", request));

                Element personalInfo = profiles.createElement("details");
                personalInfo.appendChild(createSimpleElement(request.getParameter("gender"), "gender", request));
                personalInfo.appendChild(createSimpleElement(request.getParameter("dateofbrith"), "birthDate", request));
                personalInfo.appendChild(createSimpleElement(request.getParameter("placeofbirth"), "birthPlace", request));
                personalInfo.appendChild(createSimpleElement(request.getParameter("citizenship"), "citizenship", request));

                Element education = profiles.createElement("education");
                education.appendChild(createComplexElement(request.getParameter("stschoolname"),
                        Arrays.asList(request.getParameter("stschoolfrom"), request.getParameter("stschoolto")), "school", request));
                education.appendChild(createComplexElement(request.getParameter("ndschoolname"),
                        Arrays.asList(request.getParameter("ndschoolfrom"), request.getParameter("ndschoolto")), "school", request));
                education.appendChild(createComplexElement(request.getParameter("rdschoolname"),
                        Arrays.asList(request.getParameter("rdschoolfrom"), request.getParameter("rdschoolto")), "school", request));

                Element experience = profiles.createElement("experience");
                experience.appendChild(createComplexElement(request.getParameter("stwork"),
                        Arrays.asList(request.getParameter("stworkfrom"), request.getParameter("stworkto")), "job", request));
                experience.appendChild(createComplexElement(request.getParameter("ndwork"),
                        Arrays.asList(request.getParameter("ndworkfrom"), request.getParameter("ndworkto")), "job", request));
                experience.appendChild(createComplexElement(request.getParameter("rdwork"),
                        Arrays.asList(request.getParameter("rdworkfrom"), request.getParameter("rdworkto")), "job", request));

                Element languages = profiles.createElement("languages");
                languages.appendChild(createLanguageElement(
                        request.getParameter("stlanguage"), request.getParameter("stlanguagelvl"), request));
                languages.appendChild(createLanguageElement(
                        request.getParameter("ndlanguage"), request.getParameter("ndlanguagelvl"), request));
                languages.appendChild(createLanguageElement(
                        request.getParameter("rdlanguage"), request.getParameter("rdlanguagelvl"), request));
                languages.appendChild(createLanguageElement(
                        request.getParameter("thlanguage"), request.getParameter("thlanguagelvl"), request));


                profile.appendChild(contact);
                profile.appendChild(personalInfo);
                profile.appendChild(education);
                profile.appendChild(createSimpleElement(request.getParameter("thesis"), "thesis", request));
                profile.appendChild(experience);
                profile.appendChild(languages);

                //Document doc = (Document) getServletContext().getAttribute("profilesDoc");
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

    private Element createSimpleElement(String textContent, String name, HttpServletRequest req)
    {
        if (textContent.isEmpty()){
            req.setAttribute("error", "Please fill in all fields! You didn't fill: " + name);
        }

        Element element = profiles.createElement(name);
        element.setTextContent(textContent);

        return element;
    }

    private Element createComplexElement(String attribute, List<String> childs, String name, HttpServletRequest req)
    {
        if (attribute.isEmpty()){
            req.setAttribute("error", "Please fill in all fields! You didn't fill: " + name);
        }

        Element element = profiles.createElement(name);
        Element from = profiles.createElement("from");
        Element to = profiles.createElement("to");

        element.setAttribute("name", attribute);
        from.setTextContent(childs.get(0));
        to.setTextContent(childs.get(1));

        element.appendChild(from);
        element.appendChild(to);

        return element;
    }

    private Element createAddressElement(HttpServletRequest request)
    {
        Element streetEl = createSimpleElement(request.getParameter("street"), "street", request);
        Element houseNumberEl = createSimpleElement(request.getParameter("housenumber"), "number", request);
        Element postCodeEl = createSimpleElement(request.getParameter("postcode"), "postcode", request);
        Element cityEl = createSimpleElement(request.getParameter("city"), "city", request);

        Element address = profiles.createElement("address");
        address.appendChild(streetEl);
        address.appendChild(houseNumberEl);
        address.appendChild(postCodeEl);
        address.appendChild(cityEl);

        return address;
    }

    private Element createLanguageElement(String languageName, String languageLvl, HttpServletRequest req)
    {
        if (languageName.isEmpty()){
            req.setAttribute("error", "Please fill in all fields! You didn't fill: " + languageName);
        }

        Element language = profiles.createElement("language");
        language.setAttribute(languageName, languageLvl);

        return language;
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