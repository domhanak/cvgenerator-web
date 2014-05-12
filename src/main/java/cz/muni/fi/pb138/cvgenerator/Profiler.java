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
                String degree = request.getParameter("degree");
                Element degreeEl = (Element) profiles.createElement("degree");
                degreeEl.setTextContent(degree);

                String name = request.getParameter("name");
                Element nameEl = (Element) profiles.createElement("name");
                degreeEl.setTextContent(name);

                String surname = request.getParameter("surname");
                Element surnameEl = profiles.createElement("surname");
                degreeEl.setTextContent(surname);

                String street = request.getParameter("street");
                Element streetEl = profiles.createElement("street");
                degreeEl.setTextContent(street);

                String houseNumber = request.getParameter("housenumber");
                Element houseNumberEl = profiles.createElement("houseNumber");
                degreeEl.setTextContent(houseNumber);

                String postCode = request.getParameter("postcode");
                Element postCodeEl = profiles.createElement("postCode");
                degreeEl.setTextContent(postCode);

                String city = request.getParameter("city");
                Element cityEl = profiles.createElement("city");
                degreeEl.setTextContent(city);

                String phone = request.getParameter("tel");
                Element phoneEl = profiles.createElement("phone");
                degreeEl.setTextContent(phone);

                String email = request.getParameter("email");
                Element emailEl = profiles.createElement("email");
                degreeEl.setTextContent(email);

                String country = request.getParameter("country");
                Element countryEl = profiles.createElement("country");
                degreeEl.setTextContent(country);

                String sex = request.getParameter("sex");
                Element sexEl = profiles.createElement("sex");
                degreeEl.setTextContent(sex);

                String martialStatus = request.getParameter("mas");
                Element martialStatusEl = profiles.createElement("martialStatus");
                degreeEl.setTextContent(martialStatus);

                String date = request.getParameter("dateOfBirth");
                Element dateEl = profiles.createElement("date");
                degreeEl.setTextContent(date);

                if (name.isEmpty() || name == null || surname.isEmpty() || surname == null
                        || degree.isEmpty() || degree == null || street.isEmpty() || street == null
                        || houseNumber.isEmpty() || houseNumber == null || email.isEmpty() || email == null
                        || country.isEmpty() || country == null) {
                }


                Element profile = (Element) profiles.createElement("profile");
                profile.setAttribute("pid", "");
                profile.appendChild(degreeEl);
                profile.appendChild(nameEl);
                profile.appendChild(surnameEl);
                profile.appendChild(dateEl);
                profile.appendChild(cityEl);
                profile.appendChild(streetEl);
                profile.appendChild(houseNumberEl);
                profile.appendChild(postCodeEl);
                profile.appendChild(phoneEl);
                profile.appendChild(emailEl);
                profile.appendChild(countryEl);
                profile.appendChild(sexEl);
                profile.appendChild(martialStatusEl);

                profiles.appendChild(profile);

                return;
            default:
                throw new ServletException("");
        }
    }
}
