package com.example.invoices.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/")
public class IndexController {

    @GetMapping
    public View index() {
        // Тъй като примерното приложение съдържа само страницата с фактурите,
        // началната страница пренасочва към нея
        return new RedirectView("/invoices/");
    }

}
