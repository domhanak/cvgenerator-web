package cz.muni.fi.pb138.cvgenerator.test;

import cz.muni.fi.pb138.cvgenerator.Profiler;
import cz.muni.fi.pb138.cvgenerator.ProfilerException;
import org.junit.Before;
import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.servlet.http.HttpServletRequest;

import static junit.framework.Assert.assertEquals;
import static junit.framework.Assert.assertNotNull;
import static junit.framework.Assert.assertNull;
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
        Element element;
        String elementName = "simpleElementName";
        String elementContent = "simpleElementTextContent";

        element = profiler.createSimpleElement(elementContent, elementName);

        assertNotNull(element);
        assertEquals(element.getTagName(), elementName);
        assertEquals(element.getTextContent(), elementContent);
    }

    @Test
    public void createComplexElementTest() {

    }

    @Test
    public void createAddressElementTest(){

    }

    @Test
    public void createLanguageElement(){

    }

}