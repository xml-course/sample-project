package com.example.invoices.view;

import jakarta.servlet.http.HttpServletResponse;
import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.view.xslt.XsltView;
import org.xml.sax.SAXException;

import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.sax.SAXResult;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Map;

public class ApacheFopView extends XsltView {

    private final FopFactory fopFactory;

    public ApacheFopView() throws IOException, SAXException, URISyntaxException {
        var baseUri = new URI("classpath:/fop/");
        var configUri = new URI("classpath:/fop/fop.conf");

        try (var configInputStream = configUri.toURL().openStream()) {
            fopFactory = FopFactory.newInstance(baseUri, configInputStream);
        }
    }

    @Override
    protected void configureResponse(Map<String, Object> model,
                                     HttpServletResponse response,
                                     Transformer transformer)
    {
        super.configureResponse(model, response, transformer);

        response.setContentType(MediaType.APPLICATION_PDF_VALUE);
    }

    @Override
    protected Result createResult(HttpServletResponse response)
        throws IOException, FOPException
    {
        var fop = fopFactory.newFop(MimeConstants.MIME_PDF,
            response.getOutputStream());

        return new SAXResult(fop.getDefaultHandler());
    }
}
