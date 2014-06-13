package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

/**
 * Profiler takes request with data from @see index.jsp,
 * and creates profile element according to profiles.xsd schema.
 *
 * Created by Hany on 5.6.2014.
 */
public class Profiler {
    private HttpServletRequest request;
    private Document doc = null;

    public Profiler(HttpServletRequest request, Document doc) {
        this.request = request;
        this.doc = doc;
    }

    public Element createProfile(String pid) throws ProfilerException {
        Element profile = doc.createElement("profile");
        profile.setAttribute("pid", pid);

        profile.appendChild(createContactElement());
        profile.appendChild(createPersonalInfo());
        profile.appendChild(createEducation());
        if (request.getParameter("thesis") != null && !request.getParameter("thesis").isEmpty()) {
            profile.appendChild(createSimpleElement(request.getParameter("thesis"), "thesis"));
        }
        profile.appendChild(createExperience());
        profile.appendChild(createLanguages());
        profile.appendChild(createPersonalReference());

        return profile;
    }

    private Element createPersonalReference() throws ProfilerException {
        Element reference = doc.createElement("reference");
        Element refContact = doc.createElement("contact");

        if (request.getParameter("relationship") != null && !request.getParameter("relationship").isEmpty()) {
            reference.appendChild(createSimpleElement(request.getParameter("relationship"), "relationship"));
        }
        if (request.getParameter("refdegree") != null && !request.getParameter("refdegree").isEmpty()) {
            refContact.appendChild(createSimpleElement(request.getParameter("refdegree"), "degree"));
        }
        if (request.getParameter("refname") != null && request.getParameter("refsurname") != null) {
            refContact.appendChild(createSimpleElement(request.getParameter("refname") + " " + request.getParameter("refsurname"), "name"));
        }
         if (request.getParameter("refstreet")!= null && !request.getParameter("refstreet").isEmpty()
            && request.getParameter("refhousenumber") != null && !request.getParameter("refhousenumber").isEmpty()
            && request.getParameter("refpostcode") != null && !request.getParameter("refpostcode").isEmpty()
            && request.getParameter("refcity") != null && !request.getParameter("refcity").isEmpty()) {

            refContact.appendChild(createAddressElement(request.getParameter("refstreet"),
                request.getParameter("refhousenumber"),
                request.getParameter("refpostcode"),
                request.getParameter("refcity")));
        }
        if (request.getParameter("refcountry") != null && !request.getParameter("refcountry").isEmpty()) {
            refContact.appendChild(createSimpleElement(request.getParameter("refcountry"), "country"));
        }

        if (request.getParameter("reftel") != null && !request.getParameter("reftel").isEmpty()) {
            refContact.appendChild(createSimpleElement(request.getParameter("reftel"), "phone"));
        }

        if (request.getParameter("reffax") != null && !request.getParameter("reffax").isEmpty()) {
            refContact.appendChild(createSimpleElement(request.getParameter("fax"), "fax"));
        }
        if (request.getParameter("refemail") != null && !request.getParameter("refemail").isEmpty()) {
            refContact.appendChild(createSimpleElement(request.getParameter("refemail"), "email"));
        }
        if (request.getParameter("refhomepage") != null && !request.getParameter("refhomepage").isEmpty()) {
            refContact.appendChild(createSimpleElement(request.getParameter("refhomepage"), "homepage"));
        }

        reference.appendChild(refContact);

        return reference;
    }

    private Element createContactElement() throws ProfilerException {
        Element contact = doc.createElement("contact");
        if (request.getParameter("degree") != null && !request.getParameter("degree").isEmpty()) {
            contact.appendChild(createSimpleElement(request.getParameter("degree"), "degree"));
        }
        if (request.getParameter("name") != null && request.getParameter("surname") != null) {
            contact.appendChild(createSimpleElement(request.getParameter("name") + " " + request.getParameter("surname"), "name"));
        }
        contact.appendChild(createAddressElement(request.getParameter("street"),
                request.getParameter("housenumber"),
                request.getParameter("postcode"),
                request.getParameter("city")));

        if (request.getParameter("country") != null && !request.getParameter("country").isEmpty()) {
            contact.appendChild(createSimpleElement(request.getParameter("country"), "country"));
        } else {
            request.setAttribute("error", "Please fill country field.");
            throw new ProfilerException("Country field not filled.");
        }

        if (request.getParameter("tel") != null && !request.getParameter("tel").isEmpty()) {
            String tel = request.getParameter("tel");
            contact.appendChild(createSimpleElement(tel , "phone"));
        } else {
            request.setAttribute("error", "Please fill phone field.");
            throw new ProfilerException("Phone field not filled.");
        }

        if (request.getParameter("fax") != null && !request.getParameter("fax").isEmpty()) {
            contact.appendChild(createSimpleElement(request.getParameter("fax"), "fax"));
        }
        if (request.getParameter("email") != null && !request.getParameter("email").isEmpty()) {
            contact.appendChild(createSimpleElement(request.getParameter("email"), "email"));
        } else {
            request.setAttribute("error", "Please fill email field.");
            throw new ProfilerException("Email field not filled.");
        }
        if (request.getParameter("homepage") != null && !request.getParameter("homepage").isEmpty()) {
            contact.appendChild(createSimpleElement(request.getParameter("homepage"), "homepage"));
        }
        return contact;
    }

