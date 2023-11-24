package com.breadbox.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.breadbox.service.dto.Cart;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart-details")
public class CartController {
	
	@GetMapping
	public String cartPage(HttpSession session, ModelMap map) {
		Cart cart = (Cart) session.getAttribute("cart");
		map.put("items", cart.getItems());
		return "cart-details";
	}
	
	@GetMapping(value = {"/increment/{id}", "/decrement/{id}"})
	public String changeCount(@PathVariable Integer id,ModelMap map, HttpSession session, HttpServletRequest req) {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.changeQuantity(req.getServletPath().contains("increment"), id);
		return "redirect:/cart-details";
	}
	
	@PostMapping("/delete/{id}")
	public String deleteItem(@PathVariable Integer id, HttpSession session) {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.removeFromCart(id);
		session.setAttribute("cart", cart);
		return "redirect:/cart-details";
	}
	
}
