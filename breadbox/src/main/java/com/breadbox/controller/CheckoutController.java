package com.breadbox.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.breadbox.service.CheckoutService;
import com.breadbox.service.dto.Cart;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class CheckoutController {

	@Autowired
	private CheckoutService service;

	@GetMapping("/checkout")
	public String checkOutPage(HttpSession session, ModelMap map) {
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart.getCartSize() == 0)
			return "home";
		return "checkout";
	}
	
	@GetMapping("/orders")
	public String orders(ModelMap map, Authentication authentication) {
		if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("Customer"))) {
			map.put("vouchers", service.getVouchersUser(authentication.getName()));
		} else {
			map.put("vouchers", service.getAllVouchers());
		}
		return "orders";
	}
	
	@GetMapping("/orders/{id}")
	public String orderDetails(@PathVariable("id") int voucherId,ModelMap map) {
		map.put("order", service.getOrder(voucherId));
		return "order-details";
	}

	@PostMapping("/checkout")
	public String checkout(@RequestParam String location, @RequestParam String paymentMethod,
			@RequestParam String phone, Authentication authentication, HttpSession session, ModelMap model, RedirectAttributes redirectAttributes) {
		// Check if the form inputs are valid
		if (!validated(model, location, paymentMethod, phone))
			return "checkout";
		// Get cart from session
		Cart cart = (Cart) session.getAttribute("cart");
		// Call order method
		service.order(cart.createVoucher(location, phone, paymentMethod, authentication.getName()), cart.getItems());
		// Clear cart
		cart.clearCart();
		// Put success message before redirect
		redirectAttributes.addFlashAttribute("orderSuccessMessage", "Order have been placed successfully.");
		return "redirect:/";
	}

	private boolean validated(ModelMap map, String location, String paymentMethod, String phone) {
		// Check if the name is blank
		if (location.isBlank()) {
			map.put("locationError", "Please enter location for delivery.");
		}
		// Check if category is selected or not
		if (paymentMethod.isBlank()) {
			map.put("optionError", "Please choose an available option.");
		}
		// Check if phone number is blank and matches the pattern
		if (phone.isBlank()) {
			map.put("phoneError", "Please enter phone number.");
		} else {
			String regex = "^09\\d{9}$";
			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(phone);
			if (!matcher.matches())
				map.put("phoneError", "Phone number must start with 09 then followed up by 9 digits.");
		}

		/*
		 * Check if the map contains the keys put if there is error
		 */
		if (map.containsKey("locationError") || map.containsKey("optionError") || map.containsKey("phoneError"))
			return false;

		return true;
	}

}
