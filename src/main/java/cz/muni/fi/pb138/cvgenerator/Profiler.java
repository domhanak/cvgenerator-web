package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.*;

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
        super.doPost(request, httpServletResponse);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        Document profiles = (Document) getServletContext().getAttribute("profilesDoc");

        String action = request.getPathInfo();
        switch (action)
        {
            case "/add" :
                String degree = request.getParameter("degree");
                String name = request.getParameter("name");
                String surname = request.getParameter("surname");
                String street = request.getParameter("street");
                int houseNumber = Integer.parseInt(request.getParameter("housenumber"));
                int postCode = Integer.parseInt(request.getParameter("postcode"));
                String city = request.getParameter("city");
                String phone = request.getParameter("tel");
                String email = request.getParameter("email");
                String country = request.getParameter("country");
                String sex = request.getParameter("sex");
                String martialStatus = request.getParameter("mas");
                String date = request.getParameter("dateOfBirth");

            default :
        }
    }
}
