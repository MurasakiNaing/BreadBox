package com.breadbox.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/login-error")
public class LoginErrorController {

	@PostMapping
	public String loginEror(ModelMap model) {
		System.out.println("Hello");
		model.addAttribute("error", "Username or Password is incorrect.");
		return "login";
	}
	
}
