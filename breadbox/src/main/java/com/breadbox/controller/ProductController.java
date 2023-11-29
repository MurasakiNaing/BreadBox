package com.breadbox.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.breadbox.service.CategoryService;
import com.breadbox.service.ProductService;
import com.breadbox.service.dto.Cart;
import com.breadbox.service.dto.ProductDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class ProductController {

	@Autowired
	private ProductService service;

	@Autowired
	private CategoryService categories;

	@GetMapping("/menu")
	public String menu() {
		return "menu";
	}

	@GetMapping("/details/{id}")
	public String details(@PathVariable Integer id, ModelMap map) {
		// Find product by id
		var product = service.findById(id);
		// Find category from category id obtained from product
		var category = categories.findById(product.getCategory_id());
		// Put the product to model
		map.put("product", product);
		// Put the product to category
		map.put("category", category);
		return "product-details";
	}

	@GetMapping("/add-to-cart/{id}")
	public String addToCart(@PathVariable Integer id, @RequestParam("quantity") int quantity, HttpSession session) {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.addToCart(service.findById(id), quantity);
		return "menu";
	}
	
	@GetMapping("/search")
	public String search(@RequestParam("name") String name, ModelMap map) {
		map.put("products", service.searchProduct(name));
		return "menu";
	}

	@ModelAttribute("products")
	List<ProductDto> getProducts() {
		// Get all products in the products table
		return service.getProducts();
	}

}
