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
		// Add Error message to display back to users.
		model.addAttribute("error", "Username or Password is incorrect.");
		return "login";
	}
	
}
