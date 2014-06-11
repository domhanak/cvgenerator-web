package cz.muni.fi.pb138.cvgenerator.test;

import cz.muni.fi.pb138.cvgenerator.Profiler;
import cz.muni.fi.pb138.cvgenerator.ProfilerException;
import org.junit.Before;
import org.junit.Test;
import org.w3c.dom.Document;

import javax.servlet.http.HttpServletRequest;

import static org.junit.Assert.fail;

public class ProfilerTest {
    private Profiler profiler;
    private HttpServletRequest request;
    private Document document;

    @Before
    public void setUp() throws Exception {
        profiler = new Profiler(request, document);
    }

    @Test
    public void createProfileTest()
    {
        /*
        try {
            profiler.createProfile();
            fail();
        } catch (ProfilerException ex) {}
          catch (IllegalArgumentException ex){}
          */
    }

    @Test
    public void createSimpleElementTest()
    {
        /*
        try {
            profiler.createSimpleElement("","meno", request);
            fail();
        } catch (ProfilerException e) {}
        try {
            profiler.createSimpleElement(null,"meno", request);
            fail();
        } catch (ProfilerException e) {}
        try {
            profiler.createSimpleElement("textcontent","", request);
            fail();
        } catch (IllegalArgumentException e) {}
          catch (ProfilerException e) {}
        try {
            profiler.createSimpleElement("textcontent",null, request);
            fail();
        } catch (ProfilerException e) {}
          catch (IllegalArgumentException e) {}
        try {
            profiler.createSimpleElement("textcontent","name", null);
            fail();
        } catch (ProfilerException e) {}
        catch (IllegalArgumentException e) {}
        */
    }
}