    private Element createPersonalInfo() throws ProfilerException {
        Element personalInfo = doc.createElement("details");

        if (request.getParameter("gender") != null && !request.getParameter("gender").isEmpty()) {
            personalInfo.appendChild(createSimpleElement(request.getParameter("gender"), "gender"));
        } else {
            request.setAttribute("error", "Please fill you gender.");
            throw new ProfilerException("Fill gender!.");
        }
        if (request.getParameter("dateofbirth") != null && !request.getParameter("dateofbirth").isEmpty()) {
            personalInfo.appendChild(createSimpleElement(request.getParameter("dateofbirth"), "birthDate"));
        } else {
            request.setAttribute("error", "Please fill you date of birth.");
            throw new ProfilerException("Fill date fo brith!.");
        }
        if (request.getParameter("placeofbirth") != null && !request.getParameter("placeofbirth").isEmpty()) {
            personalInfo.appendChild(createSimpleElement(request.getParameter("placeofbirth"), "birthPlace"));
        } else {
            request.setAttribute("error", "Please fill you place fo birth.");
            throw new ProfilerException("Fill place of birth!.");
        }
        if (request.getParameter("citizenship") != null && !request.getParameter("citizenship").isEmpty()) {
            personalInfo.appendChild(createSimpleElement(request.getParameter("citizenship"), "citizenship"));
        } else {
            request.setAttribute("error", "Please fill you place fo birth.");
            throw new ProfilerException("Fill your citizenship!.");
        }

        return personalInfo;
    }

    private Element createEducation() throws ProfilerException {
        Element education = doc.createElement("education");

        if (request.getParameter("stschoolname") != null && !request.getParameter("stschoolname").isEmpty()) {
            education.appendChild(createComplexElement(request.getParameter("stschoolname"),
                    Arrays.asList(request.getParameter("stschoolfrom"), request.getParameter("stschoolto")), "school"));
        } else {
            request.setAttribute("error", "Please fill at least one field in education!");
            throw new ProfilerException("Fill at least one school!");
        }

        if (request.getParameter("ndschoolname") != null && !request.getParameter("ndschoolname").isEmpty()) {
            education.appendChild(createComplexElement(request.getParameter("ndschoolname"),
                    Arrays.asList(request.getParameter("ndschoolfrom"), request.getParameter("ndschoolto")), "job"));
        }
        if (request.getParameter("rdschoolname") != null && !request.getParameter("rdschoolname").isEmpty()) {
            education.appendChild(createComplexElement(request.getParameter("rdschoolname"),
                    Arrays.asList(request.getParameter("rdschoolfrom"), request.getParameter("rdschoolto")), "job"));
        }

        return education;
    }

    private Element createExperience() throws ProfilerException {
        Element experience = doc.createElement("experience");

        /* Check if at least one job element was inputed. */
        if (request.getParameter("stwork") != null && !request.getParameter("stwork").isEmpty()) {
            experience.appendChild(createComplexElement(request.getParameter("stwork"),
                    Arrays.asList(request.getParameter("stworkfrom"), request.getParameter("stworkto")), "job"));
        } else {
            request.setAttribute("error", "Please fill at least one field in work!");
            throw new ProfilerException("Fill at least on work!.");
        }

        if (request.getParameter("ndwork") != null && !request.getParameter("ndwork").isEmpty()) {
            experience.appendChild(createComplexElement(request.getParameter("ndwork"),
                    Arrays.asList(request.getParameter("ndworkfrom"), request.getParameter("ndworkto")), "job"));
        }
        if (request.getParameter("rdwork") != null && !request.getParameter("rdwork").isEmpty()) {
            experience.appendChild(createComplexElement(request.getParameter("ndwork"),
                    Arrays.asList(request.getParameter("ndworkfrom"), request.getParameter("ndworkto")), "job"));
        }

        return experience;
    }

