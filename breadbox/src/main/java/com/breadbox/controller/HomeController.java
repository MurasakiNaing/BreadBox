package com.breadbox.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breadbox.service.UserService;
import com.breadbox.service.dto.UserDto;

@Controller
@RequestMapping
public class HomeController {
	
	@Autowired
	private UserService service;

	@GetMapping("/customer")
	public String customerHome(Model map, Authentication authentication) {
		var email = authentication.getName();
		UserDto user = service.findById(email);
		map.addAttribute("user", user);
		return "customer";
	}
	
	@GetMapping("/admin")
	public String adminHome(Model map, Authentication authentication) {
		var email = authentication.getName();
		UserDto user = service.findById(email);
		map.addAttribute("user", user);
		return "admin";
	}
}
