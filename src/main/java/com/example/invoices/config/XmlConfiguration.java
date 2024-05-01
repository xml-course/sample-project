package com.example.invoices.config;

import com.example.invoices.xml.XmlDocumentValidator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.validation.SchemaFactory;
import java.io.IOException;

@Configuration
public class XmlConfiguration {

    private final SchemaFactory schemaFactory;

    public XmlConfiguration() {
        schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
    }

    @Bean
    public XmlDocumentValidator invoiceValidator(@Value("classpath:/schema/invoice.xsd")
                                                 Resource invoiceSchemaResource)
        throws IOException, SAXException
    {
        var schema = schemaFactory.newSchema(invoiceSchemaResource.getURL());

        return new XmlDocumentValidator(schema);
    }

}
