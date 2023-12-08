package com.breadbox.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breadbox.service.ProductService;
import com.breadbox.service.UserService;
import com.breadbox.service.dto.Cart;
import com.breadbox.service.dto.ProductDto;
import com.breadbox.service.dto.UserDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductService productService;

	@GetMapping("/")
	public String customerHome(Authentication authentication, HttpSession session, HttpServletRequest req) {
		// Check if authentication is not null to check if the user is logged in or not
		if(authentication != null) {
			// If users is logged in and is admin redirect the page to admin home page
			if(authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("Admin"))) {
				return "redirect:/admin";
			}
			
			// If the user is customer get user name
			var email = authentication.getName();
			// Find user with the user name
			UserDto user = userService.findById(email);
			// Set the user in session scope
			session.setAttribute("user", user);
			
			// Check if a cart already exists in the session
			if (session.getAttribute("cart") == null) {
				 // If not, create a new cart
				Cart cart = new Cart();
				// Add cart to session
				session.setAttribute("cart", cart);
			}
		}
		return "home";
	}
	
	@GetMapping("/admin")
	public String adminHome(Model map, Authentication authentication, HttpSession session) {
		// Get user name of admin
		var email = authentication.getName();
		// Find the user with user name
		UserDto user = userService.findById(email);
		// Set the user in session scope
		session.setAttribute("user", user);
		// Return to admin home page
		return "admin";
	}
	
	@ModelAttribute("trendingProducts")
	public List<ProductDto> getTrendingProducts() {
		return productService.getTrendingProducts();
	}
	
	@ModelAttribute("newProducts")
	public List<ProductDto> getNewlyAddedProducts() {
		return productService.getNewlyAddedProducts();
	}
}
