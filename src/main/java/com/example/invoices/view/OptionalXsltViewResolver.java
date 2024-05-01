package com.example.invoices.view;

import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.xslt.XsltViewResolver;

import java.util.Locale;

public class OptionalXsltViewResolver extends XsltViewResolver {

    @Override
    public View resolveViewName(String viewName, Locale locale) throws Exception {
        var ctx = getApplicationContext();
        var viewResource = ctx.getResource(getPrefix() + viewName + getSuffix());

        return viewResource != null && viewResource.exists()
            ? super.resolveViewName(viewName, locale)
            : null;
    }

}
