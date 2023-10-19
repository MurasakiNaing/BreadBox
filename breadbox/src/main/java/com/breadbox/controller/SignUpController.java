package com.breadbox.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breadbox.service.UserService;
import com.breadbox.service.dto.SignupForm;

@Controller
@RequestMapping("/sign-up")
public class SignUpController {

	@Autowired
	private UserService service;
	
	@GetMapping
	public String singUpPage() {
		return "sign-up";
	}
	
	@PostMapping
	public String signup(@Validated @ModelAttribute("form") SignupForm form, BindingResult result) {
		if(result.hasErrors())
			return "sign-up";
		System.out.println("Hello");
		
		service.singUp(form);
		
		return "redirect:/login";
	}
	
	@ModelAttribute("form")
	SignupForm signUpForm() {
		return new SignupForm();
	}
	
}
