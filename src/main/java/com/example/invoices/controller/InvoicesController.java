package com.example.invoices.controller;

import com.example.invoices.xml.XmlDocumentValidator;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.xml.sax.SAXException;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

@Controller
@RequestMapping("/invoices")
public class InvoicesController {

    private final XmlDocumentValidator invoiceValidator;

    public InvoicesController(@Qualifier("invoiceValidator")
                              XmlDocumentValidator invoiceValidator) {
        this.invoiceValidator = invoiceValidator;
    }

    @GetMapping("/")
    public String getInvoicesList(Model model) throws FileNotFoundException {
        model.addAttribute("invoices", new FileInputStream("data/invoices-list.xml"));

        return "invoices";
    }

    @GetMapping("/{id}")
    public String getInvoice(@PathVariable("id") String id, Model model)
        throws IOException, SAXException
    {
        var invoiceFilename = String.format("data/%s.xml", id);
        var invoiceFile = new File(invoiceFilename);
        invoiceValidator.validate(invoiceFile);

        model.addAttribute("invoice", new FileInputStream(invoiceFile));
        model.addAttribute("invoice_id", id);

        return "invoice";
    }

}
