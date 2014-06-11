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
            //Logger.getAnonymousLogger(ProfileValidator.class.getName()).log(Level.INFO,exception.getMessage());
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

        private DocumentBuilder docBuilder;
        private String error;
    }
}
