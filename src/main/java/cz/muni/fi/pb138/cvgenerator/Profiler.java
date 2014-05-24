package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Hany on 4.5.2014.
 */
@WebServlet(Profiler.URL_MAPPING + "/*")
public class Profiler extends HttpServlet {

    private static Document profiles = null;

    private static final String LIST_JSP = "/index.jsp";
    public static final String URL_MAPPING = "/profiles";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        profiles = (Document) request.getAttribute("profilesDoc");

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
                education.appendChild(createComplexElement(request.getParameter("stschoolname"),
                        Arrays.asList(request.getParameter("stschoolfrom"), request.getParameter("stschoolto")), "school"));
                education.appendChild(createComplexElement(request.getParameter("ndschoolname"),
                        Arrays.asList(request.getParameter("ndschoolfrom"), request.getParameter("ndschoolto")), "school"));
                education.appendChild(createComplexElement(request.getParameter("rdschoolname"),
                        Arrays.asList(request.getParameter("rdschoolfrom"), request.getParameter("rdschoolto")), "school"));

                Element experience = profiles.createElement("experience");
                experience.appendChild(createComplexElement(request.getParameter("stwork"),
                        Arrays.asList(request.getParameter("stworkfrom"), request.getParameter("stworkto")), "job"));
                experience.appendChild(createComplexElement(request.getParameter("ndwork"),
                        Arrays.asList(request.getParameter("ndworkfrom"), request.getParameter("ndworkto")), "job"));
                experience.appendChild(createComplexElement(request.getParameter("rdwork"),
                        Arrays.asList(request.getParameter("rdworkfrom"), request.getParameter("rdworkto")), "job"));

                Element languages = profiles.createElement("languages");
                languages.appendChild(createLanguageElement(
                        request.getParameter("stlanguage"), request.getParameter("stlanguagelvl")));
                languages.appendChild(createLanguageElement(
                        request.getParameter("ndlanguage"), request.getParameter("ndlanguagelvl")));
                languages.appendChild(createLanguageElement(
                        request.getParameter("rdlanguage"), request.getParameter("rdlanguagelvl")));
                languages.appendChild(createLanguageElement(
                        request.getParameter("thlanguage"), request.getParameter("thlanguagelvl")));


                profile.appendChild(contact);
                profile.appendChild(personalInfo);
                profile.appendChild(education);
                profile.appendChild(createSimpleElement(request.getParameter("thesis"), "thesis"));
                profile.appendChild(experience);
                profile.appendChild(languages);

                profiles.appendChild(profile);
                return;
            default:
                throw new ServletException("");
        }
    }

    private Element createSimpleElement(String textContent, String name)
    {
        Element element = profiles.createElement(name);
        element.setTextContent(textContent);

        return element;
    }

    private Element createComplexElement(String attribute, List<String> childs, String name)
    {
        if (attribute.isEmpty()){
            return null;
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

    private Element createLanguageElement(String languageName, String languageLvl)
    {
        if (languageName.isEmpty()){
            return null;
        }

        Element language = profiles.createElement("language");
        language.setAttribute(languageName, languageLvl);

        return language;
    }
}