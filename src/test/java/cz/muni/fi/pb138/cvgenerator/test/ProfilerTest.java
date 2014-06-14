package cz.muni.fi.pb138.cvgenerator.test;

import cz.muni.fi.pb138.cvgenerator.Profiler;
import cz.muni.fi.pb138.cvgenerator.ProfilerException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.junit.Before;
import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.util.List;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.net.URISyntaxException;

import static junit.framework.Assert.*;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.fail;

public class ProfilerTest {
    private Profiler profiler;
    private HttpServletRequest request;
    private Document document;

    @Before
    public void setUp() throws Exception {
        File testFile = null;
        try {
            testFile = new File(this.getClass().getResource("/test.xml").toURI());
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        dbFactory.setValidating(false);
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        document = dBuilder.parse(testFile);
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

        assertFalse(element.hasAttributes());

        //TODO check child nodes

        element = null;
        elementName = null;

        try{
            element = profiler.createSimpleElement(elementContent, elementName);
        }catch (IllegalArgumentException ex){}

        element = null;
        elementName = "simpleElementName";
        elementContent = null;

        try{
            element = profiler.createSimpleElement(elementContent, elementName);
        }catch (IllegalArgumentException ex){}


    }

    @Test
    public void createComplexElementTest() {
        List <String> childElementTextContent  = new ArrayList<String>();
        childElementTextContent.add("text1");
        childElementTextContent.add("text2");

        String complexElementAttributeValue = "elementAttribute";
        String complexElementName = "elementAttribute";

        Element complexElement = null;

        complexElement = profiler.createComplexElement(complexElementAttributeValue, childElementTextContent, complexElementName);

        assertNotNull(complexElement);
        assertEquals(complexElement.getTagName(), complexElementName);
        assertTrue(complexElement.hasAttributes());

        assertEquals(complexElementAttributeValue,complexElement.getAttributes().item(0).getTextContent());

        NodeList childrenElements = complexElement.getChildNodes();

        assertEquals(childElementTextContent.size(),childrenElements.getLength());

        for(int i = 0; i<childrenElements.getLength(); i++)
        {
            Element childElement = (Element) childrenElements.item(i);
            assertEquals(childElementTextContent.get(i), childElement.getTextContent());
        }




    }



    @Test
    public void createAddressElementTest(){

    }

    @Test
    public void createLanguageElement(){

    }

}