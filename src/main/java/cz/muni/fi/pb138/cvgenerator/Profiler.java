package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

/**
 * Created by Hany on 5.6.2014.
 */
public class Profiler {
    private HttpServletRequest request;
    private Document doc = null;

    Profiler() {}

    Profiler(HttpServletRequest request, Document doc)
    {
        this.request = request;
        this.doc = doc;
    }

    public Element createProfile() throws ProfilerException {
        Element profile = doc.createElement("profile");
        //profile.setAttribute("pid", request.);

        profile.appendChild(createContactElement());
        profile.appendChild(createPersonalInfo());
        profile.appendChild(createEducation());
        profile.appendChild(createExperience());
        profile.appendChild(createLanguages());

        return profile;
    }

    private Element createContactElement() throws ProfilerException {
        Element contact = doc.createElement("contact");
        contact.appendChild(createSimpleElement(request.getParameter("degree"), "degree", request));
        contact.appendChild(createSimpleElement(request.getParameter("name"), "name", request));
        contact.appendChild(createSimpleElement(request.getParameter("surname"), "surname", request));
        contact.appendChild(createAddressElement(request));
        contact.appendChild(createSimpleElement(request.getParameter("country"), "country", request));
        contact.appendChild(createSimpleElement(request.getParameter("fax"), "fax", request));
        contact.appendChild(createSimpleElement(request.getParameter("tel"), "phone", request));
        contact.appendChild(createSimpleElement(request.getParameter("email"), "email", request));
        contact.appendChild(createSimpleElement(request.getParameter("homepage"), "homepage", request));

        return contact;
    }

    private Element createPersonalInfo() throws ProfilerException {
        Element personalInfo = doc.createElement("details");
        personalInfo.appendChild(createSimpleElement(request.getParameter("gender"), "gender", request));
        personalInfo.appendChild(createSimpleElement(request.getParameter("dateofbrith"), "birthDate", request));
        personalInfo.appendChild(createSimpleElement(request.getParameter("placeofbirth"), "birthPlace", request));
        personalInfo.appendChild(createSimpleElement(request.getParameter("citizenship"), "citizenship", request));

        return personalInfo;
    }

    private Element createEducation() throws ProfilerException {
        Element education = doc.createElement("education");
        education.appendChild(createComplexElement(request.getParameter("stschoolname"),
                Arrays.asList(request.getParameter("stschoolfrom"), request.getParameter("stschoolto")), "school", request));
        education.appendChild(createComplexElement(request.getParameter("ndschoolname"),
                Arrays.asList(request.getParameter("ndschoolfrom"), request.getParameter("ndschoolto")), "school", request));
        education.appendChild(createComplexElement(request.getParameter("rdschoolname"),
                Arrays.asList(request.getParameter("rdschoolfrom"), request.getParameter("rdschoolto")), "school", request));

        return education;
    }

    private Element createExperience() throws ProfilerException {
        Element experience = doc.createElement("experience");
        experience.appendChild(createComplexElement(request.getParameter("stwork"),
                Arrays.asList(request.getParameter("stworkfrom"), request.getParameter("stworkto")), "job", request));
        experience.appendChild(createComplexElement(request.getParameter("ndwork"),
                Arrays.asList(request.getParameter("ndworkfrom"), request.getParameter("ndworkto")), "job", request));
        experience.appendChild(createComplexElement(request.getParameter("rdwork"),
                Arrays.asList(request.getParameter("rdworkfrom"), request.getParameter("rdworkto")), "job", request));

        return experience;
    }

    private Element createLanguages() throws ProfilerException {
        Element languages = doc.createElement("languages");
        languages.appendChild(createLanguageElement(
                request.getParameter("stlanguage"), request.getParameter("stlanguagelvl"), request));
        languages.appendChild(createLanguageElement(
                request.getParameter("ndlanguage"), request.getParameter("ndlanguagelvl"), request));
        languages.appendChild(createLanguageElement(
                request.getParameter("rdlanguage"), request.getParameter("rdlanguagelvl"), request));
        languages.appendChild(createLanguageElement(
                request.getParameter("thlanguage"), request.getParameter("thlanguagelvl"), request));

        return languages;
    }

    private Element createSimpleElement(String textContent, String name, HttpServletRequest req) throws ProfilerException {
        if (textContent.isEmpty()){
            req.setAttribute("error", "Please fill in all fields! You didn't fill: " + name);
            throw new ProfilerException("Text content of " + name + "field is empty.");
        }

        Element element = doc.createElement(name);
        element.setTextContent(textContent);

        return element;
    }

    private Element createComplexElement(String attribute, List<String> childs, String name, HttpServletRequest req) throws ProfilerException {
        if (attribute.isEmpty() || childs.get(0).isEmpty() || childs.get(1).isEmpty()){
            req.setAttribute("error", "Please fill in all fields! You didn't fill: " + name);
            throw new ProfilerException("Text content of " + name + "field  is empty.");
        }

        Element element = doc.createElement(name);
        Element from = doc.createElement("from");
        Element to = doc.createElement("to");

        element.setAttribute("name", attribute);
        from.setTextContent(childs.get(0));
        to.setTextContent(childs.get(1));

        element.appendChild(from);
        element.appendChild(to);

        return element;
    }

    private Element createAddressElement(HttpServletRequest request) throws  ProfilerException
    {
        Element streetEl = createSimpleElement(request.getParameter("street"), "street", request);
        Element houseNumberEl = createSimpleElement(request.getParameter("housenumber"), "number", request);
        Element postCodeEl = createSimpleElement(request.getParameter("postcode"), "postcode", request);
        Element cityEl = createSimpleElement(request.getParameter("city"), "city", request);

        Element address = doc.createElement("address");
        address.appendChild(streetEl);
        address.appendChild(houseNumberEl);
        address.appendChild(postCodeEl);
        address.appendChild(cityEl);

        return address;
    }

    public Element createLanguageElement(String languageName, String languageLvl, HttpServletRequest req) throws ProfilerException {
        if (languageName.isEmpty() || languageName.contains("st") || languageName.contains("nd")){
            req.setAttribute("error", "Please fill in all fields! You didn't fill: " + languageName);
            throw new ProfilerException("Two language weren't filled. Fill at least first two.");
        }

        Element language = doc.createElement("language");
        language.setAttribute(languageName, languageLvl);

        return language;
    }
}