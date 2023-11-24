package com.breadbox.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
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
		// Check if there is validation error
		if(result.hasErrors())
			return "sign-up";
		// Check if the email is already in use
		if(service.findById(form.getEmail()) != null) {
			result.addError(new FieldError("form", "email", "Email is already in use."));
			return "sign-up";
		}
		// Check if 2 password fields matches
		if(!(form.getPassword().equals(form.getConfirmPassword()))) {
			result.addError(new FieldError("form", "confirmPassword", "Passwords does not matches."));
			result.addError(new FieldError("form", "password", "Passwords does not matches."));
			return "sign-up";
		}
		service.signUp(form);
		
		return "redirect:/login";
	}
	
	@ModelAttribute("form")
	SignupForm signUpForm() {
		return new SignupForm();
	}
	
}
