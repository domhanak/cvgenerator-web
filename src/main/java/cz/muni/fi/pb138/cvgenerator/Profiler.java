package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/**
 * Created by Hany on 4.5.2014.
 */
@WebServlet(Profiler.URL_MAPPING + "/*")
public class Profiler extends HttpServlet {

    private static final String LIST_JSP = "/index.jsp";
    private static Document profiles = (Document) new File("classpath:profiles.xml");

    public static final String URL_MAPPING = "/profiles";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Document profiles = (Document) getServletContext().getAttribute("profilesDoc");

        String action = request.getPathInfo();
        switch (action) {
            case "/add":
                Element profile = profiles.createElement("profile");
                profile.setAttribute("pid", "");

                Element contact = profiles.createElement("contact");
                contact.appendChild(createSimpleElement(request.getParameter("degree"), "degree"));
                contact.appendChild(createSimpleElement(request.getParameter("name"), "name"));
                contact.appendChild(createSimpleElement(request.getParameter("surname"), "surname"));
                contact.appendChild(createAddressElement(request));
                contact.appendChild(createSimpleElement(request.getParameter("country"), "country"));
                contact.appendChild(createSimpleElement(request.getParameter("fax"), "fax"));
                contact.appendChild(createSimpleElement(request.getParameter("tel"), "phone"));
                contact.appendChild(createSimpleElement(request.getParameter("email"), "email"));
                contact.appendChild(createSimpleElement(request.getParameter("homepage"), "homepage"));

                Element personalInfo = profiles.createElement("details");
                personalInfo.appendChild(createSimpleElement(request.getParameter("gender"), "gender"));
                personalInfo.appendChild(createSimpleElement(request.getParameter("dateofbrith"), "birthDate"));
                personalInfo.appendChild(createSimpleElement(request.getParameter("placeofbirth"), "birthPlace"));
                personalInfo.appendChild(createSimpleElement(request.getParameter("citizenship"), "citizenship"));

                Element education = profiles.createElement("education");


                profile.appendChild(contact);
                profile.appendChild(personalInfo);
              //  profile.appendChild(createEducationElement(request));
                profile.appendChild(createSimpleElement(request.getParameter("thesis"), "thesis"));

                return;
            default:
                throw new ServletException("");
        }
    }
    private Element createSimpleElement(String textContent, String name)
    {
        if (textContent.isEmpty() || textContent == null
                || name.isEmpty() || name == null) {
            //TODO: vyhod chybu
        }

        Element element = profiles.createElement(name);
        element.setTextContent(textContent);

        return element;
    }

    private Element createElementWithNameAttribute(String attribute, String name)
    {
        if (attribute.isEmpty() || attribute == null
                || name.isEmpty() || name == null) {
            //TODO: vyhod chybu
        }

        Element element = profiles.createElement(name);
        element.setAttribute("name", attribute);

        return element;
    }

    private Element createAddressElement(HttpServletRequest request)
    {
        Element streetEl = createSimpleElement(request.getParameter("street"), "street");
        Element houseNumberEl = createSimpleElement(request.getParameter("housenumber"), "number");
        Element postCodeEl = createSimpleElement(request.getParameter("postcode"), "postcode");
        Element cityEl = createSimpleElement(request.getParameter("city"), "city");

        Element address = profiles.createElement("address");
        address.appendChild(streetEl);
        address.appendChild(houseNumberEl);
        address.appendChild(postCodeEl);
        address.appendChild(cityEl);

        return address;
    }
}