    private Element createLanguages() throws ProfilerException {
        Element languages = doc.createElement("languages");

        /* Check if at least two langauages were inputed */
        if (request.getParameter("stlanguage") != null && !request.getParameter("stlanguage").isEmpty()) {
            languages.appendChild(createLanguageElement(
                    request.getParameter("stlanguage"), request.getParameter("stlanguagelvl")));
        } else {
            request.setAttribute("error", "First two languages are required!");
            throw new ProfilerException("Fill first two languages!");
        }
        if (request.getParameter("ndlanguage") != null && !request.getParameter("ndlanguage").isEmpty()) {
            languages.appendChild(createLanguageElement(
                    request.getParameter("ndlanguage"), request.getParameter("ndlanguagelvl")));
        } else {
            request.setAttribute("error", "First two languages are required!");
            throw new ProfilerException("Fill first two languages!");
        }

        /* Check for other languages and add them if they were inputed */
        if (request.getParameter("rdlanguage") != null && !request.getParameter("rdlanguage").isEmpty()) {
            languages.appendChild(createLanguageElement(
                    request.getParameter("rdlanguage"), request.getParameter("rdlanguagelvl")));
        }
        if (request.getParameter("thlanguage") != null && !request.getParameter("thlanguage").isEmpty()) {
            languages.appendChild(createLanguageElement(
                    request.getParameter("thlanguage"), request.getParameter("thlanguagelvl")));
        }

        return languages;
    }

    /**
     * Creates simple element.
     * Element looks like this: <@name> @textContent</@name>
     *
     * @param textContent text content of simple element
     * @param name        name of the element
     * @return Element
     */
    public Element createSimpleElement(String textContent, String name) {
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Name is null.");
        }
        if (textContent == null || textContent.isEmpty()) {
            throw new IllegalArgumentException("TextContent is null." + name);
        }

        Element element = doc.createElement(name);
        element.setTextContent(textContent);

        return element;
    }

    /**
     * Creates complex element of desired format.
     * Creates elements like this:<@name name="@attribute">
     * <from>@childs.get(0)</from>
     * <to>@childs.get(1)</to>
     * </@name>
     *
     * @param attribute attribute of element
     * @param childs    List of textContents of it's childs, should have two elements.
     * @param name      name of element
     * @return Element
     */
    public Element createComplexElement(String attribute, List<String> childs, String name) {
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("name is empty or null.");
        }
        if (attribute == null || attribute.isEmpty()) {
            throw new IllegalArgumentException("attribute is empty or null.");
        }
        if (childs.size() != 2) {
            throw new IllegalArgumentException("childs is invalid");
        }
        if (childs.get(0) == null || childs.get(0).isEmpty()
                || childs.get(1) == null || childs.get(1).isEmpty()) {
            throw new IllegalArgumentException("childs content is empty or null.");
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

    /**
     * Creates element like this: <address>
     * <street></street>
     * <postcode></postcode>
     * <city></city>
     * </address>
     *
     * @param street      textContent of street element + @houseNumber
     * @param houseNumber number of hous in the street
     * @param postcode    textContent of postcode element
     * @param city        textContent of city element
     * @return Element of format described above.
     * @throws ProfilerException thrown when not all element inputed.
     */
    public Element createAddressElement(String street, String houseNumber, String postcode, String city) throws ProfilerException {
        if (street == null || houseNumber == null || postcode == null || city == null
                || street.isEmpty() || houseNumber.isEmpty() || postcode.isEmpty() || city.isEmpty()) {
            request.setAttribute("error", "Not all address elements were inputed.");
            throw new ProfilerException("Address elements weren't inputed.");
        }

        Element streetEl = createSimpleElement(street + " " + houseNumber, "street");
        Element postCodeEl = createSimpleElement(postcode, "postcode");
        Element cityEl = createSimpleElement(city, "city");

        Element address = doc.createElement("address");
        address.appendChild(streetEl);
        address.appendChild(postCodeEl);
        address.appendChild(cityEl);

        return address;
    }

    /**
     * Creates language element like this <language name="@languageName" level="@languageLvl"/>;
     *
     * @param languageName name of the language
     * @param languageLvl  level of the langauage
     * @return Element: <language name="@languageName" level="@languageLvl"/>
     * @throws ProfilerException
     */
    public Element createLanguageElement(String languageName, String languageLvl) throws ProfilerException {
        if (languageName == null || languageName.isEmpty()) {
            request.setAttribute("error", "Please fill at least two languages! You didn't fill: " + languageName);
            throw new ProfilerException("Two language weren't filled. Fill at least first two.");
        }

        Element language = doc.createElement("language");
        language.setAttribute("name", languageName);
        language.setAttribute("knowledge", languageLvl);

        return language;
    }
}
