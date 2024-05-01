package com.example.invoices.xml;

import org.xml.sax.SAXException;

import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import java.io.File;
import java.io.IOException;

public class XmlDocumentValidator {

    private final Schema schema;

    public XmlDocumentValidator(Schema schema) {
        this.schema = schema;
    }

    public void validate(File xmlDocument) throws IOException, SAXException {
        schema.newValidator().validate(new StreamSource(xmlDocument));
    }

}
