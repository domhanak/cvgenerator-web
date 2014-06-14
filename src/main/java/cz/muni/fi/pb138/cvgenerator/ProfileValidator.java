package cz.muni.fi.pb138.cvgenerator;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.ws.handler.Handler;
import javax.xml.ws.handler.MessageContext;
import org.w3c.dom.Document;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

/**
 * Created by admin on 6/11/2014.
 */
public class ProfileValidator {
    class ValidationErrorsHandler implements ErrorHandler {


        @Override
        public void warning(SAXParseException exception) throws SAXException {
            System.out.println(exception.getMessage());
        }

        @Override
        public void error(SAXParseException exception) throws SAXException {
            error = exception.getMessage();
            throw new SAXException(error);
        }

        @Override
        public void fatalError(SAXParseException exception) throws SAXException {
            error = exception.getMessage();
            throw new SAXException(error);
        }
    }

        private DocumentBuilder docBuilder;
        private String error;

        public ProfileValidator(File schemaFile)
        {
            try {
                SchemaFactory sf = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
                Schema schema = sf.newSchema(schemaFile);

                DocumentBuilderFactory dbf=DocumentBuilderFactory.newInstance();
                dbf.setNamespaceAware(true);

                dbf.setSchema(schema);
                docBuilder = dbf.newDocumentBuilder();
                docBuilder.setErrorHandler(new ValidationErrorsHandler());
            } catch (SAXException ex) {
                System.err.println("Invalid schema: " + ex.getMessage());
                System.exit(-1);
            } catch (ParserConfigurationException ex) {
                System.err.println("Parser configuration error: " + ex.getMessage());
            }
        }

        public String validate(File xmlFile) throws IOException{
            try {
                Document doc = docBuilder.parse(xmlFile);
            } catch (SAXException ex) {
                return "Validation error: " + ex.getMessage();
            }
            return null;
        }
        public Document parse(File xmlFile) throws IOException, SAXException{

            Document doc = docBuilder.parse(xmlFile);
            return doc;
        }

}
