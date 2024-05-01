package com.example.invoices.config;

import com.example.invoices.view.ApacheFopView;
import com.example.invoices.view.OptionalXsltViewResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.view.xslt.XsltViewResolver;

@Configuration
public class ViewConfiguration {

    @Bean
    public XsltViewResolver xmlToHtmlXsltViewResolver() {
        var xsltViewResolver = new OptionalXsltViewResolver();
        xsltViewResolver.setPrefix("classpath:/xsl/");
        xsltViewResolver.setSuffix("-to-html.xsl");
        xsltViewResolver.setContentType(MediaType.TEXT_HTML_VALUE);

        return xsltViewResolver;
    }

    @Bean
    public XsltViewResolver xmlToCsvXsltViewResolver() {
        var xsltViewResolver = new OptionalXsltViewResolver();
        xsltViewResolver.setPrefix("classpath:/xsl/");
        xsltViewResolver.setSuffix("-to-csv.xsl");
        xsltViewResolver.setContentType("text/csv");

        return xsltViewResolver;
    }

    @Bean
    public XsltViewResolver xmlToPdfApacheFopViewResolver() {
        var xsltViewResolver = new OptionalXsltViewResolver();
        xsltViewResolver.setViewClass(ApacheFopView.class);
        xsltViewResolver.setPrefix("classpath:/xsl/");
        xsltViewResolver.setSuffix("-to-fo.xsl");
        xsltViewResolver.setContentType(MediaType.APPLICATION_PDF_VALUE);

        return xsltViewResolver;
    }

}
