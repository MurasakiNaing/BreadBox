package com.breadbox.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.breadbox.service.CategoryService;
import com.breadbox.service.ProductService;
import com.breadbox.service.dto.CategoryDto;
import com.breadbox.service.dto.ProductDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/edit-product")
public class EditProductController {

	@Autowired
	private ProductService service;

	@Autowired
	private CategoryService categories;

	@GetMapping
	public String edit() {
		return "edit-product";
	}

	@PostMapping
	public String save(@RequestParam("upload") MultipartFile imageFile, @RequestParam int id, @RequestParam String name,
			@RequestParam int category_id, @RequestParam int price, @RequestParam String image,
			@RequestParam String description, HttpSession session, ModelMap map) {
		// Check for validation errors
		if (!validated(map, name, category_id))
			return "edit-product";

		// Get ProductDto Object
		ProductDto product = new ProductDto();
		// Set ID if it is not 0
		if (id != 0)
			product.setId(id);
		// Set Other fields
		product.setName(name);
		product.setCategory_id(category_id);
		product.setPrice(price);
		product.setDescription(description);

		// Set Upload Path (Relative Path which will be stored in database)
		var uploadPath = "resources/images/product-images/";
		if (imageFile.isEmpty() && image.isBlank()) {
			product.setImage("/resources/images/product-images/default-product.png");
		} else if (id != 0 && imageFile.isEmpty()) {
			product.setImage(image);
		}

		// If image is not null copy it to destination
		if (!imageFile.isEmpty()) {
			// Get Servlet Context
			var context = session.getServletContext();
			// Get Real Path to use for uploading file
			String fileName = context.getRealPath(uploadPath + imageFile.getOriginalFilename());
			try {
				// Copy the file to destined path
				Files.copy(imageFile.getInputStream(), Paths.get(fileName), StandardCopyOption.REPLACE_EXISTING);
				// Set image to ProductDto object
				product.setImage("/" + uploadPath + imageFile.getOriginalFilename());
			} catch (IOException e) {
				e.printStackTrace();
				// Return to edit-page if there's error
				return "edit-product";
			}
		}
		// Save Product
		service.save(product);
		// Send redirect Product Controller
		return "redirect:/menu";
	}

	@PostMapping("/delete/{id}")
	public String delete(@PathVariable Integer id) {
		// Delete Product using ID
		service.delete(id);
		return "redirect:/menu";
		
	}
	
	@ModelAttribute("product")
	ProductDto product(@RequestParam Optional<Integer> id) {
		if (id.isPresent() && id.get() != 0) {
			return service.findById(id.get());
		}
		return new ProductDto();
	}

	@ModelAttribute("categories")
	List<CategoryDto> categoryList() {
		return categories.getAllCategories();
	}

	private boolean validated(ModelMap map, String name, int category_id) {
		// Check if the name is blank
		if (name.isBlank()) {
			map.put("nameError", "Product Name cannot be empty.");
		}
		// Check if product already exists
		if (service.findByName(name) != null) {
			map.put("nameError", "Product already exists.");
		}
		// Check if category is selected or not
		if (category_id == 0) {
			map.put("categoryError", "Please choose a category.");
		}
		/*
		 * Check if the size of map is not 0 because if there's error map size will be
		 * greater than 0 thus return false to indicate validation fails
		 */
		if (map.size() != 0)
			return false;

		return true;
	}
}
