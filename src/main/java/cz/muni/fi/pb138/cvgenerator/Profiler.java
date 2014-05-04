package cz.muni.fi.pb138.cvgenerator;

import org.w3c.dom.Document;

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

    private static final String LIST_JSP = "/list.jsp";
    private static Document profiles = (Document) new File("classpath:profiles.xml");

    public static final String URL_MAPPING = "/create_prof";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
        super.doPost(request, httpServletResponse);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse httpServletResponse)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getPathInfo();
        switch (action)
        {
            case "a" :
            case "b" :
            case "c" :
            default :
        }
    }

    private void createProfile(HttpServletRequest request)
    { }

}
